
multMatrizVAR2_mips.exe:     file format elf32-bigmips

Disassembly of section .text:

00000000 <_start>:
   0:	3c1d0050 	lui	sp,0x50
   4:	23bdfc00 	addi	sp,sp,-1024
   8:	3c1c0001 	lui	gp,0x1
   c:	0c000040 	jal	100 <main>
  10:	279c8d60 	addiu	gp,gp,-29344
  14:	0c000335 	jal	cd4 <_exit>
  18:	00000000 	nop
	...

00000100 <main>:
 100:	03a0a821 	move	s5,sp
 104:	03e0b821 	move	s7,ra
 108:	27bdff60 	addiu	sp,sp,-160
 10c:	26b5ff60 	addiu	s5,s5,-160
 110:	17b502d3 	bne	sp,s5,c60 <error>
 114:	00000000 	nop
 118:	17f702d1 	bne	ra,s7,c60 <error>
 11c:	00000000 	nop
 120:	17b502cf 	bne	sp,s5,c60 <error>
 124:	00000000 	nop
 128:	afbf009c 	sw	ra,156(sp)
 12c:	17ce02cc 	bne	s8,t6,c60 <error>
 130:	aeb7009c 	sw	s7,156(s5)
 134:	17b502ca 	bne	sp,s5,c60 <error>
 138:	00000000 	nop
 13c:	afbe0098 	sw	s8,152(sp)
 140:	aeae0098 	sw	t6,152(s5)
 144:	03a0f021 	move	s8,sp
 148:	02a07021 	move	t6,s5
 14c:	17ce02c4 	bne	s8,t6,c60 <error>
 150:	00000000 	nop
 154:	27c20010 	addiu	v0,s8,16
 158:	25cc0010 	addiu	t4,t6,16
 15c:	144c02c0 	bne	v0,t4,c60 <error>
 160:	00000000 	nop
 164:	3c030000 	lui	v1,0x0
 168:	24630d1c 	addiu	v1,v1,3356
 16c:	3c0d0000 	lui	t5,0x0
 170:	25ad0d1c 	addiu	t5,t5,3356
 174:	146d02ba 	bne	v1,t5,c60 <error>
 178:	00000000 	nop
 17c:	00402021 	move	a0,v0
 180:	0180b021 	move	s6,t4
 184:	149602b6 	bne	a0,s6,c60 <error>
 188:	00000000 	nop
 18c:	00602821 	move	a1,v1
 190:	01a08021 	move	s0,t5
 194:	14b002b2 	bne	a1,s0,c60 <error>
 198:	00000000 	nop
 19c:	24060024 	li	a2,36
 1a0:	240f0024 	li	t7,36
 1a4:	14cf02ae 	bne	a2,t7,c60 <error>
 1a8:	00000000 	nop
 1ac:	0c0001fe 	jal	7f8 <memcpy>
 1b0:	00000000 	nop
 1b4:	03e0b821 	move	s7,ra
 1b8:	27c20038 	addiu	v0,s8,56
 1bc:	25cc0038 	addiu	t4,t6,56
 1c0:	144c02a7 	bne	v0,t4,c60 <error>
 1c4:	00000000 	nop
 1c8:	3c030000 	lui	v1,0x0
 1cc:	24630d40 	addiu	v1,v1,3392
 1d0:	3c0d0000 	lui	t5,0x0
 1d4:	25ad0d40 	addiu	t5,t5,3392
 1d8:	146d02a1 	bne	v1,t5,c60 <error>
 1dc:	00000000 	nop
 1e0:	00402021 	move	a0,v0
 1e4:	0180b021 	move	s6,t4
 1e8:	1496029d 	bne	a0,s6,c60 <error>
 1ec:	00000000 	nop
 1f0:	00602821 	move	a1,v1
 1f4:	01a08021 	move	s0,t5
 1f8:	14b00299 	bne	a1,s0,c60 <error>
 1fc:	00000000 	nop
 200:	24060024 	li	a2,36
 204:	240f0024 	li	t7,36
 208:	14cf0295 	bne	a2,t7,c60 <error>
 20c:	00000000 	nop
 210:	0c0001fe 	jal	7f8 <memcpy>
 214:	00000000 	nop
 218:	14120291 	bne	zero,s2,c60 <error>
 21c:	03e0b821 	move	s7,ra
 220:	17ce028f 	bne	s8,t6,c60 <error>
 224:	00000000 	nop
 228:	afc00060 	sw	zero,96(s8)
 22c:	1412028c 	bne	zero,s2,c60 <error>
 230:	add20060 	sw	s2,96(t6)
 234:	17ce028a 	bne	s8,t6,c60 <error>
 238:	00000000 	nop
 23c:	afc00064 	sw	zero,100(s8)
 240:	14120287 	bne	zero,s2,c60 <error>
 244:	add20064 	sw	s2,100(t6)
 248:	17ce0285 	bne	s8,t6,c60 <error>
 24c:	00000000 	nop
 250:	afc00068 	sw	zero,104(s8)
 254:	14120282 	bne	zero,s2,c60 <error>
 258:	add20068 	sw	s2,104(t6)
 25c:	17ce0280 	bne	s8,t6,c60 <error>
 260:	00000000 	nop
 264:	afc0006c 	sw	zero,108(s8)
 268:	1412027d 	bne	zero,s2,c60 <error>
 26c:	add2006c 	sw	s2,108(t6)
 270:	17ce027b 	bne	s8,t6,c60 <error>
 274:	00000000 	nop
 278:	afc00070 	sw	zero,112(s8)
 27c:	14120278 	bne	zero,s2,c60 <error>
 280:	add20070 	sw	s2,112(t6)
 284:	17ce0276 	bne	s8,t6,c60 <error>
 288:	00000000 	nop
 28c:	afc00074 	sw	zero,116(s8)
 290:	14120273 	bne	zero,s2,c60 <error>
 294:	add20074 	sw	s2,116(t6)
 298:	17ce0271 	bne	s8,t6,c60 <error>
 29c:	00000000 	nop
 2a0:	afc00078 	sw	zero,120(s8)
 2a4:	1412026e 	bne	zero,s2,c60 <error>
 2a8:	add20078 	sw	s2,120(t6)
 2ac:	17ce026c 	bne	s8,t6,c60 <error>
 2b0:	00000000 	nop
 2b4:	afc0007c 	sw	zero,124(s8)
 2b8:	14120269 	bne	zero,s2,c60 <error>
 2bc:	add2007c 	sw	s2,124(t6)
 2c0:	17ce0267 	bne	s8,t6,c60 <error>
 2c4:	00000000 	nop
 2c8:	afc00080 	sw	zero,128(s8)
 2cc:	14120264 	bne	zero,s2,c60 <error>
 2d0:	add20080 	sw	s2,128(t6)
 2d4:	17ce0262 	bne	s8,t6,c60 <error>
 2d8:	00000000 	nop
 2dc:	afc00088 	sw	zero,136(s8)
 2e0:	add20088 	sw	s2,136(t6)
 2e4:	8fc20088 	lw	v0,136(s8)
 2e8:	8dcc0088 	lw	t4,136(t6)
 2ec:	00000000 	nop
 2f0:	144c025b 	bne	v0,t4,c60 <error>
 2f4:	00000000 	nop
 2f8:	28420003 	slti	v0,v0,3
 2fc:	298c0003 	slti	t4,t4,3
 300:	144c0257 	bne	v0,t4,c60 <error>
 304:	00000000 	nop
 308:	144c0255 	bne	v0,t4,c60 <error>
 30c:	00000000 	nop
 310:	14120253 	bne	zero,s2,c60 <error>
 314:	00000000 	nop
 318:	14400003 	bnez	v0,328 <main+0x228>
 31c:	00000000 	nop
 320:	080001ea 	j	7a8 <main+0x6a8>
 324:	00000000 	nop
 328:	1412024d 	bne	zero,s2,c60 <error>
 32c:	00000000 	nop
 330:	17ce024b 	bne	s8,t6,c60 <error>
 334:	00000000 	nop
 338:	afc0008c 	sw	zero,140(s8)
 33c:	add2008c 	sw	s2,140(t6)
 340:	8fc2008c 	lw	v0,140(s8)
 344:	8dcc008c 	lw	t4,140(t6)
 348:	00000000 	nop
 34c:	144c0244 	bne	v0,t4,c60 <error>
 350:	00000000 	nop
 354:	28420003 	slti	v0,v0,3
 358:	298c0003 	slti	t4,t4,3
 35c:	144c0240 	bne	v0,t4,c60 <error>
 360:	00000000 	nop
 364:	144c023e 	bne	v0,t4,c60 <error>
 368:	00000000 	nop
 36c:	1412023c 	bne	zero,s2,c60 <error>
 370:	00000000 	nop
 374:	14400003 	bnez	v0,384 <main+0x284>
 378:	00000000 	nop
 37c:	080001da 	j	768 <main+0x668>
 380:	00000000 	nop
 384:	14120236 	bne	zero,s2,c60 <error>
 388:	00000000 	nop
 38c:	17ce0234 	bne	s8,t6,c60 <error>
 390:	00000000 	nop
 394:	afc00090 	sw	zero,144(s8)
 398:	add20090 	sw	s2,144(t6)
 39c:	8fc20090 	lw	v0,144(s8)
 3a0:	8dcc0090 	lw	t4,144(t6)
 3a4:	00000000 	nop
 3a8:	144c022d 	bne	v0,t4,c60 <error>
 3ac:	00000000 	nop
 3b0:	28420003 	slti	v0,v0,3
 3b4:	298c0003 	slti	t4,t4,3
 3b8:	144c0229 	bne	v0,t4,c60 <error>
 3bc:	00000000 	nop
 3c0:	144c0227 	bne	v0,t4,c60 <error>
 3c4:	00000000 	nop
 3c8:	14120225 	bne	zero,s2,c60 <error>
 3cc:	00000000 	nop
 3d0:	14400003 	bnez	v0,3e0 <main+0x2e0>
 3d4:	00000000 	nop
 3d8:	080001ca 	j	728 <main+0x628>
 3dc:	00000000 	nop
 3e0:	8fc30088 	lw	v1,136(s8)
 3e4:	8dcd0088 	lw	t5,136(t6)
 3e8:	00000000 	nop
 3ec:	146d021c 	bne	v1,t5,c60 <error>
 3f0:	00000000 	nop
 3f4:	00601021 	move	v0,v1
 3f8:	01a06021 	move	t4,t5
 3fc:	144c0218 	bne	v0,t4,c60 <error>
 400:	00000000 	nop
 404:	00021040 	sll	v0,v0,0x1
 408:	000c6040 	sll	t4,t4,0x1
 40c:	144c0214 	bne	v0,t4,c60 <error>
 410:	00000000 	nop
 414:	00431021 	addu	v0,v0,v1
 418:	018d6021 	addu	t4,t4,t5
 41c:	144c0210 	bne	v0,t4,c60 <error>
 420:	00000000 	nop
 424:	8fc3008c 	lw	v1,140(s8)
 428:	8dcd008c 	lw	t5,140(t6)
 42c:	00000000 	nop
 430:	146d020b 	bne	v1,t5,c60 <error>
 434:	00000000 	nop
 438:	00431021 	addu	v0,v0,v1
 43c:	018d6021 	addu	t4,t4,t5
 440:	144c0207 	bne	v0,t4,c60 <error>
 444:	00000000 	nop
 448:	00021880 	sll	v1,v0,0x2
 44c:	000c6880 	sll	t5,t4,0x2
 450:	146d0203 	bne	v1,t5,c60 <error>
 454:	00000000 	nop
 458:	27c20010 	addiu	v0,s8,16
 45c:	25cc0010 	addiu	t4,t6,16
 460:	144c01ff 	bne	v0,t4,c60 <error>
 464:	00000000 	nop
 468:	00621021 	addu	v0,v1,v0
 46c:	01ac6021 	addu	t4,t5,t4
 470:	144c01fb 	bne	v0,t4,c60 <error>
 474:	00000000 	nop
 478:	24450050 	addiu	a1,v0,80
 47c:	25900050 	addiu	s0,t4,80
 480:	14b001f7 	bne	a1,s0,c60 <error>
 484:	00000000 	nop
 488:	8fc30088 	lw	v1,136(s8)
 48c:	8dcd0088 	lw	t5,136(t6)
 490:	00000000 	nop
 494:	146d01f2 	bne	v1,t5,c60 <error>
 498:	00000000 	nop
 49c:	00601021 	move	v0,v1
 4a0:	01a06021 	move	t4,t5
 4a4:	144c01ee 	bne	v0,t4,c60 <error>
 4a8:	00000000 	nop
 4ac:	00021040 	sll	v0,v0,0x1
 4b0:	000c6040 	sll	t4,t4,0x1
 4b4:	144c01ea 	bne	v0,t4,c60 <error>
 4b8:	00000000 	nop
 4bc:	00431021 	addu	v0,v0,v1
 4c0:	018d6021 	addu	t4,t4,t5
 4c4:	144c01e6 	bne	v0,t4,c60 <error>
 4c8:	00000000 	nop
 4cc:	8fc3008c 	lw	v1,140(s8)
 4d0:	8dcd008c 	lw	t5,140(t6)
 4d4:	00000000 	nop
 4d8:	146d01e1 	bne	v1,t5,c60 <error>
 4dc:	00000000 	nop
 4e0:	00431021 	addu	v0,v0,v1
 4e4:	018d6021 	addu	t4,t4,t5
 4e8:	144c01dd 	bne	v0,t4,c60 <error>
 4ec:	00000000 	nop
 4f0:	00021880 	sll	v1,v0,0x2
 4f4:	000c6880 	sll	t5,t4,0x2
 4f8:	146d01d9 	bne	v1,t5,c60 <error>
 4fc:	00000000 	nop
 500:	27c20010 	addiu	v0,s8,16
 504:	25cc0010 	addiu	t4,t6,16
 508:	144c01d5 	bne	v0,t4,c60 <error>
 50c:	00000000 	nop
 510:	00621021 	addu	v0,v1,v0
 514:	01ac6021 	addu	t4,t5,t4
 518:	144c01d1 	bne	v0,t4,c60 <error>
 51c:	00000000 	nop
 520:	24460050 	addiu	a2,v0,80
 524:	258f0050 	addiu	t7,t4,80
 528:	14cf01cd 	bne	a2,t7,c60 <error>
 52c:	00000000 	nop
 530:	8fc30088 	lw	v1,136(s8)
 534:	8dcd0088 	lw	t5,136(t6)
 538:	00000000 	nop
 53c:	146d01c8 	bne	v1,t5,c60 <error>
 540:	00000000 	nop
 544:	00601021 	move	v0,v1
 548:	01a06021 	move	t4,t5
 54c:	144c01c4 	bne	v0,t4,c60 <error>
 550:	00000000 	nop
 554:	00021040 	sll	v0,v0,0x1
 558:	000c6040 	sll	t4,t4,0x1
 55c:	144c01c0 	bne	v0,t4,c60 <error>
 560:	00000000 	nop
 564:	00431021 	addu	v0,v0,v1
 568:	018d6021 	addu	t4,t4,t5
 56c:	144c01bc 	bne	v0,t4,c60 <error>
 570:	00000000 	nop
 574:	8fc30090 	lw	v1,144(s8)
 578:	8dcd0090 	lw	t5,144(t6)
 57c:	00000000 	nop
 580:	146d01b7 	bne	v1,t5,c60 <error>
 584:	00000000 	nop
 588:	00431021 	addu	v0,v0,v1
 58c:	018d6021 	addu	t4,t4,t5
 590:	144c01b3 	bne	v0,t4,c60 <error>
 594:	00000000 	nop
 598:	00021880 	sll	v1,v0,0x2
 59c:	000c6880 	sll	t5,t4,0x2
 5a0:	146d01af 	bne	v1,t5,c60 <error>
 5a4:	00000000 	nop
 5a8:	27c20010 	addiu	v0,s8,16
 5ac:	25cc0010 	addiu	t4,t6,16
 5b0:	144c01ab 	bne	v0,t4,c60 <error>
 5b4:	00000000 	nop
 5b8:	00622021 	addu	a0,v1,v0
 5bc:	01acb021 	addu	s6,t5,t4
 5c0:	149601a7 	bne	a0,s6,c60 <error>
 5c4:	00000000 	nop
 5c8:	8fc30090 	lw	v1,144(s8)
 5cc:	8dcd0090 	lw	t5,144(t6)
 5d0:	00000000 	nop
 5d4:	146d01a2 	bne	v1,t5,c60 <error>
 5d8:	00000000 	nop
 5dc:	00601021 	move	v0,v1
 5e0:	01a06021 	move	t4,t5
 5e4:	144c019e 	bne	v0,t4,c60 <error>
 5e8:	00000000 	nop
 5ec:	00021040 	sll	v0,v0,0x1
 5f0:	000c6040 	sll	t4,t4,0x1
 5f4:	144c019a 	bne	v0,t4,c60 <error>
 5f8:	00000000 	nop
 5fc:	00431021 	addu	v0,v0,v1
 600:	018d6021 	addu	t4,t4,t5
 604:	144c0196 	bne	v0,t4,c60 <error>
 608:	00000000 	nop
 60c:	8fc3008c 	lw	v1,140(s8)
 610:	8dcd008c 	lw	t5,140(t6)
 614:	00000000 	nop
 618:	146d0191 	bne	v1,t5,c60 <error>
 61c:	00000000 	nop
 620:	00431021 	addu	v0,v0,v1
 624:	018d6021 	addu	t4,t4,t5
 628:	144c018d 	bne	v0,t4,c60 <error>
 62c:	00000000 	nop
 630:	00021880 	sll	v1,v0,0x2
 634:	000c6880 	sll	t5,t4,0x2
 638:	146d0189 	bne	v1,t5,c60 <error>
 63c:	00000000 	nop
 640:	27c20010 	addiu	v0,s8,16
 644:	25cc0010 	addiu	t4,t6,16
 648:	144c0185 	bne	v0,t4,c60 <error>
 64c:	00000000 	nop
 650:	00621021 	addu	v0,v1,v0
 654:	01ac6021 	addu	t4,t5,t4
 658:	144c0181 	bne	v0,t4,c60 <error>
 65c:	00000000 	nop
 660:	24420028 	addiu	v0,v0,40
 664:	258c0028 	addiu	t4,t4,40
 668:	144c017d 	bne	v0,t4,c60 <error>
 66c:	00000000 	nop
 670:	8c830000 	lw	v1,0(a0)
 674:	8ecd0000 	lw	t5,0(s6)
 678:	00000000 	nop
 67c:	146d0178 	bne	v1,t5,c60 <error>
 680:	00000000 	nop
 684:	8c420000 	lw	v0,0(v0)
 688:	8d8c0000 	lw	t4,0(t4)
 68c:	00000000 	nop
 690:	144c0173 	bne	v0,t4,c60 <error>
 694:	00000000 	nop
 698:	00620018 	mult	v1,v0
 69c:	00001812 	mflo	v1
 6a0:	00006812 	mflo	t5
 6a4:	146d016e 	bne	v1,t5,c60 <error>
 6a8:	00000000 	nop
 6ac:	8cc20000 	lw	v0,0(a2)
 6b0:	8dec0000 	lw	t4,0(t7)
 6b4:	00000000 	nop
 6b8:	144c0169 	bne	v0,t4,c60 <error>
 6bc:	00000000 	nop
 6c0:	00431021 	addu	v0,v0,v1
 6c4:	018d6021 	addu	t4,t4,t5
 6c8:	144c0165 	bne	v0,t4,c60 <error>
 6cc:	00000000 	nop
 6d0:	144c0163 	bne	v0,t4,c60 <error>
 6d4:	00000000 	nop
 6d8:	14b00161 	bne	a1,s0,c60 <error>
 6dc:	00000000 	nop
 6e0:	aca20000 	sw	v0,0(a1)
 6e4:	ae0c0000 	sw	t4,0(s0)
 6e8:	8fc20090 	lw	v0,144(s8)
 6ec:	8dcc0090 	lw	t4,144(t6)
 6f0:	00000000 	nop
 6f4:	144c015a 	bne	v0,t4,c60 <error>
 6f8:	00000000 	nop
 6fc:	24420001 	addiu	v0,v0,1
 700:	258c0001 	addiu	t4,t4,1
 704:	144c0156 	bne	v0,t4,c60 <error>
 708:	00000000 	nop
 70c:	144c0154 	bne	v0,t4,c60 <error>
 710:	00000000 	nop
 714:	17ce0152 	bne	s8,t6,c60 <error>
 718:	00000000 	nop
 71c:	afc20090 	sw	v0,144(s8)
 720:	080000e7 	j	39c <main+0x29c>
 724:	adcc0090 	sw	t4,144(t6)
 728:	8fc2008c 	lw	v0,140(s8)
 72c:	8dcc008c 	lw	t4,140(t6)
 730:	00000000 	nop
 734:	144c014a 	bne	v0,t4,c60 <error>
 738:	00000000 	nop
 73c:	24420001 	addiu	v0,v0,1
 740:	258c0001 	addiu	t4,t4,1
 744:	144c0146 	bne	v0,t4,c60 <error>
 748:	00000000 	nop
 74c:	144c0144 	bne	v0,t4,c60 <error>
 750:	00000000 	nop
 754:	17ce0142 	bne	s8,t6,c60 <error>
 758:	00000000 	nop
 75c:	afc2008c 	sw	v0,140(s8)
 760:	080000d0 	j	340 <main+0x240>
 764:	adcc008c 	sw	t4,140(t6)
 768:	8fc20088 	lw	v0,136(s8)
 76c:	8dcc0088 	lw	t4,136(t6)
 770:	00000000 	nop
 774:	144c013a 	bne	v0,t4,c60 <error>
 778:	00000000 	nop
 77c:	24420001 	addiu	v0,v0,1
 780:	258c0001 	addiu	t4,t4,1
 784:	144c0136 	bne	v0,t4,c60 <error>
 788:	00000000 	nop
 78c:	144c0134 	bne	v0,t4,c60 <error>
 790:	00000000 	nop
 794:	17ce0132 	bne	s8,t6,c60 <error>
 798:	00000000 	nop
 79c:	afc20088 	sw	v0,136(s8)
 7a0:	080000b9 	j	2e4 <main+0x1e4>
 7a4:	adcc0088 	sw	t4,136(t6)
 7a8:	03c0e821 	move	sp,s8
 7ac:	01c0a821 	move	s5,t6
 7b0:	17b5012b 	bne	sp,s5,c60 <error>
 7b4:	00000000 	nop
 7b8:	8fbf009c 	lw	ra,156(sp)
 7bc:	8eb7009c 	lw	s7,156(s5)
 7c0:	00000000 	nop
 7c4:	17f70126 	bne	ra,s7,c60 <error>
 7c8:	00000000 	nop
 7cc:	8fbe0098 	lw	s8,152(sp)
 7d0:	8eae0098 	lw	t6,152(s5)
 7d4:	00000000 	nop
 7d8:	17ce0121 	bne	s8,t6,c60 <error>
 7dc:	00000000 	nop
 7e0:	27bd00a0 	addiu	sp,sp,160
 7e4:	26b500a0 	addiu	s5,s5,160
 7e8:	17b5011d 	bne	sp,s5,c60 <error>
 7ec:	00000000 	nop
 7f0:	03e00008 	jr	ra
 7f4:	00000000 	nop

