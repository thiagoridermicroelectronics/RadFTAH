
multMatrizVAR1_mips.exe:     file format elf32-bigmips

Disassembly of section .text:

00000000 <_start>:
   0:	3c1d0050 	lui	sp,0x50
   4:	23bdfc00 	addi	sp,sp,-1024
   8:	3c1c0001 	lui	gp,0x1
   c:	0c000040 	jal	100 <main>
  10:	279c8c70 	addiu	gp,gp,-29584
  14:	0c0002fb 	jal	bec <_exit>
  18:	00000000 	nop
	...

00000100 <main>:
 100:	03a0a821 	move	s5,sp
 104:	17b5029c 	bne	sp,s5,b78 <error>
 108:	03e0b821 	move	s7,ra
 10c:	27bdff60 	addiu	sp,sp,-160
 110:	17f70299 	bne	ra,s7,b78 <error>
 114:	26b5ff60 	addiu	s5,s5,-160
 118:	17b50297 	bne	sp,s5,b78 <error>
 11c:	00000000 	nop
 120:	afbf009c 	sw	ra,156(sp)
 124:	17ce0294 	bne	s8,t6,b78 <error>
 128:	aeb7009c 	sw	s7,156(s5)
 12c:	17b50292 	bne	sp,s5,b78 <error>
 130:	00000000 	nop
 134:	afbe0098 	sw	s8,152(sp)
 138:	17b5028f 	bne	sp,s5,b78 <error>
 13c:	aeae0098 	sw	t6,152(s5)
 140:	03a0f021 	move	s8,sp
 144:	02a07021 	move	t6,s5
 148:	17ce028b 	bne	s8,t6,b78 <error>
 14c:	00000000 	nop
 150:	27c20010 	addiu	v0,s8,16
 154:	25cc0010 	addiu	t4,t6,16
 158:	3c030000 	lui	v1,0x0
 15c:	24630c34 	addiu	v1,v1,3124
 160:	3c0d0000 	lui	t5,0x0
 164:	144c0284 	bne	v0,t4,b78 <error>
 168:	25ad0c34 	addiu	t5,t5,3124
 16c:	00402021 	move	a0,v0
 170:	146d0281 	bne	v1,t5,b78 <error>
 174:	0180b021 	move	s6,t4
 178:	00602821 	move	a1,v1
 17c:	01a08021 	move	s0,t5
 180:	24060024 	li	a2,36
 184:	0c0001ee 	jal	7b8 <memcpy>
 188:	240f0024 	li	t7,36
 18c:	17ce027a 	bne	s8,t6,b78 <error>
 190:	03e0b821 	move	s7,ra
 194:	27c20038 	addiu	v0,s8,56
 198:	25cc0038 	addiu	t4,t6,56
 19c:	3c030000 	lui	v1,0x0
 1a0:	24630c58 	addiu	v1,v1,3160
 1a4:	3c0d0000 	lui	t5,0x0
 1a8:	144c0273 	bne	v0,t4,b78 <error>
 1ac:	25ad0c58 	addiu	t5,t5,3160
 1b0:	00402021 	move	a0,v0
 1b4:	146d0270 	bne	v1,t5,b78 <error>
 1b8:	0180b021 	move	s6,t4
 1bc:	00602821 	move	a1,v1
 1c0:	01a08021 	move	s0,t5
 1c4:	24060024 	li	a2,36
 1c8:	0c0001ee 	jal	7b8 <memcpy>
 1cc:	240f0024 	li	t7,36
 1d0:	14120269 	bne	zero,s2,b78 <error>
 1d4:	03e0b821 	move	s7,ra
 1d8:	17ce0267 	bne	s8,t6,b78 <error>
 1dc:	00000000 	nop
 1e0:	afc00060 	sw	zero,96(s8)
 1e4:	14120264 	bne	zero,s2,b78 <error>
 1e8:	add20060 	sw	s2,96(t6)
 1ec:	17ce0262 	bne	s8,t6,b78 <error>
 1f0:	00000000 	nop
 1f4:	afc00064 	sw	zero,100(s8)
 1f8:	1412025f 	bne	zero,s2,b78 <error>
 1fc:	add20064 	sw	s2,100(t6)
 200:	17ce025d 	bne	s8,t6,b78 <error>
 204:	00000000 	nop
 208:	afc00068 	sw	zero,104(s8)
 20c:	1412025a 	bne	zero,s2,b78 <error>
 210:	add20068 	sw	s2,104(t6)
 214:	17ce0258 	bne	s8,t6,b78 <error>
 218:	00000000 	nop
 21c:	afc0006c 	sw	zero,108(s8)
 220:	14120255 	bne	zero,s2,b78 <error>
 224:	add2006c 	sw	s2,108(t6)
 228:	17ce0253 	bne	s8,t6,b78 <error>
 22c:	00000000 	nop
 230:	afc00070 	sw	zero,112(s8)
 234:	14120250 	bne	zero,s2,b78 <error>
 238:	add20070 	sw	s2,112(t6)
 23c:	17ce024e 	bne	s8,t6,b78 <error>
 240:	00000000 	nop
 244:	afc00074 	sw	zero,116(s8)
 248:	1412024b 	bne	zero,s2,b78 <error>
 24c:	add20074 	sw	s2,116(t6)
 250:	17ce0249 	bne	s8,t6,b78 <error>
 254:	00000000 	nop
 258:	afc00078 	sw	zero,120(s8)
 25c:	14120246 	bne	zero,s2,b78 <error>
 260:	add20078 	sw	s2,120(t6)
 264:	17ce0244 	bne	s8,t6,b78 <error>
 268:	00000000 	nop
 26c:	afc0007c 	sw	zero,124(s8)
 270:	14120241 	bne	zero,s2,b78 <error>
 274:	add2007c 	sw	s2,124(t6)
 278:	17ce023f 	bne	s8,t6,b78 <error>
 27c:	00000000 	nop
 280:	afc00080 	sw	zero,128(s8)
 284:	1412023c 	bne	zero,s2,b78 <error>
 288:	add20080 	sw	s2,128(t6)
 28c:	17ce023a 	bne	s8,t6,b78 <error>
 290:	00000000 	nop
 294:	afc00088 	sw	zero,136(s8)
 298:	add20088 	sw	s2,136(t6)
 29c:	17ce0236 	bne	s8,t6,b78 <error>
 2a0:	00000000 	nop
 2a4:	8fc20088 	lw	v0,136(s8)
 2a8:	8dcc0088 	lw	t4,136(t6)
 2ac:	00000000 	nop
 2b0:	144c0231 	bne	v0,t4,b78 <error>
 2b4:	00000000 	nop
 2b8:	28420003 	slti	v0,v0,3
 2bc:	298c0003 	slti	t4,t4,3
 2c0:	144c022d 	bne	v0,t4,b78 <error>
 2c4:	00000000 	nop
 2c8:	1412022b 	bne	zero,s2,b78 <error>
 2cc:	00000000 	nop
 2d0:	14400003 	bnez	v0,2e0 <main+0x1e0>
 2d4:	00000000 	nop
 2d8:	080001dd 	j	774 <main+0x674>
 2dc:	00000000 	nop
 2e0:	14120225 	bne	zero,s2,b78 <error>
 2e4:	00000000 	nop
 2e8:	17ce0223 	bne	s8,t6,b78 <error>
 2ec:	00000000 	nop
 2f0:	afc0008c 	sw	zero,140(s8)
 2f4:	add2008c 	sw	s2,140(t6)
 2f8:	17ce021f 	bne	s8,t6,b78 <error>
 2fc:	00000000 	nop
 300:	8fc2008c 	lw	v0,140(s8)
 304:	8dcc008c 	lw	t4,140(t6)
 308:	00000000 	nop
 30c:	144c021a 	bne	v0,t4,b78 <error>
 310:	00000000 	nop
 314:	28420003 	slti	v0,v0,3
 318:	298c0003 	slti	t4,t4,3
 31c:	144c0216 	bne	v0,t4,b78 <error>
 320:	00000000 	nop
 324:	14120214 	bne	zero,s2,b78 <error>
 328:	00000000 	nop
 32c:	14400003 	bnez	v0,33c <main+0x23c>
 330:	00000000 	nop
 334:	080001cd 	j	734 <main+0x634>
 338:	00000000 	nop
 33c:	1412020e 	bne	zero,s2,b78 <error>
 340:	00000000 	nop
 344:	17ce020c 	bne	s8,t6,b78 <error>
 348:	00000000 	nop
 34c:	afc00090 	sw	zero,144(s8)
 350:	add20090 	sw	s2,144(t6)
 354:	17ce0208 	bne	s8,t6,b78 <error>
 358:	00000000 	nop
 35c:	8fc20090 	lw	v0,144(s8)
 360:	8dcc0090 	lw	t4,144(t6)
 364:	00000000 	nop
 368:	144c0203 	bne	v0,t4,b78 <error>
 36c:	00000000 	nop
 370:	28420003 	slti	v0,v0,3
 374:	298c0003 	slti	t4,t4,3
 378:	144c01ff 	bne	v0,t4,b78 <error>
 37c:	00000000 	nop
 380:	141201fd 	bne	zero,s2,b78 <error>
 384:	00000000 	nop
 388:	14400003 	bnez	v0,398 <main+0x298>
 38c:	00000000 	nop
 390:	080001bd 	j	6f4 <main+0x5f4>
 394:	00000000 	nop
 398:	17ce01f7 	bne	s8,t6,b78 <error>
 39c:	00000000 	nop
 3a0:	8fc30088 	lw	v1,136(s8)
 3a4:	8dcd0088 	lw	t5,136(t6)
 3a8:	00000000 	nop
 3ac:	146d01f2 	bne	v1,t5,b78 <error>
 3b0:	00000000 	nop
 3b4:	00601021 	move	v0,v1
 3b8:	01a06021 	move	t4,t5
 3bc:	144c01ee 	bne	v0,t4,b78 <error>
 3c0:	00000000 	nop
 3c4:	00021040 	sll	v0,v0,0x1
 3c8:	000c6040 	sll	t4,t4,0x1
 3cc:	144c01ea 	bne	v0,t4,b78 <error>
 3d0:	00000000 	nop
 3d4:	146d01e8 	bne	v1,t5,b78 <error>
 3d8:	00000000 	nop
 3dc:	00431021 	addu	v0,v0,v1
 3e0:	17ce01e5 	bne	s8,t6,b78 <error>
 3e4:	018d6021 	addu	t4,t4,t5
 3e8:	8fc3008c 	lw	v1,140(s8)
 3ec:	8dcd008c 	lw	t5,140(t6)
 3f0:	144c01e1 	bne	v0,t4,b78 <error>
 3f4:	00000000 	nop
 3f8:	146d01df 	bne	v1,t5,b78 <error>
 3fc:	00000000 	nop
 400:	00431021 	addu	v0,v0,v1
 404:	018d6021 	addu	t4,t4,t5
 408:	144c01db 	bne	v0,t4,b78 <error>
 40c:	00000000 	nop
 410:	00021880 	sll	v1,v0,0x2
 414:	17ce01d8 	bne	s8,t6,b78 <error>
 418:	000c6880 	sll	t5,t4,0x2
 41c:	27c20010 	addiu	v0,s8,16
 420:	146d01d5 	bne	v1,t5,b78 <error>
 424:	25cc0010 	addiu	t4,t6,16
 428:	144c01d3 	bne	v0,t4,b78 <error>
 42c:	00000000 	nop
 430:	00621021 	addu	v0,v1,v0
 434:	01ac6021 	addu	t4,t5,t4
 438:	144c01cf 	bne	v0,t4,b78 <error>
 43c:	00000000 	nop
 440:	24450050 	addiu	a1,v0,80
 444:	17ce01cc 	bne	s8,t6,b78 <error>
 448:	25900050 	addiu	s0,t4,80
 44c:	8fc30088 	lw	v1,136(s8)
 450:	8dcd0088 	lw	t5,136(t6)
 454:	00000000 	nop
 458:	146d01c7 	bne	v1,t5,b78 <error>
 45c:	00000000 	nop
 460:	00601021 	move	v0,v1
 464:	01a06021 	move	t4,t5
 468:	144c01c3 	bne	v0,t4,b78 <error>
 46c:	00000000 	nop
 470:	00021040 	sll	v0,v0,0x1
 474:	000c6040 	sll	t4,t4,0x1
 478:	144c01bf 	bne	v0,t4,b78 <error>
 47c:	00000000 	nop
 480:	146d01bd 	bne	v1,t5,b78 <error>
 484:	00000000 	nop
 488:	00431021 	addu	v0,v0,v1
 48c:	17ce01ba 	bne	s8,t6,b78 <error>
 490:	018d6021 	addu	t4,t4,t5
 494:	8fc3008c 	lw	v1,140(s8)
 498:	8dcd008c 	lw	t5,140(t6)
 49c:	144c01b6 	bne	v0,t4,b78 <error>
 4a0:	00000000 	nop
 4a4:	146d01b4 	bne	v1,t5,b78 <error>
 4a8:	00000000 	nop
 4ac:	00431021 	addu	v0,v0,v1
 4b0:	018d6021 	addu	t4,t4,t5
 4b4:	144c01b0 	bne	v0,t4,b78 <error>
 4b8:	00000000 	nop
 4bc:	00021880 	sll	v1,v0,0x2
 4c0:	17ce01ad 	bne	s8,t6,b78 <error>
 4c4:	000c6880 	sll	t5,t4,0x2
 4c8:	27c20010 	addiu	v0,s8,16
 4cc:	146d01aa 	bne	v1,t5,b78 <error>
 4d0:	25cc0010 	addiu	t4,t6,16
 4d4:	144c01a8 	bne	v0,t4,b78 <error>
 4d8:	00000000 	nop
 4dc:	00621021 	addu	v0,v1,v0
 4e0:	01ac6021 	addu	t4,t5,t4
 4e4:	144c01a4 	bne	v0,t4,b78 <error>
 4e8:	00000000 	nop
 4ec:	24460050 	addiu	a2,v0,80
 4f0:	17ce01a1 	bne	s8,t6,b78 <error>
 4f4:	258f0050 	addiu	t7,t4,80
 4f8:	8fc30088 	lw	v1,136(s8)
 4fc:	8dcd0088 	lw	t5,136(t6)
 500:	00000000 	nop
 504:	146d019c 	bne	v1,t5,b78 <error>
 508:	00000000 	nop
 50c:	00601021 	move	v0,v1
 510:	01a06021 	move	t4,t5
 514:	144c0198 	bne	v0,t4,b78 <error>
 518:	00000000 	nop
 51c:	00021040 	sll	v0,v0,0x1
 520:	000c6040 	sll	t4,t4,0x1
 524:	144c0194 	bne	v0,t4,b78 <error>
 528:	00000000 	nop
 52c:	146d0192 	bne	v1,t5,b78 <error>
 530:	00000000 	nop
 534:	00431021 	addu	v0,v0,v1
 538:	17ce018f 	bne	s8,t6,b78 <error>
 53c:	018d6021 	addu	t4,t4,t5
 540:	8fc30090 	lw	v1,144(s8)
 544:	8dcd0090 	lw	t5,144(t6)
 548:	144c018b 	bne	v0,t4,b78 <error>
 54c:	00000000 	nop
 550:	146d0189 	bne	v1,t5,b78 <error>
 554:	00000000 	nop
 558:	00431021 	addu	v0,v0,v1
 55c:	018d6021 	addu	t4,t4,t5
 560:	144c0185 	bne	v0,t4,b78 <error>
 564:	00000000 	nop
 568:	00021880 	sll	v1,v0,0x2
 56c:	17ce0182 	bne	s8,t6,b78 <error>
 570:	000c6880 	sll	t5,t4,0x2
 574:	27c20010 	addiu	v0,s8,16
 578:	146d017f 	bne	v1,t5,b78 <error>
 57c:	25cc0010 	addiu	t4,t6,16
 580:	144c017d 	bne	v0,t4,b78 <error>
 584:	00000000 	nop
 588:	00622021 	addu	a0,v1,v0
 58c:	17ce017a 	bne	s8,t6,b78 <error>
 590:	01acb021 	addu	s6,t5,t4
 594:	8fc30090 	lw	v1,144(s8)
 598:	8dcd0090 	lw	t5,144(t6)
 59c:	00000000 	nop
 5a0:	146d0175 	bne	v1,t5,b78 <error>
 5a4:	00000000 	nop
 5a8:	00601021 	move	v0,v1
 5ac:	01a06021 	move	t4,t5
 5b0:	144c0171 	bne	v0,t4,b78 <error>
 5b4:	00000000 	nop
 5b8:	00021040 	sll	v0,v0,0x1
 5bc:	000c6040 	sll	t4,t4,0x1
 5c0:	144c016d 	bne	v0,t4,b78 <error>
 5c4:	00000000 	nop
 5c8:	146d016b 	bne	v1,t5,b78 <error>
 5cc:	00000000 	nop
 5d0:	00431021 	addu	v0,v0,v1
 5d4:	17ce0168 	bne	s8,t6,b78 <error>
 5d8:	018d6021 	addu	t4,t4,t5
 5dc:	8fc3008c 	lw	v1,140(s8)
 5e0:	8dcd008c 	lw	t5,140(t6)
 5e4:	144c0164 	bne	v0,t4,b78 <error>
 5e8:	00000000 	nop
 5ec:	146d0162 	bne	v1,t5,b78 <error>
 5f0:	00000000 	nop
 5f4:	00431021 	addu	v0,v0,v1
 5f8:	018d6021 	addu	t4,t4,t5
 5fc:	144c015e 	bne	v0,t4,b78 <error>
 600:	00000000 	nop
 604:	00021880 	sll	v1,v0,0x2
 608:	17ce015b 	bne	s8,t6,b78 <error>
 60c:	000c6880 	sll	t5,t4,0x2
 610:	27c20010 	addiu	v0,s8,16
 614:	146d0158 	bne	v1,t5,b78 <error>
 618:	25cc0010 	addiu	t4,t6,16
 61c:	144c0156 	bne	v0,t4,b78 <error>
 620:	00000000 	nop
 624:	00621021 	addu	v0,v1,v0
 628:	01ac6021 	addu	t4,t5,t4
 62c:	144c0152 	bne	v0,t4,b78 <error>
 630:	00000000 	nop
 634:	24420028 	addiu	v0,v0,40
 638:	1496014f 	bne	a0,s6,b78 <error>
 63c:	258c0028 	addiu	t4,t4,40
 640:	8c830000 	lw	v1,0(a0)
 644:	8ecd0000 	lw	t5,0(s6)
 648:	144c014b 	bne	v0,t4,b78 <error>
 64c:	00000000 	nop
 650:	8c420000 	lw	v0,0(v0)
 654:	8d8c0000 	lw	t4,0(t4)
 658:	146d0147 	bne	v1,t5,b78 <error>
 65c:	00000000 	nop
 660:	144c0145 	bne	v0,t4,b78 <error>
 664:	00000000 	nop
 668:	00620018 	mult	v1,v0
 66c:	00001812 	mflo	v1
 670:	00006812 	mflo	t5
 674:	14cf0140 	bne	a2,t7,b78 <error>
 678:	00000000 	nop
 67c:	8cc20000 	lw	v0,0(a2)
 680:	8dec0000 	lw	t4,0(t7)
 684:	00000000 	nop
 688:	144c013b 	bne	v0,t4,b78 <error>
 68c:	00000000 	nop
 690:	146d0139 	bne	v1,t5,b78 <error>
 694:	00000000 	nop
 698:	00431021 	addu	v0,v0,v1
 69c:	018d6021 	addu	t4,t4,t5
 6a0:	144c0135 	bne	v0,t4,b78 <error>
 6a4:	00000000 	nop
 6a8:	14b00133 	bne	a1,s0,b78 <error>
 6ac:	00000000 	nop
 6b0:	aca20000 	sw	v0,0(a1)
 6b4:	17ce0130 	bne	s8,t6,b78 <error>
 6b8:	ae0c0000 	sw	t4,0(s0)
 6bc:	8fc20090 	lw	v0,144(s8)
 6c0:	8dcc0090 	lw	t4,144(t6)
 6c4:	00000000 	nop
 6c8:	144c012b 	bne	v0,t4,b78 <error>
 6cc:	00000000 	nop
 6d0:	24420001 	addiu	v0,v0,1
 6d4:	258c0001 	addiu	t4,t4,1
 6d8:	144c0127 	bne	v0,t4,b78 <error>
 6dc:	00000000 	nop
 6e0:	17ce0125 	bne	s8,t6,b78 <error>
 6e4:	00000000 	nop
 6e8:	afc20090 	sw	v0,144(s8)
 6ec:	080000d5 	j	354 <main+0x254>
 6f0:	adcc0090 	sw	t4,144(t6)
 6f4:	17ce0120 	bne	s8,t6,b78 <error>
 6f8:	00000000 	nop
 6fc:	8fc2008c 	lw	v0,140(s8)
 700:	8dcc008c 	lw	t4,140(t6)
 704:	00000000 	nop
 708:	144c011b 	bne	v0,t4,b78 <error>
 70c:	00000000 	nop
 710:	24420001 	addiu	v0,v0,1
 714:	258c0001 	addiu	t4,t4,1
 718:	144c0117 	bne	v0,t4,b78 <error>
 71c:	00000000 	nop
 720:	17ce0115 	bne	s8,t6,b78 <error>
 724:	00000000 	nop
 728:	afc2008c 	sw	v0,140(s8)
 72c:	080000be 	j	2f8 <main+0x1f8>
 730:	adcc008c 	sw	t4,140(t6)
 734:	17ce0110 	bne	s8,t6,b78 <error>
 738:	00000000 	nop
 73c:	8fc20088 	lw	v0,136(s8)
 740:	8dcc0088 	lw	t4,136(t6)
 744:	00000000 	nop
 748:	144c010b 	bne	v0,t4,b78 <error>
 74c:	00000000 	nop
 750:	24420001 	addiu	v0,v0,1
 754:	258c0001 	addiu	t4,t4,1
 758:	144c0107 	bne	v0,t4,b78 <error>
 75c:	00000000 	nop
 760:	17ce0105 	bne	s8,t6,b78 <error>
 764:	00000000 	nop
 768:	afc20088 	sw	v0,136(s8)
 76c:	080000a7 	j	29c <main+0x19c>
 770:	adcc0088 	sw	t4,136(t6)
 774:	17ce0100 	bne	s8,t6,b78 <error>
 778:	00000000 	nop
 77c:	03c0e821 	move	sp,s8
 780:	01c0a821 	move	s5,t6
 784:	17b500fc 	bne	sp,s5,b78 <error>
 788:	00000000 	nop
 78c:	8fbf009c 	lw	ra,156(sp)
 790:	8eb7009c 	lw	s7,156(s5)
 794:	17b500f8 	bne	sp,s5,b78 <error>
 798:	00000000 	nop
 79c:	8fbe0098 	lw	s8,152(sp)
 7a0:	8eae0098 	lw	t6,152(s5)
 7a4:	17b500f4 	bne	sp,s5,b78 <error>
 7a8:	00000000 	nop
 7ac:	27bd00a0 	addiu	sp,sp,160
 7b0:	03e00008 	jr	ra
 7b4:	26b500a0 	addiu	s5,s5,160

