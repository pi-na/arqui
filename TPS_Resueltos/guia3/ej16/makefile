# Lista de archivos fuente en ensamblador (.asm) y en C (.c)
ASMSOURCES := $(wildcard *.asm)
CSOURCES := $(wildcard *.c)

# Lista de nombres de programas finales (sin extensiones)
PROGRAMS := $(patsubst %.asm,%,$(ASMSOURCES)) $(patsubst %.c,%,$(CSOURCES))

# Lista de archivos objeto correspondientes a los archivos en ensamblador y en C
ASMOBJS := $(patsubst %.asm,%.o,$(ASMSOURCES))
COBJS := $(patsubst %.c,%.o,$(CSOURCES))

# Compilador y banderas
NASM := nasm
NASM_FLAGS := -f elf32

GCC := gcc
GCC_FLAGS := -m32 -fno-builtin

# Reglas de construcciÃ³n
.PHONY: all clean $(PROGRAMS)

all: $(PROGRAMS)

# Regla para construir programas finales
$(PROGRAMS): %: %.o $(ASMOBJS) $(COBJS)
	$(GCC) $(GCC_FLAGS) -o $@ $(ASMOBJS) $(COBJS)

# Regla para compilar archivos en ensamblador (.asm) a objetos (.o)
%.o: %.asm
	$(NASM) $(NASM_FLAGS) $< -o $@

# Regla para compilar archivos en C (.c) a objetos (.o)
%.o: %.c
	$(GCC) $(GCC_FLAGS) -c $< -o $@

# Regla para limpiar archivos generados
clean:
	rm -f $(PROGRAMS) $(ASMOBJS) $(COBJS)