000007f8 <memcpy>:
 7f8:	03e0b821 	move	s7,ra
 7fc:	00a41025 	or	v0,a1,a0
 800:	02166025 	or	t4,s0,s6
 804:	144c0116 	bne	v0,t4,c60 <error>
 808:	00000000 	nop
 80c:	30420003 	andi	v0,v0,0x3
 810:	318c0003 	andi	t4,t4,0x3
 814:	144c0112 	bne	v0,t4,c60 <error>
 818:	00000000 	nop
 81c:	00805021 	move	t2,a0
 820:	02c0c021 	move	t8,s6
 824:	1558010e 	bne	t2,t8,c60 <error>
 828:	00000000 	nop
 82c:	144c010c 	bne	v0,t4,c60 <error>
 830:	00000000 	nop
 834:	144000a2 	bnez	v0,ac0 <memcpy_0xa4>
 838:	00000000 	nop
 83c:	00064102 	srl	t0,a2,0x4
 840:	000f8902 	srl	s1,t7,0x4
 844:	15110106 	bne	t0,s1,c60 <error>
 848:	00000000 	nop
 84c:	00a04821 	move	t1,a1
 850:	02009821 	move	s3,s0
 854:	15330102 	bne	t1,s3,c60 <error>
 858:	00000000 	nop
 85c:	30c6000f 	andi	a2,a2,0xf
 860:	31ef000f 	andi	t7,t7,0xf
 864:	14cf00fe 	bne	a2,t7,c60 <error>
 868:	00000000 	nop
 86c:	00803821 	move	a3,a0
 870:	02c0a021 	move	s4,s6
 874:	14f400fa 	bne	a3,s4,c60 <error>
 878:	00000000 	nop
 87c:	151100f8 	bne	t0,s1,c60 <error>
 880:	00000000 	nop
 884:	1100003a 	beqz	t0,970 <memcpy_0x54>
 888:	00000000 	nop

