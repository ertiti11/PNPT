|Aspecto|**Simulación adversaria**|**Emulación adversaria**|
|---|---|---|
|**Definición**|Un ejercicio más amplio que simula el comportamiento de un atacante sin replicar uno específico.|Una reproducción precisa de los TTP del mundo real de un actor de amenazas conocido.|
|**Gol**|Pruebe las capacidades de detección y respuesta de una organización en condiciones similares a las de un ataque.|Evaluar cómo responde el medio ambiente a la **comportamientos exactos** de un adversario conocido.|
|**Especificidad del actor de amenazas**|Comportamiento generalizado del atacante (por ejemplo, una campaña de phishing, escenario de movimiento lateral).|Estrechamente alineado con un actor real (por ejemplo, APT29, FIN7) utilizando TTP respaldados por inteligencia.|
|**Caso de uso**|Operaciones del Equipo Rojo, validación de control de seguridad, ejercicios SOC.|Defensa basada en amenazas, trabajo en equipo morado, ajuste de reglas de detección.|
|**Marcos utilizados**|MITRE ATT&CK, Cyber Kill Chain, escenarios personalizados.|MITRE ATT&CK, informes de información sobre amenazas (Mandiant, CISA, etc.), datos CTI.|
|**Nivel de realismo**|Alto, pero centrado en el impacto del escenario sobre la fidelidad exacta.|Muy alto — intentos de **imita exactamente el comportamiento del atacante**.|
|**Personalización**|Flexible — adaptado al entorno y objetivos de la organización.|Rígido — basado en las técnicas conocidas de un APT o grupo específico.|
|**Ejemplos**|Simulación de la implementación de ransomware en un departamento de finanzas.|Recreando la cadena de eliminación de malware + spear-phishing de APT28’.|

---

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/adversary-simulation-vs-adversary-emulation#user-content-in-simple-terms)En términos simples:

- **Simulación adversaria** = “Actuemos como un atacante y probemos el equipo azul.”
    - Enfoque: Impacto, cobertura, aprendizaje
    - Ejemplo: Simular una campaña de phishing + movimiento lateral, no vinculado a un grupo específico.
- **Emulación adversaria** = “Actuemos exactamente como APT29.”
    - Enfoque: Precisión, fidelidad, cobertura de detección de **actor conocido**
    - Ejemplo: utilice el mismo cargador, canales C2 y técnicas de escalada de privilegios observadas en incidentes del mundo real.

---

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/adversary-simulation-vs-adversary-emulation#user-content-when-to-use-each)¿Cuándo utilizar cada uno?

- **Utilice simulación** cuando:
    - Quieres un **visión amplia** de postura defensiva
    - Estás poniendo a prueba la resiliencia general
    - Estás corriendo **ejercicios o escenarios de mesa**
- **Utilice emulación** cuando:
    - Quieres **validar detecciones** para a **actor de amenazas conocido**
    - Estás mapeando brechas en MITRE ATT&CK
    - Estás trabajando estrechamente con **Amenaza Intel** y equipos azules