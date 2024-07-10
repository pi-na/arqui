;   Esta lib esta hecha con mi implementacion de las funciones
;   Intentar usarla me cago la vida

GLOBAL num_to_str
GLOBAL num_to_str_stack
GLOBAL print
GLOBAL print_to_upper

section .text

;   EBP         =   EBP anterior
;   EBP + 0x4 = direccion de ret (main)
;   EBP + 0x8 = numero a transformar
;   EBP + 0xc = direccion donde escribir la string
;   Recibe un entero y una direccion de memoria. Deja en la direccion de memoria una string
;   representando dicho numero, null-terminated.
;   >>> NUEVA ESTRATEGIA. ANTES DE ARRANCAR PONGO UN 0 (NULL) EN EL STACK,
;       Y VOY PUSHEANDO TODOS LOS ASCII. CUANDO TERMINO HAGO MOV PARA IR
;       CARGANDO A LA DIRECCION DE MEMORIA LOS ASCII EN ORDEN! TERMINO
;       CUANDO ME ENCUENTRO CON EL NULL (Y A ESE TMB LE HAGO MOV)
num_to_str:
    push ebp
    mov ebp, esp
         
    mov ecx, [ebp + 0xc]    ;   Cargo en ECX el puntero a donde escribir la string
    mov ebx, 10             ;   Cargo en EBX el divisor (el resto de dividir por 10 es el ultimo digito del numero)
    
                            ;   >   NOTAR que siempre pusheo primero ascii y despues el dividendo del .ciclo actual
    push 0                  ;   Pusheo el NULL del final de la string
    push DWORD [ebp + 0x8]  ;   Pusheo al stack el DIVIDENDO, el numero que me pasaron. NOTAR que pusheo el numero y no un puntero

    .ciclo:
        xor edx, edx        ;   Llena EDX con ceros antes de la división (pues DIV toma EDX y EAX como un unico entero)
        pop eax             ;   Cargo en EAX el numero (el actual)
        div ebx             ;   Divide EAX por EBX, cociente en EAX, resto en EDX
        add edx, '0'        ;   Le sumo al digito el ascii del 0 (en EDX esta el resto de la division)

        push edx            ;   Pusheo el ascii del digito actual
        push eax            ;   Pusheo al stack el nuevo dividendo (el entero, que ahora no tiene el digito que escribi en la string)
        
        ;Si el ultimo dividendo es 0, ya no quedan digitos, no se continua el .ciclo
        test eax, eax
        jnz .ciclo            
        add esp, 0x4        ;   Descarto el dividendo del ultimo .ciclo, que siempre sera 0


    .cargar_en_memoria:
        pop eax
        mov [ecx], al           ;   Desreferencio la direccion para la string y poppeo ahi el ascii actual
        inc ecx                 ;   Apunto ecx al siguiente espacio de memoria

        ;   Si en lugar de un ascii acabo de subir el NULL, termine
        test al, al             
        jz .terminar 
        jmp .cargar_en_memoria
     
    .terminar:
        leave
        ret 

;EBP - 0x8 = En este espacio se va guardando cada caracter en mayuscula       
;EBP - 0x4 = En este espacio se va guardando el puntero al char actual
;EBP = EBP anterior
;EBP + 0x4 = ret (main)
;EBP + 0x8 = direccion de my_string COMIENZO
;   Imprime en pantalla la string que recibe por argumento en el stack. 
;   Lee hasta encontrar un 00 (NULL-TERMINATED).
print:
    push ebp
    mov ebp, esp
    mov ecx, [ebp+0x8]          ; Setea ECX al comienzo de la string

    ;   >  Seteo los registros para hacer WRITE
    mov ebx, 1                  ;   STANDARD OUTPUT
    mov edx, 1                  ;   Que lea 1 byte

    .putc:
        push ecx                ;   Guardo el puntero al char actual en ECX
        movzx eax, byte [ecx]   ;   Guardo en eax el primer char 
        test al, al             ;   Setea ZF = 1 si el caracter actual es cero! (AL es el primer byte de ECX)
        cmp eax, 0

        je .terminar            ;   je salta si ZF = 1 (Si el char actual es cero se termina)
        push eax                ;   Guardo en el stack el char
        mov ecx, esp            ;   Apunto ECX a la direccion de memoria del stack donde esta el char (para el SYSCALL)

        mov eax, 4              ;   SYSCALL WRITE
        int 0x80
        add esp, 0x4            ;   Me deshago del caracter que guarde en memoria

        pop ecx                 ;   Restaura ECX al char actual
        inc ecx                 ;   Apunta ECX al siguiente char de la string
        jmp .putc               ;   es un do-while :)

    .terminar:
        mov eax, 10
        push eax
        mov ecx, esp ; imprimir un newline!
        mov ebx, 1 ; STANDARD OUTPUT
        mov edx, 1 ; Que lea 1 byte
        mov eax, 4 ; SYSCALL WRITE
        int 0x80
        leave
        ret 

;EBP - 0x8 = En este espacio se va guardando cada caracter en mayuscula       
;EBP - 0x4 = En este espacio se va guardando el puntero al char actual
;EBP = EBP anterior
;EBP + 0x4 = ret (main)
;EBP + 0x8 = direccion de my_string COMIENZO
; Imprime en pantalla la string que recibe por argumento en el stack. Lee hasta encontrar un 00 (NULL-TERMINATED).
print_to_upper:
    push ebp
    mov ebp, esp
    mov ecx, [ebp+0x8]          ; Setea ECX al comienzo de la string

    ;   >  Seteo los registros para hacer WRITE
    mov ebx, 1                  ;   STANDARD OUTPUT
    mov edx, 1                  ;   Que lea 1 byte

    .putc:
        push ecx                ;   Guardo el puntero al char actual en ECX
        movzx eax, byte [ecx]   ;   Guardo en eax el primer char 
        test al, al             ;   Setea ZF = 1 si el caracter actual es cero! (AL es el primer byte de ECX)
        cmp eax, 0

        je .terminar            ;   je salta si ZF = 1 (Si el char actual es cero se termina)
        call to_upper_char      ;   El char en EAX ahora esta en mayuscula
        push eax                ;   Guardo en el stack el char en mayuscula
        mov ecx, esp            ;   Apunto ECX al char en mayuscula (para el SYSCALL)

        mov eax, 4              ;   SYSCALL WRITE
        int 0x80
        add esp, 0x4            ;   Me deshago del caracter que guarde en memoria

        pop ecx                 ;   Restaura ECX al char actual
        inc ecx                 ;   Apunta ECX al siguiente char de la string
        jmp .putc               ;   es un do-while :)

    .terminar:
        mov eax, 10
        push eax
        mov ecx, esp ; imprimir un newline!
        mov ebx, 1 ; STANDARD OUTPUT
        mov edx, 1 ; Que lea 1 byte
        mov eax, 4 ; SYSCALL WRITE
        int 0x80
        leave
        ret ; Convierte a mayuscula el char en el primer byte que haya en EAX, o lo deja como estaba

to_upper_char:
    push ebp
    mov ebp, esp

    cmp eax, 'a'
    jl .terminar

    cmp eax, 'z'
    jg .terminar

    sub eax, 32     ;   'a' - 'A' == 32

    .terminar:
        leave
        ret
