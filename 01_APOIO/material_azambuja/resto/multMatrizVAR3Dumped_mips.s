
multMatrizVAR3_mips.exe:     file format elf32-bigmips

Disassembly of section .text:

00000000 <_start>:
   0:	3c1d0050 	lui	sp,0x50
   4:	23bdfc00 	addi	sp,sp,-1024
   8:	3c1c0001 	lui	gp,0x1
   c:	0c000040 	jal	100 <main>
  10:	279c89c0 	addiu	gp,gp,-30272
  14:	0c00024d 	jal	934 <_exit>
  18:	00000000 	nop
	...

00000100 <main>:
 100:	03a0a821 	move	s5,sp
 104:	03e0b821 	move	s7,ra
 108:	27bdff60 	addiu	sp,sp,-160
 10c:	17f701ec 	bne	ra,s7,8c0 <error>
 110:	26b5ff60 	addiu	s5,s5,-160
 114:	17b501ea 	bne	sp,s5,8c0 <error>
 118:	00000000 	nop
 11c:	afbf009c 	sw	ra,156(sp)
 120:	17ce01e7 	bne	s8,t6,8c0 <error>
 124:	aeb7009c 	sw	s7,156(s5)
 128:	17b501e5 	bne	sp,s5,8c0 <error>
 12c:	00000000 	nop
 130:	afbe0098 	sw	s8,152(sp)
 134:	aeae0098 	sw	t6,152(s5)
 138:	03a0f021 	move	s8,sp
 13c:	02a07021 	move	t6,s5
 140:	27c20010 	addiu	v0,s8,16
 144:	25cc0010 	addiu	t4,t6,16
 148:	3c030000 	lui	v1,0x0
 14c:	2463097c 	addiu	v1,v1,2428
 150:	3c0d0000 	lui	t5,0x0
 154:	25ad097c 	addiu	t5,t5,2428
 158:	00402021 	move	a0,v0
 15c:	0180b021 	move	s6,t4
 160:	00602821 	move	a1,v1
 164:	01a08021 	move	s0,t5
 168:	24060024 	li	a2,36
 16c:	0c000174 	jal	5d0 <memcpy>
 170:	240f0024 	li	t7,36
 174:	03e0b821 	move	s7,ra
 178:	27c20038 	addiu	v0,s8,56
 17c:	25cc0038 	addiu	t4,t6,56
 180:	3c030000 	lui	v1,0x0
 184:	246309a0 	addiu	v1,v1,2464
 188:	3c0d0000 	lui	t5,0x0
 18c:	25ad09a0 	addiu	t5,t5,2464
 190:	00402021 	move	a0,v0
 194:	0180b021 	move	s6,t4
 198:	00602821 	move	a1,v1
 19c:	01a08021 	move	s0,t5
 1a0:	24060024 	li	a2,36
 1a4:	0c000174 	jal	5d0 <memcpy>
 1a8:	240f0024 	li	t7,36
 1ac:	141201c4 	bne	zero,s2,8c0 <error>
 1b0:	03e0b821 	move	s7,ra
 1b4:	17ce01c2 	bne	s8,t6,8c0 <error>
 1b8:	00000000 	nop
 1bc:	afc00060 	sw	zero,96(s8)
 1c0:	141201bf 	bne	zero,s2,8c0 <error>
 1c4:	add20060 	sw	s2,96(t6)
 1c8:	17ce01bd 	bne	s8,t6,8c0 <error>
 1cc:	00000000 	nop
 1d0:	afc00064 	sw	zero,100(s8)
 1d4:	141201ba 	bne	zero,s2,8c0 <error>
 1d8:	add20064 	sw	s2,100(t6)
 1dc:	17ce01b8 	bne	s8,t6,8c0 <error>
 1e0:	00000000 	nop
 1e4:	afc00068 	sw	zero,104(s8)
 1e8:	141201b5 	bne	zero,s2,8c0 <error>
 1ec:	add20068 	sw	s2,104(t6)
 1f0:	17ce01b3 	bne	s8,t6,8c0 <error>
 1f4:	00000000 	nop
 1f8:	afc0006c 	sw	zero,108(s8)
 1fc:	141201b0 	bne	zero,s2,8c0 <error>
 200:	add2006c 	sw	s2,108(t6)
 204:	17ce01ae 	bne	s8,t6,8c0 <error>
 208:	00000000 	nop
 20c:	afc00070 	sw	zero,112(s8)
 210:	141201ab 	bne	zero,s2,8c0 <error>
 214:	add20070 	sw	s2,112(t6)
 218:	17ce01a9 	bne	s8,t6,8c0 <error>
 21c:	00000000 	nop
 220:	afc00074 	sw	zero,116(s8)
 224:	141201a6 	bne	zero,s2,8c0 <error>
 228:	add20074 	sw	s2,116(t6)
 22c:	17ce01a4 	bne	s8,t6,8c0 <error>
 230:	00000000 	nop
 234:	afc00078 	sw	zero,120(s8)
 238:	141201a1 	bne	zero,s2,8c0 <error>
 23c:	add20078 	sw	s2,120(t6)
 240:	17ce019f 	bne	s8,t6,8c0 <error>
 244:	00000000 	nop
 248:	afc0007c 	sw	zero,124(s8)
 24c:	1412019c 	bne	zero,s2,8c0 <error>
 250:	add2007c 	sw	s2,124(t6)
 254:	17ce019a 	bne	s8,t6,8c0 <error>
 258:	00000000 	nop
 25c:	afc00080 	sw	zero,128(s8)
 260:	14120197 	bne	zero,s2,8c0 <error>
 264:	add20080 	sw	s2,128(t6)
 268:	17ce0195 	bne	s8,t6,8c0 <error>
 26c:	00000000 	nop
 270:	afc00088 	sw	zero,136(s8)
 274:	add20088 	sw	s2,136(t6)
 278:	17ce0191 	bne	s8,t6,8c0 <error>
 27c:	00000000 	nop
 280:	8fc20088 	lw	v0,136(s8)
 284:	8dcc0088 	lw	t4,136(t6)
 288:	28420003 	slti	v0,v0,3
 28c:	298c0003 	slti	t4,t4,3
 290:	144c018b 	bne	v0,t4,8c0 <error>
 294:	00000000 	nop
 298:	14120189 	bne	zero,s2,8c0 <error>
 29c:	00000000 	nop
 2a0:	14400003 	bnez	v0,2b0 <main+0x1b0>
 2a4:	00000000 	nop
 2a8:	08000167 	j	59c <main+0x49c>
 2ac:	00000000 	nop
 2b0:	14120183 	bne	zero,s2,8c0 <error>
 2b4:	00000000 	nop
 2b8:	17ce0181 	bne	s8,t6,8c0 <error>
 2bc:	00000000 	nop
 2c0:	afc0008c 	sw	zero,140(s8)
 2c4:	add2008c 	sw	s2,140(t6)
 2c8:	17ce017d 	bne	s8,t6,8c0 <error>
 2cc:	00000000 	nop
 2d0:	8fc2008c 	lw	v0,140(s8)
 2d4:	8dcc008c 	lw	t4,140(t6)
 2d8:	28420003 	slti	v0,v0,3
 2dc:	298c0003 	slti	t4,t4,3
 2e0:	144c0177 	bne	v0,t4,8c0 <error>
 2e4:	00000000 	nop
 2e8:	14120175 	bne	zero,s2,8c0 <error>
 2ec:	00000000 	nop
 2f0:	14400003 	bnez	v0,300 <main+0x200>
 2f4:	00000000 	nop
 2f8:	0800015a 	j	568 <main+0x468>
 2fc:	00000000 	nop
 300:	1412016f 	bne	zero,s2,8c0 <error>
 304:	00000000 	nop
 308:	17ce016d 	bne	s8,t6,8c0 <error>
 30c:	00000000 	nop
 310:	afc00090 	sw	zero,144(s8)
 314:	add20090 	sw	s2,144(t6)
 318:	17ce0169 	bne	s8,t6,8c0 <error>
 31c:	00000000 	nop
 320:	8fc20090 	lw	v0,144(s8)
 324:	8dcc0090 	lw	t4,144(t6)
 328:	28420003 	slti	v0,v0,3
 32c:	298c0003 	slti	t4,t4,3
 330:	144c0163 	bne	v0,t4,8c0 <error>
 334:	00000000 	nop
 338:	14120161 	bne	zero,s2,8c0 <error>
 33c:	00000000 	nop
 340:	14400003 	bnez	v0,350 <main+0x250>
 344:	00000000 	nop
 348:	0800014d 	j	534 <main+0x434>
 34c:	00000000 	nop
 350:	17ce015b 	bne	s8,t6,8c0 <error>
 354:	00000000 	nop
 358:	8fc30088 	lw	v1,136(s8)
 35c:	8dcd0088 	lw	t5,136(t6)
 360:	00601021 	move	v0,v1
 364:	01a06021 	move	t4,t5
 368:	00021040 	sll	v0,v0,0x1
 36c:	000c6040 	sll	t4,t4,0x1
 370:	00431021 	addu	v0,v0,v1
 374:	17ce0152 	bne	s8,t6,8c0 <error>
 378:	018d6021 	addu	t4,t4,t5
 37c:	8fc3008c 	lw	v1,140(s8)
 380:	8dcd008c 	lw	t5,140(t6)
 384:	00431021 	addu	v0,v0,v1
 388:	018d6021 	addu	t4,t4,t5
 38c:	00021880 	sll	v1,v0,0x2
 390:	000c6880 	sll	t5,t4,0x2
 394:	27c20010 	addiu	v0,s8,16
 398:	25cc0010 	addiu	t4,t6,16
 39c:	00621021 	addu	v0,v1,v0
 3a0:	01ac6021 	addu	t4,t5,t4
 3a4:	24450050 	addiu	a1,v0,80
 3a8:	17ce0145 	bne	s8,t6,8c0 <error>
 3ac:	25900050 	addiu	s0,t4,80
 3b0:	8fc30088 	lw	v1,136(s8)
 3b4:	8dcd0088 	lw	t5,136(t6)
 3b8:	00601021 	move	v0,v1
 3bc:	01a06021 	move	t4,t5
 3c0:	00021040 	sll	v0,v0,0x1
 3c4:	000c6040 	sll	t4,t4,0x1
 3c8:	00431021 	addu	v0,v0,v1
 3cc:	17ce013c 	bne	s8,t6,8c0 <error>
 3d0:	018d6021 	addu	t4,t4,t5
 3d4:	8fc3008c 	lw	v1,140(s8)
 3d8:	8dcd008c 	lw	t5,140(t6)
 3dc:	00431021 	addu	v0,v0,v1
 3e0:	018d6021 	addu	t4,t4,t5
 3e4:	00021880 	sll	v1,v0,0x2
 3e8:	000c6880 	sll	t5,t4,0x2
 3ec:	27c20010 	addiu	v0,s8,16
 3f0:	25cc0010 	addiu	t4,t6,16
 3f4:	00621021 	addu	v0,v1,v0
 3f8:	01ac6021 	addu	t4,t5,t4
 3fc:	24460050 	addiu	a2,v0,80
 400:	17ce012f 	bne	s8,t6,8c0 <error>
 404:	258f0050 	addiu	t7,t4,80
 408:	8fc30088 	lw	v1,136(s8)
 40c:	8dcd0088 	lw	t5,136(t6)
 410:	00601021 	move	v0,v1
 414:	01a06021 	move	t4,t5
 418:	00021040 	sll	v0,v0,0x1
 41c:	000c6040 	sll	t4,t4,0x1
 420:	00431021 	addu	v0,v0,v1
 424:	17ce0126 	bne	s8,t6,8c0 <error>
 428:	018d6021 	addu	t4,t4,t5
 42c:	8fc30090 	lw	v1,144(s8)
 430:	8dcd0090 	lw	t5,144(t6)
 434:	00431021 	addu	v0,v0,v1
 438:	018d6021 	addu	t4,t4,t5
 43c:	00021880 	sll	v1,v0,0x2
 440:	000c6880 	sll	t5,t4,0x2
 444:	27c20010 	addiu	v0,s8,16
 448:	25cc0010 	addiu	t4,t6,16
 44c:	00622021 	addu	a0,v1,v0
 450:	17ce011b 	bne	s8,t6,8c0 <error>
 454:	01acb021 	addu	s6,t5,t4
 458:	8fc30090 	lw	v1,144(s8)
 45c:	8dcd0090 	lw	t5,144(t6)
 460:	00601021 	move	v0,v1
 464:	01a06021 	move	t4,t5
 468:	00021040 	sll	v0,v0,0x1
 46c:	000c6040 	sll	t4,t4,0x1
 470:	00431021 	addu	v0,v0,v1
 474:	17ce0112 	bne	s8,t6,8c0 <error>
 478:	018d6021 	addu	t4,t4,t5
 47c:	8fc3008c 	lw	v1,140(s8)
 480:	8dcd008c 	lw	t5,140(t6)
 484:	00431021 	addu	v0,v0,v1
 488:	018d6021 	addu	t4,t4,t5
 48c:	00021880 	sll	v1,v0,0x2
 490:	000c6880 	sll	t5,t4,0x2
 494:	27c20010 	addiu	v0,s8,16
 498:	25cc0010 	addiu	t4,t6,16
 49c:	00621021 	addu	v0,v1,v0
 4a0:	01ac6021 	addu	t4,t5,t4
 4a4:	24420028 	addiu	v0,v0,40
 4a8:	14960105 	bne	a0,s6,8c0 <error>
 4ac:	258c0028 	addiu	t4,t4,40
 4b0:	8c830000 	lw	v1,0(a0)
 4b4:	8ecd0000 	lw	t5,0(s6)
 4b8:	144c0101 	bne	v0,t4,8c0 <error>
 4bc:	00000000 	nop
 4c0:	8c420000 	lw	v0,0(v0)
 4c4:	8d8c0000 	lw	t4,0(t4)
 4c8:	00620018 	mult	v1,v0
 4cc:	00001812 	mflo	v1
 4d0:	00006812 	mflo	t5
 4d4:	14cf00fa 	bne	a2,t7,8c0 <error>
 4d8:	00000000 	nop
 4dc:	8cc20000 	lw	v0,0(a2)
 4e0:	8dec0000 	lw	t4,0(t7)
 4e4:	00431021 	addu	v0,v0,v1
 4e8:	018d6021 	addu	t4,t4,t5
 4ec:	144c00f4 	bne	v0,t4,8c0 <error>
 4f0:	00000000 	nop
 4f4:	14b000f2 	bne	a1,s0,8c0 <error>
 4f8:	00000000 	nop
 4fc:	aca20000 	sw	v0,0(a1)
 500:	17ce00ef 	bne	s8,t6,8c0 <error>
 504:	ae0c0000 	sw	t4,0(s0)
 508:	8fc20090 	lw	v0,144(s8)
 50c:	8dcc0090 	lw	t4,144(t6)
 510:	24420001 	addiu	v0,v0,1
 514:	258c0001 	addiu	t4,t4,1
 518:	144c00e9 	bne	v0,t4,8c0 <error>
 51c:	00000000 	nop
 520:	17ce00e7 	bne	s8,t6,8c0 <error>
 524:	00000000 	nop
 528:	afc20090 	sw	v0,144(s8)
 52c:	080000c6 	j	318 <main+0x218>
 530:	adcc0090 	sw	t4,144(t6)
 534:	17ce00e2 	bne	s8,t6,8c0 <error>
 538:	00000000 	nop
 53c:	8fc2008c 	lw	v0,140(s8)
 540:	8dcc008c 	lw	t4,140(t6)
 544:	24420001 	addiu	v0,v0,1
 548:	258c0001 	addiu	t4,t4,1
 54c:	144c00dc 	bne	v0,t4,8c0 <error>
 550:	00000000 	nop
 554:	17ce00da 	bne	s8,t6,8c0 <error>
 558:	00000000 	nop
 55c:	afc2008c 	sw	v0,140(s8)
 560:	080000b2 	j	2c8 <main+0x1c8>
 564:	adcc008c 	sw	t4,140(t6)
 568:	17ce00d5 	bne	s8,t6,8c0 <error>
 56c:	00000000 	nop
 570:	8fc20088 	lw	v0,136(s8)
 574:	8dcc0088 	lw	t4,136(t6)
 578:	24420001 	addiu	v0,v0,1
 57c:	258c0001 	addiu	t4,t4,1
 580:	144c00cf 	bne	v0,t4,8c0 <error>
 584:	00000000 	nop
 588:	17ce00cd 	bne	s8,t6,8c0 <error>
 58c:	00000000 	nop
 590:	afc20088 	sw	v0,136(s8)
 594:	0800009e 	j	278 <main+0x178>
 598:	adcc0088 	sw	t4,136(t6)
 59c:	03c0e821 	move	sp,s8
 5a0:	01c0a821 	move	s5,t6
 5a4:	17b500c6 	bne	sp,s5,8c0 <error>
 5a8:	00000000 	nop
 5ac:	8fbf009c 	lw	ra,156(sp)
 5b0:	8eb7009c 	lw	s7,156(s5)
 5b4:	17b500c2 	bne	sp,s5,8c0 <error>
 5b8:	00000000 	nop
 5bc:	8fbe0098 	lw	s8,152(sp)
 5c0:	8eae0098 	lw	t6,152(s5)
 5c4:	27bd00a0 	addiu	sp,sp,160
 5c8:	03e00008 	jr	ra
 5cc:	26b500a0 	addiu	s5,s5,160

