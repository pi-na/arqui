//  EBP - 8     |   int FACT
//  EBP - 4     |   int AUX
//  EBP         |   EBP contexto anterior
//  EBP + 4     |   RET contexto anterior
//  EBP + 8     |   N
int factorial(int n){
    // mov ebp, esp
    // push ebp

    //  sub esp, 16     ;   Reserva espacio para las variables aux, fact 
    int aux, fact;

    //  NO MODIFICA STACK
    if(n == 0)
        return 1;
    
    //  mov EAX, [EBP + 8]
    //  mov [EBP - 4], EAX
    aux = n;

    //  mov eax, [ebp + 8]  ;   eax = N
    //  dec eax             ;   eax = N - 1
    //  push eax            
    //  call factorial
    //  mov [ebp - 8], eax
    fact = factorial(n-1);

    //  mov eax, [ebp - 8]  ;   eax = fact
    //  mov ebx, [ebp - 4]  ;   ebx = aux
    //  mul ebx             ;   Deja en eax eax * ebx
    return fact * aux;

    //  pop ebp
    //  ret
}

/* Mostrar el estado de la pila si es invocado con n = 3.

FIN: fact(0) RETORNA 1 Y VAN COLAPSANDO TODOS LOS STACK FRAMES
vacio
vacio
fact0.fact
fact0.aux
EBP fact(1)  <- EBP fact(0)
RET fact(1)
0
vacio
vacio
fact1.fact
fact1.aux
EBP fact(2)
RET fact(2)  <-  EBP FACT(1)
1
fact2.fact
fact2.aux
EBP fact(3)  <-  EBP FACT(2)
RET fact(3)
2
vacio
vacio
fact3.fact
fact3.aux
EBP MAIN     <- EBP FACT(3)
RET MAIN
3   
EBP SO       <- EBP MAIN
RET SO

*/
