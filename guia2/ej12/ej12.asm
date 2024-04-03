; Escriba un programa que recorra el stack iterativamente desde el final 
; hasta el principio, imprimiendo cuantos bytes se recorrieron, puede fallar
; con un error en lugar para cortar la iteración en lugar de detectar el final del stack.


GLOBAL _start
EXTERN numtostr
EXTERN print

section .data
my_string_divider db '=========', 0

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

.print_variables_entorno:
    mov eax, ebp
    add eax, ecx
    mov eax, dword[eax]

    ;   La consigna dice que no hagamos chequeo y que pinche por segfault ¯\_(ツ)_/¯
    ;test eax, eax
    ;jz .exit              ;   Si lei NULL me voy

    push my_string_memory
    push ecx
    call numtostr
    add esp, 0x4    ; descarto el edx en el stack
    pop ebx
    call print
    mov ebx, eax
    call print
    mov ebx, my_string_divider
    call print

    add ecx, 4              
    jmp .print_variables_entorno

.exit:
    mov eax, 1
    int 0x80
