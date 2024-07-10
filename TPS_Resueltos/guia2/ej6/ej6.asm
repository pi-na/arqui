; Dado un número n, imprimir su factorial. Tenga cuidado con los argumentos de la función.

section .bss
number_string resb 100

GLOBAL _start
EXTERN num_to_str
EXTERN print

section .text
_start:
mov eax, 10
call factorial
push number_string
push eax
call num_to_str
add esp, 0x4

call print

int 0x80

;   Recibe por EAX un entero CON SIGNO!!! y retorna por EAX su factorial
;   Si recibe un entero negativo (o un unsigned mayor a 2^31 - 1) o en algun punto da overflow, retorna 0
factorial:
    push ebp
    mov ebp, esp

    test eax, eax
    js .valor_invalido       ;   JS salta si el numero es negativo, i.e. SF = 1
    jz .valor_cero           ;   JZ salta si el numero es cero

    mov ecx, eax
    mov eax, 1
    
   .ciclo:
        mul ecx             ;   Multiplica EAX por ECX, resultado en EDX:EAX    TODO tendria q usar edx y eax pero lo ignoro (romperia con numeros grandes supongo)
        jo .valor_invalido   ;   Salta si la multiplicacion da overflow
        dec ecx

        ;   Si el multiplicando actual es cero, termine
        test cl, cl
        jnz .ciclo

    .terminar:
        leave
        ret

    .valor_cero:
        mov eax, 1
        jmp .terminar

    .valor_invalido:
        mov eax, 0
        jmp .terminar


