;   Hacer un programa que defina, en una zona de datos, una cadena de caracteres 
;   con el siguiente string: “h4ppy c0d1ng” y la convierta a mayúscula. 
;   El resultado debe ser “H4PPY C0D1NG”. Muestre por consola el resultado. 
;   Utilice como convención que los strings están terminados en 0. Implemente funciones.

.data
MY_STRING db 'h4ppy c0d1ng', 0
DIFERENCIA_MAYUSCULAS equ 32

.text
GLOBAL _start

_start:

push MY_STRING
call print

mov eax, 1  ;   SYSCALL EXIT
int 0x80

;EBP - 0x8  = En este espacio se va guardando cada caracter en mayuscula
;EBP - 0x4  = En este espacio se va guardando el puntero al char actual
;EBP        = EBP anterior
;EBP + 0x4  = ret (main)
;EBP + 0x8  = direccion de my_string COMIENZO
;   Imprime en pantalla la string que recibe por argumento en el stack.
;   Lee hasta encontrar un 00 (NULL-TERMINATED).
print:
    push ebp
    mov ebp, esp
    
    mov ecx, [ebp+0x8]  ;   Setea ECX al comienzo de la string

    ;   Seteo los registros para hacer WRITE
    mov ebx, 1          ;   STANDARD OUTPUT
    mov edx, 1          ;   Que lea 1 byte
   
    putc:
        push ecx                    ;   Guardo el puntero al char actual en ECX
        movzx eax, byte [ecx]       ;   Guardo en eax el primer char
        test al, al                 ;   Setea ZF = 1 si el caracter actual es cero! (AL es el primer byte de ECX)
        je terminar_print           ;   je salta si ZF = 1 (Si el char actual es cero se termina)

        call to_upper_char          ;   El char en EAX ahora esta en mayuscula
        push eax                    ;   Guardo en el stack el char en mayuscula
        mov ecx, esp                ;   Apunto ECX al char en mayuscula (para el SYSCALL)
        mov eax, 4                  ;   SYSCALL WRITE
        int 0x80
        
        add esp, 0x4                ;   Me deshago del caracter que guarde en memoria
        pop ecx                     ;   Restaura ECX al char actual
        inc ecx                     ;   Apunta ECX al siguiente char de la string
    
        jmp putc                    ;   es un do-while :)
        

    terminar_print: 
        mov eax, 10
        push eax
        mov ecx, esp    ;   imprimir un newline!

        mov ebx, 1      ;   STANDARD OUTPUT
        mov edx, 1      ;   Que lea 1 byte
        mov eax, 4      ;   SYSCALL WRITE
        int 0x80

        leave
        ret

;   Convierte a mayuscula el char en el primer byte que haya en EAX, o lo deja como estaba
to_upper_char:
    push ebp
    mov ebp, esp

    cmp eax, 'a'
    jl terminar_to_upper_char
    cmp eax, 'z'
    jg terminar_to_upper_char

    ;   TODO    Usar el equ y no magic number
    sub eax, 32

    terminar_to_upper_char:
        leave 
        ret

;   Convierte a mayuscula la string apuntada en EAX. Hasta encontrar un 00 (NULL-TERMINATED) to_upper:
;   NO FUNCIONA PUES NO SE PUEDE MODIFICAR EL VALOR DE UN DATO QUE ESTA EN .data
to_upper:
    push ebp
    mov ebp, esp
    mov ecx, [ebp+0x8]  ;   Setea ECX al comienzo de la string

    ;   es un do-while
    begin:
        movzx eax, byte [ecx]

        test al, al
        jne terminar_to_upper

        cmp eax, 'a'
        jl while
        cmp eax, 'z'
        jge while
        
        sub eax, 32
        mov [ecx], al  ;   AL es el primer byte (de derecha a izquierda) de EAX

    while:
        inc ecx
        jmp begin

    terminar_to_upper:
        leave
        ret
