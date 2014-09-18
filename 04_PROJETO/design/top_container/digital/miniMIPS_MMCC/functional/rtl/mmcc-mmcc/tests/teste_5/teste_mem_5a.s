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
li $3, 0x400   # First data page words
li $5, 0x10000 # Starting address
nop
_l1:
sw $3, 0($5)
addi $3, $3, -1
addi $5, $5, 0x4
nop
nop
bne $3, $0, _l1
nop
nop
li $3, 0x400   # First data page words
li $5, 0x10000 # Starting address
nop
_l2:
nop
lw $17, 0($5)
addi $3, $3, -1
addi $5, $5, 0x4
nop
nop
bne $3, $0, _l2
nop
_exit:
jal _exit
nop
.end _start
.align 2
