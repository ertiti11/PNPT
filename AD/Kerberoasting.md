

## 🧠 ¿Qué hace este comando?

bash

CopiarEditar

`setspn -a HYDRA-DC/SQLService.MARVEL.local:60111 MARVEL\SQLService`

Este comando **registra un SPN (Service Principal Name)** en Active Directory para una cuenta de servicio (`MARVEL\SQLService`).

---

### 📌 Explicado por partes:

|Parte del comando|Significado|
|---|---|
|`setspn`|Herramienta de Windows para administrar SPNs.|
|`-a`|Añade un nuevo SPN.|
|`HYDRA-DC/SQLService.MARVEL.local:60111`|El nombre del servicio (SPN). Aquí: nombre del host + nombre del servicio + puerto.|
|`MARVEL\SQLService`|La cuenta de dominio a la que se le asigna ese servicio.|

---

## 🛠️ ¿Para qué sirve esto?

En entornos de Active Directory, los **SPNs** permiten que los servicios autentiquen con **Kerberos**. Pero en **pentesting**, este registro se puede usar con varios fines ofensivos:

---

### 🎯 1. **Preparar el ataque Kerberoasting**

Cuando una cuenta tiene un SPN asociado, se puede pedir un **ticket Kerberos (TGS)** para ese servicio. Y ese ticket:

> 🔐 Está cifrado con el **hash NTLM** de la cuenta de servicio.

🧑‍💻 Como pentester, si consigues ese ticket (con `GetUserSPNs.py`, `Rubeus`, etc.), puedes crackearlo offline para obtener la contraseña de la cuenta.

Este comando permite **forzar la creación de un SPN sobre una cuenta controlada por ti**, para luego pedir el ticket y crackearlo.

---

### 🧪 Ejemplo de uso ofensivo:

1. El atacante compromete una cuenta con privilegios suficientes (como `Domain User`).
    
2. Crea una cuenta de servicio: `MARVEL\SQLService`.
    
3. Usa `setspn` para asociar un SPN a esa cuenta.
    
4. Usa `Rubeus` o `Impacket` para pedir un TGS:
    
    bash
    
    CopiarEditar
    
    `GetUserSPNs.py marvel.local/sqlservice:'Pass123' -dc-ip 192.168.1.10`
    
5. Crackea el ticket con `hashcat` o `john`.
    

---

### ⚠️ Nota importante:

- El uso de `setspn` requiere **permisos en el objeto de usuario** o permisos más elevados.
    
- En entornos reales, muchos ataques de **Kerberoasting** funcionan porque hay **cuentas de servicio con SPNs** y contraseñas débiles.
    

---

## 🧩 Resumen rápido:

> 🔧 `setspn -a` se usa para **asociar un servicio (SPN)** a una cuenta de AD.  
> 💀 En pentesting, se usa para **crear un SPN falso y forzar un Kerberoasting controlado**, crackeando el hash Kerberos offline.