000005d0 <memcpy>:
 5d0:	03e0b821 	move	s7,ra
 5d4:	00a41025 	or	v0,a1,a0
 5d8:	02166025 	or	t4,s0,s6
 5dc:	30420003 	andi	v0,v0,0x3
 5e0:	318c0003 	andi	t4,t4,0x3
 5e4:	00805021 	move	t2,a0
 5e8:	144c00b5 	bne	v0,t4,8c0 <error>
 5ec:	02c0c021 	move	t8,s6
 5f0:	1440006e 	bnez	v0,7ac <memcpy_0xa4>
 5f4:	00000000 	nop
 5f8:	00064102 	srl	t0,a2,0x4
 5fc:	000f8902 	srl	s1,t7,0x4
 600:	00a04821 	move	t1,a1
 604:	02009821 	move	s3,s0
 608:	30c6000f 	andi	a2,a2,0xf
 60c:	31ef000f 	andi	t7,t7,0xf
 610:	00803821 	move	a3,a0
 614:	151100aa 	bne	t0,s1,8c0 <error>
 618:	02c0a021 	move	s4,s6
 61c:	1100002e 	beqz	t0,6d8 <memcpy_0x54>
 620:	00000000 	nop

00000624 <memcpy_0x24>:
 624:	153300a6 	bne	t1,s3,8c0 <error>
 628:	00000000 	nop
 62c:	8d220000 	lw	v0,0(t1)
 630:	8e6c0000 	lw	t4,0(s3)
 634:	153300a2 	bne	t1,s3,8c0 <error>
 638:	00000000 	nop
 63c:	8d230004 	lw	v1,4(t1)
 640:	8e6d0004 	lw	t5,4(s3)
 644:	1533009e 	bne	t1,s3,8c0 <error>
 648:	00000000 	nop
 64c:	8d240008 	lw	a0,8(t1)
 650:	8e760008 	lw	s6,8(s3)
 654:	1533009a 	bne	t1,s3,8c0 <error>
 658:	00000000 	nop
 65c:	8d25000c 	lw	a1,12(t1)
 660:	8e70000c 	lw	s0,12(s3)
 664:	2508ffff 	addiu	t0,t0,-1
 668:	144c0095 	bne	v0,t4,8c0 <error>
 66c:	2631ffff 	addiu	s1,s1,-1
 670:	14f40093 	bne	a3,s4,8c0 <error>
 674:	00000000 	nop
 678:	ace20000 	sw	v0,0(a3)
 67c:	146d0090 	bne	v1,t5,8c0 <error>
 680:	ae8c0000 	sw	t4,0(s4)
 684:	14f4008e 	bne	a3,s4,8c0 <error>
 688:	00000000 	nop
 68c:	ace30004 	sw	v1,4(a3)
 690:	1496008b 	bne	a0,s6,8c0 <error>
 694:	ae8d0004 	sw	t5,4(s4)
 698:	14f40089 	bne	a3,s4,8c0 <error>
 69c:	00000000 	nop
 6a0:	ace40008 	sw	a0,8(a3)
 6a4:	14b00086 	bne	a1,s0,8c0 <error>
 6a8:	ae960008 	sw	s6,8(s4)
 6ac:	14f40084 	bne	a3,s4,8c0 <error>
 6b0:	00000000 	nop
 6b4:	ace5000c 	sw	a1,12(a3)
 6b8:	ae90000c 	sw	s0,12(s4)
 6bc:	25290010 	addiu	t1,t1,16
 6c0:	26730010 	addiu	s3,s3,16
 6c4:	24e70010 	addiu	a3,a3,16
 6c8:	1511007d 	bne	t0,s1,8c0 <error>
 6cc:	26940010 	addiu	s4,s4,16
 6d0:	1500ffd4 	bnez	t0,624 <memcpy_0x24>
 6d4:	00000000 	nop

