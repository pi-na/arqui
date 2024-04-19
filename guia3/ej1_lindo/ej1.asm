
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
fmt3 db "argumento: %s", 10, 0

section .text
main:
    push ebp ;Armado de stack frame 
    mov ebp, esp 

    mov ecx, [ebp + 8]
    mov esi, [ebp + 12]

    .loop:
        lodsd
        push ecx            ;   printf modifica el ECX, necesito backupearlo
        push eax
        push fmt3
        call printf
        add esp, 2*4
        pop ecx             ;   restauro ECX
        loop .loop          ;   loop: dec ECX; test cl, cl; jnz .loop

                            ;   test cl, cl con jnz loop es equivalente a: if ecx != 0 jump loop

    mov esp, ebp
    pop ebp
    ret
