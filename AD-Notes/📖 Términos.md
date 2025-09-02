

# 📖 Términos clave en Active Directory

Listado de conceptos y palabras que siempre hay que reconocer durante un pentest en entornos AD.

---

## 🏛️ Estructura de AD

- **Forest** → Conjunto de uno o más dominios que comparten un esquema y una relación de confianza.
- **Domain** → Unidad principal de administración (ej: `corp.local`).
- **OU (Organizational Unit)** → Contenedor lógico donde se agrupan usuarios, equipos y grupos.
- **Trust** → Relación de confianza entre dominios (ej: `corp.local` confía en `child.corp.local`).

---

## 👥 Usuarios y Grupos
- **sAMAccountName** → Nombre de inicio de sesión del usuario.
- **userPrincipalName (UPN)** → Nombre de usuario en formato `usuario@dominio`.
- **userAccountControl (UAC)** → Atributo con *flags* de configuración de la cuenta (ej: deshabilitada, password never expires).
- **Groups** importantes:
  - **Domain Admins** → Control total del dominio.
  - **Enterprise Admins** → Control sobre todo el forest.
  - **Administrators** → Control local.
  - **Backup Operators** → Pueden leer NTDS.dit (muy sensible).
  - **Account Operators** → Pueden crear y modificar cuentas.

---

## 🔑 Autenticación
- **Kerberos** → Protocolo de autenticación por tickets en AD.
- **NTLM** → Autenticación basada en hash, legado pero aún común.
- **krbtgt** → Cuenta usada para firmar tickets Kerberos (clave para Golden Ticket).
- **SPN (Service Principal Name)** → Identificador que vincula un servicio con una cuenta de AD (ej: `MSSQLSvc/sqlserver.corp.local`).

---

## 📂 Shares y Políticas
- **SYSVOL** → Carpeta compartida en todos los DCs con scripts y GPOs.
- **NETLOGON** → Share para scripts de inicio de sesión.
- **GPO (Group Policy Object)** → Configuración aplicada a usuarios/equipos.
- **GPP (Group Policy Preferences)** → Configuración extendida, puede almacenar contraseñas (`Groups.xml`, `ScheduledTasks.xml`, etc.).

---

## ⚙️ Objetos y Atributos sensibles
- **SID (Security Identifier)** → Identificador único de usuario/grupo.
- **RID (Relative ID)** → Parte final del SID (ej: 500 = Administrator).
- **DN (Distinguished Name)** → Ruta LDAP completa del objeto.
- **memberOf** → Grupos a los que pertenece el usuario.
- **lastLogon / lastLogonTimestamp** → Última vez que inició sesión.
- **pwdLastSet** → Última vez que se cambió la contraseña.
- **description** → Campo de texto libre donde a veces guardan contraseñas 😏.

---

## 🛠️ Técnicas y conceptos ofensivos
- **AS-REP Roasting** → Explotar usuarios sin Kerberos pre-auth.
- **Kerberoasting** → Pedir TGS de cuentas con SPNs y crackear offline.
- **Pass-the-Hash (PtH)** → Autenticarse con NTLM hash.
- **Pass-the-Ticket (PtT)** → Autenticarse con tickets Kerberos.
- **Overpass-the-Hash (Pass-the-Key)** → Convertir NTLM hash en TGT Kerberos.
- **Delegation (Unconstrained, Constrained, RBCD)** → Abuso de delegación Kerberos.
- **DCSync** → Replicar hashes del DC usando privilegios de replicación.
- **DCShadow** → Inyectar cambios en el AD haciéndose pasar por un DC.
- **Golden Ticket** → Ticket Kerberos forjado con la clave de `krbtgt`.
- **Silver Ticket** → Ticket Kerberos forjado para un servicio concreto.

---

## 🧾 Notas rápidas
- RID 500 = **Administrador**
- RID 501 = **Invitado**
- Cuentas de servicio con **password never expires** son objetivo prioritario.
- Siempre revisar `SYSVOL` y `NETLOGON` → pueden contener credenciales en texto plano.