000006d8 <memcpy_0x54>:
 6d8:	00064082 	srl	t0,a2,0x2
 6dc:	000f8882 	srl	s1,t7,0x2
 6e0:	30c60003 	andi	a2,a2,0x3
 6e4:	15110076 	bne	t0,s1,8c0 <error>
 6e8:	31ef0003 	andi	t7,t7,0x3
 6ec:	11000013 	beqz	t0,73c <memcpy_0x78>
 6f0:	00000000 	nop

000006f4 <memcpy_0x60>:
 6f4:	15330072 	bne	t1,s3,8c0 <error>
 6f8:	00000000 	nop
 6fc:	8d220000 	lw	v0,0(t1)
 700:	8e6c0000 	lw	t4,0(s3)
 704:	2508ffff 	addiu	t0,t0,-1
 708:	144c006d 	bne	v0,t4,8c0 <error>
 70c:	2631ffff 	addiu	s1,s1,-1
 710:	14f4006b 	bne	a3,s4,8c0 <error>
 714:	00000000 	nop
 718:	ace20000 	sw	v0,0(a3)
 71c:	ae8c0000 	sw	t4,0(s4)
 720:	25290004 	addiu	t1,t1,4
 724:	26730004 	addiu	s3,s3,4
 728:	24e70004 	addiu	a3,a3,4
 72c:	15110064 	bne	t0,s1,8c0 <error>
 730:	26940004 	addiu	s4,s4,4
 734:	1500ffef 	bnez	t0,6f4 <memcpy_0x60>
 738:	00000000 	nop

