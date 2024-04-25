#include <stdio.h>

//  TODOS LOS COMENTARIOS CON INSTRUCCIONES SON SIMBOLICAS,
//  EJEMPLOS DE COMO PODRIAN SER LAS INSTRUCCIONES DEL CODIGO COMPILADO

/*  CONSIGNA:
    El dispositivo de encriptación comienza devolviendo 1 byte igual 
    a 0 e incrementa en 1 en cada llamada.
    Supongo que se refieren a que get_pad() devuelve 0, 1, 2, 3, ...

    CONSIGNA:
    Muestre como cada operación altera el estado de la pila al 
    invocar la función test y cuál es la salida por salida estándar.
*/


char get_pad(){
    static char pad = 0;
    return pad++;
}

//  EBP         |   EBP contexto anterior
//  EBP + 4     |   direccion RET contexto anterior
//  EBP + 8     |   char* plain
//  EBP + 12    |   char* cipher
void encrypt(char* plain, char* cipher){
    //  PUSH EBP
    //  MOV EBP, ESP
    //=======================================
    //  NO ALTERA EL STACK.
    //  Si el char actual de plain es == 0, deja [cipher] en cero y retorna...
    if(!(*plain)){
        *cipher = 0;    
        return;
    }
    //=======================================

    //  SUB ESP, 16: reserva espacio en el stack para la nueva variable 'char pad'
    //  call get_pad()
    //  mov [EBP - 8], EAX: almacena el return de get_pad en char pad
    char pad = get_pad();
    
    //  No altera el stack. Carga plain en EAX, carga pad en EBX, sum EAX, EBX.
    //  MOV EAX, [EBP + 8]          ;   Carga la direccion del primer char de la string plain en EAX
    //  MOVZX EAX, BYTE PTR [EAX]   ;   CARGA EL PRIMER CHAR DE LA STRING PLAIN EN EAX
    //  MOV EBX, [EBP - 8]          ;   Carga el char pad en EBX
    //  SUM EAX, EBX                ;   Suma el primer char de plain con el char pad
    //  MOV EBX, [EBP + 12]         ;   Carga la direccion de string cipher en EBX
    //  MOV BYTE PTR[EBX], [EAX]    ;   Carga en el primer char de cipher el resultado de la suma
    *cipher = *plain + pad;

    //  MOV EAX, [EBP + 12]
    //  INC EAX
    //  PUSH EAX
    //  MOV EAX, [EBP + 8]
    //  INC EAX
    //  PUSH EAX
    //  call encrypt
    encrypt(plain+1, cipher+1);
    //  ADD ESP, 4 * 2
    //  ADD ESP, 16
    
    //  POP EBP
    //  RET
}

/*
    Supongo que por cada llamado recursivo que hace encrypt a si misma se
    van apilando los stack de cada llamado, hasta que llega el ultimo
    y arrancan a descartarse uno por uno hasta el llamado original que
    retorna test()
*/

void test(){
    char *msg = "Ark";
    char cipher[] = "--------";
    cipher[4] = '0';              //    cipher == "----0---"
    encrypt(msg, cipher);         //    cipher == "Asm00---"  

    printf(cipher);               //    Supongo que mandan el cipher sin "%s" para que el stack sea mas simple
                                  //    cipher es un char[] asi que funciona
                                  //    Es peligroso usarlo asi! Deberia usarse siempre la cadena de formato
}


int main(){
    test();
    return 0;
}
