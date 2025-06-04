

```bash
# Nmap 7.95 scan initiated Wed Jun  4 12:40:24 2025 as: /usr/lib/nmap/nmap --privileged -sCV --min-rate 5000 -v -Pn -oN Bastard.txt 10.10.10.9
Nmap scan report for 10.10.10.9
Host is up (0.042s latency).
Not shown: 997 filtered tcp ports (no-response)
PORT      STATE SERVICE VERSION
80/tcp    open  http    Microsoft IIS httpd 7.5
| http-robots.txt: 36 disallowed entries (15 shown)
| /includes/ /misc/ /modules/ /profiles/ /scripts/ 
| /themes/ /CHANGELOG.txt /cron.php /INSTALL.mysql.txt 
| /INSTALL.pgsql.txt /INSTALL.sqlite.txt /install.php /INSTALL.txt 
|_/LICENSE.txt /MAINTAINERS.txt
|_http-title: Welcome to Bastard | Bastard
|_http-favicon: Unknown favicon MD5: CF2445DCB53A031C02F9B57E2199BC03
| http-methods: 
|   Supported Methods: OPTIONS TRACE GET HEAD POST
|_  Potentially risky methods: TRACE
|_http-server-header: Microsoft-IIS/7.5
|_http-generator: Drupal 7 (http://drupal.org)
135/tcp   open  msrpc   Microsoft Windows RPC
49154/tcp open  msrpc   Microsoft Windows RPC
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Read data files from: /usr/share/nmap
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Wed Jun  4 12:41:28 2025 -- 1 IP address (1 host up) scanned in 63.13 seconds

```

vemos que tenemos un drupal, tenemos que mirar el **CHANGELOG.txt **

Drupal 7.54, 2017-02-01

![[Pasted image 20250604130228.png]]
 asi que buscamos exploit
 
 