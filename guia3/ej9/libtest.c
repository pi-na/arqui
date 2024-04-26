#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>  // flags para el file_open
#include "libio.h"

#define INPUT_LENGTH 20

/*
FLAGS PARA OPEN. Concatenar usando PIPE | 
O_RDONLY: Abre el archivo solo para lectura.
O_WRONLY: Abre el archivo solo para escritura.
O_RDWR: Abre el archivo para lectura y escritura.
O_CREAT: Crea el archivo si no existe.
O_TRUNC: Si el archivo ya existe y es un archivo regular, trúncalo a longitud cero
 * */

static char* hello = "Hola, como te llamas?\n"; static char* user_msg = " no sabe programar!!\n";
static char* file_open_msg = "================ Leyendo archivo:\n";
static char* file_close_msg = "================ Fin del archivo:\n";
static char* exit_msg = "Saliendo con codigo de error 200 - (echo $? para verificarlo)\n";

int main(){
    sys_write(STDOUT, hello, strlen(hello));
    
    //  Interaccion con el usuario
    char* user_name = malloc(sizeof(char) * INPUT_LENGTH);
    for(int i = 0; i < INPUT_LENGTH; i++){
        user_name[i] = 0;
    }
    sys_read(user_name, 0, INPUT_LENGTH - 1); //(0: stdin, 1: stdout, 2:stderr)
    sys_write(STDOUT, user_name, strlen(user_name)); 
    sys_write(STDOUT, user_msg, strlen(user_msg));
    free(user_name);

    //Apertura de archivo -> print -> Cerrar archivo
    char* file_txt = malloc(sizeof(char) * 13);
    for(int i = 0; i < INPUT_LENGTH; i++){
        file_txt[i] = 0;
    }
    unsigned int file_descriptor = file_open("/home/tomas/shared/guia3/ej9/ejemplo.txt", O_RDONLY);
    sys_read(file_txt, file_descriptor, 11);

    sys_write(STDOUT, file_open_msg, strlen(file_open_msg));
    sys_write(STDOUT, file_txt, 11);
    free(file_txt);

    file_close(file_descriptor);
    sys_write(STDOUT, file_close_msg, strlen(file_close_msg));

    //Salida
    sys_write(STDOUT, exit_msg, strlen(exit_msg));
    exit(200);
    return 0;
}
