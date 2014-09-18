PATH=$PATH:/mips_tools/mips/bin
mips-elf-gcc -mips1 -msoft-float -S matrix.c -o matrix.s
mips-elf-as -O0 -g -EB -mips1 -o matrix.o matrix.s
mips-elf-as -O0 -g -EB -mips1 -o start.o start.s
mips-elf-as -O0 -g -EB -mips1 -o start.o start.s
mips-elf-ld --oformat binary -e _start -Ttext 0 -o matrix.bin start.o matrix.o
mips-elf-ld --oformat ihex -e _start -Ttext 0 -o matrix.hex start.o matrix.o
mips-elf-ld --oformat srec -e _start -Ttext 0 -o matrix.srec start.o matrix.o
mips-elf-ld -e _start -Ttext 0 -o matrix.elf start.o matrix.o
mips-elf-objdump -z -D -EB matrix.elf > matrix.dump
./bin2coe matrix.bin matrix.coe
cp matrix.bin ../../sim/.
