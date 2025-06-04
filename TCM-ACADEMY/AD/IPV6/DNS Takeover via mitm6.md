
>[!WARNING]
>es importante no ejecutarlo durante mas de 5-10 minutos ya que causa interrupciones en la red.

# 🌐 ¿Para qué sirve un ataque **DNS Takeover vía IPv6**?

El **DNS Takeover por IPv6** (también conocido como **NS Takeover** usando `mitm6`) permite:

### 🎯 Principalmente:

- **Engañar a las víctimas** para que usen **tu máquina como servidor DNS**.
    
- **Capturar o relayar** autenticaciones NTLM automáticamente.
    
- **Registrar entradas DNS falsas** en el Active Directory si tienes permisos.
    
- **Crear nombres de máquinas o servicios** que apunten hacia tu control.
    

---

# ✅ ¿Qué podemos hacer con él en un pentest?

|Uso|Descripción|
|---|---|
|**Captura de credenciales**|Forzar que usuarios o servidores se autentiquen hacia ti.|
|**SMB Relay**|Relayar autenticaciones hacia SMB/LDAP para obtener acceso o ejecutar comandos.|
|**Creación de usuarios maliciosos**|Si puedes abusar de LDAP, crear cuentas en el dominio.|
|**Suplantar servicios**|Fingir ser servidores internos (ej. `fileserver.empresa.local`) para capturar tráfico o contraseñas.|
|**Movimientos laterales**|Escalar privilegios o pivotar hacia otros hosts usando los accesos obtenidos.|

---

# 📌 ¿Por qué IPv6?

- Aunque muchas redes no lo usan activamente, **Windows habilita IPv6 por defecto**.
    
- **mitm6** explota esta "puerta trasera" para entregar respuestas falsas de DHCPv6 y DNS.


## 🧠 Esquema de DNS Takeover via IPv6

Así consigues acceso **sin necesidad de explotar vulnerabilidades tradicionales**.

[Red Corporativa] 
       |
       | (1) Las computadoras Windows están configuradas para usar IPv6 por defecto
       |
[Atacante (Kali Linux)]
       |
       | (2) Inicia mitm6
       | => mitm6 envía anuncios DHCPv6 falsos
       | => Dice a las víctimas: "Yo soy tu nuevo servidor DNS"
       |
[Máquinas Windows Víctimas]
       |
       | (3) Configuran automáticamente el servidor DNS (tu IP de atacante)
       | (sin que el usuario se entere)
       |
[Víctimas envían consultas DNS]
       |
       | (4) Las solicitudes de resolución de nombres ahora van al atacante
       |
[Atacante captura NTLM]
       |
       | (5) ntlmrelayx.py recibe las solicitudes de autenticación NTLM
       |
       | (6) Relay de hashes hacia LDAP / SMB / HTTP (según configuración)
       |
       | (7) Si los permisos lo permiten:
       |     - Crear un nuevo usuario en Active Directory
       |     - Registrar un SPN o máquina falsa
       |     - Moverse lateralmente




# 🌐 ¿Qué es **WPAD**?

**WPAD** significa **Web Proxy Auto-Discovery Protocol**.

Es un protocolo que permite a las computadoras encontrar automáticamente el **proxy de la red** sin que el usuario tenga que configurarlo manualmente.

**En otras palabras:**

- Es una forma en la que Windows (y otros sistemas) preguntan en la red:
    
    > "¿Dónde está mi servidor proxy?"
    
- Y si hay un servidor **WPAD**, el sistema **descarga automáticamente** un archivo de configuración `.pac` para enrutar su tráfico.


# 📌 ¿Cómo funciona WPAD en la práctica?

1. El cliente Windows hace una consulta DNS preguntando por `wpad.empresa.local`.
    
2. Si existe, se conecta al servidor WPAD.
    
3. Descarga un archivo `.pac` (proxy auto-config).
    
4. El navegador configura automáticamente el proxy que dice ese archivo.
    
5. Si el servidor WPAD es malicioso → el atacante captura tráfico o credenciales NTLM.


## ¿Cómo se hace?

Primeramente debemos de lanzar el relay para las peticiones ipv6


```bash
impacket-ntlmrelayx -6 -t ldaps://192.168.0.220 -wh fakewpad.marvel.local -l lootme -i
```

donde los parametros son:

+ -6: indica que se ejecutara con ipv6.
+ -t: este seria el LDAP objetivo
+ -wh: **WPAD host:** dice a las víctimas que descarguen el archivo WPAD desde este nombre malicioso. Se usa para capturar más NTLM o para forzar autenticaciones automáticas de navegador.
+ -l: carpeta donde `ntlmrelayx` guardará todo lo capturado: hashes, tickets, objetos LDAP enumerados, información sensible.
+ -i: después de capturar una autenticación válida, te da acceso a un menú interactivo para explotar manualmente: enumerar objetos LDAP, crear usuarios, abusar de permisos, etc. **(opcional)**

Despues ejecutaremos Mitm6:

```bash
sudo mitm6 -d marvel.local
```

Ahora cuando ocurra cualquier evento nos lo mostrará, e incluso, si hemos puesto el modo interactivo, se nos abrira una puerta para una consola de ldap y podremos crear usuarios, tambien el directorio lootme, nos vendra un monton de info sobre el dominio.

![[Pasted image 20250427131711.png]]

Para crear el usuario nuevo del dominio y que este pertenezca al grupo de **Enterprise Admins**, Tendremos que acceder a esta consola con el comando:

```bash
nc 127.0.0.1 11000
```

*esto dependerá de la dirección que te haya dado el **relay** .

![[Pasted image 20250427131913.png]]

Creamos el usuario dentro de la sesion de *nc*:

```bash
add_user test
```

y lo añadimos a los grupos que podamos, si podemos en administradores perfecto, si no a Enterprise Admins para despues poder usar secretsdumps.py

```bash
add_user_to_group test Administradores
```


# 🛡️ Estrategias de Mitigación para Ataques IPv6

### 1. **Bloquear tráfico DHCPv6 y anuncios de enrutador**

- **Por qué:** mitm6 y otros ataques aprovechan que Windows siempre consulta IPv6, incluso si solo usas IPv4.
    
- **Cómo prevenirlo:**
    
    - Bloquear tráfico DHCPv6 y anuncios de enrutadores en el firewall de Windows mediante GPO (Group Policy).
        
    - No es necesario deshabilitar completamente IPv6 (podría causar problemas en Windows).
        
- **Reglas específicas a bloquear:**
    
    - (Inbound) Core Networking - DHCPv6-In
        
    - (Inbound) Core Networking - ICMPv6-In (Router Advertisement)
        
    - (Outbound) Core Networking - DHCPv6-Out
        

---

### 2. **Desactivar WPAD si no se usa**

- **Por qué:** WPAD puede ser usado para forzar autenticaciones NTLM (secuestro).
    
- **Cómo:** Deshabilitar WPAD por GPO y detener el servicio `WinHttpAutoProxySvc`.
    

---

### 3. **Proteger LDAP/LDAPS contra NTLM relay**

- **Cómo:**
    
    - Activar **LDAP signing**.
        
    - Activar **LDAP channel binding**.
        

Así se evita que un relay NTLM funcione sobre LDAP o LDAPS.

---

### 4. **Proteger usuarios privilegiados**

- **Cómo:**
    
    - Mover usuarios administradores a **Protected Users group** o
        
    - Marcar cuentas como **"sensibles"** y **"no delegables"**.
        
- **Qué logra:**
    
    - Evitar que puedan ser suplantados mediante ataques de relay o delegación.