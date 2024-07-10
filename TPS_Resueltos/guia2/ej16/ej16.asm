;   Investigar la manera de llamar al syscall read. Realizar un programa 
;   que reciba por entrada estándar (file descriptor 0) un string, lo convierta
;   a mayúscula y lo imprima por salida estándar (file descriptor 1).

GLOBAL _start
EXTERN print

section .data
msg db 'simon dice: ', 0

section .bss
input resb 100

section .text
_start:
mov ebp, esp

mov eax, 0x03       ;   SYSCALL READ
mov ebx, 0          ;   FILE DESCRIPTOR 0
mov ecx, input      ;   Donde dejar la string
mov edx, 50         ;   ?? longitud maxima del string ??
int 0x80

mov ebx, msg
call print

mov ebx, input
call print

mov eax, 1
int 0x80
