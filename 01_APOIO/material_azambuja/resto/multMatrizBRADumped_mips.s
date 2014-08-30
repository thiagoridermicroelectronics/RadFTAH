
multMatrizBRA_mips.exe:     file format elf32-bigmips

Disassembly of section .text:

00000000 <_start>:
   0:	3c1d0050 	lui	sp,0x50
   4:	23bdfc00 	addi	sp,sp,-1024
   8:	3c1c0001 	lui	gp,0x1
   c:	0c000040 	jal	100 <main>
  10:	279c86e0 	addiu	gp,gp,-31008
  14:	0c000198 	jal	660 <_exit>
  18:	00000000 	nop
	...

00000100 <main>:
 100:	27bdff60 	addiu	sp,sp,-160
 104:	afbf009c 	sw	ra,156(sp)
 108:	afbe0098 	sw	s8,152(sp)
 10c:	03a0f021 	move	s8,sp
 110:	27c20010 	addiu	v0,s8,16
 114:	3c030000 	lui	v1,0x0
 118:	246306a8 	addiu	v1,v1,1704
 11c:	00402021 	move	a0,v0
 120:	00602821 	move	a1,v1
 124:	0c0000d7 	jal	35c <memcpy>
 128:	24060024 	li	a2,36
 12c:	27c20038 	addiu	v0,s8,56
 130:	3c030000 	lui	v1,0x0
 134:	246306cc 	addiu	v1,v1,1740
 138:	00402021 	move	a0,v0
 13c:	00602821 	move	a1,v1
 140:	0c0000d7 	jal	35c <memcpy>
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
 17c:	14400007 	bnez	v0,19c <main+0x9c>
 180:	00000000 	nop
 184:	14400119 	bnez	v0,5ec <error>
 188:	00000000 	nop
 18c:	080000d2 	j	348 <main+0x248>
 190:	00000000 	nop
 194:	0800006b 	j	1ac <main+0xac>
 198:	00000000 	nop
 19c:	10400113 	beqz	v0,5ec <error>
 1a0:	00000000 	nop
 1a4:	0800006b 	j	1ac <main+0xac>
 1a8:	00000000 	nop
 1ac:	afc0008c 	sw	zero,140(s8)
 1b0:	8fc2008c 	lw	v0,140(s8)
 1b4:	00000000 	nop
 1b8:	28420003 	slti	v0,v0,3
 1bc:	14400007 	bnez	v0,1dc <main+0xdc>
 1c0:	00000000 	nop
 1c4:	14400109 	bnez	v0,5ec <error>
 1c8:	00000000 	nop
 1cc:	080000cd 	j	334 <main+0x234>
 1d0:	00000000 	nop
 1d4:	0800007b 	j	1ec <main+0xec>
 1d8:	00000000 	nop
 1dc:	10400103 	beqz	v0,5ec <error>
 1e0:	00000000 	nop
 1e4:	0800007b 	j	1ec <main+0xec>
 1e8:	00000000 	nop
 1ec:	afc00090 	sw	zero,144(s8)
 1f0:	8fc20090 	lw	v0,144(s8)
 1f4:	00000000 	nop
 1f8:	28420003 	slti	v0,v0,3
 1fc:	14400007 	bnez	v0,21c <main+0x11c>
 200:	00000000 	nop
 204:	144000f9 	bnez	v0,5ec <error>
 208:	00000000 	nop
 20c:	080000c8 	j	320 <main+0x220>
 210:	00000000 	nop
 214:	0800008b 	j	22c <main+0x12c>
 218:	00000000 	nop
 21c:	104000f3 	beqz	v0,5ec <error>
 220:	00000000 	nop
 224:	0800008b 	j	22c <main+0x12c>
 228:	00000000 	nop
 22c:	8fc30088 	lw	v1,136(s8)
 230:	00000000 	nop
 234:	00601021 	move	v0,v1
 238:	00021040 	sll	v0,v0,0x1
 23c:	00431021 	addu	v0,v0,v1
 240:	8fc3008c 	lw	v1,140(s8)
 244:	00000000 	nop
 248:	00431021 	addu	v0,v0,v1
 24c:	00021880 	sll	v1,v0,0x2
 250:	27c20010 	addiu	v0,s8,16
 254:	00621021 	addu	v0,v1,v0
 258:	24450050 	addiu	a1,v0,80
 25c:	8fc30088 	lw	v1,136(s8)
 260:	00000000 	nop
 264:	00601021 	move	v0,v1
 268:	00021040 	sll	v0,v0,0x1
 26c:	00431021 	addu	v0,v0,v1
 270:	8fc3008c 	lw	v1,140(s8)
 274:	00000000 	nop
 278:	00431021 	addu	v0,v0,v1
 27c:	00021880 	sll	v1,v0,0x2
 280:	27c20010 	addiu	v0,s8,16
 284:	00621021 	addu	v0,v1,v0
 288:	24460050 	addiu	a2,v0,80
 28c:	8fc30088 	lw	v1,136(s8)
 290:	00000000 	nop
 294:	00601021 	move	v0,v1
 298:	00021040 	sll	v0,v0,0x1
 29c:	00431021 	addu	v0,v0,v1
 2a0:	8fc30090 	lw	v1,144(s8)
 2a4:	00000000 	nop
 2a8:	00431021 	addu	v0,v0,v1
 2ac:	00021880 	sll	v1,v0,0x2
 2b0:	27c20010 	addiu	v0,s8,16
 2b4:	00622021 	addu	a0,v1,v0
 2b8:	8fc30090 	lw	v1,144(s8)
 2bc:	00000000 	nop
 2c0:	00601021 	move	v0,v1
 2c4:	00021040 	sll	v0,v0,0x1
 2c8:	00431021 	addu	v0,v0,v1
 2cc:	8fc3008c 	lw	v1,140(s8)
 2d0:	00000000 	nop
 2d4:	00431021 	addu	v0,v0,v1
 2d8:	00021880 	sll	v1,v0,0x2
 2dc:	27c20010 	addiu	v0,s8,16
 2e0:	00621021 	addu	v0,v1,v0
 2e4:	24420028 	addiu	v0,v0,40
 2e8:	8c830000 	lw	v1,0(a0)
 2ec:	8c420000 	lw	v0,0(v0)
 2f0:	00000000 	nop
 2f4:	00620018 	mult	v1,v0
 2f8:	00001812 	mflo	v1
 2fc:	8cc20000 	lw	v0,0(a2)
 300:	00000000 	nop
 304:	00431021 	addu	v0,v0,v1
 308:	aca20000 	sw	v0,0(a1)
 30c:	8fc20090 	lw	v0,144(s8)
 310:	00000000 	nop
 314:	24420001 	addiu	v0,v0,1
 318:	0800007c 	j	1f0 <main+0xf0>
 31c:	afc20090 	sw	v0,144(s8)
 320:	8fc2008c 	lw	v0,140(s8)
 324:	00000000 	nop
 328:	24420001 	addiu	v0,v0,1
 32c:	0800006c 	j	1b0 <main+0xb0>
 330:	afc2008c 	sw	v0,140(s8)
 334:	8fc20088 	lw	v0,136(s8)
 338:	00000000 	nop
 33c:	24420001 	addiu	v0,v0,1
 340:	0800005c 	j	170 <main+0x70>
 344:	afc20088 	sw	v0,136(s8)
 348:	03c0e821 	move	sp,s8
 34c:	8fbf009c 	lw	ra,156(sp)
 350:	8fbe0098 	lw	s8,152(sp)
 354:	03e00008 	jr	ra
 358:	27bd00a0 	addiu	sp,sp,160

