

Esta herramienta es parecida a bloodhound, pero esta nos arrojara muchos archivos html,csv y json, despues nos meteremos en el index.html y podremos ver todos los datos.

> [!NOTE]
> Para poder ejecutar esto, primero debemos de haber lanzado antes bloodhound!



## Como se ejecuta

Primero iniciamos neo4j

```bash
sudo neo4j
```


despues lanzamos el programa

```bash
sudo python3 /opt/PlumHound/PlumHound.py -x tasks/default.tasks -p titi
```

esto nos arrojara un monton de archivos

![[Pasted image 20250427161144.png]]