.thumb 
.global prCallSequence
.type prCallSequence, %function 
prCallSequence: 
PUSH {r4-r7,lr}  
MOV r4 ,r1
MOV r5 ,r2
MOV r6 ,r3
MOV r7, PC
add r7, #1 
LDMIA r6,{r3}
CMP r3, #0x0
BEQ End
MOV r1, #0x1
ORR r3 ,r1
MOV r1 ,r4
MOV r2 ,r5
MOV LR, r7
bx r3 
End: 
POP {r4-r7}
POP {r1}
BX r1
.ltorg 

















