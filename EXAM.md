




# nmap ports

```bash
nmap thepastamentors.com -sCV --min-rate 5000 -v -Pn -oN thepastamentors.txt
```

```bash
Nmap scan report for thepastamentors.com (185.230.63.107)
Host is up (0.12s latency).
Other addresses for thepastamentors.com (not scanned): 185.230.63.171 185.230.63.186
rDNS record for 185.230.63.107: unalocated.63.wixsite.com
Not shown: 994 closed tcp ports (reset)
PORT     STATE SERVICE       VERSION
80/tcp   open  http
|_http-title: Site doesn't have a title.
| fingerprint-strings: 
|   FourOhFourRequest, GetRequest: 
|     HTTP/1.0 403 Forbidden
|     X-Seen-By: vmPhUNXuQemvc7fjBI8NWewfbs+7qUVAqsIx00yI78k=
|     Connection: close
|     Content-Length: 0
|   HTTPOptions, TerminalServerCookie: 
|     HTTP/1.0 403 Forbidden
|     X-Seen-By: oDbbMvfdXCdtsgjD2KgaM8iHE4dbw+wewoJ5nvKoyjE=
|     Connection: close
|     Content-Length: 0
|   RTSPRequest: 
|     HTTP/1.0 403 Forbidden
|     X-Seen-By: pmHZlB45NPy7b1VBAukQrewfbs+7qUVAqsIx00yI78k=
|     Connection: close
|_    Content-Length: 0
82/tcp   open  xfer?
443/tcp  open  ssl/https     Pepyaka
| fingerprint-strings: 
|   FourOhFourRequest, GetRequest: 
|     HTTP/1.0 403 Forbidden
|     X-Seen-By: pmHZlB45NPy7b1VBAukQrewfbs+7qUVAqsIx00yI78k=
|     Connection: close
|     Content-Length: 0
|   HTTPOptions, RTSPRequest: 
|     HTTP/1.0 403 Forbidden
|     X-Seen-By: oDbbMvfdXCdtsgjD2KgaM8iHE4dbw+wewoJ5nvKoyjE=
|     Connection: close
|     Content-Length: 0
|   SIPOptions: 
|     HTTP/1.0 403 Forbidden
|     X-Seen-By: AHc3TXLcXOul+t9LIbGg9ciHE4dbw+wewoJ5nvKoyjE=
|     Connection: close
|     Content-Length: 0
|   TerminalServerCookie: 
|     HTTP/1.0 403 Forbidden
|     X-Seen-By: jKB0KR2wTEE1MYSdxvKSbciHE4dbw+wewoJ5nvKoyjE=
|     Connection: close
|_    Content-Length: 0
|_http-title: Site doesn't have a title.
| ssl-cert: Subject: commonName=thepastamentors.com
| Subject Alternative Name: DNS:thepastamentors.com, DNS:www.thepastamentors.com
| Issuer: commonName=WR1/organizationName=Google Trust Services/countryName=US
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2025-07-07T18:04:43
| Not valid after:  2025-10-05T18:04:42
| MD5:   7c9a:9a4a:e34b:1ed4:1b55:f2a0:e031:0880
|_SHA-1: aa88:e899:0533:45a0:2bd2:04eb:fe3e:0fee:9ff5:0eae
|_http-server-header: Pepyaka
445/tcp  open  microsoft-ds?
2000/tcp open  tcpwrapped
5060/tcp open  tcpwrapped
2 services unrecognized despite returning data. If you know the service/version, please submit the following fingerprints at https://nmap.org/cgi-bin/submit.cgi?new-service :
==============NEXT SERVICE FINGERPRINT (SUBMIT INDIVIDUALLY)==============
SF-Port80-TCP:V=7.95%I=7%D=8/11%Time=6899D7CB%P=x86_64-pc-linux-gnu%r(GetR
SF:equest,79,"HTTP/1\.0\x20403\x20Forbidden\r\nX-Seen-By:\x20vmPhUNXuQemvc
SF:7fjBI8NWewfbs\+7qUVAqsIx00yI78k=\r\nConnection:\x20close\r\nContent-Len
SF:gth:\x200\r\n\r\n")%r(HTTPOptions,79,"HTTP/1\.0\x20403\x20Forbidden\r\n
SF:X-Seen-By:\x20oDbbMvfdXCdtsgjD2KgaM8iHE4dbw\+wewoJ5nvKoyjE=\r\nConnecti
SF:on:\x20close\r\nContent-Length:\x200\r\n\r\n")%r(RTSPRequest,79,"HTTP/1
SF:\.0\x20403\x20Forbidden\r\nX-Seen-By:\x20pmHZlB45NPy7b1VBAukQrewfbs\+7q
SF:UVAqsIx00yI78k=\r\nConnection:\x20close\r\nContent-Length:\x200\r\n\r\n
SF:")%r(FourOhFourRequest,79,"HTTP/1\.0\x20403\x20Forbidden\r\nX-Seen-By:\
SF:x20vmPhUNXuQemvc7fjBI8NWewfbs\+7qUVAqsIx00yI78k=\r\nConnection:\x20clos
SF:e\r\nContent-Length:\x200\r\n\r\n")%r(TerminalServerCookie,79,"HTTP/1\.
SF:0\x20403\x20Forbidden\r\nX-Seen-By:\x20oDbbMvfdXCdtsgjD2KgaM8iHE4dbw\+w
SF:ewoJ5nvKoyjE=\r\nConnection:\x20close\r\nContent-Length:\x200\r\n\r\n");
==============NEXT SERVICE FINGERPRINT (SUBMIT INDIVIDUALLY)==============
SF-Port443-TCP:V=7.95%T=SSL%I=7%D=8/11%Time=6899D7D1%P=x86_64-pc-linux-gnu
SF:%r(GetRequest,79,"HTTP/1\.0\x20403\x20Forbidden\r\nX-Seen-By:\x20pmHZlB
SF:45NPy7b1VBAukQrewfbs\+7qUVAqsIx00yI78k=\r\nConnection:\x20close\r\nCont
SF:ent-Length:\x200\r\n\r\n")%r(HTTPOptions,79,"HTTP/1\.0\x20403\x20Forbid
SF:den\r\nX-Seen-By:\x20oDbbMvfdXCdtsgjD2KgaM8iHE4dbw\+wewoJ5nvKoyjE=\r\nC
SF:onnection:\x20close\r\nContent-Length:\x200\r\n\r\n")%r(FourOhFourReque
SF:st,79,"HTTP/1\.0\x20403\x20Forbidden\r\nX-Seen-By:\x20pmHZlB45NPy7b1VBA
SF:ukQrewfbs\+7qUVAqsIx00yI78k=\r\nConnection:\x20close\r\nContent-Length:
SF:\x200\r\n\r\n")%r(RTSPRequest,79,"HTTP/1\.0\x20403\x20Forbidden\r\nX-Se
SF:en-By:\x20oDbbMvfdXCdtsgjD2KgaM8iHE4dbw\+wewoJ5nvKoyjE=\r\nConnection:\
SF:x20close\r\nContent-Length:\x200\r\n\r\n")%r(TerminalServerCookie,79,"H
SF:TTP/1\.0\x20403\x20Forbidden\r\nX-Seen-By:\x20jKB0KR2wTEE1MYSdxvKSbciHE
SF:4dbw\+wewoJ5nvKoyjE=\r\nConnection:\x20close\r\nContent-Length:\x200\r\
SF:n\r\n")%r(SIPOptions,79,"HTTP/1\.0\x20403\x20Forbidden\r\nX-Seen-By:\x2
SF:0AHc3TXLcXOul\+t9LIbGg9ciHE4dbw\+wewoJ5nvKoyjE=\r\nConnection:\x20close
SF:\r\nContent-Length:\x200\r\n\r\n");

```


