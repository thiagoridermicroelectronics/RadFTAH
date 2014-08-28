
multMatrizJ_mips.exe:     file format elf32-bigmips

Disassembly of section .text:

00000000 <_start>:
   0:	3c1d0050 	lui	sp,0x50
   4:	23bdfc00 	addi	sp,sp,-1024

00000100 <main>:
 100:	27bdff60 	addiu	sp,sp,-160
 104:	afbf009c 	sw	ra,156(sp)
 108:	afbe0098 	sw	s8,152(sp)
 10c:	03a0f021 	move	s8,sp
 110:	27c20010 	addiu	v0,s8,16
 114:	3c030000 	lui	v1,0x0
 118:	246304d4 	addiu	v1,v1,1236
 11c:	00402021 	move	a0,v0
 120:	00602821 	move	a1,v1
 124:	0c0000c3 	jal	30c <memcpy>
 128:	24060024 	li	a2,36
 12c:	27c20038 	addiu	v0,s8,56
 130:	3c030000 	lui	v1,0x0
 134:	246304f8 	addiu	v1,v1,1272
 138:	00402021 	move	a0,v0
 13c:	00602821 	move	a1,v1
 140:	0c0000c3 	jal	30c <memcpy>
 144:	24060024 	li	a2,36
 148:	afc00060 	sw	zero,96(s8)
 14c:	afc00064 	sw	zero,100(s8)
 150:	afc00068 	sw	zero,104(s8)
 154:	afc0006c 	sw	zero,108(s8)
 158:	afc00070 	sw	zero,112(s8)
 15c:	afc00074 	sw	zero,116(s8)
 160:	afc00078 	sw	zero,120(s8)
 164:	afc0007c 	sw	zero,124(s8)
 168:	afc00080 	sw	zero,128(s8)
 16c:	afc00088 	sw	zero,136(s8)
 170:	8fc20088 	lw	v0,136(s8)
 174:	00000000 	nop
 178:	28420003 	slti	v0,v0,3
 17c:	14400003 	bnez	v0,18c <main+0x8c>
 180:	00000000 	nop
 184:	080000ba 	j	2e8 <main+0x1e8>
 188:	00000000 	nop
 18c:	afc0008c 	sw	zero,140(s8)
 190:	8fc2008c 	lw	v0,140(s8)
 194:	00000000 	nop
 198:	28420003 	slti	v0,v0,3
 19c:	14400003 	bnez	v0,1ac <main+0xac>
 1a0:	00000000 	nop
 1a4:	080000b5 	j	2d4 <main+0x1d4>
 1a8:	00000000 	nop
 1ac:	afc00090 	sw	zero,144(s8)
 1b0:	8fc20090 	lw	v0,144(s8)
 1b4:	00000000 	nop
 1b8:	28420003 	slti	v0,v0,3
 1bc:	14400003 	bnez	v0,1cc <main+0xcc>
 1c0:	00000000 	nop
 1c4:	080000b0 	j	2c0 <main+0x1c0>
 1c8:	00000000 	nop
 1cc:	8fc30088 	lw	v1,136(s8)
 1d0:	00000000 	nop
 1d4:	00601021 	move	v0,v1
 1d8:	00021040 	sll	v0,v0,0x1
 1dc:	00431021 	addu	v0,v0,v1
 1e0:	8fc3008c 	lw	v1,140(s8)
 1e4:	00000000 	nop
 1e8:	00431021 	addu	v0,v0,v1
 1ec:	00021880 	sll	v1,v0,0x2
 1f0:	27c20010 	addiu	v0,s8,16
 1f4:	00621021 	addu	v0,v1,v0
 1f8:	24450050 	addiu	a1,v0,80
 1fc:	8fc30088 	lw	v1,136(s8)
 200:	00000000 	nop
 204:	00601021 	move	v0,v1
 208:	00021040 	sll	v0,v0,0x1
 20c:	00431021 	addu	v0,v0,v1
 210:	8fc3008c 	lw	v1,140(s8)
 214:	00000000 	nop
 218:	00431021 	addu	v0,v0,v1
 21c:	00021880 	sll	v1,v0,0x2
 220:	27c20010 	addiu	v0,s8,16
 224:	00621021 	addu	v0,v1,v0
 228:	24460050 	addiu	a2,v0,80
 22c:	8fc30088 	lw	v1,136(s8)
 230:	00000000 	nop
 234:	00601021 	move	v0,v1
 238:	00021040 	sll	v0,v0,0x1
 23c:	00431021 	addu	v0,v0,v1
 240:	8fc30090 	lw	v1,144(s8)
 244:	00000000 	nop
 248:	00431021 	addu	v0,v0,v1
 24c:	00021880 	sll	v1,v0,0x2
 250:	27c20010 	addiu	v0,s8,16
 254:	00622021 	addu	a0,v1,v0
 258:	8fc30090 	lw	v1,144(s8)
 25c:	00000000 	nop
 260:	00601021 	move	v0,v1
 264:	00021040 	sll	v0,v0,0x1
 268:	00431021 	addu	v0,v0,v1
 26c:	8fc3008c 	lw	v1,140(s8)
 270:	00000000 	nop
 274:	00431021 	addu	v0,v0,v1
 278:	00021880 	sll	v1,v0,0x2
 27c:	27c20010 	addiu	v0,s8,16
 280:	00621021 	addu	v0,v1,v0
 284:	24420028 	addiu	v0,v0,40
 288:	8c830000 	lw	v1,0(a0)
 28c:	8c420000 	lw	v0,0(v0)
 290:	00000000 	nop
 294:	00620018 	mult	v1,v0
 298:	00001812 	mflo	v1
 29c:	8cc20000 	lw	v0,0(a2)
 2a0:	00000000 	nop
 2a4:	00431021 	addu	v0,v0,v1
 2a8:	aca20000 	sw	v0,0(a1)
 2ac:	8fc20090 	lw	v0,144(s8)
 2b0:	00000000 	nop
 2b4:	24420001 	addiu	v0,v0,1
 2b8:	0800006c 	j	1b0 <main+0xb0>
 2bc:	afc20090 	sw	v0,144(s8)
 2c0:	8fc2008c 	lw	v0,140(s8)
 2c4:	00000000 	nop
 2c8:	24420001 	addiu	v0,v0,1
 2cc:	08000064 	j	190 <main+0x90>
 2d0:	afc2008c 	sw	v0,140(s8)
 2d4:	8fc20088 	lw	v0,136(s8)
 2d8:	00000000 	nop
 2dc:	24420001 	addiu	v0,v0,1
 2e0:	0800005c 	j	170 <main+0x70>
 2e4:	afc20088 	sw	v0,136(s8)
 2e8:	03c0e821 	move	sp,s8
 2ec:	8fbf009c 	lw	ra,156(sp)
 2f0:	8fbe0098 	lw	s8,152(sp)
 2f4:	00000000 	j	304 <loop>
 2f8:	00000000 	addiu	sp,sp,160
 2fc:	NOSSOLOOP 	LOOP NOSSO
 300:	00000000 	nop

