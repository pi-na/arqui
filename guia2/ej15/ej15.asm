 ;  Escribir un programa que suspenda la ejecución del mismo por n segundos y 
 ;  luego termine (No utilizar ciclos ni rutinas que dependan de la velocidad de la PC).

GLOBAL _start
EXTERN numtostr
EXTERN print

section .data
string1 db 'hola voy a esperar', 0
string2 db 'ya espere', 0
tiempo dd 5,0

section .text
_start:
mov ebp, esp

mov ebx, string1
call print

mov ecx, 0
mov ebx, tiempo
mov eax, 0xa2         ;   SYSCALL nanoseconds
int 0x80

mov ebx, string2
call print

mov eax, 1
int 0x80
