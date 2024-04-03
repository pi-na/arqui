#include <stdio.h>
#include <stdlib.h>

FILE * openFile(char * path);

int main(int argc, char ** argv){
    int c;
    FILE * file = openFile(argv[1]);

    /*  CODIGO INCOMPLETO
        Extracto del man de strings:
        "A string is any sequence of 4 (the default) or more printing characters"
        Deberia ir cargando en una string (USANDO CHAR* Y REALLOC DE A BLOQUES)
        los caracteres que sean ASCII. Hasta que encuentre un caracter que no sea ASCII.
        Ahi, chequeo si ya acumule 4 o mas caracteres y ahi la imprimo.
    */

    // fgetc automaticamente aumenta el indice de lectura CADA VEZ QUE SE LLAMA DE NUEVO!
    char justPrinted = 0;
    while ((c = fgetc(file)) != EOF) {
        if( c >= ' ' && c <= '{' ){
            justPrinted = 1;
            printf("%c", c);
        } else {            
            if(justPrinted){
                printf("\n");    
            }
            justPrinted = 0;
        }
    }

    // while ((c = fgetc(file)) != EOF) {
    //     printf("%c", c);
    // }

}

FILE * openFile(char * path){
    FILE * file = fopen(path, "rt");
        if(file == NULL){
            printf("Error al abrir el archivo\n");
            return NULL;
        }

    return file;
}