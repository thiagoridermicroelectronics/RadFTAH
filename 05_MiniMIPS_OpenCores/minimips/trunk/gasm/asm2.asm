main add $1,$1,$2
     add $2,$0,$3
     add $3,$3,$3
     add $3,$0,$4

loop beq $3,$0,done #here’s the loop
     sub $3,$1,$3
     j loop

done sw $2,0($0)
     lw $a,-2($4)
