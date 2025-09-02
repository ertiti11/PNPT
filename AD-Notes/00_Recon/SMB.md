# # 📂 SMB Enumeration

El protocolo SMB (Server Message Block) es muy común en entornos Windows y Active Directory.  
Se usa para compartir archivos, impresoras y comunicación con servicios como SYSVOL y NETLOGON.  
Es un punto de entrada frecuente en pentesting.

---

## 📌 Conceptos clave
- **Puertos** → 139 (NetBIOS), 445 (SMB Direct).
- **Versiones** → SMBv1, SMBv2, SMBv3.
- **Shares comunes:**
  - `C$`, `ADMIN$`, `IPC$` → shares administrativos.
  - `SYSVOL`, `NETLOGON` → relevantes en AD.
  - `Replication`, `Users` → a menudo contienen información sensible.

---

## 🛠️ Enumeración básica

### Listar shares con `smbclient`

```bash
smbclient -L //10.10.10.100 -N
smbclient -L //10.10.10.100 -U "usuario%contraseña"

```
### Conectarse a un share

`smbclient //10.10.10.100/Users -U "usuario%contraseña"`

Comandos internos:

- `ls` → listar ficheros
- `cd` → cambiar directorio
- `get <archivo>` → descargar archivo
- `mget *` → descargar todo

---

## 🔎 Herramientas de enumeración

### smbmap

`smbmap -H 10.10.10.100 smbmap -H 10.10.10.100 -u usuario -p contraseña smbmap -H 10.10.10.100 -d dominio -u usuario -p contraseña`

### enum4linux-ng

`enum4linux-ng 10.10.10.100 enum4linux-ng -A 10.10.10.100`

### CrackMapExec

```bash
crackmapexec smb 10.10.10.100 -u '' -p '' --shares crackmapexec smb 10.10.10.100 -u usuario -p contraseña --shares
```

---

## 📑 Ejemplos prácticos

### Anónimo

```bash
smbclient -L //10.10.10.100 -N
```

→ Si responde, revisar SYSVOL y NETLOGON.

### Usuario autenticado

```bash
smbmap -H 10.10.10.100 -d active.htb -u SVC_TGS -p GPPstillStandingStrong2k18
```

---

## 🔑 Cosas a buscar

- Archivos de configuración (`*.xml`, `*.ini`, `*.conf`).
    
- Scripts en `SYSVOL` / `NETLOGON`.
    
- `Groups.xml` con `cpassword`.
    
- Carpetas de usuarios (`Users/Username/Desktop`) → flags o credenciales.
    
- Backups, notas de admins, logs con información sensible.
    

---

## ⚠️ Vectores comunes de ataque

- **Null session** → acceso sin usuario/contraseña.
    
- **Sensitive files in SYSVOL/NETLOGON**.
    
- **Password reuse** en scripts o archivos.
    
- **Kerberoasting** → identificar SPNs desde información en shares.
    
- **NTLM Relay** → usar SMB en combinación con Responder/ntlmrelayx.
    

---

## 🧾 Notas rápidas

- SYSVOL se replica en todos los DCs → todo lo que esté allí es visible para todos.
    
- Los `cpassword` en GPP (`Groups.xml`, `ScheduledTasks.xml`) son crackeables.
    
- IPC$ permite enumerar información incluso sin privilegios altos.