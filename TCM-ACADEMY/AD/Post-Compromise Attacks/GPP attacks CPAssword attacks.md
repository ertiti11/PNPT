# 🧠 ¿Qué son los **GPP Attacks** (también conocidos como **cPassword Attacks**)?

---

## 📚 Resumen rápido:

- **Group Policy Preferences (GPP)** permitía a los administradores **crear políticas** en Active Directory que **incluían credenciales** embebidas (por ejemplo, para crear cuentas locales automáticamente).
    
- Estas credenciales se **guardaban cifradas** en ficheros XML bajo una etiqueta llamada **`cPassword`**.
    
- **El problema**: Microsoft **accidentalmente publicó** la clave de cifrado usada para `cPassword` 🤦‍♂️.
    
- Resultado: **Cualquiera** que pudiera leer esos archivos XML **podía descifrar las contraseñas** fácilmente.
    
- Microsoft **parcheó** el problema en el **boletín MS14-025**, **pero no eliminó las políticas antiguas** ya existentes.
    

---

## 🎯 ¿Por qué sigue siendo relevante en pentesting hoy?

- Muchas empresas **aún tienen GPPs antiguos expuestos** en sus controladores de dominio o compartidos en SYSVOL.
    
- Un pentester que acceda a SYSVOL puede:
    
    - Buscar archivos XML de GPP.
        
    - Extraer `cPassword`.
        
    - Descifrar la contraseña.
        
    - Obtener **acceso privilegiado** (por ejemplo, usuario administrador local en muchos equipos).
        

---

# 📌 Resumen sencillo:

|Aspecto|Detalle|
|---|---|
|¿Qué atacamos?|Archivos XML de Group Policy Preferences|
|¿Qué buscamos?|Campo `cPassword`|
|¿Qué logramos?|Recuperar contraseñas de usuarios de dominio|
|¿Por qué sigue funcionando?|Muchas empresas no borraron políticas antiguas|


https://academy.tcm-sec.com/courses/1152300/lectures/48494642