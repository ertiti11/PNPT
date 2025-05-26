



ip = 10.10.11.130






```bash
# Nmap 7.95 scan initiated Mon May 26 07:54:46 2025 as: /usr/lib/nmap/nmap --privileged -sCV --min-rate 5000 -v -Pn -oN goodgames.txt 10.10.11.130
Nmap scan report for 10.10.11.130
Host is up (0.044s latency).
Not shown: 999 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
80/tcp open  http    Werkzeug httpd 2.0.2 (Python 3.9.2)
| http-methods: 
|_  Supported Methods: GET OPTIONS HEAD POST
|_http-favicon: Unknown favicon MD5: 61352127DC66484D3736CACCF50E7BEB
|_http-server-header: Werkzeug/2.0.2 Python/3.9.2
|_http-title: GoodGames | Community and Store

Read data files from: /usr/share/nmap
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Mon May 26 07:54:54 2025 -- 1 IP address (1 host up) scanned in 7.89 seconds

```


![[Pasted image 20250526080616.png]]