000007b8 <memcpy>:
 7b8:	14b000ef 	bne	a1,s0,b78 <error>
 7bc:	03e0b821 	move	s7,ra
 7c0:	149600ed 	bne	a0,s6,b78 <error>
 7c4:	00000000 	nop
 7c8:	00a41025 	or	v0,a1,a0
 7cc:	02166025 	or	t4,s0,s6
 7d0:	144c00e9 	bne	v0,t4,b78 <error>
 7d4:	00000000 	nop
 7d8:	30420003 	andi	v0,v0,0x3
 7dc:	149600e6 	bne	a0,s6,b78 <error>
 7e0:	318c0003 	andi	t4,t4,0x3
 7e4:	00805021 	move	t2,a0
 7e8:	144c00e3 	bne	v0,t4,b78 <error>
 7ec:	02c0c021 	move	t8,s6
 7f0:	14400087 	bnez	v0,a10 <memcpy_0xa4>
 7f4:	00000000 	nop
 7f8:	14cf00df 	bne	a2,t7,b78 <error>
 7fc:	00000000 	nop
 800:	00064102 	srl	t0,a2,0x4
 804:	14b000dc 	bne	a1,s0,b78 <error>
 808:	000f8902 	srl	s1,t7,0x4
 80c:	00a04821 	move	t1,a1
 810:	14cf00d9 	bne	a2,t7,b78 <error>
 814:	02009821 	move	s3,s0
 818:	30c6000f 	andi	a2,a2,0xf
 81c:	149600d6 	bne	a0,s6,b78 <error>
 820:	31ef000f 	andi	t7,t7,0xf
 824:	00803821 	move	a3,a0
 828:	151100d3 	bne	t0,s1,b78 <error>
 82c:	02c0a021 	move	s4,s6
 830:	11000032 	beqz	t0,8fc <memcpy_0x54>
 834:	00000000 	nop

