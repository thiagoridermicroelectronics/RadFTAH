#   compute the integer squareroot
#   of the positive value in $a0

main:   lui     $sp,0x7fff
        ori     $sp,$sp,0xfffc
        addiu   $a0,$0,144
        jal     sqrt
*done:  beq     $0,$0,done

array:  .asciiz "abcdef"

sqrt:   add     $t0,$0,$0       # zero result
        addi    $t1,$0,1        # $t1 = successive odd integers
loop:   slt     $t2,$a0,$t1     # value > next odd?
        bne     $0,$t2,return
        subu    $a0,$a0,$t1
        addi    $t0,$t0,1       # increment result
        addi    $t1,$t1,2       # next odd
        beq     $0,$0,loop
return: add     $v0,$t0,$0      # move result
        jr      $ra             # returnt2, 0($gp)       # i = ...
