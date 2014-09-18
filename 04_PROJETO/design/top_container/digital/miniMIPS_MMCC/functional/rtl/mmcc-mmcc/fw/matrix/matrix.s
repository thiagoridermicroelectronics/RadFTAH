	.file	1 "matrix.c"
	.section .mdebug.abi32
	.previous
	.text
	.align	2
	.globl	get_time
	.ent	get_time
get_time:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
 #APP
	mfc0 $2,$18
 #NO_APP
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	get_time
	.align	2
	.globl	print_space
	.ent	print_space
print_space:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,16
	sw	$fp,8($sp)
	move	$fp,$sp
	li	$2,17408			# 0x4400
	sw	$2,0($fp)
	lw	$3,0($fp)
	li	$2,32			# 0x20
	sw	$2,0($3)
	move	$sp,$fp
	lw	$fp,8($sp)
	addu	$sp,$sp,16
	j	$31
	.end	print_space
	.align	2
	.globl	print_newline
	.ent	print_newline
print_newline:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,16
	sw	$fp,8($sp)
	move	$fp,$sp
	li	$2,17408			# 0x4400
	sw	$2,0($fp)
	lw	$3,0($fp)
	li	$2,10			# 0xa
	sw	$2,0($3)
	lw	$3,0($fp)
	li	$2,13			# 0xd
	sw	$2,0($3)
	move	$sp,$fp
	lw	$fp,8($sp)
	addu	$sp,$sp,16
	j	$31
	.end	print_newline
	.align	2
	.globl	adivb
	.ent	adivb