0000035c <memcpy>:
 35c:	00a41025 	or	v0,a1,a0
 360:	30420003 	andi	v0,v0,0x3
 364:	14400060 	bnez	v0,4e8 <memcpy_0xa4_3>
 368:	00805021 	move	t2,a0
 36c:	1440009f 	bnez	v0,5ec <error>
 370:	00000000 	nop
 374:	00064102 	srl	t0,a2,0x4
 378:	00a04821 	move	t1,a1
 37c:	30c6000f 	andi	a2,a2,0xf
 380:	11000019 	beqz	t0,3e8 <memcpy_0x54_4>
 384:	00803821 	move	a3,a0
 388:	11000098 	beqz	t0,5ec <error>
 38c:	00000000 	nop
 390:	080000ea 	j	3a8 <memcpy_0x24>
 394:	00000000 	nop

00000398 <memcpy_0x24_5>:
 398:	11000094 	beqz	t0,5ec <error>
 39c:	00000000 	nop
 3a0:	080000ea 	j	3a8 <memcpy_0x24>
 3a4:	00000000 	nop

000003a8 <memcpy_0x24>:
 3a8:	8d220000 	lw	v0,0(t1)
 3ac:	8d230004 	lw	v1,4(t1)
 3b0:	8d240008 	lw	a0,8(t1)
 3b4:	8d25000c 	lw	a1,12(t1)
 3b8:	2508ffff 	addiu	t0,t0,-1
 3bc:	ace20000 	sw	v0,0(a3)
 3c0:	ace30004 	sw	v1,4(a3)
 3c4:	ace40008 	sw	a0,8(a3)
 3c8:	ace5000c 	sw	a1,12(a3)
 3cc:	25290010 	addiu	t1,t1,16
 3d0:	1500fff1 	bnez	t0,398 <memcpy_0x24_5>
 3d4:	24e70010 	addiu	a3,a3,16
 3d8:	15000084 	bnez	t0,5ec <error>
 3dc:	00000000 	nop
 3e0:	080000fe 	j	3f8 <memcpy_0x54>
 3e4:	00000000 	nop

