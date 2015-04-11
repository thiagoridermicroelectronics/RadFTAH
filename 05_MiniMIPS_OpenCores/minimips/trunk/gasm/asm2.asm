MAIN: ADD $1,$1,$2
      ADD $2,$0,$3
      ADD $3,$3,$3
      ADD $3,$0,$4

LOOP: BEQ $3,$0,DONE
      SUB $3,$1,$3
      J LOOP

DONE: SW $2,0($0)