0000073c <memcpy_0x78>:
 73c:	00e01821 	move	v1,a3
 740:	02806821 	move	t5,s4
 744:	01202821 	move	a1,t1
 748:	14cf005d 	bne	a2,t7,8c0 <error>
 74c:	02608021 	move	s0,s3
 750:	18c00013 	blez	a2,7a0 <memcpy_0x9c>
 754:	00000000 	nop

00000758 <memcpy_0x84>:
 758:	14b00059 	bne	a1,s0,8c0 <error>
 75c:	00000000 	nop
 760:	90a20000 	lbu	v0,0(a1)
 764:	920c0000 	lbu	t4,0(s0)
 768:	24c6ffff 	addiu	a2,a2,-1
 76c:	144c0054 	bne	v0,t4,8c0 <error>
 770:	25efffff 	addiu	t7,t7,-1
 774:	146d0052 	bne	v1,t5,8c0 <error>
 778:	00000000 	nop
 77c:	a0620000 	sb	v0,0(v1)
 780:	a1ac0000 	sb	t4,0(t5)
 784:	24a50001 	addiu	a1,a1,1
 788:	26100001 	addiu	s0,s0,1
 78c:	24630001 	addiu	v1,v1,1
 790:	14cf004b 	bne	a2,t7,8c0 <error>
 794:	25ad0001 	addiu	t5,t5,1
 798:	1cc0ffef 	bgtz	a2,758 <memcpy_0x84>
 79c:	00000000 	nop

