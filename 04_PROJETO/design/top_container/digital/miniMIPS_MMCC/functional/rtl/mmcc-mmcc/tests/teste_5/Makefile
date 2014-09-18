BINARY=program
SOURCES=
HEADERS=other.h


#============================
#DO NOT EDIT FROM HERE!
#============================

CC=mips-gcc
LD=mips-ld
AS=mips-as

ASMS=teste_mem_5a.s $(SOURCES:.c=.s)
OBJECTS=$(ASMS:.s=.o)

# We want a binary only image
all: $(BINARY).bin

# Generating the assembly code
%.s: %.c $(HEADERS)
	mips-gcc -mips1 -msoft-float -S $< -o $@

# Building .o files using the assembly code
%.o: %.s
	$(AS) -O0 -g -EB -mips1 -o $@ $<

# Generating elf file to avoid breaking LD with segfault. WTF!
$(BINARY).elf: $(OBJECTS)
	$(LD) -e _start -Ttext 0  -Tdata 0x00010000 -o $(BINARY).elf $(OBJECTS)

# Stripping elf to get the binary only image
$(BINARY).bin: $(BINARY).elf
	mips-objcopy $(BINARY).elf -O binary $(BINARY).bin

# XXX: I don't know why, but make is not using our defined rule to
# build the .o files. It's ignoring the .s step. So this
# rule forces it to create the .s file first.
$(OBJECTS): $(ASMS)

clear:
	rm -f $(OBJECTS) $(SOURCES:.c=.s) $(BINARY).elf $(BINARY).bin