0000088c <memcpy_0x24>:
 88c:	8d220000 	lw	v0,0(t1)
 890:	8e6c0000 	lw	t4,0(s3)
 894:	00000000 	nop
 898:	144c00f1 	bne	v0,t4,c60 <error>
 89c:	00000000 	nop
 8a0:	8d230004 	lw	v1,4(t1)
 8a4:	8e6d0004 	lw	t5,4(s3)
 8a8:	00000000 	nop
 8ac:	146d00ec 	bne	v1,t5,c60 <error>
 8b0:	00000000 	nop
 8b4:	8d240008 	lw	a0,8(t1)
 8b8:	8e760008 	lw	s6,8(s3)
 8bc:	00000000 	nop
 8c0:	149600e7 	bne	a0,s6,c60 <error>
 8c4:	00000000 	nop
 8c8:	8d25000c 	lw	a1,12(t1)
 8cc:	8e70000c 	lw	s0,12(s3)
 8d0:	00000000 	nop
 8d4:	14b000e2 	bne	a1,s0,c60 <error>
 8d8:	00000000 	nop
 8dc:	2508ffff 	addiu	t0,t0,-1
 8e0:	2631ffff 	addiu	s1,s1,-1
 8e4:	151100de 	bne	t0,s1,c60 <error>
 8e8:	00000000 	nop
 8ec:	144c00dc 	bne	v0,t4,c60 <error>
 8f0:	00000000 	nop
 8f4:	14f400da 	bne	a3,s4,c60 <error>
 8f8:	00000000 	nop
 8fc:	ace20000 	sw	v0,0(a3)
 900:	146d00d7 	bne	v1,t5,c60 <error>
 904:	ae8c0000 	sw	t4,0(s4)
 908:	14f400d5 	bne	a3,s4,c60 <error>
 90c:	00000000 	nop
 910:	ace30004 	sw	v1,4(a3)
 914:	149600d2 	bne	a0,s6,c60 <error>
 918:	ae8d0004 	sw	t5,4(s4)
 91c:	14f400d0 	bne	a3,s4,c60 <error>
 920:	00000000 	nop
 924:	ace40008 	sw	a0,8(a3)
 928:	14b000cd 	bne	a1,s0,c60 <error>
 92c:	ae960008 	sw	s6,8(s4)
 930:	14f400cb 	bne	a3,s4,c60 <error>
 934:	00000000 	nop
 938:	ace5000c 	sw	a1,12(a3)
 93c:	ae90000c 	sw	s0,12(s4)
 940:	25290010 	addiu	t1,t1,16
 944:	26730010 	addiu	s3,s3,16
 948:	153300c5 	bne	t1,s3,c60 <error>
 94c:	00000000 	nop
 950:	24e70010 	addiu	a3,a3,16
 954:	26940010 	addiu	s4,s4,16
 958:	14f400c1 	bne	a3,s4,c60 <error>
 95c:	00000000 	nop
 960:	151100bf 	bne	t0,s1,c60 <error>
 964:	00000000 	nop
 968:	1500ffc8 	bnez	t0,88c <memcpy_0x24>
 96c:	00000000 	nop

