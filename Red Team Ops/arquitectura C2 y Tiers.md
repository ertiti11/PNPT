En las operaciones modernas del Equipo Rojo y la emulación de adversarios, **La infraestructura de comando y control (C2) debe diseñarse con redundancia, sigilo y adaptabilidad**. Un método común para lograrlo es diseñar la infraestructura utilizando **múltiples niveles de C2**—cada uno con un propósito operativo y nivel de exposición diferentes.

Esta estructura escalonada aumenta la resiliencia y permite la recuperación de compromisos parciales o la detección. Refleja comportamientos adversarios del mundo real, donde a menudo se emplean mecanismos alternativos y rutas de comunicación retrasadas.

---

![](https://images.coursestack.com/62c9b0f6-6a0a-488c-870b-4ca0ac754378/7b0a386f-d867-4517-bdcd-751d6ec7fe65)

Niveles de ejemplo

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-tiered-c2-architecture-overview)**Descripción general de la arquitectura C2 escalonada**

|Nivel|Propósito|Características|
|---|---|---|
|Nivel 1|Interactivo|Control en tiempo real de alto riesgo|
|Nivel 2|Transporte corto (semiinteractivo)|Comunicación encubierta y retrasada|
|Nivel 3|Transporte de larga distancia (no interactivo/pasivo)|Respaldo resistente y ultra sigiloso|

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-tier-1--interactive-c2)**Nivel 1 – C2 interactivo**

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-purpose)Propósito:

Este nivel se utiliza para **control en vivo** de sistemas comprometidos. Admite interacción directa como:

- Enumeración de anfitriones
- Recolección de credenciales
- Descargas y cargas de archivos
- Movimiento lateral
- Estadificación y exfiltración de datos

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-characteristics)Características:

- **Comunicación de alta frecuencia** (intervalos de baliza en segundos o minutos)
- Tareas y respuestas en tiempo real
- **Más capaz**, pero **más detectable**
- Se utiliza a menudo durante el **post-explotación y acción sobre objetivos** fases

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-risks)Riscuri:

- El alto volumen y la regularidad temporal facilitan la detección mediante el monitoreo de la red
- Si se descubre, probablemente dará como resultado **pérdida de agente o bloqueo de C2**
- Puede requerir ofuscación adicional, interfaz de dominio o redireccionadores

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-usage-considerations)Consideraciones de uso:

- Uso **con prudencia y conocimiento de las ventanas de detección**
- Rotar o restablecer la infraestructura con frecuencia
- Lo ideal es enrutar el tráfico a través de múltiples redirectores o CDN

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-tier-2--short-haul-c2)**Nivel 2 – Transporte corto C2**

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-purpose-1)Propósito:

Este nivel funciona como un **canal de respaldo resiliente** cuando se pierde el Nivel 1 o su uso se vuelve riesgoso. Permite **recuperación de acceso** y tareas limitadas.

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-characteristics-1)Características:

- **Baliza retardada** (intervalos que van de 1 a 24 horas)
- **Comunicación encubierta de bajo volumen**
- Imita tráfico legítimo (por ejemplo, Office 365, API de Google)
- Puede utilizar puertos menos comunes o protocolos ocultos (DNS, HTTP sobre CDN)

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-risks-1)Riscuri:

- Menor riesgo de detección, pero **capacidad limitada** debido a la baja interacción
- Las herramientas de detección estándar pueden pasar desapercibidas
- Utilizado principalmente para **restablecimiento del C2 interactivo**

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-usage-considerations-1)Consideraciones de uso:

- El implante debe soportar **autoescalada** a este nivel en caso de fracaso del Nivel 1
- Crítico para **persistencia y respaldo**
- La configuración del tráfico y la minimización de artefactos en los puntos finales son fundamentales

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-tier-3--long-haul-c2)**Nivel 3 – C2 de larga distancia**

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-purpose-2)Propósito:

Este es el **respaldo de último recurso** diseñado para la persistencia y recuperación a largo plazo en caso de compromiso generalizado, detección o desmantelamiento de infraestructura.

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-characteristics-2)Características:

- **Intervalos de baliza muy lentos** (24+ horas, a veces días o incluso semanas)
- Transmisión mínima de datos (solo latidos del corazón)
- Puede utilizar canales no convencionales (por ejemplo, alojamiento de archivos encubiertos, sondeo de almacenamiento en la nube, esteganografía)
- Reside tranquilamente en los anfitriones durante períodos prolongados

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-risks-2)Riscuri:

- **Baja detectabilidad**, pero extremadamente limitadas en capacidades
- Puede desactivarse mediante restablecimientos de puntos finales o actualizaciones del agente de seguridad
- Usado sólo para **bootstrap niveles superiores** cuando no quedan otros

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-usage-considerations-2)Consideraciones de uso:

- Diseñado para **longevidad, no volumen operativo**
- Puede utilizar **solucionadores de caída muerta codificados** o dominios C2 resilientes
- A menudo incluye **lógica de vigilancia** para evitar activar alarmas de comportamiento

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-design-considerations-for-tiered-c2-infrastructure)**Consideraciones de diseño para infraestructura C2 escalonada**

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-1-isolation)1. **Aislamiento**

- Infraestructura separada para cada nivel (direcciones IP, proveedores de VPS, certificados TLS)
- Compartimentar los implantes por nivel y objetivo

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-2-redundancy)2. **Redundancia**

- Uso **múltiples implantes de respaldo** por anfitrión
- Los implantes de nivel 2 y nivel 3 deben promocionarse automáticamente al nivel 1 si se restablece C2

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-3-infrastructure-hardening)3. **Endurecimiento de infraestructura**

- Todos los niveles deben utilizar un cifrado sólido y verificación de firmas
- Implementar controles de acceso estrictos y monitoreo operativo en los nodos C2

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-4-command-differentiation)4. **Diferenciación de comandos**

- Los niveles deben tener capacidades distintas:
    - Nivel 1: Soporte completo para módulos interactivos
    - Nivel 2: Tareas mínimas con transferencia de archivos y control de balizas
    - Nivel 3: Registro básico de balizas y recuperación de comandos únicamente

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-example-beaconing-strategy)**Ejemplo de estrategia de baliza**

|Nivel|Intervalo de baliza|Tipo de comunicación|Notas|
|---|---|---|---|
|Nivel 1|30s – 2 min|HTTP(S), SMB, TCP|Interactivo; alta exposición|
|Nivel 2|1h – 12h|DNS, HTTP(S), llamadas API|Retrasado y sigiloso; tarea parcial|
|Nivel 3|24h – 72h+|Métodos de sondeo encubiertos|Pasivo; solo acceso alternativo|

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/c2-and-tiers-architecture#user-content-benefits-of-a-tiered-c2-model)**Beneficios de un modelo C2 escalonado**

- **Resiliencia**: Las operaciones pueden continuar incluso después de la detección
- **Sigilo**: No todos los implantes necesitan exponerse simultáneamente
- **Flexibilidad**: Los operadores pueden escalar o reducir la interacción en función del riesgo de OpSec
- **Redundancia**: Múltiples caminos para recuperar el acceso a objetivos de alto valor