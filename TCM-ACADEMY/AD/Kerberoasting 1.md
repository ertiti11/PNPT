# 🔥 ¿Qué es un ataque de **Kerberoasting**?

**Kerberoasting** es un ataque donde **pides** a un controlador de dominio **un ticket de servicio** (un Ticket Granting Service, o TGS) y el servidor **te lo da cifrado con la contraseña del usuario de servicio**.

✅ **¿Qué puedes hacer con eso?**

- Capturas ese ticket.
    
- Lo crackeas **offline** (sin alertar a la red).
    
- Y **recuperas la contraseña** del usuario de servicio.
    

---

# 🎯 ¿Para qué sirve Kerberoasting?

- Conseguir **contraseñas** de **cuentas de servicio** del Active Directory.
    
- Algunas cuentas de servicio tienen **permisos muy altos** (a veces son administradores de dominio).
    
- **Moverte lateralmente**, **elevar privilegios** o **comprometer todo el dominio** si logras crackear una contraseña potente.
    

---

# 🛠️ ¿Cómo se hace en la práctica?

1. Estás dentro de la red (con acceso como cualquier usuario).
    
2. Pides un ticket TGS para un servicio que esté expuesto.
    
3. Capturas el ticket (que está cifrado con el hash de la contraseña del usuario del servicio).
    
4. Lo guardas.
    
5. Usas herramientas como `hashcat` o `john` para **crackearlo offline**.
    
6. Si crackeas, obtienes la contraseña **en texto claro**.
    

---

# 🧠 Explicación ultra rápida

|Paso|Acción|
|---|---|
|1|Pides un ticket de servicio|
|2|Capturas el ticket cifrado|
|3|Lo crackeas offline|
|4|Si tienes éxito → obtienes contraseña|
|5|Puedes usar esa cuenta para moverte/escalar|

---

# 💬 Ejemplo sencillo:

- Estás conectado como un usuario normal (`empleado1`).
    
- Pides el ticket para `sqlservice/miserver.local`.
    
- Guardas el ticket.
    
- Lo crackeas.
    
- Descubres que la contraseña es `Winter2024!`.
    
- ¡Y resulta que ese `sqlservice` era **administrador de dominio**!



## MITIGACIÓN

+ contraseñas fuertes
+ menos privilegios