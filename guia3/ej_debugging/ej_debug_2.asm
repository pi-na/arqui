;===============================================================================
;   COMO ARREGLARLO: Poner el orden de los argumentos bien
;   Ademas decia and esp, 3*4 y tenia que decir add esp, 3*4
;   (and es otra directiva que hace compara los bits de los dos operandos)
;===============================================================================
; char str[80];  sprintf(char* buffer, char* fmt_string, void* arg1, void* arg2, (...) );

GLOBAL main
EXTERN puts, sprintf

section .bss
buffer resb 40

section .rodata
fmt db "%d", 0
number dd 1234567890

section .text
main:
     mov eax, dword [number]

     ;push dword [number]
     push eax
     push fmt
     push buffer
     call sprintf
     add esp, 3*4

     push buffer
     call puts
     add esp,4

     ret
