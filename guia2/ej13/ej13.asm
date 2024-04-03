;   Investigue el system call getpid y escriba un programa que imprima su pid

GLOBAL _start
EXTERN print
EXTERN numtostr

section .bss
my_string_memory resb 100

section .text
_start:
mov ebp, esp

mov eax, 0x14
int 0x80
push my_string_memory
push eax
call numtostr
add esp, 0x4
pop ebx
call print

mov eax, 1
int 0x80
