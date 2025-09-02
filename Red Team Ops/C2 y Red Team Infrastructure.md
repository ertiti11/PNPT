### **1. Comando y Control (C2)**

**Comando y Control (C2)** se refiere al canal de comunicación establecido entre un sistema comprometido (el "agente") y el sistema del atacante (el "servidor"). C2 es una fase crítica en las operaciones posteriores a la explotación, que permite al atacante interactuar con activos comprometidos, exfiltrar datos, moverse lateralmente o implementar cargas útiles adicionales.

#### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-red-team-infrastructure#user-content-key-c2-functions)**Funciones clave C2:**

- Envío de comandos a hosts comprometidos
- Recibir salida de las máquinas de destino
- Mantener la persistencia y el control de la sesión
- Ejecución de scripts, módulos o implantes
- Gestión de múltiples objetivos (manejo de sesiones)

#### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-red-team-infrastructure#user-content-types-of-c2-channels)**Tipos de canales C2:**

- **HTTP/HTTPS**: Apto para evasivas y sigiloso, a menudo imitando el tráfico web legítimo.
- **DNS**: Canal encubierto y de bajo ancho de banda útil para entornos con reglas de firewall estrictas.
- **Tuberías SMB/con nombre**: Se utiliza en redes internas para movimiento lateral.
- **Protocolos personalizados**: Protocolos personalizados diseñados para evadir la detección.

#### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-red-team-infrastructure#user-content-popular-c2-frameworks)**Marcos C2 populares:**

- **Huelga de cobalto**
- **Astilla**
- **Mítico**
- **Havoc**
- **Ratel bruto**
- **Imperio**
- **Cachorro**

---

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-red-team-infrastructure#user-content-2-redirectors)**2. Redirectores**

**Redirectores** son servidores intermedios que **tráfico de retransmisión o de avance** entre el servidor C2 y los sistemas comprometidos. Están acostumbrados a:

- **Ofuscar la verdadera ubicación** de la infraestructura del atacante
- **Distribuir tráfico** y reducir la exposición del servidor C2 principal
- Enable **segmentación operativa** (por ejemplo, diferentes redirectors por campaña o equipo)

#### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-red-team-infrastructure#user-content-types-of-redirectors)**Tipos de redireccionadores:**

- **Transportistas portuarios** (por ejemplo, `socat`, `iptables`, tunelización SSH)
- **Proxies inversos HTTP/S** (por ejemplo, `Apache`, `nginx`)
- **Redirecciones de interfaz de dominio** (utilizando infraestructura en la nube como Azure o CloudFront para integrarse con dominios confiables)

#### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-red-team-infrastructure#user-content-example-setup)**Ejemplo de configuración:**

```
Compromised Host → Redirector (nginx reverse proxy) → C2 Server
```

---

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-red-team-infrastructure#user-content-3-red-team-infrastructure)**3. Infraestructura del equipo rojo**

Las operaciones del Equipo Rojo requieren un equipo cuidadosamente segmentado y seguro **atacar infraestructura**, a menudo dividido en múltiples roles:

#### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-red-team-infrastructure#user-content-core-components)**Componentes principales:**

|Componente|Propósito|
|---|---|
|**Servidor C2**|Ejecuta el software de comando y control (por ejemplo, Cobalt Strike teamserver)|
|**Redirectores**|Enmascarar el origen del tráfico y proporcionar una capa amortiguadora|
|**Escenarios**|Cargas útiles iniciales, scripts y exploits del host|
|**Servidores de archivos**|Entregar herramientas y descargables durante las operaciones|
|**Sistemas de registro**|Almacene registros de la actividad del operador y la interacción con el objetivo|
|**Estaciones de trabajo del operador**|Entornos locales desde los que los operadores ejecutan campañas|

#### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-red-team-infrastructure#user-content-best-practices-for-infrastructure)**Mejores prácticas para infraestructura:**

- Uso **instancias VPS dedicadas** por función (C2, redirector, puesta en escena)
- Ensure **segmentación** entre la coordinación interna del Equipo Rojo y el tráfico externo
- Aplicar **Certificados TLS** (por ejemplo, Let's Encrypt) para canales HTTPS C2
- Uso **proveedores de nube en diferentes regiones** para evitar la detección de patrones
- Rotar la infraestructura entre operaciones para evitar quemaduras

---

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-red-team-infrastructure#user-content-operational-security-opsec-tips)**Consejos de seguridad operativa (OpSec):**

- Nunca exponga su IP real o servidor de control directamente
- Monitorear el tráfico de entrada y salida de todos los nodos
- Uso **frente de dominio** o **redireccionadores de nube** mezclarse con el tráfico conocido como bueno
- Implementar **perfiles de tráfico** para emular un comportamiento legítimo (por ejemplo, imitar Microsoft Update o el tráfico de Google)
- Asegure la infraestructura con reglas de firewall y control de acceso (por ejemplo, claves SSH, MFA)

---

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-red-team-infrastructure#user-content-diagram--example-c2-architecture)**Diagrama – Ejemplo de arquitectura C2**

```
+------------------+         +------------------+         +------------------+
| Compromised Host | <--->   | Redirector (nginx)| <--->  |  C2 Server       |
+------------------+         +------------------+         +------------------+
                                   ↑                             ↑
                             [Cloud Provider]             [Red Team Operator]
```

---

Al dominar C2, el uso de redirector y el diseño de infraestructura, Red Teamers puede ejecutar operaciones sigilosas, persistentes y efectivas mientras minimiza el riesgo de exposición o atribución. Este conocimiento es esencial para cualquier programa maduro de emulación de adversarios.