```bash
┌──(titi㉿kali)-[~/pnpt]
└─$ nmap -sn 10.10.155.0/24 -oG hosts.txt
Starting Nmap 7.95 ( https://nmap.org ) at 2025-08-11 14:28 CEST
Nmap scan report for 10.10.155.5
Host is up (0.11s latency).
Nmap done: 256 IP addresses (1 host up) scanned in 9.68 seconds
                                                                                                                                                             
┌──(titi㉿kali)-[~/pnpt]
└─$ cat hosts.txt          
# Nmap 7.95 scan initiated Mon Aug 11 14:28:39 2025 as: /usr/lib/nmap/nmap --privileged -sn -oG hosts.txt 10.10.155.0/24
Host: 10.10.155.5 ()    Status: Up
# Nmap done at Mon Aug 11 14:28:48 2025 -- 256 IP addresses (1 host up) scanned in 9.68 seconds

```

```bash
┌──(titi㉿kali)-[~/pnpt]
└─$ nmap 10.10.155.5 -sCV --min-rate 5000 --open -p- --exclude-ports 2000,5060 -v -Pn -oN 10.10.155.5.txt                                          
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Starting Nmap 7.95 ( https://nmap.org ) at 2025-08-11 14:30 CEST
NSE: Loaded 157 scripts for scanning.
NSE: Script Pre-scanning.
Initiating NSE at 14:30
Completed NSE at 14:30, 0.00s elapsed
Initiating NSE at 14:30
Completed NSE at 14:30, 0.00s elapsed
Initiating NSE at 14:30
Completed NSE at 14:30, 0.00s elapsed
Initiating Parallel DNS resolution of 1 host. at 14:30
Completed Parallel DNS resolution of 1 host. at 14:30, 0.02s elapsed
Initiating SYN Stealth Scan at 14:30
Scanning 10.10.155.5 [65533 ports]
Discovered open port 587/tcp on 10.10.155.5
Discovered open port 25/tcp on 10.10.155.5
Discovered open port 443/tcp on 10.10.155.5
Discovered open port 143/tcp on 10.10.155.5
Discovered open port 110/tcp on 10.10.155.5
Discovered open port 995/tcp on 10.10.155.5
Discovered open port 22/tcp on 10.10.155.5
Discovered open port 80/tcp on 10.10.155.5
Discovered open port 993/tcp on 10.10.155.5
Completed SYN Stealth Scan at 14:30, 15.42s elapsed (65533 total ports)
Initiating Service scan at 14:30
Scanning 9 services on 10.10.155.5
Completed Service scan at 14:30, 12.70s elapsed (9 services on 1 host)
NSE: Script scanning 10.10.155.5.
Initiating NSE at 14:30
Completed NSE at 14:31, 5.19s elapsed
Initiating NSE at 14:31
Completed NSE at 14:31, 4.65s elapsed
Initiating NSE at 14:31
Completed NSE at 14:31, 0.00s elapsed
Nmap scan report for 10.10.155.5
Host is up (0.11s latency).
Not shown: 65524 closed tcp ports (reset)
PORT    STATE SERVICE  VERSION
22/tcp  open  ssh      OpenSSH 7.6p1 Ubuntu 4ubuntu0.7 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 ca:8d:f9:d8:62:2f:b9:df:dd:c2:af:91:9a:7a:c8:18 (RSA)
|   256 74:27:39:90:00:13:ab:60:ce:ae:68:68:77:ff:d2:41 (ECDSA)
|_  256 fe:a4:f4:52:1f:01:62:08:4b:96:2d:49:f4:06:85:cb (ED25519)
25/tcp  open  smtp     Postfix smtpd
|_smtp-commands: SMTP: EHLO 521 5.5.1 Protocol error\x0D
80/tcp  open  http     nginx
|_http-title: Did not follow redirect to https://10.10.155.5/
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
110/tcp open  pop3     Dovecot pop3d
|_pop3-capabilities: AUTH-RESP-CODE PIPELINING SASL CAPA TOP RESP-CODES UIDL STLS
| ssl-cert: Subject: commonName=mail.thepastamentors.com/organizationName=mail.thepastamentors.com/stateOrProvinceName=GuangDong/countryName=CN
| Issuer: commonName=mail.thepastamentors.com/organizationName=mail.thepastamentors.com/stateOrProvinceName=GuangDong/countryName=CN
| Public Key type: rsa
| Public Key bits: 4096
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2021-04-05T20:22:31
| Not valid after:  2031-04-03T20:22:31
| MD5:   9405:d2f6:0598:e5a7:1dd8:f55b:4f9b:8466
|_SHA-1: 5b56:dbfb:2da9:7e14:10fa:0230:da14:91e6:04f6:4a63
|_ssl-date: TLS randomness does not represent time
143/tcp open  imap     Dovecot imapd (Ubuntu)
|_imap-capabilities: OK ID have STARTTLS SASL-IR more listed post-login Pre-login LOGIN-REFERRALS IMAP4rev1 LITERAL+ LOGINDISABLEDA0001 capabilities ENABLE IDLE
|_ssl-date: TLS randomness does not represent time
| ssl-cert: Subject: commonName=mail.thepastamentors.com/organizationName=mail.thepastamentors.com/stateOrProvinceName=GuangDong/countryName=CN
| Issuer: commonName=mail.thepastamentors.com/organizationName=mail.thepastamentors.com/stateOrProvinceName=GuangDong/countryName=CN
| Public Key type: rsa
| Public Key bits: 4096
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2021-04-05T20:22:31
| Not valid after:  2031-04-03T20:22:31
| MD5:   9405:d2f6:0598:e5a7:1dd8:f55b:4f9b:8466
|_SHA-1: 5b56:dbfb:2da9:7e14:10fa:0230:da14:91e6:04f6:4a63
443/tcp open  ssl/http nginx
| http-methods: 
|_  Supported Methods: GET HEAD
| http-robots.txt: 1 disallowed entry 
|_/
|_http-title: Site doesn't have a title (text/html).
| tls-nextprotoneg: 
|   h2
|_  http/1.1
|_ssl-date: TLS randomness does not represent time
| ssl-cert: Subject: commonName=mail.thepastamentors.com/organizationName=mail.thepastamentors.com/stateOrProvinceName=GuangDong/countryName=CN
| Issuer: commonName=mail.thepastamentors.com/organizationName=mail.thepastamentors.com/stateOrProvinceName=GuangDong/countryName=CN
| Public Key type: rsa
| Public Key bits: 4096
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2021-04-05T20:22:31
| Not valid after:  2031-04-03T20:22:31
| MD5:   9405:d2f6:0598:e5a7:1dd8:f55b:4f9b:8466
|_SHA-1: 5b56:dbfb:2da9:7e14:10fa:0230:da14:91e6:04f6:4a63
| tls-alpn: 
|   h2
|_  http/1.1
587/tcp open  smtp     Postfix smtpd
|_smtp-commands: mail.thepastamentors.com, PIPELINING, SIZE 15728640, ETRN, STARTTLS, ENHANCEDSTATUSCODES, 8BITMIME, DSN, SMTPUTF8
|_ssl-date: TLS randomness does not represent time
| ssl-cert: Subject: commonName=mail.thepastamentors.com/organizationName=mail.thepastamentors.com/stateOrProvinceName=GuangDong/countryName=CN
| Issuer: commonName=mail.thepastamentors.com/organizationName=mail.thepastamentors.com/stateOrProvinceName=GuangDong/countryName=CN
| Public Key type: rsa
| Public Key bits: 4096
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2021-04-05T20:22:31
| Not valid after:  2031-04-03T20:22:31
| MD5:   9405:d2f6:0598:e5a7:1dd8:f55b:4f9b:8466
|_SHA-1: 5b56:dbfb:2da9:7e14:10fa:0230:da14:91e6:04f6:4a63
993/tcp open  ssl/imap Dovecot imapd (Ubuntu)
|_imap-capabilities: OK ID AUTH=PLAIN have SASL-IR more listed post-login Pre-login LOGIN-REFERRALS IMAP4rev1 LITERAL+ capabilities AUTH=LOGINA0001 ENABLE IDLE
|_ssl-date: TLS randomness does not represent time
| ssl-cert: Subject: commonName=mail.thepastamentors.com/organizationName=mail.thepastamentors.com/stateOrProvinceName=GuangDong/countryName=CN
| Issuer: commonName=mail.thepastamentors.com/organizationName=mail.thepastamentors.com/stateOrProvinceName=GuangDong/countryName=CN
| Public Key type: rsa
| Public Key bits: 4096
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2021-04-05T20:22:31
| Not valid after:  2031-04-03T20:22:31
| MD5:   9405:d2f6:0598:e5a7:1dd8:f55b:4f9b:8466
|_SHA-1: 5b56:dbfb:2da9:7e14:10fa:0230:da14:91e6:04f6:4a63
995/tcp open  ssl/pop3 Dovecot pop3d
| ssl-cert: Subject: commonName=mail.thepastamentors.com/organizationName=mail.thepastamentors.com/stateOrProvinceName=GuangDong/countryName=CN
| Issuer: commonName=mail.thepastamentors.com/organizationName=mail.thepastamentors.com/stateOrProvinceName=GuangDong/countryName=CN
| Public Key type: rsa
| Public Key bits: 4096
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2021-04-05T20:22:31
| Not valid after:  2031-04-03T20:22:31
| MD5:   9405:d2f6:0598:e5a7:1dd8:f55b:4f9b:8466
|_SHA-1: 5b56:dbfb:2da9:7e14:10fa:0230:da14:91e6:04f6:4a63
|_pop3-capabilities: AUTH-RESP-CODE PIPELINING SASL(PLAIN LOGIN) CAPA TOP RESP-CODES UIDL USER
|_ssl-date: TLS randomness does not represent time
Service Info: Hosts: -mail.thepastamentors.com,  mail.thepastamentors.com; OS: Linux; CPE: cpe:/o:linux:linux_kernel

NSE: Script Post-scanning.
Initiating NSE at 14:31
Completed NSE at 14:31, 0.00s elapsed
Initiating NSE at 14:31
Completed NSE at 14:31, 0.00s elapsed
Initiating NSE at 14:31
Completed NSE at 14:31, 0.00s elapsed
Read data files from: /usr/share/nmap
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 38.25 seconds
           Raw packets sent: 76143 (3.350MB) | Rcvd: 76101 (3.044MB)
                                                                        
```

alessandra@thepastamentors.com
alanzo@thepastamentors.com
adriano@thepastamentors.com

despues de reconocer el patron de la empresa
giovanni@thepastamentors.com
mario@thepastamentors.com



