;   Output del gcc de un programa de ejemplo de la catedra:

main:
    push ebp
    mov ebp, esp
    and esp, -16
    sub esp, 32
    mov DWORD PTR [esp + 19], 1819043176
    mov DWORD PTR [esp + 23], 1870078063    ;0x6F77206F
    mov DWORD PTR [esp + 27], 174353522
    mov   BYTE PTR [esp+31], 0
    lea   eax, [esp+19]                     ;   Carga LA DIRECCION esp + 19
    mov DWORD PTR [esp], eax                ;   apunta esp a esp + 19
    call magia
    lea eax, [esp+19]
    mov DWORD PTR [esp], eax
    call printf
    mov eax, 0
    leave

;   printf(char * fmt, void* arg1, void* arg2);

magia:
    push  ebp
    mov ebp, esp
    sub esp, 16     
    jmp .L4

.L6:
      mov   eax, DWORD PTR [ebp+8]
      movzx eax, BYTE PTR [eax]         ;   >Carga el primer byte de eax
      cmp   al, 96                      ;   > Si el primer byte de EAX es menor O IGUAL a 96,
      jle   .L5                         ;   > Salta a la etiqueta .L5: suma 1 al valor ebp + 8 
      mov   eax, DWORD PTR [ebp+8]      ;]
      movzx eax, BYTE PTR [eax]         ;]-->si el 1er byte de eax es mayor estricto a 122, le suma 1 al valor de ebp+8
      cmp   al, 122                     ;]
      jg    .L5                         ;]
      mov   eax, DWORD PTR [ebp+8]      ;   >Carga en eax ebp + 8
      movzx eax, BYTE PTR [eax]         ;   Carga en eax el primer byte de ebp+8, llena con cero 
      mov   BYTE PTR [ebp‐1], al        ;   escribe en ebp - 1 el primer byte de ebp + 8
      movzx eax, BYTE PTR [ebp‐1]       ;   carga de ebp-1 a eax el mismo byte que escribio y llena con cero
      sub   eax, 32                     ;   Le resta 32 a eax
      mov   BYTE PTR [ebp‐1], al        ;   carga en ebp -1 el byte - 32
      mov  eax, DWORD PTR [ebp+8]       ;   carga en eax de nuevo el ebp + 8
      movzx edx, BYTE PTR [ebp‐1]       ;   carga en edx el byte de ebp-1 y llena con ceros
      mov   BYTE PTR [eax], dl          ;   carga en eax el byte de eb[ - 1
.L5:
      add   DWORD PTR [ebp+8], 1        ;   incrementa en uno lo que hay en ebp+8
    
;=========== ETIQUETA L4 =============
;   Si el numero no termina en 0,
;   vuelve a arrancar el ciclo L6
;   Si no, retorna el numero
;=====================================  
.L4:
      mov   eax, DWORD PTR [ebp+8]      ;   en EBP + 8 inicialmente hay basura
      movzx eax, BYTE PTR [eax]         ;   agarra el primer byte de lo que haya ahi
      test  al, al
      jne   .L6                         ;   Si el primer byte de ebp + 8 es != 0 vuelve al ciclo de L6
      leave
      ret
