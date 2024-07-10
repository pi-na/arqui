GLOBAL _start
EXTERN numtostr
EXTERN print

section .bss
my_string_memory resb 100

section .text
_start:
mov ebp, esp
push my_string_memory
push dword[ebp]
call numtostr
add esp, 0x4
pop ebx
call print

mov eax, 1
int 0x80