00000838 <memcpy_0x24>:
 838:	153300cf 	bne	t1,s3,b78 <error>
 83c:	00000000 	nop
 840:	8d220000 	lw	v0,0(t1)
 844:	8e6c0000 	lw	t4,0(s3)
 848:	153300cb 	bne	t1,s3,b78 <error>
 84c:	00000000 	nop
 850:	8d230004 	lw	v1,4(t1)
 854:	8e6d0004 	lw	t5,4(s3)
 858:	153300c7 	bne	t1,s3,b78 <error>
 85c:	00000000 	nop
 860:	8d240008 	lw	a0,8(t1)
 864:	8e760008 	lw	s6,8(s3)
 868:	153300c3 	bne	t1,s3,b78 <error>
 86c:	00000000 	nop
 870:	8d25000c 	lw	a1,12(t1)
 874:	8e70000c 	lw	s0,12(s3)
 878:	151100bf 	bne	t0,s1,b78 <error>
 87c:	00000000 	nop
 880:	2508ffff 	addiu	t0,t0,-1
 884:	144c00bc 	bne	v0,t4,b78 <error>
 888:	2631ffff 	addiu	s1,s1,-1
 88c:	14f400ba 	bne	a3,s4,b78 <error>
 890:	00000000 	nop
 894:	ace20000 	sw	v0,0(a3)
 898:	146d00b7 	bne	v1,t5,b78 <error>
 89c:	ae8c0000 	sw	t4,0(s4)
 8a0:	14f400b5 	bne	a3,s4,b78 <error>
 8a4:	00000000 	nop
 8a8:	ace30004 	sw	v1,4(a3)
 8ac:	149600b2 	bne	a0,s6,b78 <error>
 8b0:	ae8d0004 	sw	t5,4(s4)
 8b4:	14f400b0 	bne	a3,s4,b78 <error>
 8b8:	00000000 	nop
 8bc:	ace40008 	sw	a0,8(a3)
 8c0:	14b000ad 	bne	a1,s0,b78 <error>
 8c4:	ae960008 	sw	s6,8(s4)
 8c8:	14f400ab 	bne	a3,s4,b78 <error>
 8cc:	00000000 	nop
 8d0:	ace5000c 	sw	a1,12(a3)
 8d4:	153300a8 	bne	t1,s3,b78 <error>
 8d8:	ae90000c 	sw	s0,12(s4)
 8dc:	25290010 	addiu	t1,t1,16
 8e0:	14f400a5 	bne	a3,s4,b78 <error>
 8e4:	26730010 	addiu	s3,s3,16
 8e8:	24e70010 	addiu	a3,a3,16
 8ec:	151100a2 	bne	t0,s1,b78 <error>
 8f0:	26940010 	addiu	s4,s4,16
 8f4:	1500ffd0 	bnez	t0,838 <memcpy_0x24>
 8f8:	00000000 	nop

