

## Gobuster

```bash
gobuster vhost -u http://planning.htb -w /usr/share/wordlists/seclists/Discovery/DNS/combined_subdomains.txt --append-domain -t 50
```

## wfuzz

```bash
wfuzz -w subdomains-top1million-5000.txt -u 'http://domain.htb' -H "Host: FUZZ.domain.htb" --hc=302
```
## Sublist3r


### Instalación

```bash
sudo apt install sublist3r
```


### Uso

```bash
sublist3r -d domain.com
```



## CRT.sh

### WEB

esto es una web https://crt.sh, aqui podemos extraer todos los certs que ha tenido para cada subdominio



### PRUEBA

para probarlos podemos usar o http-probe o httpx-toolkit