
;   EBP contexto anterior
;   RET contexto anterior
;   encabezado  (puntero a char)
;   17
;   pie (puntero a char)
;   14


section .text

;   EBP         |   ebp contexto anterior
;   EBP + 4     |   dir ret
;   EBP + 8     |   string
;   EBP + 12    |   len
;   EBP + 16    |   OFFSET ESCRITURA
;   CONFIANDO EN QUE EL LEN ES VALIDO ! ! !
imprimir_pie:
    mov ebp, esp
    push ebp
    
    mov edx, 0xA0000000
    mov eax, [EBP + 16]
    add edx, eax

    mov esi, [EBP + 8]
    mov ecx, [EBP + 12]         ;   preparo counter para lodsb, con el len
    cld                         ;   Preparo flags para usar esi+lodsb+loop
    .loop:
        lodsb                   ;   LODSB me deja el siguiente char en AL
        mov [edx], al
        
        inc edx                 ;   Apunto EDX 1 byte adleante
        loop .loop

    leave
    ret
    
