AVISO IMPORTANTE GUIA 1
LAS FUNCIONES ARMADAS POR LA CATEDRA NUMTOSTR Y PRINT ESTAN MAL HECHAS!!! MODIFICAN EBP!!!
En mi lib/lib.asm, las tengo corregidas por medio de una funcion wrapper. Chequealo.



!!!!!!!! MAQUINA VIRTUAL PARA MACS CON APPLE SILICON !!!!!!!!
La manera mas facil de hacer esta materia si tenes mac con m1 m2 o m3. 

1. Instala UTM: https://mac.getutm.app/
2. Descarga la imagen ya preparada para arqui:  TODO PONER EL LINK DE DRIVE
3. Selecciona la opcion nueva virtual machine -> open... -> elegi la imagen .utm -- Ahora estas EMULANDO un procesador intel, corriendo un linux con todas las dependencias necesarias
4. En el inicio de UTM, elegi la maquina virtual que acabas de crear, baja hasta shared space, y elegi la carpeta que quieras compartir entre macos y tu linux
5. Inicia la maquina virtual, abri una terminal, hace cd al Desktop y corre el comando ./set_shared_space.sh -- Tenes que hacer esto cada vez que apagues la maquina (podes evitar apagarla cerrando sesion desde el menu de apagar y luego cerrando la ventana, o tocando el boton de pausa desde UTM y dejando UTM abierto)

Con este setup, tenes una maquina emulada de linux con todos los programas necesarios para compilar y debuggear los programas de arqui, con un directorio compartido con tu macos. En la maquina virtual, podes encontrar ese directorio en /home/tomas/shared. Los contenidos de shared van a estar vinculados a los contenidos del directorio de macos que hayas agregado en UTM en el paso 4.
No se por que, pero muchas veces es necesario ejecutar los comandos con sudo (Cualquier comando que vaya a editar o crear un archivo, y el EDB lo necesitan!!!).
El user y contraseña son ambos "tomas".
   


NOTAS GUIA 1:
Los primeros ejercicios los hice mientras aprendia o sea que pueden estar medio raros.
Si en algun ejercicio usa funciones declaradas como EXTERN, hay que linkeditar con lib/lib.asm

Los primeros ejercicios de la guia 2 que usan print deberian tener el codigo de print copiado en el mismo programa.
Si no es asi, es necesario linkeditar con lib.asm. Para esto, CHEQUEAR que este usando la misma definicion de print
que la que se usa en lib.asm. Es decir, el print al que le pasas por EBX el puntero a la string. Si hace un PUSH del
puntero a la string antes de hacer call print (o bien hace push para numtostr y despues aprovecha que ya esta ese push hecho),
es necesario cambiar el codigo para que use la version de print.
