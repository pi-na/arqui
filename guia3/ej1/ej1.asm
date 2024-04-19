;main.asm
GLOBAL main
EXTERN printf
EXTERN puts

;   EBP             |   EBP contexto anterior
;   EBP + 4         |   RET contexto anterior
;   EBP + 8         |   argc
;   EBP + 12        |   puntero a argv[]
;   EBP + (n+1)*4   |   puntero variables_entorno[]

section .rodata
fmt db "Cantidad de argumentos: %d", 10, 0
fmt2 db "[argv + %d]: %s", 10, 0   ;   printf(char* fmt, int arg1, char* string);
fmt3 db "test argumento: %s", 10, 0
fmt4 db "ecx = %d", 10, 0

section .text
main:
    push ebp ;Armado de stack frame 
    mov ebp, esp ;

    ;====================================
    ;imprime argc, cantidad de argumentos
    ;====================================
    push dword [ebp+8]
    push fmt
    call printf
    add esp, 2*4
    mov eax, 0

    ;===============
    ;imprime argv[0]
    ;===============
    mov eax, [ebp+12]
    mov eax, [eax+4]
    push eax
    push fmt3
    call printf
    add esp, 2*4

    ;=============================================
    ;loopea por argv[], imprimiendo todos los args
    ;=============================================
    mov ecx, dword[ebp+8]   ;   ECX = cantidad de argumentos
    mov ebx, 0

    .ciclo:
        mov eax, [ebp + 12]     ;   EAX = *argv 
        add eax, ebx            ;   EAX = *argv + EBX 
        mov eax, [eax]          ;   pusheo argv[EBX], que es un puntero a una string
        
        test al, al             ;   Si leo NULL, termine
        jz .fin

        push eax
        push ebx
        push fmt2
        call printf          
        add esp, 3*4
        
        add ebx, 4
        
        jmp .ciclo
   
    .fin:
    mov esp, ebp
    pop ebp
    ret
