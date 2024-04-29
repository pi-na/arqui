global check_long
global msg
global len

section .data 
msg db "Hola Mundo", 0 
len db 10

section .text

check_long:
    push ebp
    mov ebp,esp
    push ebx
    push ecx
    push esi
    mov esi, [ebp + 8]      ;   carga el puntero del array a esi    
    mov ecx, 0              ;   carga 0 a ecx, COUNTER
    mov ebx, [ebp + 12]     ;   carga a ebx el supuesto size del array
    .loop:
        movzx eax, byte [esi]   ;   carga 1 byte de lo apuntado por esi, ES UN CHAR 
                                ;   llena con ceros para que entre en EAX (4 bytes)
        inc esi                 ;   apunta esi al siguiente char (incrementa 1)
        cmp eax, 0              ;   se fija que no haya leido 0 (NULL TERMINATED)
        je .end                 ;   si era 0 va a .end
        inc ecx                 ;   si no era 0, aumenta en uno el counter
        jmp .loop
    .end:
        mov eax, ecx            ;   carga en eax el largo de la string
        sub eax, ebx            ;   le resta ebx a eax (ebx contiene el supuesto size)

        pop esi                 ;   restaura los registros
        pop ecx
        pop ebx
        leave                   ;   desarmado de stack-frame
        ret
