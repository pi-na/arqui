//Escriba una función en Assembler que retorne siempre el valor 7.
//Llámela con C y muestre por salida estándar dicho valor.

#include <stdio.h>

unsigned int seven();

int main(){
    int number = seven();
    printf("Tu numero de la suerte es: %d\n", number);
    return 0;
}
