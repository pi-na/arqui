#define STDOUT 1

unsigned int sys_write(unsigned int fd, void *buffer, unsigned int size);

void exit(int code);

void sys_read(char* buffer, unsigned int file_descriptor, unsigned int length);

unsigned int file_open(char* file_pathname, char* FLAGS);

void file_close(unsigned int file_descriptor);
