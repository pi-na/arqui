; Dado un número n y un valor k, imprimir todos los valores múltiplos de n desde 1 hasta k.

GLOBAL _start
EXTERN num_to_str
EXTERN print

section .bss
my_string_malloc resb 1000

section .text
_start:
push 50
push 5
call print_multiplos    ;   Imprimo todos los multiplos de 5 desde 1 hasta 50
mov eax, 1
int 0x80

;   Recibe 2 enteros por stack, e imprime por salida estandar todos los multiplos 
;   de n desde 1 hasta k. NO modifica el stack
;   >   STACK:
;   EBP         =   EBP anterior
;   EBP + 0x4   =   direccion de retorno (main)
;   EBP + 0x8   =   n
;   EBP + 0xc   =   k
print_multiplos:
    push ebp
    mov ebp, esp
    pusha                           ;   Pusheo al stack el estado de los registros
    
    mov ebx, 1
    .ciclo:
        mov ecx, [ebp + 0xc]
        mov eax, [ebp+0x8]          ;   Cargo N en eax
        MUL ebx                     ;   EAX = EAX * EBX  
        jo .terminar

        .print_num
            push ebx
            push ecx
            push eax

            push my_string_malloc
            push eax
            call num_to_str             
            add esp, 0x4
            call print
            add esp, 0x4                ;   Descarto my_string_malloc del stack

            pop eax
            pop ecx
            pop ebx
        
        inc ebx
        cmp eax, ecx                ;   Comparo el current multiplo con el limite k
        jne .ciclo

    .terminar:
        popa        ;   Restauro el estado original de los registros
        leave
        ret
