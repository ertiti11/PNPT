![](https://github.com/hackthebox/writeup-templates/raw/master/machine/assets/images/banner.png)



<img src="https://labs.hackthebox.com/storage/avatars/2bc1a8dc04b09b8ac2db694f25ccf051.png" style="margin-left: 20px; zoom: 60%;" align=left />    	<font size="10">Servmon</font>

​		28/04/2025

​		

​		

 



### Description:

This machine...

### Difficulty:

`EASY`

### Flags:

User: `6dad2258bbb1d9da536daa19edc69e95`

Root: `<md5>`


# Enumeration

```bash
nmap -sCV -p- --open 10.10.10.184 -v -Pn -oN Servmon.txt
```

Vemos que tenemos una página de un login, vemos que software es y buscamos exploit

![[Pasted image 20250504203449.png]]

Vemos que es vulnerable a path traversal:

https://github.com/AleDiBen/NVMS1000-Exploit/blob/master/nvms.py

Vemos que podemos leer archivos internos de la maquina:

![[Pasted image 20250504203549.png]]

por ftp nos pone algo interesante que no se si sera importante:

![[Pasted image 20250504204211.png]]

damos enter y podemos entrar, hay dos usuarios y dos archivos en cada carpeta de usuario

usuarios: Nathan y Nadine.

Nadine nos ha dejado una nota con el siguiente texto

```
**Nathan,
I left your Passwords.txt file on your Desktop.  Please remove this once you have edited it yourself and place it back into the secure folder.

Regards

Nadine
```

Teniendo esto en cuenta, podemos usar el path traversal para intentar acceder a este archivo.
y Vuala!!

![[Pasted image 20250504204551.png]]
Tenemos unas cuantas, asi que haremos password spraying

y correcto, tenemos contraseña de nadine:
![[Pasted image 20250504204900.png]]

Nadine:L1k3B1gBut7s@W0rk

![[Pasted image 20250504204926.png]]

1nsp3ctTh3Way2Mars!
Th3r34r3To0M4nyTrait0r5!
B3WithM30r4ga1n5tMe
L1k3B1gBut7s@W0rk
0nly7h3y0unGWi11F0l10w
IfH3s4b0Utg0t0H1sH0me
Gr4etN3w5w17hMySk1Pa5$


POR FAVOR ADRIAN, PUEDES MIRAR LOS PUTOS PUERTOS Y SERVICIOS QUE TIENE ANTES DE ENREARTE PORFAVOR??????????????

![[Pasted image 20250504211002.png]]

Dentro de la maquina en la ruta C:\Program Files\NSClient++ encontramos una contraseña

```bash
ew2x6SsGTxjRwXOT
```



hacemos port fowarding para poder ver el panel de control del nsclient++

```bash
ssh -L 8443:127.0.0.1:8443 nadine@10.10.10.184
```