000003e8 <memcpy_0x54_4>:
 3e8:	15000080 	bnez	t0,5ec <error>
 3ec:	00000000 	nop
 3f0:	080000fe 	j	3f8 <memcpy_0x54>
 3f4:	00000000 	nop

000003f8 <memcpy_0x54>:
 3f8:	00064082 	srl	t0,a2,0x2
 3fc:	11000013 	beqz	t0,44c <memcpy_0x78_6>
 400:	30c60003 	andi	a2,a2,0x3
 404:	11000079 	beqz	t0,5ec <error>
 408:	00000000 	nop
 40c:	08000109 	j	424 <memcpy_0x60>
 410:	00000000 	nop

00000414 <memcpy_0x60_7>:
 414:	11000075 	beqz	t0,5ec <error>
 418:	00000000 	nop
 41c:	08000109 	j	424 <memcpy_0x60>
 420:	00000000 	nop

00000424 <memcpy_0x60>:
 424:	8d220000 	lw	v0,0(t1)
 428:	2508ffff 	addiu	t0,t0,-1
 42c:	ace20000 	sw	v0,0(a3)
 430:	25290004 	addiu	t1,t1,4
 434:	1500fff7 	bnez	t0,414 <memcpy_0x60_7>
 438:	24e70004 	addiu	a3,a3,4
 43c:	1500006b 	bnez	t0,5ec <error>
 440:	00000000 	nop
 444:	08000117 	j	45c <memcpy_0x78>
 448:	00000000 	nop

0000044c <memcpy_0x78_6>:
 44c:	15000067 	bnez	t0,5ec <error>
 450:	00000000 	nop
 454:	08000117 	j	45c <memcpy_0x78>
 458:	00000000 	nop

0000045c <memcpy_0x78>:
 45c:	00e01821 	move	v1,a3
 460:	18c00013 	blez	a2,4b0 <memcpy_0x9c_8>
 464:	01202821 	move	a1,t1
 468:	18c00060 	blez	a2,5ec <error>
 46c:	00000000 	nop
 470:	08000122 	j	488 <memcpy_0x84>
 474:	00000000 	nop

00000478 <memcpy_0x84_9>:
 478:	18c0005c 	blez	a2,5ec <error>
 47c:	00000000 	nop
 480:	08000122 	j	488 <memcpy_0x84>
 484:	00000000 	nop

