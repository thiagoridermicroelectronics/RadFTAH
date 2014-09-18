.text
.align 2
.globl _start
.ent _start

#########################################################################
# Teste sistema de memória                                              #
# 3) escrever em todos os blocos da cache (talvez uns blocos a          #
#    menos, dependendo dos dados do programa de testes);                #
#    lêr e verificar valores escritos; verificar tráfego no barramento. #
#########################################################################
_start:
li $3, 0x200   # Cache words
li $5, 0x10000 # Starting address
li $6, 0x42
sw $6, 0($5)
_l1:
addi $3, $3, -1
addi $5, $5, 0x4
nop
sw $6, 0($5)
bne $3, $0, _l1

li $3, 0x200   # Cache words
li $5, 0x10000 # Starting address
lw $6, 0($5)
_l2:
addi $3, $3, -1
addi $5, $5, 0x4
nop
lw $6, 0($5)
bne $3, $0, _l2
nop
_exit:
jal _exit
nop
.end _start
.align 2