000008fc <memcpy_0x54>:
 8fc:	14cf009e 	bne	a2,t7,b78 <error>
 900:	00000000 	nop
 904:	00064082 	srl	t0,a2,0x2
 908:	14cf009b 	bne	a2,t7,b78 <error>
 90c:	000f8882 	srl	s1,t7,0x2
 910:	30c60003 	andi	a2,a2,0x3
 914:	15110098 	bne	t0,s1,b78 <error>
 918:	31ef0003 	andi	t7,t7,0x3
 91c:	11000017 	beqz	t0,97c <memcpy_0x78>
 920:	00000000 	nop

00000924 <memcpy_0x60>:
 924:	15330094 	bne	t1,s3,b78 <error>
 928:	00000000 	nop
 92c:	8d220000 	lw	v0,0(t1)
 930:	8e6c0000 	lw	t4,0(s3)
 934:	15110090 	bne	t0,s1,b78 <error>
 938:	00000000 	nop
 93c:	2508ffff 	addiu	t0,t0,-1
 940:	144c008d 	bne	v0,t4,b78 <error>
 944:	2631ffff 	addiu	s1,s1,-1
 948:	14f4008b 	bne	a3,s4,b78 <error>
 94c:	00000000 	nop
 950:	ace20000 	sw	v0,0(a3)
 954:	15330088 	bne	t1,s3,b78 <error>
 958:	ae8c0000 	sw	t4,0(s4)
 95c:	25290004 	addiu	t1,t1,4
 960:	14f40085 	bne	a3,s4,b78 <error>
 964:	26730004 	addiu	s3,s3,4
 968:	24e70004 	addiu	a3,a3,4
 96c:	15110082 	bne	t0,s1,b78 <error>
 970:	26940004 	addiu	s4,s4,4
 974:	1500ffeb 	bnez	t0,924 <memcpy_0x60>
 978:	00000000 	nop

