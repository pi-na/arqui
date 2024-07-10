;   printear el valor de la variable de entorno USER

GLOBAL _start
EXTERN numtostr
EXTERN print

section .data
my_string_divider db '=========', 0
mensaje db  '======== EL USER ACTUAL ES:', 0

section .bss
my_string_memory resb 100

section .text
_start:
mov ebp, esp


;   Apunto EAX a la primer variable de entorno
mov ecx, [ebp]  ;  [ebp] contiene la cantidad de argumentos
inc ecx              ;  #args + 1 y salteo el null
mov eax, 4
mul ecx              ;  EDX:EAX = EAX * ECX

add ebp, eax
mov eax, ebp
push eax

mov edx, 0
.print_variables_entorno:
    mov eax, ebp
    add eax, ecx
    mov eax, dword[eax]

    test eax, eax
    jz .print_user               ;   Si lei NULL me voy

    push my_string_memory
    push edx
    call numtostr
    add esp, 0x4    ; descarto el edx en el stack
    pop ebx
    call print
    mov ebx, eax
    call print
    mov ebx, my_string_divider
    call print

    add ecx, 4              
    inc edx
    jmp .print_variables_entorno


.print_user:
    pop eax
    add eax, 156            ;       156 = 39 * 4 = (posicion de variable USER) + (#bytes por argumento)
    mov ebx, [eax]
    call print

.exit:
    mov eax, 1
    int 0x80
