#include <stdio.h>

int checklength(char* buffer, char len);
extern char *msg;
extern char len;

int main(){
   int ret = checklength(msg, len);

   if(ret == 0)
        printf("El len es 10!!\n");
   else printf("El len no era 10 D:\n");

   return 0;
}
