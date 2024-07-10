;Escriba una función en Assembler que retorne siempre el valor 7. 
;Llámela con C y muestre por salida estándar dicho valor.

GLOBAL seven

section .text
seven:
    mov eax, 7
    ret
