# # 📞 RPC Enumeration

El servicio RPC (Remote Procedure Call) expuesto por los Domain Controllers permite interactuar con Active Directory sin necesidad de SMB o LDAP completos.  
La herramienta más común para aprovecharlo es **rpcclient**.

---

## 📌 Conceptos clave
- RPC suele correr en **puerto 135**.
- Permite enumerar usuarios, grupos y políticas si el servidor lo permite.
- A veces admite **null sessions** (sin usuario ni contraseña).
- Muy útil cuando SMB está filtrado o restringido.

---

## 🛠️ Comandos básicos con rpcclient

### Conexión anónima
```bash
rpcclient -U "" -N 10.10.10.100
```


### Conexión autenticada

```bash
rpcclient -U "DOMINIO\usuario%contraseña" 10.10.10.100`
```

---

## 🔎 Enumeración de usuarios

`enumdomusers`

→ Lista todos los usuarios del dominio.

`queryuser <RID>`

→ Muestra detalles de un usuario específico.

---

## 👥 Enumeración de grupos

`enumdomgroups`

→ Lista todos los grupos.

`querygroup <RID>`

→ Muestra los miembros de un grupo.

---

## 📑 Otras funciones útiles

`enumalsgroups`

→ Lista los grupos locales administradores.

`getdompwinfo`

→ Muestra políticas de contraseñas (longitud mínima, expiración, lockout).

`lsaquery`

→ Muestra nombre del dominio y SID.

`lookupsids <SID>`

→ Resolver un SID en nombre de usuario/grupo.

---

## ⚠️ Vectores comunes

- **Null sessions**: enumeración completa sin credenciales.
    
- **Weak password policies**: detectables con `getdompwinfo`.
    
- **Usuarios ocultos**: aparecen en `enumdomusers` aunque SMB no los muestre.
    
- **RID Cycling**: adivinación de usuarios a partir de enumerar RIDs.
    

---

## 🧾 Notas rápidas

- RID 500 = Administrator.
    
- RID 501 = Guest.
    
- RID 512 = Domain Admins.
    
- rpcclient puede ser usado junto a **CrackMapExec** o **enum4linux-ng** para automatizar.