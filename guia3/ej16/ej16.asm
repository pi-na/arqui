
;   ESTE EJERCICIO ME CHUPA BIEN LOS DOS HUEVOS
;   vean la version ej16_gay.























;   El primer parámetro es la dirección de inicio de un vector de caracteres.
;   El segundo parámetro es un valor entero que indica la cantidad de
;   elementos del vector de caracteres.
;   retorna la diferencia que hubo entre el valor calculado y el valor informado. 
;   Es decir, si son iguales retorna cero, si el valor calculado es mayor al informado
;   retorna la deferencia en valor positivo, si el valor informado es mayor, retorna 
;   la diferencia en valor negativo.

global checklength
global msg
global len

section .data
msg db "Hola Mundo", 0
len db 10



section .text:

;   Los registros a preservar entre las llamadas de las funciones son:
;   ebx,  esi, edi, ebp, esp
;   EBP - 4     |   ESI contexto anterior
;   EBP         |   EBP contexto anterior
;   EBP + 4     |   Dir ret contexto anterior
;   EBP + 8     |   Puntero a vector de chars
;   EBP + 12    |   len: Cantidad de elementos del vector

;   PRUEBA ACTUAL PUSH ECX
checklength:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push esi

    mov ecx, 0      ;   Contador en ecx 
    mov eax, [EBP + 8]

    .loop:
        movzx esi, BYTE[eax]
        
        test eax, eax   ;   test al, al ya era suficiente
        jz .finish

        inc ecx
        inc esi
        jmp .loop


    .finish:
        mov eax, [ebp + 12]
        sub eax, ecx

        pop esi
        pop ecx
        pop ebx
        leave
        ret

