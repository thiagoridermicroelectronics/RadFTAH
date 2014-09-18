.text
.align 2
.globl _start
.ent _start
_start:
li $30, 0x00              # Master core ID
mfc0 $31, $11             # Get CPU_ID
nop
bne $31,$30, _no_init     # If not master core, just start
nop
li $31, 1                 # If master, request bus lock
mtc0 $31,$17
nop
_lock_st :
li $30, 0x03              # Locked status
mfc0 $31, $17             # Get lock status
nop
bne $31, $30, _lock_st    # Check and wait lock status
nop
li $sp,0x4000             #Initialize shared memory at 0x4000...
li $31, 0x80              # ... init CPU counter ...
nop
_sem_init:
sw $0,0($sp)              # ... initialize semaphore ...
addi $sp,$sp, 0x4         # ... increment pointer ...
addiu $31, $31, -1        # ... decrement init counter ...
bne $31, $0, _sem_init    # ... and keep intializing all semaphores.
nop
li $31, 0x00FF            # Unreset other cores.
mtc0 $31,$16
nop
li $31, 0                 # Release lock
mtc0 $31,$17
nop
_no_init :
li $sp,0x17f0             # Initialize stack pointer to 0x17f0
addi $sp,$sp,0
la $gp,_gp
mfc0 $4, $11              # Get CPU_ID
nop
jal main                  # Go to main ...
nop
_exit:
jal _exit
nop
.end _start
.align 7