0000097c <memcpy_0x78>:
 97c:	14f4007e 	bne	a3,s4,b78 <error>
 980:	00000000 	nop
 984:	00e01821 	move	v1,a3
 988:	1533007b 	bne	t1,s3,b78 <error>
 98c:	02806821 	move	t5,s4
 990:	01202821 	move	a1,t1
 994:	14cf0078 	bne	a2,t7,b78 <error>
 998:	02608021 	move	s0,s3
 99c:	18c00017 	blez	a2,9fc <memcpy_0x9c>
 9a0:	00000000 	nop

000009a4 <memcpy_0x84>:
 9a4:	14b00074 	bne	a1,s0,b78 <error>
 9a8:	00000000 	nop
 9ac:	90a20000 	lbu	v0,0(a1)
 9b0:	920c0000 	lbu	t4,0(s0)
 9b4:	14cf0070 	bne	a2,t7,b78 <error>
 9b8:	00000000 	nop
 9bc:	24c6ffff 	addiu	a2,a2,-1
 9c0:	144c006d 	bne	v0,t4,b78 <error>
 9c4:	25efffff 	addiu	t7,t7,-1
 9c8:	146d006b 	bne	v1,t5,b78 <error>
 9cc:	00000000 	nop
 9d0:	a0620000 	sb	v0,0(v1)
 9d4:	14b00068 	bne	a1,s0,b78 <error>
 9d8:	a1ac0000 	sb	t4,0(t5)
 9dc:	24a50001 	addiu	a1,a1,1
 9e0:	146d0065 	bne	v1,t5,b78 <error>
 9e4:	26100001 	addiu	s0,s0,1
 9e8:	24630001 	addiu	v1,v1,1
 9ec:	14cf0062 	bne	a2,t7,b78 <error>
 9f0:	25ad0001 	addiu	t5,t5,1
 9f4:	1cc0ffeb 	bgtz	a2,9a4 <memcpy_0x84>
 9f8:	00000000 	nop