000007a0 <memcpy_0x9c>:
 7a0:	01401021 	move	v0,t2
 7a4:	03e00008 	jr	ra
 7a8:	03006021 	move	t4,t8

000007ac <memcpy_0xa4>:
 7ac:	00801821 	move	v1,a0
 7b0:	02c06821 	move	t5,s6
 7b4:	00c01021 	move	v0,a2
 7b8:	14cf0041 	bne	a2,t7,8c0 <error>
 7bc:	01e06021 	move	t4,t7
 7c0:	04c0003c 	bltz	a2,8b4 <memcpy_0x10c>
 7c4:	00000000 	nop

000007c8 <memcpy_0xb0>:
 7c8:	00024083 	sra	t0,v0,0x2
 7cc:	000c8883 	sra	s1,t4,0x2
 7d0:	00081080 	sll	v0,t0,0x2
 7d4:	00116080 	sll	t4,s1,0x2
 7d8:	00c23023 	subu	a2,a2,v0
 7dc:	15110038 	bne	t0,s1,8c0 <error>
 7e0:	01ec7823 	subu	t7,t7,t4
 7e4:	1100001b 	beqz	t0,854 <memcpy_0xe4>
 7e8:	00000000 	nop

000007ec <memcpy_0xc0>:
 7ec:	2508ffff 	addiu	t0,t0,-1
 7f0:	14b00033 	bne	a1,s0,8c0 <error>
 7f4:	2631ffff 	addiu	s1,s1,-1
 7f8:	88a20000 	lwl	v0,0(a1)
 7fc:	8a0c0000 	lwl	t4,0(s0)
 800:	14b0002f 	bne	a1,s0,8c0 <error>
 804:	00000000 	nop
 808:	98a20003 	lwr	v0,3(a1)
 80c:	9a0c0003 	lwr	t4,3(s0)
 810:	24a50004 	addiu	a1,a1,4
 814:	144c002a 	bne	v0,t4,8c0 <error>
 818:	26100004 	addiu	s0,s0,4
 81c:	146d0028 	bne	v1,t5,8c0 <error>
 820:	00000000 	nop
 824:	a8620000 	swl	v0,0(v1)
 828:	144c0025 	bne	v0,t4,8c0 <error>
 82c:	a9ac0000 	swl	t4,0(t5)
 830:	146d0023 	bne	v1,t5,8c0 <error>
 834:	00000000 	nop
 838:	b8620003 	swr	v0,3(v1)
 83c:	b9ac0003 	swr	t4,3(t5)
 840:	24630004 	addiu	v1,v1,4
 844:	1511001e 	bne	t0,s1,8c0 <error>
 848:	25ad0004 	addiu	t5,t5,4
 84c:	1500ffe7 	bnez	t0,7ec <memcpy_0xc0>
 850:	00000000 	nop