adivb:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,16
	sw	$fp,8($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	sw	$5,20($fp)
	sw	$0,0($fp)
	lw	$2,20($fp)
	beq	$2,$0,$L5
$L6:
	lw	$2,16($fp)
	lw	$3,20($fp)
	sltu	$2,$2,$3
	beq	$2,$0,$L8
	j	$L5
$L8:
	lw	$2,0($fp)
	addu	$2,$2,1
	sw	$2,0($fp)
	lw	$3,16($fp)
	lw	$2,20($fp)
	subu	$2,$3,$2
	sw	$2,16($fp)
	j	$L6
$L5:
	lw	$2,0($fp)
	move	$sp,$fp
	lw	$fp,8($sp)
	addu	$sp,$sp,16
	j	$31
	.end	adivb
	.align	2
	.globl	print_uint
	.ent	print_uint
print_uint:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	li	$2,17408			# 0x4400
	sw	$2,16($fp)
	li	$2,1			# 0x1
	sw	$2,24($fp)
	lw	$4,40($fp)
	li	$5,999948288			# 0x3b9a0000
	ori	$5,$5,0xca00
	jal	adivb
	sw	$2,20($fp)
	lw	$3,16($fp)
	lw	$2,20($fp)
	addu	$2,$2,48
	sw	$2,0($3)
	lw	$3,20($fp)
	li	$2,999948288			# 0x3b9a0000
	ori	$2,$2,0xca00
	mult	$3,$2
	mflo	$3
	lw	$2,40($fp)
	subu	$2,$2,$3
	sw	$2,40($fp)
	lw	$4,40($fp)
	li	$5,99942400			# 0x5f50000
	ori	$5,$5,0xe100
	jal	adivb
	sw	$2,20($fp)
	lw	$3,16($fp)
	lw	$2,20($fp)
	addu	$2,$2,48
	sw	$2,0($3)
	lw	$3,20($fp)
	move	$2,$3
	sll	$2,$2,1
	addu	$2,$2,$3
	sll	$2,$2,6
	subu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,4
	subu	$2,$2,$3
	sll	$2,$2,5
	addu	$2,$2,$3
	sll	$3,$2,8
	lw	$2,40($fp)
	subu	$2,$2,$3
	sw	$2,40($fp)
	lw	$4,40($fp)
	li	$5,9961472			# 0x980000
	ori	$5,$5,0x9680
	jal	adivb
	sw	$2,20($fp)
	lw	$3,16($fp)
	lw	$2,20($fp)
	addu	$2,$2,48
	sw	$2,0($3)
	lw	$4,20($fp)
	move	$2,$4
	sll	$3,$2,5
	subu	$3,$3,$4
	sll	$2,$3,6
	subu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$4
	sll	$3,$2,2
	addu	$2,$2,$3
	sll	$3,$2,7
	lw	$2,40($fp)
	subu	$2,$2,$3
	sw	$2,40($fp)
	lw	$4,40($fp)
	li	$5,983040			# 0xf0000
	ori	$5,$5,0x4240
	jal	adivb
	sw	$2,20($fp)
	lw	$3,16($fp)
	lw	$2,20($fp)
	addu	$2,$2,48
	sw	$2,0($3)
	lw	$4,20($fp)
	move	$2,$4
	sll	$3,$2,5
	subu	$3,$3,$4
	sll	$2,$3,6
	subu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$4
	sll	$3,$2,6
	lw	$2,40($fp)
	subu	$2,$2,$3
	sw	$2,40($fp)
	lw	$4,40($fp)
	li	$5,65536			# 0x10000
	ori	$5,$5,0x86a0
	jal	adivb
	sw	$2,20($fp)
	lw	$3,16($fp)
	lw	$2,20($fp)
	addu	$2,$2,48
	sw	$2,0($3)
	lw	$4,20($fp)
	move	$2,$4
	sll	$2,$2,1
	addu	$2,$2,$4
	sll	$3,$2,6
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$4
	sll	$3,$2,5
	lw	$2,40($fp)
	subu	$2,$2,$3
	sw	$2,40($fp)
	lw	$4,40($fp)
	li	$5,10000			# 0x2710
	jal	adivb
	sw	$2,20($fp)
	lw	$3,16($fp)
	lw	$2,20($fp)
	addu	$2,$2,48
	sw	$2,0($3)
	lw	$3,20($fp)
	move	$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,3
	subu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$3
	sll	$3,$2,4
	lw	$2,40($fp)
	subu	$2,$2,$3
	sw	$2,40($fp)
	lw	$4,40($fp)
	li	$5,1000			# 0x3e8
	jal	adivb
	sw	$2,20($fp)
	lw	$3,16($fp)
	lw	$2,20($fp)
	addu	$2,$2,48
	sw	$2,0($3)
	lw	$3,20($fp)
	move	$2,$3
	sll	$2,$2,5
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$3,$2,3
	lw	$2,40($fp)
	subu	$2,$2,$3
	sw	$2,40($fp)
	lw	$4,40($fp)
	li	$5,100			# 0x64
	jal	adivb
	sw	$2,20($fp)
	lw	$3,16($fp)
	lw	$2,20($fp)
	addu	$2,$2,48
	sw	$2,0($3)
	lw	$3,20($fp)
	move	$2,$3
	sll	$2,$2,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$3,$2,2
	lw	$2,40($fp)
	subu	$2,$2,$3
	sw	$2,40($fp)
	lw	$4,40($fp)
	li	$5,10			# 0xa
	jal	adivb
	sw	$2,20($fp)
	lw	$3,16($fp)
	lw	$2,20($fp)
	addu	$2,$2,48
	sw	$2,0($3)
	lw	$3,20($fp)
	move	$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$3,$2,1
	lw	$2,40($fp)
	subu	$2,$2,$3
	sw	$2,40($fp)
	lw	$3,16($fp)
	lw	$2,40($fp)
	addu	$2,$2,48
	sw	$2,0($3)
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addu	$sp,$sp,40
	j	$31
	.end	print_uint
	.align	2
	.globl	print_start
	.ent	print_start
print_start:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$5,36($fp)
	li	$2,17408			# 0x4400
	sw	$2,16($fp)
	lw	$3,16($fp)
	li	$2,83			# 0x53
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,116			# 0x74
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,97			# 0x61
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,114			# 0x72
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,116			# 0x74
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,105			# 0x69
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,110			# 0x6e
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,103			# 0x67
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,32			# 0x20
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,99			# 0x63
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,111			# 0x6f
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,100			# 0x64
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,101			# 0x65
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,32			# 0x20
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,111			# 0x6f
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,110			# 0x6e
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,32			# 0x20
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,67			# 0x43
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,80			# 0x50
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,85			# 0x55
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,35			# 0x23
	sw	$2,0($3)
	lw	$4,32($fp)
	jal	print_uint
	jal	print_newline
	lw	$4,36($fp)
	jal	print_uint
	jal	print_newline
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addu	$sp,$sp,32
	j	$31
	.end	print_start
	.align	2
	.globl	print_end
	.ent	print_end
print_end:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$5,36($fp)
	li	$2,17408			# 0x4400
	sw	$2,16($fp)
	lw	$3,16($fp)
	li	$2,70			# 0x46
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,105			# 0x69
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,110			# 0x6e
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,105			# 0x69
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,115			# 0x73
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,104			# 0x68
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,101			# 0x65
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,100			# 0x64
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,32			# 0x20
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,112			# 0x70
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,114			# 0x72
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,111			# 0x6f
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,99			# 0x63
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,101			# 0x65
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,115			# 0x73
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,115			# 0x73
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,105			# 0x69
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,110			# 0x6e
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,103			# 0x67
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,32			# 0x20
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,111			# 0x6f
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,110			# 0x6e
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,32			# 0x20
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,67			# 0x43
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,80			# 0x50
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,85			# 0x55
	sw	$2,0($3)
	lw	$3,16($fp)
	li	$2,35			# 0x23
	sw	$2,0($3)
	lw	$4,32($fp)
	jal	print_uint
	jal	print_newline
	lw	$4,36($fp)
	jal	print_uint
	jal	print_newline
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addu	$sp,$sp,32
	j	$31
	.end	print_end
	.align	2
	.globl	print_matrix
	.ent	print_matrix
print_matrix:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	jal	print_newline
	sw	$0,16($fp)
$L13:
	lw	$2,16($fp)
	slt	$2,$2,8
	bne	$2,$0,$L16
	j	$L14
$L16:
	sw	$0,20($fp)
$L17:
	lw	$2,20($fp)
	slt	$2,$2,8
	bne	$2,$0,$L20
	j	$L18
$L20:
	lw	$2,20($fp)
	sll	$3,$2,3
	lw	$2,16($fp)
	addu	$2,$3,$2
	sll	$3,$2,2
	lw	$2,40($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,24($fp)
	lw	$4,24($fp)
	jal	print_uint
	jal	print_space
	lw	$2,20($fp)
	addu	$2,$2,1
	sw	$2,20($fp)
	j	$L17
$L18:
	jal	print_newline
	lw	$2,16($fp)
	addu	$2,$2,1
	sw	$2,16($fp)
	j	$L13
$L14:
	jal	print_newline
	jal	print_newline
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addu	$sp,$sp,40
	j	$31
	.end	print_matrix
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,56,$31		# vars= 32, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$31,52($sp)
	sw	$fp,48($sp)
	move	$fp,$sp
	sw	$4,56($fp)
	li	$2,16640			# 0x4100
	sw	$2,16($fp)
	li	$2,16896			# 0x4200
	sw	$2,20($fp)
	li	$2,16384			# 0x4000
	sw	$2,44($fp)
	lw	$2,56($fp)
	bne	$2,$0,$L22
	sw	$0,24($fp)
$L23:
	lw	$2,24($fp)
	sltu	$2,$2,8
	bne	$2,$0,$L26
	j	$L22
$L26:
	sw	$0,28($fp)
$L27:
	lw	$2,28($fp)
	sltu	$2,$2,8
	bne	$2,$0,$L30
	j	$L25
$L30:
	lw	$2,28($fp)
	sll	$3,$2,3
	lw	$2,24($fp)
	addu	$2,$3,$2
	sll	$3,$2,2
	lw	$2,16($fp)
	addu	$4,$3,$2
	lw	$3,24($fp)
	lw	$2,28($fp)
	addu	$2,$3,$2
	sw	$2,0($4)
	lw	$2,28($fp)
	addu	$2,$2,1
	sw	$2,28($fp)
	j	$L27
$L25:
	lw	$2,24($fp)
	addu	$2,$2,1
	sw	$2,24($fp)
	j	$L23
$L22:
	lw	$2,56($fp)
	bne	$2,$0,$L31
	lw	$2,44($fp)
	addu	$3,$2,60
	li	$2,1			# 0x1
	sw	$2,0($3)
$L31:
	.set	noreorder
	nop
	.set	reorder
$L32:
	lw	$2,44($fp)
	addu	$2,$2,60
	lw	$2,0($2)
	beq	$2,$0,$L34
	j	$L33
$L34:
	sw	$0,24($fp)
$L35:
	lw	$2,24($fp)
	sltu	$2,$2,10
	bne	$2,$0,$L38
	j	$L32
$L38:
 #APP
	nop
 #NO_APP
	lw	$2,24($fp)
	addu	$2,$2,1
	sw	$2,24($fp)
	j	$L35
$L33:
	jal	get_time
	sw	$2,36($fp)
	lw	$2,56($fp)
	sll	$2,$2,3
	srl	$2,$2,1
	sw	$2,28($fp)
$L39:
	lw	$2,56($fp)
	sll	$2,$2,3
	addu	$2,$2,8
	srl	$3,$2,1
	lw	$2,28($fp)
	sltu	$2,$2,$3
	bne	$2,$0,$L42
	j	$L40
$L42:
	sw	$0,24($fp)
$L43:
	lw	$2,24($fp)
	sltu	$2,$2,8
	bne	$2,$0,$L46
	j	$L41
$L46:
	lw	$2,28($fp)
	sll	$3,$2,3
	lw	$2,24($fp)
	addu	$2,$3,$2
	sll	$3,$2,2
	lw	$2,20($fp)
	addu	$2,$3,$2
	sw	$0,0($2)
	sw	$0,32($fp)
$L47:
	lw	$2,32($fp)
	sltu	$2,$2,8
	bne	$2,$0,$L50
	j	$L45
$L50:
	lw	$2,28($fp)
	sll	$3,$2,3
	lw	$2,24($fp)
	addu	$2,$3,$2
	sll	$3,$2,2
	lw	$2,20($fp)
	addu	$5,$3,$2
	lw	$2,28($fp)
	sll	$3,$2,3
	lw	$2,24($fp)
	addu	$2,$3,$2
	sll	$3,$2,2
	lw	$2,20($fp)
	addu	$6,$3,$2
	lw	$2,32($fp)
	sll	$3,$2,3
	lw	$2,24($fp)
	addu	$2,$3,$2
	sll	$3,$2,2
	lw	$2,16($fp)
	addu	$4,$3,$2
	lw	$2,28($fp)
	sll	$3,$2,3
	lw	$2,32($fp)
	addu	$2,$3,$2
	sll	$3,$2,2
	lw	$2,16($fp)
	addu	$2,$3,$2
	lw	$3,0($4)
	lw	$2,0($2)
	mult	$3,$2
	mflo	$3
	lw	$2,0($6)
	addu	$2,$2,$3
	sw	$2,0($5)
	lw	$2,32($fp)
	addu	$2,$2,1
	sw	$2,32($fp)
	j	$L47
$L45:
	lw	$2,24($fp)
	addu	$2,$2,1
	sw	$2,24($fp)
	j	$L43
$L41:
	lw	$2,28($fp)
	addu	$2,$2,1
	sw	$2,28($fp)
	j	$L39
$L40:
	lw	$2,56($fp)
	sll	$3,$2,5
	lw	$2,44($fp)
	addu	$3,$3,$2
	li	$2,1			# 0x1
	sw	$2,0($3)
	jal	get_time
	sw	$2,40($fp)
	lw	$2,56($fp)
	bne	$2,$0,$L53
	lw	$4,56($fp)
	lw	$5,36($fp)
	jal	print_start
	lw	$4,56($fp)
	lw	$5,40($fp)
	jal	print_end
	lw	$2,56($fp)
	sll	$3,$2,5
	lw	$2,44($fp)
	addu	$3,$3,$2
	li	$2,2			# 0x2
	sw	$2,0($3)
	j	$L52
$L53:
	lw	$2,56($fp)
	sll	$3,$2,5
	lw	$2,44($fp)
	addu	$2,$3,$2
	addu	$2,$2,-32
	lw	$3,0($2)
	li	$2,2			# 0x2
	bne	$3,$2,$L55
	j	$L54
$L55:
	sw	$0,24($fp)
$L56:
	lw	$2,24($fp)
	sltu	$2,$2,10
	bne	$2,$0,$L59
	j	$L53
$L59:
 #APP
	nop
 #NO_APP
	lw	$2,24($fp)
	addu	$2,$2,1
	sw	$2,24($fp)
	j	$L56
$L54:
	lw	$4,56($fp)
	lw	$5,36($fp)
	jal	print_start
	lw	$4,56($fp)
	lw	$5,40($fp)
	jal	print_end
	lw	$2,56($fp)
	sll	$3,$2,5
	lw	$2,44($fp)
	addu	$3,$3,$2
	li	$2,2			# 0x2
	sw	$2,0($3)
$L52:
	lw	$2,56($fp)
	bne	$2,$0,$L60
$L61:
	lw	$2,44($fp)
	addu	$2,$2,32
	lw	$3,0($2)
	li	$2,2			# 0x2
	bne	$3,$2,$L63
	j	$L60
$L63:
	sw	$0,24($fp)
$L64:
	lw	$2,24($fp)
	sltu	$2,$2,10
	bne	$2,$0,$L67
	j	$L61
$L67:
 #APP
	nop
 #NO_APP
	lw	$2,24($fp)
	addu	$2,$2,1
	sw	$2,24($fp)
	j	$L64
$L60:
	move	$2,$0
	move	$sp,$fp
	lw	$31,52($sp)
	lw	$fp,48($sp)
	addu	$sp,$sp,56
	j	$31
	.end	main
