### Pentesting Linux
#### Tratamiento de la TTY



Una vez accedemos a un equipo Linux con una reverse shell de Netcat, veremos que andamos a ciegas, lo que hace que incluso no podamos utilizar servicios que corran en interactivo (Python, mysql, etc.). Para arreglar este problema, simplemente seguimos los pasos que se describen a continuación.

- Cargamos una pseudoconsola sobre el sistema

Tenemos 2 formas de hacer esto, la primera es la siguiente:

```shell
script /dev/null -c bash
```

Otra de ellas es a través de python, para ello se recomienda aplicar un `whereis python` a nivel de sistema para comprobar las versiones que se encuentran presentes en el sistema, así tendremos que aplicar el siguiente comando seguido de su versión:

```shell
python -c 'import pty;pty.spawn("/bin/bash")'
```

- Configuramos las variables de entorno correctamente

A continuación presionamos la tecla **Ctrl+Z**, esto lo que hará será dejar en segundo plano nuestra sesión (no hay que asustarse). Una vez hecho, aplicamos los siguientes comandos:

```shell
stty raw -echo
fg
reset
xterm
```

Tras introducir el primero, es normal que al escribir **fg** no veamos lo que se está escribiendo, sin embargo se están introduciendo los caracteres. Este comando lo que hará será retornanos a la sesión que teníamos vía **Netcat**. Con el comando **reset** reconfiguraremos nuestra sesión, preguntándonos en la mayoría de los casos a continuación con qué tipo de terminal queremos tratar.

Puede ser que no nos pregunte por el tipo de terminal, en caso de que sí lo haga, introducimos `xterm`, en caso de que no e incluso aunque lo pida, posteriormente aplicamos los siguientes comandos:

```shell
export TERM=xterm
export SHELL=bash
```

Una vez hecho, lo único que queda (paso opcional), es configurar correctamente el redimensionamiento de la terminal, pues en caso de abrir algún editor como nano, veremos que las proporciones no cuadran. Para ello, lo más recomendable es poner a tamaño completo la terminal.

Abrimos otra terminal en nuestro sistema con el mismo redimensionamiento, y aplicamos el siguiente comando:

```shell
┌─[root@parrot]─[/home/s4vitar/Desktop]
└──╼ #stty -a
speed 38400 baud; rows 44; columns 190; line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>; eol2 = <undef>; swtch = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W; lnext = ^V; discard = ^O;
min = 1; time = 0;
-parenb -parodd -cmspar cs8 -hupcl -cstopb cread -clocal -crtscts
-ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon -ixoff -iuclc -ixany -imaxbel iutf8
opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop -echoprt echoctl echoke -flusho -extproc

```

Tal y como podemos ver, figuran los números de filas y columnas, 44 y 190 respectivamente para este caso. Copiamos dicha configuración en la máquina que hemos comprometido donde se ha llevado a cabo toda la previa configuración, aplicando para ello el siguiente comandos:

```shell
stty rows 44 columns 190
```

El resultado final será una Shell completamente interactiva, donde nos sentiremos como si hubiéramos ganado acceso por SSH, con capacidad de tabulación, uso de Shortcuts (Ctrl+C, Ctrl+L, etc.), sesiones interactivas, etc.