



# Domain Controller

un controlador de dominio es un windows server con el role de DC instalado

Tienen:
+ contiene una copia de AD DS directory store
+ provee de auth y servicios de autorizacion
+ replica actualizaciones a otro controladores de dominio en el dominio y en el bosque
+ permite control administrativo de cuentas de usuarios y recursos de red

## AD DS data store (Ntds.dit)

### 📁 **Ubicación típica**

```
%SystemRoot%%\ntds.dit
```

---

### 📌 **¿Qué contiene?**

- Es la **base de datos principal de Active Directory**.
    
- Contiene toda la **información crítica del dominio**, incluyendo:
    
    - Usuarios y contraseñas (en formato hash)
        
    - Grupos
        
    - Unidades organizativas (OU)
        
    - Políticas
        
    - Otros objetos del directorio
        

---

### 🔐 **Hash de contraseñas**

- Las contraseñas **no están en texto plano**.
    
- Están guardadas como **hashes**: normalmente **NTLM** y a veces también **LM** (si está habilitado).
    
- Estos hashes pueden ser **crackeados offline**.
    

---

### 🛠️ **Herramientas para extraerlo**

#### 🧪 Desde un pentest:

1. **Volume Shadow Copy + reg save + copy**
    
    - Crear una copia del sistema y extraer `ntds.dit` + `SYSTEM` hive (clave de encriptación):
        ```powershell
        vssadmin create shadow /for=C:
copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopyX\Windows\NTDS\ntds.dit .
reg save HKLM\SYSTEM SYSTEM.hive
```
        
        
        
2. **Herramientas como:**
    
    - `secretsdump.py` (Impacket):
        
        ```bash
        secretsdump.py -system SYSTEM -ntds ntds.dit LOCAL

```
        
    - `mimikatz`
        
    - `ntdsxtract`
        
    - `crackmapexec` (post-auth)
        

---

### ⚠️ **Importancia en un pentest**

- Obtener `ntds.dit` = **control total del dominio**.
    
- Permite **extraer credenciales**, **moverse lateralmente**, **escalar privilegios**.
    
- Es uno de los **objetivos más valiosos** en post-explotación.
    

---

### 🧰 **Qué puedes hacer tras obtenerlo**

- Crackear hashes con **Hashcat/John the Ripper**
    
- Buscar cuentas privilegiadas (como `Domain Admin`)
    
- Acceder a recursos protegidos
    
- Realizar **Golden Ticket attacks** (si se obtiene el KRBTGT hash)


## Componentes


## 🧬 **AD DS Schema (Esquema de Active Directory)**

---

### 📌 ¿Qué es?

Es la **estructura lógica** que define **todos los objetos** y sus **atributos** en Active Directory.

---

### 🔧 ¿Qué contiene?

- **Clases de objetos** (como usuario, grupo, equipo)
    
- **Atributos** de cada clase (como nombre, correo, SID)
    

---

### 🧠 ¿Para qué sirve?

- Determina **qué se puede crear y cómo** se almacena en AD.
    
- Es la **base** para que AD funcione correctamente.
    

---

### ⚠️ Datos clave

- **Solo hay uno por bosque**.
    
- Es **extendible** (por ejemplo, al instalar Exchange o SCCM).
    
- ¡Cambiarlo mal puede romper todo AD!




## 🌐 **Dominios en Active Directory (AD)**

---

### 📌 ¿Qué es un dominio?

Es la **unidad principal de organización y seguridad** en AD.  
Agrupa **usuarios, equipos y recursos** bajo una misma política y administración.

---

### 🧱 ¿Qué define?

- **Límites de seguridad** (políticas, autenticación)
    
- **Base de datos propia** (cada dominio tiene su copia del AD)
    
- Nombre único: ej. `empresa.local`
    

---

### 🔐 ¿Quién lo controla?

- Un **Controlador de Dominio (DC)** gestiona el dominio y la autenticación.
    

---

### 🌳 Relación con otros dominios

- Pueden formar parte de un **árbol** o un **bosque**.
    
- Se conectan mediante **relaciones de confianza (trusts)**.


## 🌲 **Bosque (Forest) en Active Directory**

---

### 📌 ¿Qué es?

Es la **estructura más alta** en AD.  
Un **bosque** agrupa uno o varios **dominios** que comparten:

- Un **esquema común** (estructura de objetos/atributos)
    
- Un **catálogo global**
    
- Relaciones de confianza automáticas
    

---

### 🧠 ¿Para qué sirve?

- Permite tener **múltiples dominios independientes**, pero **conectados y gestionables**.
    
- Se usa en empresas grandes o con varias filiales.
    

---

### ⚙️ Características

- El primer dominio creado es el **dominio raíz del bosque**.
    
- Se puede tener **un solo bosque** o varios bosques con **trusts entre ellos**.
    

---

### 🧪 Ejemplo

Una empresa con:

- `empresa.local` (raíz)
    
- `ventas.empresa.local`
    
- `it.empresa.local`
    

Todos forman parte del **mismo bosque**.