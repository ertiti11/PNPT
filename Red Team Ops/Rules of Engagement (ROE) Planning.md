## **¿Qué son las Reglas de Compromiso (ROE) en las Operaciones del Equipo Rojo?**

**Reglas de compromiso (ROE)** son un conjunto formal de **Restricciones, pautas y permisos predefinidos** que rigen cómo puede operar un Equipo Rojo durante un enfrentamiento. Estas reglas garantizan que la simulación sea realista, pero también **controlado, legal y alineado con el apetito de riesgo de la organización** siendo probado.

Las ROE son esenciales para:

- **Definir alcance y límites**
- **Garantizar el cumplimiento legal y regulatorio**
- **Proteger a la organización de daños no deseados**
- **Establecer expectativas claras tanto para los equipos ofensivos como defensivos**
- **Mantener la confianza entre el cliente y Red Team**

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/rules-of-engagement-roe-planning#user-content-key-elements-of-roe-planning)**Elementos clave de la planificación de ROE**

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/rules-of-engagement-roe-planning#user-content-1-scope-definition)1. **Definición de alcance**

- **Activos dentro del alcance**: rangos de IP, dominios, aplicaciones, empleados, ubicaciones físicas.
- **Activos fuera de alcance**: Sistemas críticos de producción, servicios de terceros, zonas de datos reguladas.
- Debe incluir listas claras de activos y si se permite el pivoteo.

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/rules-of-engagement-roe-planning#user-content-2-timeframe)2. **Plazo**

- Fechas de inicio y finalización del compromiso.
- Horario de atención permitido (por ejemplo, solo fuera del horario comercial o 24 horas al día, 7 días a la semana).
- Duración de cada fase (recon, explotación, post-explotación).

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/rules-of-engagement-roe-planning#user-content-3-authorized-techniques)3. **Técnicas autorizadas**

- Qué TTP están permitidos (p. ej., phishing, caídas USB, movimiento lateral).
- Si se permite la ingeniería social o la intrusión física.
- Restricciones a las técnicas destructivas (por ejemplo, no realizar simulaciones de ransomware sin consentimiento).

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/rules-of-engagement-roe-planning#user-content-4-constraints-and-limitations)4. **Restricciones y limitaciones**

- Número máximo de hosts a comprometer.
- Sin modificación ni eliminación de datos de producción.
- Evitación de condiciones de denegación de servicio (DoS).
- Niveles preaprobados de escalada de privilegios.

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/rules-of-engagement-roe-planning#user-content-5-communication-protocols)5. **Protocolos de comunicación**

- Puntos de contacto primarios y alternativos (POC).
- Cómo escalar hallazgos críticos en tiempo real.
- Canales de comunicación seguros (por ejemplo, señal, correo electrónico PGP).
- Requisitos de informes de estado diarios o semanales (si los hubiera).

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/rules-of-engagement-roe-planning#user-content-6-kill-switch--emergency-exit)6. **Interruptor de apagado / Salida de emergencia**

- Un mecanismo (generalmente una frase de código o procedimiento predefinido) que detiene inmediatamente la interacción si:
    - Un servicio crítico se interrumpe.
    - Hay un impacto no intencional en las operaciones.
    - Surgen riesgos legales o de cumplimiento.
- Esto debe ser comprendido y acordado por ambas partes.

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/rules-of-engagement-roe-planning#user-content-7-legal-and-regulatory-considerations)7. **Consideraciones legales y regulatorias**

- Autorización firmada (carta "Sal de la cárcel gratis").
- Políticas de manejo y retención de datos.
- Cumplimiento de leyes como GDPR, HIPAA, PCI-DSS, etc.
- Restricciones a las pruebas en entornos transfronterizos o multiinquilino.

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/rules-of-engagement-roe-planning#user-content-8-team-identification-and-behavior)8. **Identificación y comportamiento del equipo**

- Es posible que se requiera que el Equipo Rojo:
    - Utilice infraestructura específica (por ejemplo, regiones de nube).
    - Etiquetar cargas útiles o implantes para su trazabilidad.
    - Registre todas las acciones para su revisión posterior al compromiso.

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/rules-of-engagement-roe-planning#user-content-roe-examples-in-practice)**Ejemplos de ROE en la práctica**

|Escenario|Decisión ROE|
|---|---|
|Simulación de ataques de phishing|Solo se permiten 3 plantillas de correo electrónico; no hay enlaces a malware real|
|Prueba de sistemas internos|No se permite el acceso a bases de datos de producción|
|Prueba de intrusión física|Se permite la clonación de insignias; está prohibido el tailgating|
|Ejecución de malware en vivo|Sólo implantes aprobados; debe evitar activar alertas EDR|

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/rules-of-engagement-roe-planning#user-content-why-roe-matters)Por qué es importante ROE

Sin ROE claros:

- Los equipos rojos pueden provocar interrupciones comerciales accidentalmente.
- El acceso no autorizado puede tener consecuencias legales.
- La confianza entre los equipos de seguridad y las partes interesadas puede erosionarse.
- Los resultados valiosos pueden ser descartados debido a violaciones éticas o procesales.

Las ROE son las **columna vertebral de la seguridad ética ofensiva** — transforman lo que podría verse como un ataque en un **Simulación segura y autorizada** que produce resultados mensurables y defendibles.

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/rules-of-engagement-roe-planning#user-content-recommended-roe-documents-and-templates)Documentos y plantillas de ROE recomendados

- **Carta de compromiso**
- **Carta de Autorización (LOA)**
- **Attack Playbook (catálogo TTP con etiquetas ROE)**
- **Inventario objetivo (dentro/fuera del alcance)**
- **Matriz de comunicación**
- **Registro de revisión de ROE posterior al compromiso**