00000488 <memcpy_0x84>:
 488:	90a20000 	lbu	v0,0(a1)
 48c:	24c6ffff 	addiu	a2,a2,-1
 490:	a0620000 	sb	v0,0(v1)
 494:	24a50001 	addiu	a1,a1,1
 498:	1cc0fff7 	bgtz	a2,478 <memcpy_0x84_9>
 49c:	24630001 	addiu	v1,v1,1
 4a0:	1cc00052 	bgtz	a2,5ec <error>
 4a4:	00000000 	nop
 4a8:	08000136 	j	4d8 <memcpy_0x9c>
 4ac:	00000000 	nop

000004b0 <memcpy_0x9c_8>:
 4b0:	1cc0004e 	bgtz	a2,5ec <error>
 4b4:	00000000 	nop
 4b8:	08000136 	j	4d8 <memcpy_0x9c>
 4bc:	00000000 	nop
 4c0:	08000136 	j	4d8 <memcpy_0x9c>
 4c4:	00000000 	nop

000004c8 <memcpy_0x9c_13>:
 4c8:	1cc00048 	bgtz	a2,5ec <error>
 4cc:	00000000 	nop
 4d0:	08000136 	j	4d8 <memcpy_0x9c>
 4d4:	00000000 	nop

000004d8 <memcpy_0x9c>:
 4d8:	03e00008 	jr	ra
 4dc:	01401021 	move	v0,t2
 4e0:	0800013e 	j	4f8 <memcpy_0xa4>
 4e4:	00000000 	nop

000004e8 <memcpy_0xa4_3>:
 4e8:	10400040 	beqz	v0,5ec <error>
 4ec:	00000000 	nop
 4f0:	0800013e 	j	4f8 <memcpy_0xa4>
 4f4:	00000000 	nop

000004f8 <memcpy_0xa4>:
 4f8:	00801821 	move	v1,a0
 4fc:	04c00035 	bltz	a2,5d4 <memcpy_0x10c_10>
 500:	00c01021 	move	v0,a2
 504:	04c00039 	bltz	a2,5ec <error>
 508:	00000000 	nop

0000050c <memcpy_0xb0>:
 50c:	00024083 	sra	t0,v0,0x2
 510:	00081080 	sll	v0,t0,0x2
 514:	11000015 	beqz	t0,56c <memcpy_0xe4_11>
 518:	00c23023 	subu	a2,a2,v0
 51c:	11000033 	beqz	t0,5ec <error>
 520:	00000000 	nop
 524:	0800014f 	j	53c <memcpy_0xc0>
 528:	00000000 	nop

0000052c <memcpy_0xc0_12>:
 52c:	1100002f 	beqz	t0,5ec <error>
 530:	00000000 	nop
 534:	0800014f 	j	53c <memcpy_0xc0>
 538:	00000000 	nop

0000053c <memcpy_0xc0>:
 53c:	2508ffff 	addiu	t0,t0,-1
 540:	88a20000 	lwl	v0,0(a1)
 544:	98a20003 	lwr	v0,3(a1)
 548:	24a50004 	addiu	a1,a1,4
 54c:	a8620000 	swl	v0,0(v1)
 550:	b8620003 	swr	v0,3(v1)
 554:	1500fff5 	bnez	t0,52c <memcpy_0xc0_12>
 558:	24630004 	addiu	v1,v1,4
 55c:	15000023 	bnez	t0,5ec <error>
 560:	00000000 	nop
 564:	0800015f 	j	57c <memcpy_0xe4>
 568:	00000000 	nop

0000056c <memcpy_0xe4_11>:
 56c:	1500001f 	bnez	t0,5ec <error>
 570:	00000000 	nop
 574:	0800015f 	j	57c <memcpy_0xe4>
 578:	00000000 	nop

0000057c <memcpy_0xe4>:
 57c:	18c0ffd2 	blez	a2,4c8 <memcpy_0x9c_13>
 580:	00000000 	nop
 584:	18c00019 	blez	a2,5ec <error>
 588:	00000000 	nop
 58c:	08000169 	j	5a4 <memcpy_0xec>
 590:	00000000 	nop

00000594 <memcpy_0xec_14>:
 594:	18c00015 	blez	a2,5ec <error>
 598:	00000000 	nop
 59c:	08000169 	j	5a4 <memcpy_0xec>
 5a0:	00000000 	nop

