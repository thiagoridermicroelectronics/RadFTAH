.text
.align 2
.globl _start
.ent _start

#########################################################################
# Teste sistema de memória                                              #
# 4) escrever em número de blocos maior do que a cache, forçando        #
#    expurgos;  lêr novamente blocos expurgados e conferir valores.     #
#########################################################################
_start:
li $3, 0x200   # Cache words
li $5, 0x10000 # Starting address
li $6, 0x1
sw $6, 0($5)
_l1:
addi $3, $3, -1
addi $5, $5, 0x4
nop
sw $6, 0($5)
addi $6, $6, 1
bne $3, $0, _l1
nop
# Cache cheia, escrever mais 2 blocos pra causar flushes
# e então ler os blocos expurgados
li $5, 0x11000 # Address to cause block 1 flush
li $6, 0x42
sw $6, 0($5)
sw $6, 4($5)
li $5, 0x11020 # Address to cause block 2 flush
li $6, 0x42
sw $6, 0($5)
sw $6, 4($5)
nop
nop
li $5, 0x10000 # Read flushed block
lw $13, 0($5)
lw $14, 4($5)
li $5, 0x10020 # Read flushed block
lw $15, 0($5)
lw $16, 4($5)


_exit:
jal _exit
nop
.end _start
.align 2
