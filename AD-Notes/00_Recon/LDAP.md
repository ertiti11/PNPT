# LDAP Recon 



Active Directory expone un servicio LDAP (puerto 389 / 636 LDAPS) que se puede consultar para enumerar usuarios, grupos, políticas y SPNs.  
Es uno de los primeros pasos cuando tenemos credenciales válidas o acceso anónimo.


--- 

##  Conceptos clave

- **Base DN (Distinguished Name):** raíz del dominio AD (ej: `dc=active,dc=htb`).
- **Bind DN:** usuario con el que te autenticas.
- **Scope de búsqueda:**
  - `base` → solo la entrada base.
  - `one` → entradas directamente bajo la base.
  - `sub` → toda la jerarquía (más común en pentesting).
- **Filtros comunes:**
  - `objectClass=user`
  - `objectClass=group`
  - `servicePrincipalName=*`
  - `!(useraccountcontrol:1.2.840.113556.1.4.803:=2)` → excluir usuarios deshabilitados.

---

## 🛠️ Comandos útiles

### Enumerar usuarios activos

```bash
ldapsearch -x -H ldap://10.10.10.100 \
  -D "SVC_TGS" -w 'Password123!' \
  -b "dc=active,dc=htb" -s sub \
  "(&(objectCategory=person)(objectClass=user)(!(useraccountcontrol:1.2.840.113556.1.4.803:=2)))" sAMAccountName
```


### Ver grupos del dominio

`ldapsearch -x -H ldap://10.10.10.100 \   -D "SVC_TGS" -w 'Password123!' \   -b "dc=active,dc=htb" -s sub "(objectClass=group)" cn`

### Buscar SPNs (para Kerberoasting)

`ldapsearch -x -H ldap://10.10.10.100 \   -D "SVC_TGS" -w 'Password123!' \   -b "dc=active,dc=htb" -s sub "(servicePrincipalName=*)" servicePrincipalName`

### Buscar políticas de contraseñas

`ldapsearch -x -H ldap://10.10.10.100 \   -D "SVC_TGS" -w 'Password123!' \   -b "dc=active,dc=htb" -s sub "(objectClass=domain)" minPwdLength lockoutThreshold`

---

## 🔑 Atributos interesantes

- **`sAMAccountName`** → nombre de inicio de sesión.
    
- **`userAccountControl`** → flags de la cuenta.
    
- **`pwdLastSet`** → última vez que se cambió la contraseña.
    
- **`lastLogon` / `lastLogonTimestamp`** → última vez que se conectó.
    
- **`memberOf`** → grupos a los que pertenece.
    
- **`servicePrincipalName`** → objetivo para Kerberoasting.
    
- **`description`** → a veces los admins guardan contraseñas ahí 🙃.
    

---

## 🧾 Notas prácticas

- Intenta siempre primero **sin credenciales** → algunos DCs permiten anonymous bind.
    
- Usa `-ZZ` para forzar **StartTLS** si LDAPS está activo.
    
- Para scripting: `python3 windapsearch.py -d active.htb -u SVC_TGS -p 'Password123!' --custom "servicePrincipalName=*"`