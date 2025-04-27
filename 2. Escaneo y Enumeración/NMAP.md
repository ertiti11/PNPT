### 🧪 **Comandos Básicos y Muy Comunes**

#### 🔎 1. Escaneo de puertos por defecto

bash

CopiarEditar

`nmap 192.168.1.1`

- Escanea los **1000 puertos más comunes** del host.
    

---

#### 🛠 2. Escaneo de puertos específicos

bash

CopiarEditar

`nmap -p 22,80,443 192.168.1.1`

- Escanea solo los puertos **22 (SSH), 80 (HTTP), 443 (HTTPS)**.
    

bash

CopiarEditar

`nmap -p- 192.168.1.1`

- Escanea **todos los puertos (0-65535)**.
    

---

#### ⏱ 3. Escaneo rápido (Fast Scan)

bash

CopiarEditar

`nmap -F 192.168.1.1`

- Escaneo **muy rápido** de los puertos más comunes (puede saltarse información útil).
    

---

#### 🧬 4. Detección de sistema operativo y servicios

bash

CopiarEditar

`nmap -A 192.168.1.1`

- Realiza detección de:
    
    - **SO**
        
    - **Versión de servicios**
        
    - **Traceroute**
        
    - **Scripts comunes**
        

bash

CopiarEditar

`nmap -O 192.168.1.1`

- Solo intenta detectar el **sistema operativo**.
    

---

#### 🔧 5. Detección de versión de servicios

bash

CopiarEditar

`nmap -sV 192.168.1.1`

- Intenta identificar la **versión exacta** de los servicios abiertos.
    

---

#### 🎭 6. Escaneo sigiloso (SYN Scan - "Stealth Scan")

bash

CopiarEditar

`nmap -sS 192.168.1.1`

- Escaneo tipo **SYN** (half-open), más **difícil de detectar** por IDS/IPS.
    

---

#### 🛡 7. Escaneo UDP

bash

CopiarEditar

`nmap -sU 192.168.1.1`

- Escaneo de **puertos UDP**, útil para detectar servicios como DNS, SNMP, etc.
    

---

#### 📜 8. Usar scripts NSE (Nmap Scripting Engine)

bash

CopiarEditar

`nmap --script=vuln 192.168.1.1`

- Ejecuta scripts de detección de **vulnerabilidades comunes**.
    

bash

CopiarEditar

`nmap --script=http-enum 192.168.1.1`

- Enumeración de directorios y servicios HTTP.
    

---

#### 🧑‍🤝‍🧑 9. Escaneo de una red completa

bash

CopiarEditar

`nmap 192.168.1.0/24`

- Escanea **todos los hosts** en la subred.
    

---

#### 🖥 10. Guardar resultados

bash

CopiarEditar

`nmap -oN resultado.txt 192.168.1.1`

- Guarda la salida en **formato legible** en `resultado.txt`.
    

bash

CopiarEditar

`nmap -oX resultado.xml 192.168.1.1`

- Guarda en **formato XML**, útil para herramientas como **Metasploit**.