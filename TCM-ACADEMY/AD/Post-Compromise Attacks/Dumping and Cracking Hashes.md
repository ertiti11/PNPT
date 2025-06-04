

# secretsdump

En sistemas como **Windows 7**, **Windows 8**, **Windows Server 2008**, **2008 R2**, **2012** y **2012 R2**, si el protocolo **WDigest** está habilitado, es posible **extraer contraseñas en texto claro** directamente desde la memoria.

Cuando **WDigest** está activo:

- El sistema **almacena las contraseñas en memoria en texto plano** para realizar autenticaciones rápidas.
    
- Usando herramientas como **Mimikatz** o **Secretsdump** (o variantes como **SecretDumps/SecretDAMS**), puedes **dumper la memoria de LSASS** y **ver las credenciales sin necesidad de crackear hashes**.
    

Esto hace que **WDigest** sea un objetivo muy valioso en pentests internos o ataques post-explotación.


## 🛡️ Nota extra:

- Desde **Windows 8.1** y **Server 2012 R2** (y más en Windows 10+), **WDigest está desactivado por defecto**, pero se puede volver a activar manualmente.
    
- Un pentester o atacante puede revisar el registro:
    
    bash
    
    CopiarEditar
    
    `reg query HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest`
    
    Y ver si la clave `UseLogonCredential` está en `1`, lo que indica que **está vulnerable**.

Para sacar hashes con secretsdump debemos de ejecutar lo siguiente:

```bash
impacket-secretsdump 'MARVEL.local/fcastle:Mypassword1234!@192.168.0.231'
```