00000854 <memcpy_0xe4>:
 854:	14cf001a 	bne	a2,t7,8c0 <error>
 858:	00000000 	nop
 85c:	18c0ffd0 	blez	a2,7a0 <memcpy_0x9c>
 860:	00000000 	nop

00000864 <memcpy_0xec>:
 864:	14b00016 	bne	a1,s0,8c0 <error>
 868:	00000000 	nop
 86c:	90a20000 	lbu	v0,0(a1)
 870:	920c0000 	lbu	t4,0(s0)
 874:	24c6ffff 	addiu	a2,a2,-1
 878:	144c0011 	bne	v0,t4,8c0 <error>
 87c:	25efffff 	addiu	t7,t7,-1
 880:	146d000f 	bne	v1,t5,8c0 <error>
 884:	00000000 	nop
 888:	a0620000 	sb	v0,0(v1)
 88c:	a1ac0000 	sb	t4,0(t5)
 890:	24a50001 	addiu	a1,a1,1
 894:	26100001 	addiu	s0,s0,1
 898:	24630001 	addiu	v1,v1,1
 89c:	14cf0008 	bne	a2,t7,8c0 <error>
 8a0:	25ad0001 	addiu	t5,t5,1
 8a4:	1cc0ffef 	bgtz	a2,864 <memcpy_0xec>
 8a8:	00000000 	nop
 8ac:	080001e8 	j	7a0 <memcpy_0x9c>
 8b0:	00000000 	nop

