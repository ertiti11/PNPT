

Para iniciar bloodhound primero debemos de iniciar neo4j

```bash
sudo neo4j console
```


despues debemos de ejecutar bloodhound


```bash
sudo bloodhound
```


despues debemos de lanzar el analizador de bloodhound


```bash
sudo bloodhound-python -d MARVEL.local -u fcastle -p Mypassword1234! -ns 192.168.0.220 -c all
```

+ -d: el dominio
+ -u: usuario
+ -p: password
+ -ns: el servidor dns (DC)
+ -c: lo que va  a recolectar

Esto nos generará unos archivos que debemos de importar en bloodhound

![[Pasted image 20250427140236.png]]


