global _start
extern get_humedad
extern print
ALIGN 4

section .rodata:
time dd 1       ;   un int
file_path db "/sys/bus/gay", 0
arreglo dd 10, 20, 30, 40, 50
cant_arreglo dd ($-arreglo)/4
match db "La humedad coincide. Humedad: %d\n", 0
no_match db "La humedad no coincide\n", 0

section .text
_start:
    push ebp
    mov ebp, esp
    ;   Armo stack frame por mas de que el programa no tiene
    ;   salida. Se interrumpe la ejecucion desde el SO cuando
    ;   se desea salir.

    .loop:
        push file_path
        push 16
        call get_humedad        ;   Deja en EAX la humedad
        add esp, 4*2
    
        mov ebx, 7
        div ebx                 ;   Divide EAX por EBX. 
                                ;   Deja cociente en EAX, resto en EDX

        .check_humedad
            mov ebx, eax                    ;   guardo en ebx la humedad
            mov ecx, dword[cant_arreglo]    ;   cargo en ecx size del array     
            cld                             ;   preparo flags para lodsd
            mov esi, arreglo                ;   cargo en eesi puntero al array
            lodsd                           ;   deja en eax el valor actual del array,
                                            ;   y avanza esi una posicion
            cmp eax, ebx
            je .match
        
            loop .check_humedad             ;   salta si ecx != 0. Decrementa ecx

            push no_match
            call print
            add esp, 4
            jmp .continue
            
        .match
            push eax
            push match
            call print
            add esp 4*2

        .continue
            mov eax, 162            ;   syscall nanosleep
            mov ebx, time           ;   Recibe puntero!
            mov ecx, 0
            int 0x80
            jmp .loop

    ;   No hay condicion de salida
