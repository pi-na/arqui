#AVISO IMPORTANTE GUIA 1
LAS FUNCIONES ARMADAS POR LA CATEDRA NUMTOSTR Y PRINT ESTAN MAL HECHAS!!! MODIFICAN EBP!!!
En mi lib/lib.asm, las tengo corregidas por medio de una funcion wrapper. Chequealo.

#NOTAS GUIA 1:
Los primeros ejercicios los hice mientras aprendia o sea que pueden estar medio raros.
Si en algun ejercicio usa funciones declaradas como EXTERN, hay que linkeditar con lib/lib.asm

Los primeros ejercicios de la guia 2 que usan print deberian tener el codigo de print copiado en el mismo programa.
Si no es asi, es necesario linkeditar con lib.asm. Para esto, CHEQUEAR que este usando la misma definicion de print
que la que se usa en lib.asm. Es decir, el print al que le pasas por EBX el puntero a la string. Si hace un PUSH del
puntero a la string antes de hacer call print (o bien hace push para numtostr y despues aprovecha que ya esta ese push hecho),
es necesario cambiar el codigo para que use la version de print.