00000970 <memcpy_0x54>:
 970:	00064082 	srl	t0,a2,0x2
 974:	000f8882 	srl	s1,t7,0x2
 978:	151100b9 	bne	t0,s1,c60 <error>
 97c:	00000000 	nop
 980:	30c60003 	andi	a2,a2,0x3
 984:	31ef0003 	andi	t7,t7,0x3
 988:	14cf00b5 	bne	a2,t7,c60 <error>
 98c:	00000000 	nop
 990:	151100b3 	bne	t0,s1,c60 <error>
 994:	00000000 	nop
 998:	1100001c 	beqz	t0,a0c <memcpy_0x78>
 99c:	00000000 	nop

000009a0 <memcpy_0x60>:
 9a0:	8d220000 	lw	v0,0(t1)
 9a4:	8e6c0000 	lw	t4,0(s3)
 9a8:	00000000 	nop
 9ac:	144c00ac 	bne	v0,t4,c60 <error>
 9b0:	00000000 	nop
 9b4:	2508ffff 	addiu	t0,t0,-1
 9b8:	2631ffff 	addiu	s1,s1,-1
 9bc:	151100a8 	bne	t0,s1,c60 <error>
 9c0:	00000000 	nop
 9c4:	144c00a6 	bne	v0,t4,c60 <error>
 9c8:	00000000 	nop
 9cc:	14f400a4 	bne	a3,s4,c60 <error>
 9d0:	00000000 	nop
 9d4:	ace20000 	sw	v0,0(a3)
 9d8:	ae8c0000 	sw	t4,0(s4)
 9dc:	25290004 	addiu	t1,t1,4
 9e0:	26730004 	addiu	s3,s3,4
 9e4:	1533009e 	bne	t1,s3,c60 <error>
 9e8:	00000000 	nop
 9ec:	24e70004 	addiu	a3,a3,4
 9f0:	26940004 	addiu	s4,s4,4
 9f4:	14f4009a 	bne	a3,s4,c60 <error>
 9f8:	00000000 	nop
 9fc:	15110098 	bne	t0,s1,c60 <error>
 a00:	00000000 	nop
 a04:	1500ffe6 	bnez	t0,9a0 <memcpy_0x60>
 a08:	00000000 	nop

00000a0c <memcpy_0x78>:
 a0c:	00e01821 	move	v1,a3
 a10:	02806821 	move	t5,s4
 a14:	146d0092 	bne	v1,t5,c60 <error>
 a18:	00000000 	nop
 a1c:	01202821 	move	a1,t1
 a20:	02608021 	move	s0,s3
 a24:	14b0008e 	bne	a1,s0,c60 <error>
 a28:	00000000 	nop
 a2c:	14cf008c 	bne	a2,t7,c60 <error>
 a30:	00000000 	nop
 a34:	18c0001c 	blez	a2,aa8 <memcpy_0x9c>
 a38:	00000000 	nop

00000a3c <memcpy_0x84>:
 a3c:	90a20000 	lbu	v0,0(a1)
 a40:	920c0000 	lbu	t4,0(s0)
 a44:	00000000 	nop
 a48:	144c0085 	bne	v0,t4,c60 <error>
 a4c:	00000000 	nop
 a50:	24c6ffff 	addiu	a2,a2,-1
 a54:	25efffff 	addiu	t7,t7,-1
 a58:	14cf0081 	bne	a2,t7,c60 <error>
 a5c:	00000000 	nop
 a60:	144c007f 	bne	v0,t4,c60 <error>
 a64:	00000000 	nop
 a68:	146d007d 	bne	v1,t5,c60 <error>
 a6c:	00000000 	nop
 a70:	a0620000 	sb	v0,0(v1)
 a74:	a1ac0000 	sb	t4,0(t5)
 a78:	24a50001 	addiu	a1,a1,1
 a7c:	26100001 	addiu	s0,s0,1
 a80:	14b00077 	bne	a1,s0,c60 <error>
 a84:	00000000 	nop
 a88:	24630001 	addiu	v1,v1,1
 a8c:	25ad0001 	addiu	t5,t5,1
 a90:	146d0073 	bne	v1,t5,c60 <error>
 a94:	00000000 	nop
 a98:	14cf0071 	bne	a2,t7,c60 <error>
 a9c:	00000000 	nop
 aa0:	1cc0ffe6 	bgtz	a2,a3c <memcpy_0x84>
 aa4:	00000000 	nop

00000aa8 <memcpy_0x9c>:
 aa8:	01401021 	move	v0,t2
 aac:	03006021 	move	t4,t8
 ab0:	144c006b 	bne	v0,t4,c60 <error>
 ab4:	00000000 	nop
 ab8:	03e00008 	jr	ra
 abc:	00000000 	nop

00000ac0 <memcpy_0xa4>:
 ac0:	00801821 	move	v1,a0
 ac4:	02c06821 	move	t5,s6
 ac8:	146d0065 	bne	v1,t5,c60 <error>
 acc:	00000000 	nop
 ad0:	00c01021 	move	v0,a2
 ad4:	01e06021 	move	t4,t7
 ad8:	144c0061 	bne	v0,t4,c60 <error>
 adc:	00000000 	nop
 ae0:	14cf005f 	bne	a2,t7,c60 <error>
 ae4:	00000000 	nop
 ae8:	04c00057 	bltz	a2,c48 <memcpy_0x10c>
 aec:	00000000 	nop

00000af0 <memcpy_0xb0>:
 af0:	00024083 	sra	t0,v0,0x2
 af4:	000c8883 	sra	s1,t4,0x2
 af8:	15110059 	bne	t0,s1,c60 <error>
 afc:	00000000 	nop
 b00:	00081080 	sll	v0,t0,0x2
 b04:	00116080 	sll	t4,s1,0x2
 b08:	144c0055 	bne	v0,t4,c60 <error>
 b0c:	00000000 	nop
 b10:	00c23023 	subu	a2,a2,v0
 b14:	01ec7823 	subu	t7,t7,t4
 b18:	14cf0051 	bne	a2,t7,c60 <error>
 b1c:	00000000 	nop
 b20:	1511004f 	bne	t0,s1,c60 <error>
 b24:	00000000 	nop
 b28:	11000026 	beqz	t0,bc4 <memcpy_0xe4>
 b2c:	00000000 	nop