000009fc <memcpy_0x9c>:
 9fc:	1558005e 	bne	t2,t8,b78 <error>
 a00:	00000000 	nop
 a04:	01401021 	move	v0,t2
 a08:	03e00008 	jr	ra
 a0c:	03006021 	move	t4,t8

00000a10 <memcpy_0xa4>:
 a10:	14960059 	bne	a0,s6,b78 <error>
 a14:	00000000 	nop
 a18:	00801821 	move	v1,a0
 a1c:	14cf0056 	bne	a2,t7,b78 <error>
 a20:	02c06821 	move	t5,s6
 a24:	00c01021 	move	v0,a2
 a28:	14cf0053 	bne	a2,t7,b78 <error>
 a2c:	01e06021 	move	t4,t7
 a30:	04c0004c 	bltz	a2,b64 <memcpy_0x10c>
 a34:	00000000 	nop

00000a38 <memcpy_0xb0>:
 a38:	144c004f 	bne	v0,t4,b78 <error>
 a3c:	00000000 	nop
 a40:	00024083 	sra	t0,v0,0x2
 a44:	000c8883 	sra	s1,t4,0x2
 a48:	1511004b 	bne	t0,s1,b78 <error>
 a4c:	00000000 	nop
 a50:	00081080 	sll	v0,t0,0x2
 a54:	14cf0048 	bne	a2,t7,b78 <error>
 a58:	00116080 	sll	t4,s1,0x2
 a5c:	144c0046 	bne	v0,t4,b78 <error>
 a60:	00000000 	nop
 a64:	00c23023 	subu	a2,a2,v0
 a68:	15110043 	bne	t0,s1,b78 <error>
 a6c:	01ec7823 	subu	t7,t7,t4
 a70:	11000020 	beqz	t0,af4 <memcpy_0xe4>
 a74:	00000000 	nop

