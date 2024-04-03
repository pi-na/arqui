;   Escribir un programa que ordene un array de números enteros, de 4 bytes, 
;   e imprima el resultado ordenado por pantalla.

section .bss
my_string_memory resb 100
my_array_memory resb 40

section .data
my_array dd 4,2,7,5,8,9,1,3,6,10
my_array_len equ 10

GLOBAL _start
EXTERN print_array
EXTERN print
EXTERN numtostr
section .text
_start:
    push my_string_memory
    push my_array_len       
    push my_array            
    call print_array
    add esp, 0xc

    mov ebp, esp                ;   EBP
    push my_array_len           ;   EBP - 0x4
    push my_array               ;   EBP - 0x8
                                ;   EBP - 0xc posicion final

    ;   if len <= 1: exit
    mov ecx, [ebp - 0x4]           
    dec ecx                     ;   ecx = len(array) - 1 = posicion final
    cmp ecx, 1
    jbe .exit
    
    ;   else: pusheo la posicion final del array, en bytes
    mov eax, 4
    mul ecx                     ;   EDX:EAX = ECX * EAX
    push eax                    

    mov ecx, 0                  ;   posicion 0                       
    mov edx, 0                  ;   flag desordenado (si >0 esta desordenado)
    .ciclo:
        mov eax, [ebp - 0x8]
        add eax, ecx

        mov ebx, eax
        add ebx, 4

        push ecx
        push edx

        mov ecx, dword[eax]
        mov edx, dword[ebx]

        cmp ecx, edx
        jb .sin_permutar
        .permutar:
            mov dword[eax], edx
            mov dword[ebx], ecx
            pop edx
            pop ecx
            inc edx
            jmp .fin_ciclo
        .sin_permutar:
            pop edx
            pop ecx
        .fin_ciclo:
            add ecx, 4
            mov eax, [ebp - 0xc]           ;   pos final
            cmp ecx, eax
            jb .ciclo

            ;   Si estoy en el ultimo elem del array, me fijo si esta ordenado
            test dl, dl
            jz .exit                       ;   flag == 0 esta ordenado
            mov ecx, 0
            mov edx, 0
            jmp .ciclo
    
    .exit:
        add esp, 0xc        ;   descarto el len, la dir del array y el dato de la pos final

        push my_string_memory
        push my_array_len       
        push my_array            
        call print_array
        add esp, 0xc
    
        mov eax, 1
        int 0x80