0000030c <memcpy>:
 30c:	00a41025 	or	v0,a1,a0
 310:	30420003 	andi	v0,v0,0x3
 314:	14400026 	bnez	v0,3b0 <memcpy+0xa4>
 318:	00805021 	move	t2,a0
 31c:	00064102 	srl	t0,a2,0x4
 320:	00a04821 	move	t1,a1
 324:	30c6000f 	andi	a2,a2,0xf
 328:	1100000d 	beqz	t0,360 <memcpy+0x54>
 32c:	00803821 	move	a3,a0
 330:	8d220000 	lw	v0,0(t1)
 334:	8d230004 	lw	v1,4(t1)
 338:	8d240008 	lw	a0,8(t1)
 33c:	8d25000c 	lw	a1,12(t1)
 340:	2508ffff 	addiu	t0,t0,-1
 344:	ace20000 	sw	v0,0(a3)
 348:	ace30004 	sw	v1,4(a3)
 34c:	ace40008 	sw	a0,8(a3)
 350:	ace5000c 	sw	a1,12(a3)
 354:	25290010 	addiu	t1,t1,16
 358:	1500fff5 	bnez	t0,330 <memcpy+0x24>
 35c:	24e70010 	addiu	a3,a3,16
 360:	00064082 	srl	t0,a2,0x2
 364:	11000007 	beqz	t0,384 <memcpy+0x78>
 368:	30c60003 	andi	a2,a2,0x3
 36c:	8d220000 	lw	v0,0(t1)
 370:	2508ffff 	addiu	t0,t0,-1
 374:	ace20000 	sw	v0,0(a3)
 378:	25290004 	addiu	t1,t1,4
 37c:	1500fffb 	bnez	t0,36c <memcpy+0x60>
 380:	24e70004 	addiu	a3,a3,4
 384:	00e01821 	move	v1,a3
 388:	18c00007 	blez	a2,3a8 <memcpy+0x9c>
 38c:	01202821 	move	a1,t1
 390:	90a20000 	lbu	v0,0(a1)
 394:	24c6ffff 	addiu	a2,a2,-1
 398:	a0620000 	sb	v0,0(v1)
 39c:	24a50001 	addiu	a1,a1,1
 3a0:	1cc0fffb 	bgtz	a2,390 <memcpy+0x84>
 3a4:	24630001 	addiu	v1,v1,1
 3a8:	03e00008 	jr	ra
 3ac:	01401021 	move	v0,t2
 3b0:	00801821 	move	v1,a0
 3b4:	04c00018 	bltz	a2,418 <memcpy+0x10c>
 3b8:	00c01021 	move	v0,a2
 3bc:	00024083 	sra	t0,v0,0x2
 3c0:	00081080 	sll	v0,t0,0x2
 3c4:	1100000a 	beqz	t0,3f0 <memcpy+0xe4>
 3c8:	00c23023 	subu	a2,a2,v0
 3cc:	2508ffff 	addiu	t0,t0,-1
 3d0:	88a20000 	lwl	v0,0(a1)
 3d4:	98a20003 	lwr	v0,3(a1)
 3d8:	00000000 	nop
 3dc:	24a50004 	addiu	a1,a1,4
 3e0:	a8620000 	swl	v0,0(v1)
 3e4:	b8620003 	swr	v0,3(v1)
 3e8:	1500fff8 	bnez	t0,3cc <memcpy+0xc0>
 3ec:	24630004 	addiu	v1,v1,4
 3f0:	18c0ffed 	blez	a2,3a8 <memcpy+0x9c>
 3f4:	00000000 	nop
 3f8:	90a20000 	lbu	v0,0(a1)
 3fc:	24c6ffff 	addiu	a2,a2,-1
 400:	a0620000 	sb	v0,0(v1)
 404:	24a50001 	addiu	a1,a1,1
 408:	1cc0fffb 	bgtz	a2,3f8 <memcpy+0xec>
 40c:	24630001 	addiu	v1,v1,1
 410:	080000ea 	j	3a8 <memcpy+0x9c>
 414:	00000000 	nop
 418:	080000ef 	j	3bc <memcpy+0xb0>
 41c:	24c20003 	addiu	v0,a2,3

000004d4 <.rodata>:
 4d4:	0000000b 	0xb
 4d8:	0000000c 	syscall
 4dc:	0000000d 	break
 4e0:	00000015 	0x15
 4e4:	00000016 	0x16
 4e8:	00000017 	0x17
 4ec:	0000001f 	0x1f
 4f0:	00000020 	add	zero,zero,zero
 4f4:	00000021 	move	zero,zero
 4f8:	0000001c 	0x1c
 4fc:	0000001b 	divu	zero,zero,zero
 500:	0000001a 	div	zero,zero,zero
 504:	00000012 	mflo	zero
 508:	00000011 	mthi	zero
 50c:	00000010 	mfhi	zero
 510:	00000008 	jr	zero
 514:	00000007 	srav	zero,zero,zero
 518:	00000006 	srlv	zero,zero,zero
Disassembly of section .data:
