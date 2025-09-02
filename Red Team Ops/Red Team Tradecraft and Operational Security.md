Aquí tienes la **traducción completa al español**:

---

### ¿Qué es Red Team Tradecraft?

**Red Team Tradecraft** se refiere al conjunto de habilidades, técnicas y metodologías utilizadas por los equipos de Red Team para simular operaciones adversarias encubiertas y realistas contra una organización objetivo.  
Estas habilidades se inspiran en los comportamientos de actores de amenazas reales, como APTs (_Advanced Persistent Threats_), grupos cibercriminales y amenazas internas.

El objetivo del _tradecraft_ del Red Team es:

- Obtener acceso a entornos sensibles
    
- Mantener persistencia
    
- Evadir la detección
    
- Alcanzar objetivos definidos (ej. exfiltración de datos)
    
- Proporcionar resultados medibles que mejoren la defensa de la organización
    

---

### ¿Qué es OpSec en Red Teaming?

**Seguridad Operacional (OpSec)** en Red Teaming implica la protección activa de las herramientas, infraestructura, identidad y técnicas del Red Team para:

- Evitar una detección temprana por parte de los equipos Blue Team
    
- Prevenir la atribución
    
- Proteger los objetivos del ejercicio
    

Refleja la práctica adversaria real de minimizar la exposición en cada fase de una operación.

---

### Fases de un ejercicio de Red Team (con enfoque en Tradecraft)

|Fase|Objetivos de Tradecraft|
|---|---|
|Reconocimiento|Enumerar objetivos de forma pasiva (OSINT, DNS, GitHub, etc.)|
|Arma (Weaponization)|Crear _payloads_ o infraestructura de phishing a medida|
|Entrega|Entrega encubierta vía phishing, USB drops, watering holes|
|Explotación|Explotar vulnerabilidades o configuraciones erróneas|
|Instalación|Establecer acceso (ej. _implants_, _web shells_)|
|C2 (_Command & Control_)|Mantener canales de comunicación cifrados y sigilosos|
|Acciones sobre objetivos|Exfiltrar datos, movimiento lateral, escalada de privilegios|
|Exfiltración y salida|Limpieza, reporte de hallazgos, evitar indicadores residuales|

---

### Áreas principales de Tradecraft

**1. Acceso inicial**

- Phishing (spear phishing, BEC)
    
- Documentos de Office maliciosos (macros, DDE, OLE)
    
- Explotación en _watering holes_ o navegadores
    
- Acceso físico (clonado de tarjetas, dispositivos maliciosos)
    
- Herramientas: Gophish, Evilginx, Unicorn, MSFVenom, HID Attacks
    

**2. Ofuscación de _payloads_ y evasión**

- Codificación de _shellcode_ (XOR, AES, RC4)
    
- Uso de _syscalls_ para evadir detección en espacio de usuario
    
- _Unhooking_ de APIs y evasión en memoria
    
- Uso de binarios del sistema (LOLBins: mshta, regsvr32, rundll32)
    
- Herramientas: Donut, Shellter, Nimcrypt2, ScareCrow, PEzor
    

**3. Persistencia**

- Autoruns en el registro (HKCU\Software\Microsoft\Windows\CurrentVersion\Run)
    
- Tareas programadas (schtasks)
    
- Suscripciones a eventos WMI
    
- _DLL hijacking_ o _side-loading_
    
- Accesos directos en la carpeta de inicio
    
- TTPs: MITRE T1053, T1547
    

**4. Escalada de privilegios**

- Suplantación de tokens (SeImpersonatePrivilege)
    
- Abuso de servicios mal configurados
    
- Explotar permisos débiles (binarios de servicio modificables)
    
- Explotación de kernel (solo en entornos controlados)
    
- Herramientas: WinPEAS, SharpUp, JuicyPotato, PrintSpoofer
    

**5. Movimiento lateral**

- _Pass-the-Hash / Pass-the-Ticket_
    
- Ejecución remota de servicios (WMI, PSExec, SMB)
    
- RDP con credenciales obtenidas
    
- Herramientas personalizadas internas
    
- Herramientas: CrackMapExec, Impacket, SMBexec, SharpRDP
    

**6. Acceso a credenciales**

- _Dumping_ de LSASS (procdump, comsvcs.dll)
    
- Extracción de contraseñas de navegadores
    
- Extracción de SAM/NTDS.dit
    
- Keylogging o captura de portapapeles
    
- Herramientas: Mimikatz, LaZagne, SharpDump, Seatbelt
    

**7. Comando y Control (C2)**

- Canales cifrados (HTTPS, DNS tunneling)
    
- _Beacons_ personalizados o _implants_ sin _stager_
    
- _Domain fronting_ y _redirectors_
    
- Intervalos largos + _jitter_ para evadir detección de red
    
- Frameworks: Cobalt Strike, Sliver, Mythic, Havoc
    

**8. Exfiltración de datos y acciones sobre objetivos**

- Esteganografía o datos en etapas vía HTTP(S)
    
- Uso de servicios en la nube (OneDrive, Dropbox)
    
- Codificación para evadir DLP
    
- Camuflaje como tráfico legítimo
    
- Herramientas: Rclone, DNSExfiltrator, Invoke-ExfilData
    

---

### Principios de OpSec en Red Teaming

|Principio|Aplicación en Red Teaming|
|---|---|
|Menor privilegio|Usar los permisos mínimos en infraestructura y agentes|
|Compartimentación|Segmentar servidores C2, infraestructura, _payloads_ y roles|
|Separación operativa|Infraestructura distinta para staging, C2, phishing, etc.|
|_Traffic shaping_|Imitar servicios legítimos (Office365, Google CDN)|
|Control de detección|Evitar comportamientos repetitivos que disparen alertas|
|Evadir atribución|Usar cabeceras falsas, _implants_ aleatorios, evitar herramientas públicas|

---

### Tácticas de infraestructura con enfoque en OpSec

- Varios _redirectors_ por campaña usando nginx, socat o haproxy
    
- Certificados TLS de Let's Encrypt para C2 por HTTPS
    
- Servidores de staging en la nube (DigitalOcean, Vultr, AWS)
    
- Aleatorización de tráfico (patrones de URI, intervalos de _beacons_)
    
- Rotación de infraestructura: eliminar tras el ejercicio o detección
    

---

### Higiene de logs y limpieza

- Eliminar todos los artefactos (payloads, scripts, logs)
    
- Limpiar registros de eventos de Windows (donde esté autorizado)
    
- Revertir cambios en registro y servicios
    
- Verificar que no queden _backdoors_ accidentales
    
- Proporcionar informe final y, opcionalmente, _logs_ aptos para forense
    

---

### Reflexiones finales

El _tradecraft_ del Red Team trata de **precisión, sigilo y realismo**.  
El objetivo no es “ganar”, sino ofrecer **insights medibles** sobre qué tan bien una organización puede detectar y responder a amenazas avanzadas.

La **OpSec** es lo que marca la diferencia entre una detección temprana y un ejercicio exitoso de varias semanas que refleja amenazas reales.

Un Red Team maduro equilibra:

- Habilidad técnica
    
- Modelado de amenazas
    
- Capacidades de evasión
    
- Responsabilidad ética
    

