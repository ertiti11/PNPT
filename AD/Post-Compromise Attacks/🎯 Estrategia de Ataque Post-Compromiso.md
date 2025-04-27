

---

## 📚 ¿Ya tenemos una cuenta comprometida? ¿Qué hacemos ahora?

### 1. **Buscar los "Quick Wins" (fáciles y rápidos)**

- **Kerberoasting**: Capturar tickets de servicios y crackear contraseñas offline.
    
- **Secretsdump**: Volcar hashes o credenciales de máquinas accesibles.
    
- **Pass-the-Hash / Pass-the-Password**: Usar directamente los hashes o contraseñas robadas para moverte lateralmente o escalar.
    

---

### 2. **¿No encontramos quick wins? ¡Excavar más profundo!**

- **Enumerar con herramientas como BloodHound**: Analizar relaciones entre usuarios, equipos y permisos en Active Directory.
    
- **Buscar dónde tiene acceso nuestra cuenta**: Quizás tiene acceso a servidores menos protegidos o shares interesantes.
    
- **Revisar vulnerabilidades antiguas**: Muchas veces redes tienen parches críticos pendientes. ¡Las viejas vulnerabilidades aún funcionan!
    

---

### 3. **Pensar fuera de lo convencional**

- No te limites a ataques estándar: explora rutas laterales, abusa de configuraciones débiles, creatividades en scripts, etc.
    

---

# 📌 Resumen práctico

|Paso|Acción|
|---|---|
|1|Buscar quick wins rápidos (Kerberoasting, Secretsdump, PTH)|
|2|Si no hay acceso inmediato, enumerar y analizar accesos|
|3|Explorar vulnerabilidades olvidadas y técnicas no convencionales|


# 🏴‍☠️ Ya controlamos el dominio… ¿Ahora qué?

---

## 📚 1. **Aportar el máximo valor al cliente**

- **Seguir trabajando**: No detenerse, seguir explotando y analizando la infraestructura.
    
- **Volcar el archivo `NTDS.dit`**:
    
    - Contiene todas las cuentas y hashes de contraseñas del dominio.
        
    - Permite crackear contraseñas para identificar malas prácticas o vulnerabilidades.
        
- **Enumerar recursos compartidos**:
    
    - Buscar información sensible en carpetas y shares accesibles.
        
    - Información crítica de negocio o configuraciones internas.
        

---

## 🔐 2. **Considerar la persistencia**

- **¿Qué pasa si pierdes acceso a tu cuenta de Domain Admin?**
    
    - Hay que preverlo antes.
        
- **Crear una cuenta de administrador del dominio (DA)** puede ser muy útil:
    
    - **(¡No olvidar eliminarla después!)**
        
- **Crear un Golden Ticket**:
    
    - Un ticket Kerberos totalmente falsificado que te permite acceso indefinido al dominio, aunque cambien contraseñas o borren cuentas.
        

---

## 🕺 3. **Celebrar el éxito (un poco)**

- **Haz un pequeño baile** (¡porque comprometer un dominio no es poca cosa!). 😄
    

---

# 📌 Resumen en tabla:

|Acción|Propósito|
|---|---|
|Seguir explotando (NTDS.dit, shares)|Obtener más credenciales e información crítica|
|Crear persistencia (DA account, Golden Ticket)|Mantener acceso aunque las cosas cambien|
|Celebrar|¡Reconocer el logro!|