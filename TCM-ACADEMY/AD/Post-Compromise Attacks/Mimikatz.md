# 🛠️ Mimikatz — Resumen rápido

---

## 📚 ¿Qué es Mimikatz?

Mimikatz es una **herramienta de post-explotación** muy poderosa que permite:

- **Visualizar y robar credenciales** directamente de la memoria.
    
- **Generar y manipular tickets Kerberos**.
    
- **Realizar varios tipos de ataques** basados en credenciales.
    

---

## 🎯 ¿Qué funciones principales tiene?

- **Volcar credenciales** almacenadas en la memoria (`lsass.exe`).
    
- **Generar tickets Kerberos falsificados**.
    
- **Imitar autenticaciones** sin necesidad de tener contraseñas claras.
    

---

## 🧨 Algunos ataques que se pueden hacer con Mimikatz:

|Ataque|Descripción breve|
|---|---|
|**Credential Dumping**|Extraer nombres de usuario, contraseñas, hashes o tickets directamente de la memoria.|
|**Pass-the-Hash (PtH)**|Autenticarse en sistemas usando solo el hash NTLM, sin conocer la contraseña real.|
|**Over-Pass-the-Hash (Pass-the-Key)**|Utilizar hashes Kerberos (NTLM) para obtener tickets TGT y moverse en la red.|
|**Pass-the-Ticket (PtT)**|Reutilizar tickets Kerberos capturados para acceder a servicios.|
|**Silver Ticket**|Crear tickets Kerberos falsos para servicios específicos (sin controlar el dominio completo).|
|**Golden Ticket**|Crear un ticket Kerberos totalmente falsificado para dominar un dominio Active Directory (control total).|

---

# 🎯 En resumen:

> **Mimikatz** permite **dominar un sistema Windows** extrayendo y usando credenciales, tickets o hashes de manera silenciosa y efectiva.




https://academy.tcm-sec.com/courses/1152300/lectures/48496456