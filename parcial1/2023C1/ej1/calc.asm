extern return
extern printf
extern puts
extern operar

global main

section .rodata:
muls db '*', 0
sums db '+', 0
divs db '/', 0
pows db '^', 0
ok_msg dd "Resultado = %d\n", 0
error_msg dd "Error: operador <%s> no reconocido\n", 0

;   EBP         |   ebp contexto anterior
;   EBP + 4     |   ret contexto anterior
;   EBP + 8     |   argc
;   EBP + 12    |   argv[]  (puntero)
section .text:
main:
    push ebp
    mov ebp, esp
    
    pushad

    mov ebx, [ebp + 12]     ;   Cargo el puntero a argv (que es un array de punteros)   
    ;mov ebx, [ebx]         ;   !! ESTA DE MAS !!
    add ebx, 4              ;   Salto a la segunda posicion de argv (puntero al primer argumento, char*)

    mov eax, [ebx]          ;   Cargo el primer operando
    push eax        

    .validate:
        add ebx, 4              ;   Salto a la tercera posicion de argv (puntero al segundo argumento, operador)
        mov eax, [ebx]          ;   Cargo el segundo char* en eax, que deberia apuntar a un operador
        movzx eax, byte[eax]    ;   Cargo el primer char de la string operador

        movzx ecx, byte[divs]
        cmp eax, ecx
        je .validated

        movzx ecx, byte[sums]
        cmp eax, ecx
        je .validated

        movzx ecx, byte[pows]
        cmp eax, ecx
        je .validated

        movzx ecx, byte[muls]
        cmp eax, ecx
        je .validated

        jmp .error

    .validated:
        mov eax, [ebx]          ;   Cargo el char* del operador en eax, nuevamente
        push eax                ;   Pusheo el puntero al operador validado                

        add ebx, 4
        mov eax, [eax]          ;   Cargo el segundo operando
        push eax

        ;   Llamo a operar, que deja en EAX el resultado de la operacion!
        call operar
        add esp, 4*3             ;   Me deshago de los argumentos que pushee

        push eax                ;   Pusheo el resultado
        push ok_msg             ;   Pusheo la string de format
        call printf
        add esp, 4*2
        jmp .exit

    .error:
        mov eax, [ebx]       
        push eax                ;   Pusheo char* de operando (el puntero al operador invalido)
        push error_msg
        call printf
        add esp, 4*2

    .exit:
        popad
        leave 
        ret
