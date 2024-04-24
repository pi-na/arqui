void encrypt(char *plain, char *cipher){
      if(!(*plain)){
}
*cipher = 0;
return; }
char pad = get_pad();
*cipher = *plain + pad;
encrypt(plain+1, cipher+1);
