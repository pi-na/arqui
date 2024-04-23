;imprima por salida estándar el fabricante del procesador.
;Investigue la función cpuid de assembler

;   Se carga un valor en el registro EAX y luego se ejecuta la instrucción CPUID. 
;   El valor cargado en EAX especifica qué tipo de información se desea obtener. 
;   Después de ejecutar la instrucción, CPUID devuelve la información en los registros EAX,
;   EBX, ECX y EDX, dependiendo de la consulta realizada.
;   >>Valores posibles para EAX:
;   0: Devuelve el número máximo de identificador de CPUID que se puede usar y una cadena de identificación del fabricante en EBX, ECX, EDX.
;       >EBX contiene los primeros 4 caracteres del identificador del fabricante.
;       >EDX contiene los siguientes 4 caracteres del identificador.
;       >ECX contiene los últimos 4 caracteres del identificador.
;   1: Devuelve información del modelo del CPU, características del CPU en ECX y EDX, y otros detalles.
;   2: Devuelve información sobre la caché del CPU.
;   3: Devuelve detalles del número de serie del procesador (en CPUs más antiguos que soportaban esta característica).
;   4 y superiores: Proporcionan información más detallada sobre características específicas, como tipos de caché, configuración multicore y capacidades de ahorro de energía.

global _start
extern sys_write

section .bss
manufacturer_id resb 12     ;       3 Registros de 4 bytes: 12 bytes de string

section .text
_start:
    mov ebp, esp
    push ebp

    ;   Consigo el manufacturer id (leer info arriba de todo)
    mov eax, 0
    cpuid
    
    ;   Cargo el manufacturer id en memoria (registro x registro)
    mov eax, manufacturer_id
    mov [eax], ebx
    mov [eax + 4], edx
    mov [eax + 8], ecx

    ;   imprimo el id
    push 12                    ;   imprimir 12 bytes
    push manufacturer_id       ;   buffer a imprimir
    push 1                     ;   FD: STDOUT
    call sys_write
    add esp, 4*3

    pop ebp
    mov eax, 1
    int 0x80
