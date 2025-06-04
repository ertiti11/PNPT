# Writeup Técnico: Máquina "Return"

Este documento detalla el procedimiento de ataque y explotación de la máquina "Return". El writeup está organizado por fases para facilitar su comprensión y estudio.

## 1. Reconocimiento

### Escaneo Nmap

Se realizó un escaneo de puertos utilizando `nmap` con las siguientes opciones:

```bash
nmap 10.10.11.108 -sCV --min-rate 5000 -v -Pn -oN return.txt
```

**Resultados del escaneo:**

- Puertos abiertos y servicios identificados:
  - **53/tcp**: `domain` - Simple DNS Plus
  - **80/tcp**: `http` - Microsoft IIS httpd 10.0
  - **88/tcp**: `kerberos-sec` - Microsoft Windows Kerberos
  - **135/tcp**: `msrpc` - Microsoft Windows RPC
  - **139/tcp**: `netbios-ssn` - Microsoft Windows netbios-ssn
  - **389/tcp**: `ldap` - Microsoft Windows Active Directory LDAP
  - **445/tcp**: `microsoft-ds?`
  - **464/tcp**: `kpasswd5?`
  - **593/tcp**: `ncacn_http` - Microsoft Windows RPC over HTTP 1.0
  - **5985/tcp**: `http` - Microsoft HTTPAPI httpd 2.0

Se destacan la presencia de un panel de administración de impresoras y un puerto WinRM.

## 2. Enumeración

### Información del Servicio Web

Se detectó un panel web de configuración de impresoras:

- Título del sitio: **HTB Printer Admin Panel**

![Captura del Panel de Administración](Pasted%20image%2020250523233501.png)
![Credenciales Extraídas](Pasted%20image%2020250523233429.png)

**Credenciales obtenidas:**
- Usuario: `svc-printer`
- Contraseña: `1edFg43012!!`

## 3. Explotación

### Acceso SMB

Se utilizó `smbclient` para conectarse a un recurso compartido:

```bash
smbclient //10.10.11.108/ADMIN$ -U svc-printer --password='1edFg43012!!' --option='client min protocol=SMB2' --option='client max protocol=SMB3'
```

### Acceso WinRM

No es necesario ser administrador para utilizar `evil-winrm`, solo tener el puerto 5985/tcp abierto. 
![Demostración de Acceso WinRM](Pasted%20image%2020250524001200.png)

### Escalada de Privilegios

- El usuario pertenece al grupo "Server Operators", lo que permite modificar y controlar servicios. Se puede alterar el `binPath` de un servicio para ejecutar comandos arbitrarios.

![Escalada de Privilegios - Modificación de Servicios](Pasted%20image%2020250524002353.png)
![Ejecución de Payloads](Pasted%20image%2020250524002903.png)
![Confirmación de Escalada](Pasted%20image%2020250524002919.png)

## Notas Finales

- La correcta identificación y uso de credenciales puede ser clave para la explotación.
- Los privilegios del grupo "Server Operators" proporcionan un vector útil para la escalada de privilegios.

Este procedimiento ofrece un enfoque claro y eficiente para realizar un pentest en esta máquina, destacando especialmente el uso de servicios reconocidos y métodos de escalada de privilegios basados en configuraciones de servicios.