00000b30 <memcpy_0xc0>:
 b30:	2508ffff 	addiu	t0,t0,-1
 b34:	2631ffff 	addiu	s1,s1,-1
 b38:	15110049 	bne	t0,s1,c60 <error>
 b3c:	00000000 	nop
 b40:	88a20000 	lwl	v0,0(a1)
 b44:	8a0c0000 	lwl	t4,0(s0)
 b48:	00000000 	nop
 b4c:	144c0044 	bne	v0,t4,c60 <error>
 b50:	00000000 	nop
 b54:	98a20003 	lwr	v0,3(a1)
 b58:	9a0c0003 	lwr	t4,3(s0)
 b5c:	00000000 	nop
 b60:	144c003f 	bne	v0,t4,c60 <error>
 b64:	00000000 	nop
 b68:	24a50004 	addiu	a1,a1,4
 b6c:	26100004 	addiu	s0,s0,4
 b70:	14b0003b 	bne	a1,s0,c60 <error>
 b74:	00000000 	nop
 b78:	144c0039 	bne	v0,t4,c60 <error>
 b7c:	00000000 	nop
 b80:	146d0037 	bne	v1,t5,c60 <error>
 b84:	00000000 	nop
 b88:	a8620000 	swl	v0,0(v1)
 b8c:	144c0034 	bne	v0,t4,c60 <error>
 b90:	a9ac0000 	swl	t4,0(t5)
 b94:	146d0032 	bne	v1,t5,c60 <error>
 b98:	00000000 	nop
 b9c:	b8620003 	swr	v0,3(v1)
 ba0:	b9ac0003 	swr	t4,3(t5)
 ba4:	24630004 	addiu	v1,v1,4
 ba8:	25ad0004 	addiu	t5,t5,4
 bac:	146d002c 	bne	v1,t5,c60 <error>
 bb0:	00000000 	nop
 bb4:	1511002a 	bne	t0,s1,c60 <error>
 bb8:	00000000 	nop
 bbc:	1500ffdc 	bnez	t0,b30 <memcpy_0xc0>
 bc0:	00000000 	nop