00000a78 <memcpy_0xc0>:
 a78:	1511003f 	bne	t0,s1,b78 <error>
 a7c:	00000000 	nop
 a80:	2508ffff 	addiu	t0,t0,-1
 a84:	14b0003c 	bne	a1,s0,b78 <error>
 a88:	2631ffff 	addiu	s1,s1,-1
 a8c:	88a20000 	lwl	v0,0(a1)
 a90:	8a0c0000 	lwl	t4,0(s0)
 a94:	14b00038 	bne	a1,s0,b78 <error>
 a98:	00000000 	nop
 a9c:	98a20003 	lwr	v0,3(a1)
 aa0:	9a0c0003 	lwr	t4,3(s0)
 aa4:	14b00034 	bne	a1,s0,b78 <error>
 aa8:	00000000 	nop
 aac:	24a50004 	addiu	a1,a1,4
 ab0:	144c0031 	bne	v0,t4,b78 <error>
 ab4:	26100004 	addiu	s0,s0,4
 ab8:	146d002f 	bne	v1,t5,b78 <error>
 abc:	00000000 	nop
 ac0:	a8620000 	swl	v0,0(v1)
 ac4:	144c002c 	bne	v0,t4,b78 <error>
 ac8:	a9ac0000 	swl	t4,0(t5)
 acc:	146d002a 	bne	v1,t5,b78 <error>
 ad0:	00000000 	nop
 ad4:	b8620003 	swr	v0,3(v1)
 ad8:	146d0027 	bne	v1,t5,b78 <error>
 adc:	b9ac0003 	swr	t4,3(t5)
 ae0:	24630004 	addiu	v1,v1,4
 ae4:	15110024 	bne	t0,s1,b78 <error>
 ae8:	25ad0004 	addiu	t5,t5,4
 aec:	1500ffe2 	bnez	t0,a78 <memcpy_0xc0>
 af0:	00000000 	nop

