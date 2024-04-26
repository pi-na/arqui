#include <stdio.h>
extern char msg[];
extern char len;
int check_long(char* msg, char len);

int main()
{
    long res = check_long(msg, len);
    printf("%s\n",  res == 0? "Funciona":"No funciona");
    return 0;
}
