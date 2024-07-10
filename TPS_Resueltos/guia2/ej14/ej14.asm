;   realizar un programa que realice un fork, y que el proceso “hijo” imprima 
;   un mensaje “Soy el hijo” y su padre imprima un mensaje “Soy el padre”.

;   DE MAN FORK:
;       RETURN VALUE
;       On success, the PID of the child process is returned in the parent, and 0 is returned in the child.  On failure, -1 is  re‐
;       turned in the parent, no child process is created, and errno is set appropriately.

GLOBAL _start
EXTERN print
EXTERN numtostr

section .data
child db "soy el child", 0
father db "i am your father", 0

;   Supongo que cuando haces el fork(), el child process spawnea con EL MISMO ESTADO
;   i.e. empieza a correr desde la linea siguiente al fork(), solo que con un return
;   distinto que el que obtiene el padre (father el PID del child, child un 0)

section .text
_start:
mov ebp, esp

mov eax, 2        ;   SYSCALL FORK
int 0x80
test al, al
jz .child
mov ebx, father
call print

rexit:
    mov eax, 1
    int 0x80

.child:
    mov ebx, child
    call print
    