00000bc4 <memcpy_0xe4>:
 bc4:	14cf0026 	bne	a2,t7,c60 <error>
 bc8:	00000000 	nop
 bcc:	18c0ffb6 	blez	a2,aa8 <memcpy_0x9c>
 bd0:	00000000 	nop

00000bd4 <memcpy_0xec>:
 bd4:	90a20000 	lbu	v0,0(a1)
 bd8:	920c0000 	lbu	t4,0(s0)
 bdc:	00000000 	nop
 be0:	144c001f 	bne	v0,t4,c60 <error>
 be4:	00000000 	nop
 be8:	24c6ffff 	addiu	a2,a2,-1
 bec:	25efffff 	addiu	t7,t7,-1
 bf0:	14cf001b 	bne	a2,t7,c60 <error>
 bf4:	00000000 	nop
 bf8:	144c0019 	bne	v0,t4,c60 <error>
 bfc:	00000000 	nop
 c00:	146d0017 	bne	v1,t5,c60 <error>
 c04:	00000000 	nop
 c08:	a0620000 	sb	v0,0(v1)
 c0c:	a1ac0000 	sb	t4,0(t5)
 c10:	24a50001 	addiu	a1,a1,1
 c14:	26100001 	addiu	s0,s0,1
 c18:	14b00011 	bne	a1,s0,c60 <error>
 c1c:	00000000 	nop
 c20:	24630001 	addiu	v1,v1,1
 c24:	25ad0001 	addiu	t5,t5,1
 c28:	146d000d 	bne	v1,t5,c60 <error>
 c2c:	00000000 	nop
 c30:	14cf000b 	bne	a2,t7,c60 <error>
 c34:	00000000 	nop
 c38:	1cc0ffe6 	bgtz	a2,bd4 <memcpy_0xec>
 c3c:	00000000 	nop
 c40:	080002aa 	j	aa8 <memcpy_0x9c>
 c44:	00000000 	nop

00000c48 <memcpy_0x10c>:
 c48:	24c20003 	addiu	v0,a2,3
 c4c:	25ec0003 	addiu	t4,t7,3
 c50:	144c0003 	bne	v0,t4,c60 <error>
 c54:	00000000 	nop
 c58:	080002bc 	j	af0 <memcpy_0xb0>
 c5c:	00000000 	nop

00000c60 <error>:
 c60:	08000318 	j	c60 <error>
 c64:	240b0001 	li	t3,1

00000c68 <open>:
 c68:	24030040 	li	v1,64
 c6c:	00600008 	jr	v1
 c70:	00000000 	nop

00000c74 <creat>:
 c74:	24030044 	li	v1,68
 c78:	00600008 	jr	v1
 c7c:	00000000 	nop

00000c80 <close>:
 c80:	24030048 	li	v1,72
 c84:	00600008 	jr	v1
 c88:	00000000 	nop

00000c8c <read>:
 c8c:	2403004c 	li	v1,76
 c90:	00600008 	jr	v1
 c94:	00000000 	nop

00000c98 <write>:
 c98:	24030050 	li	v1,80
 c9c:	00600008 	jr	v1
 ca0:	00000000 	nop

00000ca4 <isatty>:
 ca4:	24030054 	li	v1,84
 ca8:	00600008 	jr	v1
 cac:	00000000 	nop

00000cb0 <sbrk>:
 cb0:	24030058 	li	v1,88
 cb4:	00600008 	jr	v1
 cb8:	00000000 	nop

00000cbc <lseek>:
 cbc:	2403005c 	li	v1,92
 cc0:	00600008 	jr	v1
 cc4:	00000000 	nop

00000cc8 <fstat>:
 cc8:	24030060 	li	v1,96
 ccc:	00600008 	jr	v1
 cd0:	00000000 	nop

00000cd4 <_exit>:
 cd4:	24030064 	li	v1,100
 cd8:	00600008 	jr	v1
 cdc:	00000000 	nop

00000ce0 <times>:
 ce0:	24030068 	li	v1,104
 ce4:	00600008 	jr	v1
 ce8:	00000000 	nop

00000cec <time>:
 cec:	2403006c 	li	v1,108
 cf0:	00600008 	jr	v1
 cf4:	00000000 	nop

00000cf8 <random>:
 cf8:	24030070 	li	v1,112
 cfc:	00600008 	jr	v1
 d00:	00000000 	nop
Disassembly of section .rodata:

00000d1c <.rodata>:
 d1c:	0000000b 	0xb
 d20:	0000000c 	syscall
 d24:	0000000d 	break
 d28:	00000015 	0x15
 d2c:	00000016 	0x16
 d30:	00000017 	0x17
 d34:	0000001f 	0x1f
 d38:	00000020 	add	zero,zero,zero
 d3c:	00000021 	move	zero,zero
 d40:	0000001c 	0x1c
 d44:	0000001b 	divu	zero,zero,zero
 d48:	0000001a 	div	zero,zero,zero
 d4c:	00000012 	mflo	zero
 d50:	00000011 	mthi	zero
 d54:	00000010 	mfhi	zero
 d58:	00000008 	jr	zero
 d5c:	00000007 	srav	zero,zero,zero
 d60:	00000006 	srlv	zero,zero,zero
Disassembly of section .data:
