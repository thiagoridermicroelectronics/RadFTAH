.text
.align 2
.globl _start
.ent _start

#################################################################
# Teste sistema de memória                                      #
# 1) escreve no endereço E1 e lê do mesmo endereço, desviando   #
# da cache; verificar se o bloco da cache no qual E1 é mapeado  #
# foi alterado (cache não pode ter sido alterada)               #
#################################################################
_start:

li $t0, 0x11004
li $t1, 0x42
sw $t1, 0($t0)
nop
nop
nop
nop
nop
lw $t2, 0($t0)

_exit:
jal _exit
nop
.end _start
.align 2
