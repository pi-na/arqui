;   Escribir un programa que dado un array de números enteros,
;   de 4 bytes, encuentre el menor, y lo imprima por salida estándar.

section .bss
my_string_memory resb 100

section .data
my_array dd 5,6,24,4,3,64,24642,1,3434,7514,721476
my_array_len equ 11

GLOBAL _start
EXTERN print
EXTERN numtostr
section .text
_start:
    mov ebp, esp                ;   EBP
    push my_array_len           ;   EBP - 0x4
    push my_array               ;   EBP - 0x8

    ;   if len == 0: exit
    mov ecx, [ebp - 0x4]        ;   ecx = len(array)
    test cl, cl
    jz .exit
    
    ;   else: pusheo la posicion final del array
    mov eax, 4
    mul ecx                     ;   EDX:EAX = ECX * EAX
    mov edx, eax                ;   EDX = pos final

    ;   ECX = offset lectura    |   EDX = len(array)
    ;   EBX = array             |   EAX = elemento menor    
    mov ebx, [ebp - 0x8]        ;   ebx = direccion inicio del array
    mov eax, [ebx]              ;   eax = arr[0]
    mov ecx, 0                  ;   posicion 0                       
    .ciclo
        add ecx, 4              ;   Apunto el offset a la siguiente posicion (int: 4 bytes)
        cmp ecx, edx            ;   Si el ultimo ciclo correspondia al ultimo elemento, offset = len
        je .finish

        mov ebx, [ebp - 0x8]    
        add ebx, ecx  
        mov ebx, [ebx]
        cmp eax, ebx
        jb .ciclo            
        mov eax, ebx            ;   if eax > ebx: eax = ebx   
        jmp .ciclo
    
    .finish
        push my_string_memory
        push eax
        call numtostr
        add esp, 0x4
        pop ebx
        call print
    .exit
        mov eax, 1
        int 0x80


;   EBP - 0x4   = Longitud en bytes del array (len * 4)
;   EBP         = EBP anterior
;   EBP + 0x4   = direccion de ret (main)
;   EBP + 0x8   = direccion del array
;   EBP + 0xc   = longitud del array
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
        push my_string_memory
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

    mov eax, [ebp + 0xc]
    push eax
    mov eax, [ebp + 0x8]
    push eax
    call _print_array
    add esp, 0x8

    popad
    pop ebp
    ret

