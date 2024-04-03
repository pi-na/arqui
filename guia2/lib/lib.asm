;   EBP + 0x8   = direccion del array
;   EBP + 0xc   = longitud del array
GLOBAL print_array

;   Argumentos - STACK, pushear en orden de aparicion
;   Direccion donde escribir la string
;   Entero al que transformar
GLOBAL numtostr

;   Argumentos: 
;   EBX: puntero a string null terminated
GLOBAL print

;   Argumentos:
;	ebx: puntero a la cadena
;   Retorno:
;	eax: largo de la cadena
GLOBAL strlen

;   Argumentos:
;	STACK: el numero entero de 32 bit 
;   Retorno:
;	STACK: los caracteres ASCII  
GLOBAL numtostr

GLOBAL exit

section .text

print:
    push ebp
    mov ebp, esp    ;   init stack frame
    pushad

    call _print

    popad
    pop ebp         ;   Restauro el EBP de la funcion que me llamo.
                    ;   Este pop restaura ESP a la dir retorno.
    ret


;===============================================================================
; print - imprimer una cadena en la salida estandar
;===============================================================================
; Argumentos:
;	ebx: cadena a imprimer en pantalla, terminada con 0
;===============================================================================
_print:
	pushad		; hago backup de los registros

	call strlen
	mov ecx, ebx	; la cadena esta en ebx
	mov edx, eax	; en eax viene el largo de la cadena

	mov ebx, 1	; FileDescriptor (STDOUT)
	mov eax, 4	; ID del Syscall WRITE
	int 80h
	
    .print_newline
        mov eax, 10     ; ASCII \n
        push eax
        mov ecx, esp ; imprimir un newline!
        mov ebx, 1 ; STANDARD OUTPUT
        mov edx, 1 ; Que lea 1 byte
        mov eax, 4 ; SYSCALL WRITE
        int 0x80
        add esp, 0x4    ;   Descarto el 10 

	popad 		; restauro los registros

	ret	
	
;===============================================================================
; exit - termina el programa
;===============================================================================
; Argumentos:
;	ebx: valor de retorno al sistema operativo
;===============================================================================
exit:
	mov eax, 1	; ID del Syscall EXIT
	int 80h	; Ejecucion de la llamada


;===============================================================================
; strlen - calcula la longitud de una cadena terminada con 0
;===============================================================================
; Argumentos:
;	ebx: puntero a la cadena
; Retorno:
;	eax: largo de la cadena
;===============================================================================
strlen:
	push ecx ; preservo ecx	
	push ebx ; preservo ebx
	pushf	; preservo los flags

	mov ecx, 0	; inicializo el contador en 0
.loop:			; etiqueta local a strlen
	mov al, [ebx] 	; traigo al registo AL el valor apuntado por ebx
	cmp al, 0	; lo comparo con 0 o NULL
	jz .fin 	; Si es cero, termino.
	inc ecx		; Incremento el contador
	inc ebx
	jmp .loop
.fin:				; etiqueta local a strlen
	mov eax, ecx	
	
	popf
	pop ebx ; restauro ebx	
	pop ecx ; restauro ecx
	ret

;   Funcion wrapper para num_to_str
;   Argumentos - STACK, pushear en orden de aparicion
;   Direccion donde escribir la string Entero al que transformar
numtostr:
    push ebp
    mov ebp, esp    ;   init stack frame
    pushad

    ;El stack queda [EBP viejo] [dir retorno] [num a transformar] [dir donde escribir string]
    mov eax, [ebp+0xc]
    push eax
    mov eax, [ebp+0x8]
    push eax
    call _numtostr
    add esp, 0x8

    popad
    pop ebp         ;   Restauro el EBP de la funcion que me llamo.
                    ;   Este pop restaura ESP a la dir retorno.
    ret

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
_numtostr:
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

;   EBP - 0x4   = Longitud en bytes del array (len * 4)
;   EBP         = EBP anterior
;   EBP + 0x4   = direccion de ret (main)
;   EBP + 0x8   = direccion del array
;   EBP + 0xc   = longitud del array
;   EBP + 0x10  = direccion de memoria writeable para el numtostr
_print_array:
    push ebp
    mov ebp, esp

    ;   Si me pasaron longitud cero, retorno
    mov ecx, [ebp + 0xc]    ;   ecx = len(array)
    test cl, cl
    jz .terminar

    ;   Almaceno la posicion final del array - (len != 0)
    mov eax, 4
    mul ecx                 ;   EDX:EAX = ECX * EAX
    push eax

    mov ecx, 0              ;   init indice de lectura          

    .ciclo
        mov eax, [ebp+0x8]      ;   Direccion inicial del array
        add eax, ecx

        mov ebx, [ebp+0x10]
        push ebx
        ;push my_string_memory
        push dword[eax]
        call numtostr
        add esp, 0x4
        pop ebx
        call print
        add ecx, 4              ;   Leo la siguiente posicion (entero de 4 bytes)

        mov eax, [ebp - 0x4]    ;   Longitud
        cmp eax, ecx            ;   Si acabo de imprimir el ultimo elemento, indice = len
        je .terminar

        jmp .ciclo

    .terminar
        add esp, 0x4            ;   Descarto el len/pos final del array
        leave
        ret

print_array:
    push ebp
    mov ebp, esp
    pushad

    mov eax, [ebp + 0x10]
    push eax
    mov eax, [ebp + 0xc]
    push eax
    mov eax, [ebp + 0x8]
    push eax
    call _print_array
    add esp, 0xc

    popad
    pop ebp
    ret