000005a4 <memcpy_0xec>:
 5a4:	90a20000 	lbu	v0,0(a1)
 5a8:	24c6ffff 	addiu	a2,a2,-1
 5ac:	a0620000 	sb	v0,0(v1)
 5b0:	24a50001 	addiu	a1,a1,1
 5b4:	1cc0fff7 	bgtz	a2,594 <memcpy_0xec_14>
 5b8:	24630001 	addiu	v1,v1,1
 5bc:	1cc0000b 	bgtz	a2,5ec <error>
 5c0:	00000000 	nop
 5c4:	08000136 	j	4d8 <memcpy_0x9c>
 5c8:	00000000 	nop
 5cc:	08000179 	j	5e4 <memcpy_0x10c>
 5d0:	00000000 	nop

000005d4 <memcpy_0x10c_10>:
 5d4:	04c10005 	bgez	a2,5ec <error>
 5d8:	00000000 	nop
 5dc:	08000179 	j	5e4 <memcpy_0x10c>
 5e0:	00000000 	nop

000005e4 <memcpy_0x10c>:
 5e4:	08000143 	j	50c <memcpy_0xb0>
 5e8:	24c20003 	addiu	v0,a2,3

000005ec <error>:
 5ec:	0800017b 	j	5ec <error>
 5f0:	240b0001 	li	t3,1

000005f4 <open>:
 5f4:	24030040 	li	v1,64
 5f8:	00600008 	jr	v1
 5fc:	00000000 	nop

00000600 <creat>:
 600:	24030044 	li	v1,68
 604:	00600008 	jr	v1
 608:	00000000 	nop

0000060c <close>:
 60c:	24030048 	li	v1,72
 610:	00600008 	jr	v1
 614:	00000000 	nop

00000618 <read>:
 618:	2403004c 	li	v1,76
 61c:	00600008 	jr	v1
 620:	00000000 	nop

00000624 <write>:
 624:	24030050 	li	v1,80
 628:	00600008 	jr	v1
 62c:	00000000 	nop

00000630 <isatty>:
 630:	24030054 	li	v1,84
 634:	00600008 	jr	v1
 638:	00000000 	nop

0000063c <sbrk>:
 63c:	24030058 	li	v1,88
 640:	00600008 	jr	v1
 644:	00000000 	nop

00000648 <lseek>:
 648:	2403005c 	li	v1,92
 64c:	00600008 	jr	v1
 650:	00000000 	nop

00000654 <fstat>:
 654:	24030060 	li	v1,96
 658:	00600008 	jr	v1
 65c:	00000000 	nop

00000660 <_exit>:
 660:	24030064 	li	v1,100
 664:	00600008 	jr	v1
 668:	00000000 	nop

0000066c <times>:
 66c:	24030068 	li	v1,104
 670:	00600008 	jr	v1
 674:	00000000 	nop

00000678 <time>:
 678:	2403006c 	li	v1,108
 67c:	00600008 	jr	v1
 680:	00000000 	nop

00000684 <random>:
 684:	24030070 	li	v1,112
 688:	00600008 	jr	v1
 68c:	00000000 	nop
Disassembly of section .rodata:

000006a8 <.rodata>:
 6a8:	0000000b 	0xb
 6ac:	0000000c 	syscall
 6b0:	0000000d 	break
 6b4:	00000015 	0x15
 6b8:	00000016 	0x16
 6bc:	00000017 	0x17
 6c0:	0000001f 	0x1f
 6c4:	00000020 	add	zero,zero,zero
 6c8:	00000021 	move	zero,zero
 6cc:	0000001c 	0x1c
 6d0:	0000001b 	divu	zero,zero,zero
 6d4:	0000001a 	div	zero,zero,zero
 6d8:	00000012 	mflo	zero
 6dc:	00000011 	mthi	zero
 6e0:	00000010 	mfhi	zero
 6e4:	00000008 	jr	zero
 6e8:	00000007 	srav	zero,zero,zero
 6ec:	00000006 	srlv	zero,zero,zero
Disassembly of section .data:
