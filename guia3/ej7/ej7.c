/*
  Declare en una función de C, un arreglo de las siguientes formas:
 Sin inicializar
 Con inicialización (int numeros[20] = {0}, ó char msg[] = “mensaje”)
 Sin inicializar y luego realizando una escritura en el índice 10
 Con inicialización y luego realizando una escritura en el índice 10
 De manera global, sin inicializar
 De manera global inicializando.
*/


//De manera global, sin inicializar
int array5[1];

// De manera global inicializando.
int array6[] = {1};

int main(){
    //Sin inicializar
    int array1[5];

    //Con inicializacion
    int array2[20] = {0};

    //Sin inicializar y luego realizando una escritura en el índice 10
    int array3[11];
    array3[10] = 10;

    //Con inicialización y luego realizando una escritura en el índice 10
    int array4[11] = {0};
    array4[10] = 10;


}