00000af4 <memcpy_0xe4>:
 af4:	14cf0020 	bne	a2,t7,b78 <error>
 af8:	00000000 	nop
 afc:	18c0ffbf 	blez	a2,9fc <memcpy_0x9c>
 b00:	00000000 	nop

00000b04 <memcpy_0xec>:
 b04:	14b0001c 	bne	a1,s0,b78 <error>
 b08:	00000000 	nop
 b0c:	90a20000 	lbu	v0,0(a1)
 b10:	920c0000 	lbu	t4,0(s0)
 b14:	14cf0018 	bne	a2,t7,b78 <error>
 b18:	00000000 	nop
 b1c:	24c6ffff 	addiu	a2,a2,-1
 b20:	144c0015 	bne	v0,t4,b78 <error>
 b24:	25efffff 	addiu	t7,t7,-1
 b28:	146d0013 	bne	v1,t5,b78 <error>
 b2c:	00000000 	nop
 b30:	a0620000 	sb	v0,0(v1)
 b34:	14b00010 	bne	a1,s0,b78 <error>
 b38:	a1ac0000 	sb	t4,0(t5)
 b3c:	24a50001 	addiu	a1,a1,1
 b40:	146d000d 	bne	v1,t5,b78 <error>
 b44:	26100001 	addiu	s0,s0,1
 b48:	24630001 	addiu	v1,v1,1
 b4c:	14cf000a 	bne	a2,t7,b78 <error>
 b50:	25ad0001 	addiu	t5,t5,1
 b54:	1cc0ffeb 	bgtz	a2,b04 <memcpy_0xec>
 b58:	00000000 	nop
 b5c:	0800027f 	j	9fc <memcpy_0x9c>
 b60:	00000000 	nop

00000b64 <memcpy_0x10c>:
 b64:	14cf0004 	bne	a2,t7,b78 <error>
 b68:	00000000 	nop
 b6c:	24c20003 	addiu	v0,a2,3
 b70:	0800028e 	j	a38 <memcpy_0xb0>
 b74:	25ec0003 	addiu	t4,t7,3

00000b78 <error>:
 b78:	080002de 	j	b78 <error>
 b7c:	240b0001 	li	t3,1

00000b80 <open>:
 b80:	24030040 	li	v1,64
 b84:	00600008 	jr	v1
 b88:	00000000 	nop

00000b8c <creat>:
 b8c:	24030044 	li	v1,68
 b90:	00600008 	jr	v1
 b94:	00000000 	nop

00000b98 <close>:
 b98:	24030048 	li	v1,72
 b9c:	00600008 	jr	v1
 ba0:	00000000 	nop

00000ba4 <read>:
 ba4:	2403004c 	li	v1,76
 ba8:	00600008 	jr	v1
 bac:	00000000 	nop

00000bb0 <write>:
 bb0:	24030050 	li	v1,80
 bb4:	00600008 	jr	v1
 bb8:	00000000 	nop

00000bbc <isatty>:
 bbc:	24030054 	li	v1,84
 bc0:	00600008 	jr	v1
 bc4:	00000000 	nop

00000bc8 <sbrk>:
 bc8:	24030058 	li	v1,88
 bcc:	00600008 	jr	v1
 bd0:	00000000 	nop

00000bd4 <lseek>:
 bd4:	2403005c 	li	v1,92
 bd8:	00600008 	jr	v1
 bdc:	00000000 	nop

00000be0 <fstat>:
 be0:	24030060 	li	v1,96
 be4:	00600008 	jr	v1
 be8:	00000000 	nop

00000bec <_exit>:
 bec:	24030064 	li	v1,100
 bf0:	00600008 	jr	v1
 bf4:	00000000 	nop

00000bf8 <times>:
 bf8:	24030068 	li	v1,104
 bfc:	00600008 	jr	v1
 c00:	00000000 	nop

00000c04 <time>:
 c04:	2403006c 	li	v1,108
 c08:	00600008 	jr	v1
 c0c:	00000000 	nop

00000c10 <random>:
 c10:	24030070 	li	v1,112
 c14:	00600008 	jr	v1
 c18:	00000000 	nop
Disassembly of section .rodata:

00000c34 <.rodata>:
 c34:	0000000b 	0xb
 c38:	0000000c 	syscall
 c3c:	0000000d 	break
 c40:	00000015 	0x15
 c44:	00000016 	0x16
 c48:	00000017 	0x17
 c4c:	0000001f 	0x1f
 c50:	00000020 	add	zero,zero,zero
 c54:	00000021 	move	zero,zero
 c58:	0000001c 	0x1c
 c5c:	0000001b 	divu	zero,zero,zero
 c60:	0000001a 	div	zero,zero,zero
 c64:	00000012 	mflo	zero
 c68:	00000011 	mthi	zero
 c6c:	00000010 	mfhi	zero
 c70:	00000008 	jr	zero
 c74:	00000007 	srav	zero,zero,zero
 c78:	00000006 	srlv	zero,zero,zero
Disassembly of section .data:
