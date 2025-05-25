```bash
nmap 10.10.11.108 -sCV --min-rate 5000 -v -Pn -oN return.txt
```

```bash
# Nmap 7.95 scan initiated Fri May 23 23:18:51 2025 as: /usr/lib/nmap/nmap --privileged -sCV --min-rate 5000 -v -Pn -oN return.txt 10.10.11.108
Nmap scan report for 10.10.11.108
Host is up (0.043s latency).
Not shown: 987 closed tcp ports (reset)
PORT     STATE SERVICE       VERSION
53/tcp   open  domain        Simple DNS Plus
80/tcp   open  http          Microsoft IIS httpd 10.0
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Microsoft-IIS/10.0
|_http-title: HTB Printer Admin Panel
88/tcp   open  kerberos-sec  Microsoft Windows Kerberos (server time: 2025-05-23 21:37:33Z)
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
389/tcp  open  ldap          Microsoft Windows Active Directory LDAP (Domain: return.local0., Site: Default-First-Site-Name)
445/tcp  open  microsoft-ds?
464/tcp  open  kpasswd5?
593/tcp  open  ncacn_http    Microsoft Windows RPC over HTTP 1.0
636/tcp  open  tcpwrapped
3268/tcp open  ldap          Microsoft Windows Active Directory LDAP (Domain: return.local0., Site: Default-First-Site-Name)
3269/tcp open  tcpwrapped
5985/tcp open  http          Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Microsoft-HTTPAPI/2.0
|_http-title: Not Found
Service Info: Host: PRINTER; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled and required
| smb2-time: 
|   date: 2025-05-23T21:37:40
|_  start_date: N/A
|_clock-skew: 18m34s

```



Vemos que tenemos una web con configuracion de impresora, vamos a poner nuestra ip para que nos de la config por un socket

![[Pasted image 20250523233501.png]]

![[Pasted image 20250523233429.png]]

usuario svc-printer:1edFg43012!!



![[Pasted image 20250523233621.png





por si da por culo
```bash
smbclient //10.10.11.108/ADMIN$ -U svc-printer --password='1edFg43012!!' --option='client min protocol=SMB2' --option='client max protocol=SMB3'
```



NO HACE FALTA SER ADMIN PARA EVILWINRM, SOLO TENER EL PUERTO 5985/tcp ABIERTO

![[Pasted image 20250524001200.png]]


El usuario pertenece a server operators, por lo que pueede modificar, accionar y stopear servicios, por que podemos cambiar el binPath del servicio y hacer que se ejecute lo que nosotros queremos.



![[Pasted image 20250524002353.png]]![[Pasted image 20250524002903.png]]


![[Pasted image 20250524002919.png]]