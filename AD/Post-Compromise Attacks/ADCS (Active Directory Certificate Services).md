### 🔐 ¿Qué es ADCS (Active Directory Certificate Services)?

ADCS es una funcionalidad de Windows Server que proporciona **infraestructura de clave pública (PKI)** dentro de un dominio de Active Directory. Se encarga de emitir, revocar y gestionar **certificados digitales**.

---

### 💥 ¿Por qué ADCS es un vector de elevación de privilegios?

Cuando un entorno de Active Directory tiene ADCS mal configurado o expuesto, puede abrir **vectores de ataque graves**. Esto se debe a que los certificados pueden utilizarse para:

- Autenticarse como otros usuarios.
    
- Autenticarse como usuarios privilegiados (incluso como **Domain Admin**).
    
- Obtener **tickets Kerberos** válidos (Golden/TGT-style attacks).
    
- Persistencia silenciosa sin dejar rastros típicos como hashes.
    

---

### 🧠 ¿Qué se busca como pentester cuando analizas ADCS?

Al obtener acceso a una máquina dentro del dominio, puedes analizar ADCS buscando vulnerabilidades como:

1. **Plantillas de certificados mal configuradas**:
    
    - Permiten que usuarios no privilegiados soliciten certificados para otras identidades.
        
2. **Plantillas con flag "ENROLLEE_SUPPLIES_SUBJECT" activado**:
    
    - Esto permite al atacante especificar el nombre del sujeto, o sea, hacerse pasar por otro usuario al solicitar el certificado.
        
3. **Certificados que permiten autenticación (Client Authentication)**:
    
    - Si están mal configurados, puedes usarlos con herramientas como `Rubeus` o `Certipy` para autenticarte como otros usuarios.
        
4. **CAs accesibles por todos**:
    
    - Las Enterprise CA expuestas pueden aceptar peticiones de usuarios del dominio que no deberían tener ese nivel de acceso.
        

---

### 🛠 Herramientas típicas para evaluar ADCS:

- [`Certipy`](https://github.com/ly4k/Certipy): Herramienta moderna y poderosa para descubrir y explotar vulnerabilidades en ADCS.
    
- `Rubeus`: Para solicitar certificados y usarlos en ataques Kerberos.
    
- `ADCS enumeration scripts` de PowerShell.
    

---

### 🎯 Ejemplo de ataque típico

1. Enumeras las plantillas de certificados con `Certipy`:
    
    bash
    
    CopiarEditar
    
    `certipy find -u usuario -p contraseña -dc-ip 192.168.1.1 -target dominio.local`
    
2. Encuentras una plantilla vulnerable que permite especificar el `Subject`.
    
3. Solicitas un certificado como otro usuario (ej. administrador):
    
    bash
    
    CopiarEditar
    
    `certipy req -u titi -p 'Password123' -ca 'DOM-CA\dc-root-CA' -template 'VulnerableTemplate' -upn administrator@dom.local`
    
4. Usas ese certificado para autenticarte como el **Domain Admin**.
    

---

### ✅ Conclusión

Cuando tienes acceso inicial en un entorno con Active Directory, **buscar ADCS** es crucial, porque si está mal configurado, puedes:

- Escalar privilegios a administradores de dominio.
    
- Persistir en el entorno con certificados válidos.
    
- Eludir detecciones tradicionales basadas en hashes o password spraying.




## Certify

```
Certify.exe find /vulnerable
```