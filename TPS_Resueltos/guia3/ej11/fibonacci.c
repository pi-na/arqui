#include <stdio.h>

int fibo(int n);

int main(){
    int result = fibo(3);
    printf("fibonacci(3) = %d\n", result);
    return 0;
}

int fibo(int n){
    if(n == 0 || n == 1) return n;
    return fibo(n - 1) + fibo(n - 2);
}

/*
=========   posible output en ASM   =========

;   EBP         |   EBP contexto anterior
;   EBP + 4     |   Dir ret contexto anterior
;   EBP + 8     |   N en naturales
fibo:
    push ebp
    mov ebp, esp

    mov eax, [EBP + 8]
    test al, al
    jz .end

    cmp eax, 1
    je .end

    dec eax
    push eax        ;   push N - 1
    call fibo
    mov ebx, eax    ;   return de fibo(N - 1) en ebx
    
    pop eax         ;   recupero N-1
    dec eax     
    push eax        ;   push N - 2
    call fibo       ;   return de fibo(N - 2) en eax

    add eax, ebx    ;   eax = fibo(n - 2), le sumo fibo(N - 1)

    .end
    pop ebp
    ret

========    output real en ASM   ========

;   OJO TAMBIEN VER fibonacci.s para realizar el seguimiento de stack

fibo:
;=========================
;   Armado de stack frame
;=========================
.LFB1:
	.loc 1 11 16
	push	ebp
.LCFI7:
	mov	ebp, esp
.LCFI8:
	push	ebx
	sub	esp, 4

;==========================================================
;   !!!CASO BASE!!!
;   Bloque IF, hace literalmente dos cmp.
;   No hace trucos con test al, al para el if == 0.
;   Notar que hace cmp cargando el dato directo del stack,
;   NO LOS CARGA A UN REGISTRO
;   Si esta en el caso base y va a retornar N,
;   recien ahi carga N a EAX y salta a return (.L4)
;==========================================================
.LCFI9:
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	.loc 1 12 7
	cmp	DWORD PTR 8[ebp], 0
	je	.L4                 ;   Si era 0 salta a .L4
	.loc 1 12 15 discriminator 2
	cmp	DWORD PTR 8[ebp], 1
	jne	.L5                 ;   Si NO era 0 ni 1, salta a .L5
                            ;   Si era 1 SIGUE LEYENDO ('salta' a .L4)
.L4:
	.loc 1 12 33 discriminator 3
	mov	eax, DWORD PTR 8[ebp]   ;   Carga el argumento N en EAX (que es cero o uno)
	jmp	.L6                     ;   RETURN


;   >>>> Si no era 0 o 1 salta a .L5 q contiene el [[paso recursivo]]
;==========================================================
;   Llamados recursivos
;==========================================================
.L5:
	.loc 1 13 12
	mov	eax, DWORD PTR 8[ebp]   ;   Carga el dato a EAX
	sub	eax, 1                  ;   Como el dec eax que tengo en mi codigo (N - 1)
	sub	esp, 12                 ;   Reserva 12 bytes en el stack (3 palabras)
	push	eax                 ;   Pushea el dato de N - 1
	call	fibo                ;   LLAMADO RECURSIVO fibo(N-1)
	add	esp, 16                 ;   Descarta 16 bytes del stack (los 12 bytes que reservo + el dato (N - 1) que pusheo recien)
	mov	ebx, eax                ;   !!! ALMACENA EN EBX EL RETURN DE EAX OAAAAA ADIVINE !!!
	.loc 1 13 26
	mov	eax, DWORD PTR 8[ebp]   ;   Carga el dato a EAX
	sub	eax, 2                  ;   EAX = (N - 2)
	sub	esp, 12                 ;   Reserva 12 bytes
	push	eax                 ;   Pushea el dato N - 2
	call	fibo                ;   LLAMADO RECURSIVO fibo(N-2)
	add	esp, 16                 ;   Descarta 16 bytes del stack (los 12 bytes que reservo + el dato (N - 1) que pusheo recien)
	.loc 1 13 24
	add	eax, ebx                ;   !!! SUMA EAX = fibo(N - 2) CON EBX = fibo(N - 1); ADIVINE !!!
;==========================================================
;   Desarmado de stack frame y RETURN
;==========================================================
.L6:
	.loc 1 14 1
	mov	ebx, DWORD PTR -4[ebp]
	leave
.LCFI10:
	ret

*/
