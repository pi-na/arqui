global check_long
global msg
global len

section .data 
msg:  db "Hola Mundo", 0 
len:  db 10

section .text

check_long:
    push ebp
    mov ebp,esp
    push ebx
    push ecx
    push esi
    mov esi, [ebp + 8]
    mov ecx, 0
    mov ebx, [ebp + 12]
    .loop:
        movzx eax, byte [esi]
        inc esi
        cmp eax, 0
        je .end
        inc ecx
        jmp .loop
    .end:
        mov eax, ecx
        sub eax, ebx

        pop esi
        pop ecx
        pop ebx
        leave
        ret
