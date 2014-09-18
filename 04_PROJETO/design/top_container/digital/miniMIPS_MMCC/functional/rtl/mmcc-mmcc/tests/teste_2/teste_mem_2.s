.text
.align 2
.globl _start
.ent _start

####################################################################
# Teste sistema de memória                                         #
# 2) escreve no endereço E2, cacheável, escreve no endereço E3     #
# que mapeia no mesmo bloco que E2, assim expurgando E2 da cache.  #
# Lê novamente E2 para a cache e verifica valor na cache.          #
####################################################################
_start:
li $t0, 0x10000 # Cacheável
li $t1, 0x11000 # Cacheável
li $t2, 0x40
li $t3, 0x17
sw $t2, 0($t0)
addiu $t2, $t2, 1
sw $t2, 4($t0)
addiu $t2, $t2, 1
sw $t2, 8($t0)
addiu $t2, $t2, 1
sw $t2, 12($t0)
addiu $t2, $t2, 1
sw $t2, 16($t0)
addiu $t2, $t2, 1
sw $t2, 20($t0)
addiu $t2, $t2, 1
sw $t2, 24($t0)
addiu $t2, $t2, 1
sw $t2, 28($t0)
nop
nop
nop
nop
nop
sw $t3, 0($t1)
nop
nop
nop
nop
nop
lw $17, 0($t0)
_exit:
jal _exit
nop
.end _start
.align 2
