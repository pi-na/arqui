;Expanda el ejercicio anterior para imprimir todos los argumentos de un programa

GLOBAL _start
EXTERN numtostr
EXTERN print

section .data

section .bss
my_string_memory resb 100

section .text
_start:
mov ebp, esp

mov ecx, 4
.ciclo
    add ecx, 4              ;   En la primer iteracion ya arranco por el 1er argumento
    mov eax, ebp
    add eax, ecx
    mov eax, dword[eax]
    test eax, eax
    jz .exit                ;   Si lei NULL me voy
    
    mov ebx, eax
    call print
    jmp .ciclo

.exit
    mov eax, 1
    int 0x80
