

## nmap

```bash
nmap -sCV -p- --open --min-rate 5000 10.10.11.68 -n -v -oN planning.txt
Starting Nmap 7.95 ( https://nmap.org ) at 2025-08-31 18:36 CEST
NSE: Loaded 157 scripts for scanning.
NSE: Script Pre-scanning.
Initiating NSE at 18:36
Completed NSE at 18:36, 0.00s elapsed
Initiating NSE at 18:36
Completed NSE at 18:36, 0.00s elapsed
Initiating NSE at 18:36
Completed NSE at 18:36, 0.00s elapsed
Initiating Ping Scan at 18:36
Scanning 10.10.11.68 [4 ports]
Completed Ping Scan at 18:36, 0.12s elapsed (1 total hosts)
Initiating SYN Stealth Scan at 18:36
Scanning 10.10.11.68 [65535 ports]
Discovered open port 22/tcp on 10.10.11.68
Discovered open port 80/tcp on 10.10.11.68
Completed SYN Stealth Scan at 18:37, 14.02s elapsed (65535 total ports)
Initiating Service scan at 18:37
Scanning 2 services on 10.10.11.68
Completed Service scan at 18:37, 6.22s elapsed (2 services on 1 host)
NSE: Script scanning 10.10.11.68.
Initiating NSE at 18:37
Completed NSE at 18:37, 3.16s elapsed
Initiating NSE at 18:37
Completed NSE at 18:37, 0.41s elapsed
Initiating NSE at 18:37
Completed NSE at 18:37, 0.00s elapsed
Nmap scan report for 10.10.11.68
Host is up (0.11s latency).
Not shown: 64245 closed tcp ports (reset), 1288 filtered tcp ports (no-response)
Some closed ports may be reported as filtered due to --defeat-rst-ratelimit
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 9.6p1 Ubuntu 3ubuntu13.11 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 62:ff:f6:d4:57:88:05:ad:f4:d3:de:5b:9b:f8:50:f1 (ECDSA)
|_  256 4c:ce:7d:5c:fb:2d:a0:9e:9f:bd:f5:5c:5e:61:50:8a (ED25519)
80/tcp open  http    nginx 1.24.0 (Ubuntu)
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: nginx/1.24.0 (Ubuntu)
|_http-title: Did not follow redirect to http://planning.htb/
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

NSE: Script Post-scanning.
Initiating NSE at 18:37
Completed NSE at 18:37, 0.00s elapsed
Initiating NSE at 18:37
Completed NSE at 18:37, 0.00s elapsed
Initiating NSE at 18:37
Completed NSE at 18:37, 0.00s elapsed
Read data files from: /usr/share/nmap
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 24.36 seconds
           Raw packets sent: 69198 (3.045MB) | Rcvd: 65863 (2.635MB)
```


## Directoy fuzzing

```bash
gobuster dir  --url http://planning.htb --wordlist /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x php,txt,zip
===============================================================
Gobuster v3.6
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://planning.htb
[+] Method:                  GET
[+] Threads:                 10
[+] Wordlist:                /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.6
[+] Extensions:              zip,php,txt
[+] Timeout:                 10s
===============================================================
Starting gobuster in directory enumeration mode
===============================================================
/index.php            (Status: 200) [Size: 23914]
/contact.php          (Status: 200) [Size: 10632]
/about.php            (Status: 200) [Size: 12727]
/img                  (Status: 301) [Size: 178] [--> http://planning.htb/img/]
/detail.php           (Status: 200) [Size: 13006]
/css                  (Status: 301) [Size: 178] [--> http://planning.htb/css/]
/lib                  (Status: 301) [Size: 178] [--> http://planning.htb/lib/]
/js                   (Status: 301) [Size: 178] [--> http://planning.htb/js/]
/course.php           (Status: 200) [Size: 10229]
Progress: 13558 / 882244 (1.54%)^C
[!] Keyboard interrupt detected, terminating.
Progress: 13578 / 882244 (1.54%)
===============================================================
Finished
===============================================================

```

nada Significativo

vemos en el puerto 80 una web

![[Pasted image 20250831200308.png]]


nada significativo


## subdomain fuzzing


```bash
sudo gobuster vhost -u http://planning.htb -w /usr/share/wordlists/seclists/Discovery/DNS/combined_subdomains.txt --append-domain -t 200
===============================================================
Gobuster v3.6
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:             http://planning.htb
[+] Method:          GET
[+] Threads:         200
[+] Wordlist:        /usr/share/wordlists/seclists/Discovery/DNS/combined_subdomains.txt
[+] User Agent:      gobuster/3.6
[+] Timeout:         10s
[+] Append Domain:   true
===============================================================
Starting gobuster in VHOST enumeration mode
===============================================================
Found: grafana.planning.htb Status: 302 [Size: 29] [--> /login]
Progress: 285622 / 653921 (43.68%)^C
[!] Keyboard interrupt detected, terminating.
Progress: 285801 / 653921 (43.71%)
===============================================================
Finished
===============================================================
```

vemos que tenemos un subdominio que es grafa.planning.htb

veamos que hay

![[Pasted image 20250831200604.png]]

vemos un grafana con la version 11.0.0


si nos metemos en sploitus, veremos que tenemos CVE-2024-9264

![[Pasted image 20250831200637.png]]


vamos a ejecutar el script de python
