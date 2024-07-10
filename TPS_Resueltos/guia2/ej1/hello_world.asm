;   Hacer un programa que escriba por salida estándar “Hello World”. 
;   ¿Qué es el valor 10 en el archivo de ejemplo?

.data
hello_string db 'Hello world!', 10   ;   Almacena los bytes de la cadena seguidos por el entero 10 (salto de linea)
len equ $-hello_string               ;   equ es como un DEFINE. Reemplaza la cadena len por el resultado de la cuenta

.text

GLOBAL _start

_start:
mov eax, 4      ;   SYSCALL WRITE
mov ebx, 1      ;   STANDARD OUTPUT
mov ecx, hello_string   ;    la dirección de memoria del buffer que contiene los datos que se van a escribir.
mov edx, len     ;   Que lea [len] bytes
int 0x80

mov eax, 1      ;   SYSCALL EXIT
int 0x80

; ARGUMENTOS DE SYSCALL WRITE:
;   ebx: El descriptor de archivo al que se escribirán los datos. Por ejemplo, 1 para la salida estándar, 2 para la salida de error estándar, o un descriptor obtenido de una llamada previa a open.
;   ecx: La dirección del buffer que contiene los datos que se van a escribir.
;   edx: El número de bytes a escribir desde el buffer.
