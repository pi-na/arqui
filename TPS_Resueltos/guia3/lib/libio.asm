GLOBAL sys_write
GLOBAL exit
GLOBAL sys_read
GLOBAL file_open
GLOBAL file_close

EXTERN printf
EXTERN fflush

section .bss
file_descriptor resb 5

section .text

;   Salir de un proceso
;   Recibe por argumento el codigo de return para el SO
;   ESP     |   ret del contexto anterior
;   ESP + 4 |   error code  (chequeado con el print!)
exit:
    mov ebx, [ESP+4]  ;   error code
    mov eax, 0x01        ;   exit
    int 0x80

;   Deja en EAX el FD
;   EBP         |   EBP contexto anterior
;   EBP + 4     |   Dir ret contexto anterior
;   EBP + 8     |   Pathname
;   EBP + 12    |   flags para abrir el archivo
file_open:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx

    ;   Open crea un nuevo FILE DESCRIPTOR que apunta al archivo, y lo deja en EAX
    mov eax, 5           ;   syscall read
    mov ebx, [EBP + 8]   ;   pathname
    mov edx, 0644        ;   mode
    mov ecx, [EBP + 12]  ;   flags   
    int 0x80

    pop edx
    pop ecx
    pop ebx

    ;   Ya tengo en EAX el FD, y en C se retorna por EAX
    pop ebp
    ret

;   Cierra el archivo en el FD que reciube por pathname
;   EBP         |   EBP contexto anterior
;   EBP + 4     |   Dir ret contexto anterior
;   EBP + 8     |   FD con el file a cerrar
file_close:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 6          ;   syscall close
    mov ebx, [EBP + 8]  ;   FD
    int 0x80

    pop ebx
    pop ebp
    ret

;   EBP         |   EBP context anterior
;   EBP + 4     |   RET context anterior
;   EBP + 8     |   FD al que escribir
;   EBP + 12    |   buffer del que leer
;   EBP + 16    |   length para leer
sys_write:
    push ebp
    mov ebp, esp

    pushad

    mov eax, 0x4
    mov ebx, [ebp+8]  ; file descriptor (0: stdin, 1: stdout, 2:stderr)
    mov ecx, [ebp+12] ; buffer 
    mov edx, [ebp+16] ; length
    int 0x80

    popad

    pop ebp
    ret

;   EBP         |   EBP contexto anterior
;   EBP + 4     |   Dir ret contexto anterior
;   EBP + 8     |   Buffer al que escribir el string leido
;   EBP + 12    |   File descriptor del que leer
;   EBP + 16    |   Cantidad de chars a leer (bytes)
sys_read:
    push ebp
    mov ebp, esp

    pushad

    mov eax, 3
    mov ecx, [ebp + 8]   ; buffer al que escribir
    mov ebx, [ebp + 12]  ; file descriptor del que leer (0: stdin, 1: stdout, 2:stderr)
    mov edx, [ebp + 16]  ; length
    int 0x80

    popad

    pop ebp
    ret
