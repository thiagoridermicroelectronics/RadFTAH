.text
.align 2
.globl _start
.ent _start

_start:
li $sp, 73724     # Start SP
li $31, 0x00FF    # Unreset other cores
mtc0 $31,$16
nop
jal main
nop
_exit:
jal _exit
nop
.end _start
.align 2
