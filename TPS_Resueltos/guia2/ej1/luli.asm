.text
global _start

_start:
    mov eax,4
    mov ebx,1
    mov ecx, frase
    mov edx, longitud
    int 0x80

    mov eax,1 // sys call exit
    int 0x80

.data
    frase db "Hello World", 10
    longitud equ $-frase