000008b4 <memcpy_0x10c>:
 8b4:	24c20003 	addiu	v0,a2,3
 8b8:	080001f2 	j	7c8 <memcpy_0xb0>
 8bc:	25ec0003 	addiu	t4,t7,3

000008c0 <error>:
 8c0:	08000230 	j	8c0 <error>
 8c4:	240b0001 	li	t3,1

000008c8 <open>:
 8c8:	24030040 	li	v1,64
 8cc:	00600008 	jr	v1
 8d0:	00000000 	nop

000008d4 <creat>:
 8d4:	24030044 	li	v1,68
 8d8:	00600008 	jr	v1
 8dc:	00000000 	nop

000008e0 <close>:
 8e0:	24030048 	li	v1,72
 8e4:	00600008 	jr	v1
 8e8:	00000000 	nop

000008ec <read>:
 8ec:	2403004c 	li	v1,76
 8f0:	00600008 	jr	v1
 8f4:	00000000 	nop

000008f8 <write>:
 8f8:	24030050 	li	v1,80
 8fc:	00600008 	jr	v1
 900:	00000000 	nop

00000904 <isatty>:
 904:	24030054 	li	v1,84
 908:	00600008 	jr	v1
 90c:	00000000 	nop

00000910 <sbrk>:
 910:	24030058 	li	v1,88
 914:	00600008 	jr	v1
 918:	00000000 	nop

