EXTERN main
GLOBAL _start

section .text
_start:

    call main
 
    mov ebx, eax
    mov eax, 1
    int 0x80
    













