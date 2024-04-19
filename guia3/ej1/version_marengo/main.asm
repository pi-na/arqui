GLOBAL main
EXTERN printf
section .rodata
fmt db "Cantidad de argumentos: %d", 0
barraN db 10, 0

section .text
main:
    push ebp
    mov ebp, esp
    push dword [ebp+8]
    push fmt
    call printf
    mov esi, [ebp+12]
    mov ebx, [ebp+8]
.ciclo:
    cmp ebx, 0
    je .fin
    push barraN
    call printf
    lodsd
    push eax
    call printf
    dec ebx
    jmp .ciclo
.fin:
    push barraN
    call printf
    mov eax, 0
    mov esp, ebp
    pop ebp
    ret