0000091c <lseek>:
 91c:	2403005c 	li	v1,92
 920:	00600008 	jr	v1
 924:	00000000 	nop

00000928 <fstat>:
 928:	24030060 	li	v1,96
 92c:	00600008 	jr	v1
 930:	00000000 	nop

00000934 <_exit>:
 934:	24030064 	li	v1,100
 938:	00600008 	jr	v1
 93c:	00000000 	nop

00000940 <times>:
 940:	24030068 	li	v1,104
 944:	00600008 	jr	v1
 948:	00000000 	nop

0000094c <time>:
 94c:	2403006c 	li	v1,108
 950:	00600008 	jr	v1
 954:	00000000 	nop

00000958 <random>:
 958:	24030070 	li	v1,112
 95c:	00600008 	jr	v1
 960:	00000000 	nop
Disassembly of section .rodata:

0000097c <.rodata>:
 97c:	0000000b 	0xb
 980:	0000000c 	syscall
 984:	0000000d 	break
 988:	00000015 	0x15
 98c:	00000016 	0x16
 990:	00000017 	0x17
 994:	0000001f 	0x1f
 998:	00000020 	add	zero,zero,zero
 99c:	00000021 	move	zero,zero
 9a0:	0000001c 	0x1c
 9a4:	0000001b 	divu	zero,zero,zero
 9a8:	0000001a 	div	zero,zero,zero
 9ac:	00000012 	mflo	zero
 9b0:	00000011 	mthi	zero
 9b4:	00000010 	mfhi	zero
 9b8:	00000008 	jr	zero
 9bc:	00000007 	srav	zero,zero,zero
 9c0:	00000006 	srlv	zero,zero,zero
Disassembly of section .data:
