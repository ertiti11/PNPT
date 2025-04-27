![[Pasted image 20250425122454.png]]

### 📌 ¿Qué es?

Es un ataque de **envenenamiento de resolución de nombres** en redes Windows. Aprovecha protocolos antiguos como **LLMNR** y **NBT-NS** que entran en acción cuando el DNS falla al intentar resolver un nombre de red.

> 🧠 El atacante se hace pasar por un servidor inexistente para capturar **hashes de contraseñas** (NTLMv2).

---

# 🎯 ¿Qué puede hacer un atacante aprovechando LLMNR?

Cuando haces **LLMNR poisoning** (por ejemplo con `Responder`), logras:

|Objetivo|Qué consigues|
|---|---|
|**Capturar credenciales NTLM**|Hashes de usuario y contraseña que puedes crackear o relayar.|
|**Relay de autenticaciones**|Reutilizar los hashes capturados para autenticarte contra otros sistemas sin necesidad de crackearlos (SMB Relay, LDAP Relay, etc.).|
|**Movimientos laterales**|Si haces relay exitoso a otra máquina donde la víctima tiene permisos, puedes ejecutar comandos o tomar control.|
|**Elevación de privilegios**|Si capturas o relayas credenciales de un administrador, puedes escalar rápidamente.|
|**Acceso a información sensible**|Dependiendo de dónde puedas relayar, podrías sacar bases de datos, correos, ficheros, etc.|

### 📍 ¿Cuándo ocurre?

Cuando un equipo en la red intenta acceder a un nombre que no existe (por error del usuario o por procesos automáticos), y **no lo resuelve por DNS**.

Entonces el sistema lanza una petición LLMNR o NBT-NS del tipo:

> “¿Alguien sabe quién es `servidorx`?”

Ahí es cuando el atacante (con `Responder`) responde falsamente:

> “¡Yo soy `servidorx`!”

Y el cliente le envía su **hash de autenticación NTLM**, creyendo que está hablando con un servidor legítimo.

---

### 🛠️ ¿Cómo se hace el ataque?

#### ✅ Requisitos:

- Estar conectado a la red local (por cable, WiFi o VPN)
    
- Tener instalado `Responder` (viene en Kali Linux)
    

#### ⚙️ Comando básico:

```bash
sudo responder -I eth0 -dwP
```


Donde `eth0` es la interfaz de red (puedes verla con `ip a`)

#### 📥 Resultado:

Cada vez que un dispositivo haga una petición fallida y entre LLMNR/NBT-NS, Responder capturará el hash NTLM del usuario.

---

### 🧪 Ejemplo real:

1. Un usuario tiene una unidad mapeada a `\\servidor-viejo` que ya no existe.
    
2. Su PC intenta reconectar esa unidad automáticamente.
    
3. El nombre no se resuelve por DNS.
    
4. Se lanza una petición LLMNR.
    
5. El atacante con Responder dice “Yo soy `servidor-viejo`”.
    
6. El PC del usuario le manda su **hash NTLMv2**.
    
7. El atacante captura el hash y puede intentar **crackearlo con `hashcat` o `john`**.
    

---

### 🛡️ ¿Cómo se mitiga?

- Desactivando **LLMNR y NBT-NS** por GPO o manualmente.
    
- Usando **DNS bien configurado**.
    
- Revisando scripts, accesos mapeados y dispositivos con rutas obsoletas.
    
- Implementando **SMB Signing**.
    

---

### 📚 Comando para ver hashes capturados (en la carpeta de Responder):

```bash
cat /usr/share/responder/logs/Responder-Session.log
```

![[Pasted image 20250425151128.png]]

## Crackear los hashes

### 1. Meter las contraseñas en un archivo de texto plano

copiar el hash en un archivo hash.txt



### Hashcat

Para ver que tipo de hash es ejecutaremos lo siguiente

```bash
hashcat --help | grep NTLM
```


![[Pasted image 20250425151613.png]]

Para el cracking ejecutaremos

```bash
hashcat -m 5600 hash /usr/share/wordlists/rockyou.txt -O
```

Donde 5600 sera el ID del tipo de hash recibido anteriormente.
a veces hay que añadir el parametro --force
+ -m es el tipo de hash
+ **hash** es el archivo donde esta almacenado el hash
+ -O aumenta la velocidad del crackeo

Para ver el hash crackeado:

```bash
hashcat -m 5600 hash /usr/share/wordlists/rockyou.txt --show  
```

## Lista de contraseñas

EXISTE ROCKYOU 2021 QUE PESA 90GB EN COMPARACION DE ROCKYOU ORIGINAL QUE PESA 600MB




## 🛡️ Mitigación del envenenamiento LLMNR

**Mejor defensa:** Deshabilitar **LLMNR** y **NBT-NS**.

- 🔧 Para deshabilitar **LLMNR**:
    
    - Ir a: Política de grupo local → Configuración del equipo → Plantillas administrativas → Red → Cliente DNS.
        
    - Seleccionar: **“Desactivar resolución de nombres de multidifusión”**.
        
- 🔧 Para deshabilitar **NBT-NS**:
    
    - Ir a: Conexiones de red → Propiedades del adaptador → Propiedades TCP/IPv4 → Pestaña Avanzado → Pestaña WINS.
        
    - Seleccionar: **“Deshabilitar NetBIOS sobre TCP/IP”**.
        

---

### 🛡️ Si no se puede deshabilitar LLMNR/NBT-NS:

- Implementar **control de acceso a la red**.
    
- Exigir **contraseñas fuertes**:
    
    - Más de **14 caracteres**.
        
    - Evitar palabras comunes.
        
    - Cuanto más larga y compleja, más difícil es romper el hash.
    
### 📌 Casos en los que no se puede deshabilitar LLMNR:

1. **Sistemas o aplicaciones legadas**  
    Algunas aplicaciones antiguas dependen de LLMNR o NBT-NS para la resolución de nombres porque no usan DNS adecuadamente.
    
2. **Ambientes mixtos o heterogéneos**  
    Redes que mezclan distintos sistemas operativos (Windows, Linux, dispositivos IoT) pueden requerir compatibilidad con métodos de resolución más antiguos.
    
3. **Desconocimiento o limitaciones administrativas**  
    Organizaciones grandes con políticas distribuidas o poco control sobre las estaciones de trabajo pueden tener dificultades para aplicar cambios a nivel de política de grupo (GPO).
    
4. **Entornos de desarrollo o pruebas**  
    Algunos equipos usan LLMNR/NBT-NS para facilitar conexiones rápidas entre dispositivos sin configurar DNS manualmente.
    
5. **Dependencias con dispositivos de red o software propietario**  
    Algunos dispositivos embebidos o software comercial pueden usar LLMNR para descubrimiento de servicios o resolución de nombres.
    

---

### 💡 ¿Qué hacer si no puedes deshabilitarlo?

Implementar mitigaciones como:

- Control de acceso a la red (NAC).
    
- Contraseñas fuertes y políticas de bloqueo.
    
- Supervisión activa del tráfico para detectar ataques de tipo "poisoning".