.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb

.equ Check_Effectiveness,  0x8016BEC

.global TypeEffectiveness
.type TypeEffectiveness, %function 
TypeEffectiveness:
push {r4-r7, lr}


mov r4, r0 @ Atkr 
mov r5, r1 @ dfdr 

mov r3, #0x48 @ 
ldrh r0, [r4, r3] @ Attacker's weapon 
mov r1, r5 @ dfdr 
blh Check_Effectiveness
mov r6, r0 
cmp r6, #0 
beq DoNothing 
mov r3, #0x5A @ att 
ldsh r0, [r4, r3] 
cmp r0, #0 
blt DoNothing @ if negative for some reason, do nothing 
mov r2, #0x5C 
ldsh r1, [r5, r2] @ def 
sub r0, r1 
cmp r0, #0 
blt DoNothing 

cmp r6, #9
beq DoNothing
cmp r6, #7
beq Ineffective
cmp r6, #2
beq Ineffective
cmp r6, #1
beq Immune
b SuperEffective

Immune:
lsr r0, #2 @ 1/4 dmg 
b Store

Ineffective:
lsr r0, #1 
b Store 

SuperEffective:
mov r3, #0x68 @ critical avoid 
ldsh r2, [r4, r3] 
cmp r2, #0 
bge NoCapCritAvo
mov r2, #0 
NoCapCritAvo:
lsl r2, #1 
add r2, #10 
strh r2, [r4, r3] @ 2x crit avoid + 10 while SE 

mov r3, #0x5A @ att 
ldsh r2, [r5, r3]  
cmp r2, #0 
bge NoCapEnemyAtt
mov r2, #0 
NoCapEnemyAtt:
add r2, #1 
lsr r1, r2, #1 @ Half att 
add r2, #2 
lsr r2, #2 @ 1/4 of att 
add r2, r1 @ 3/4 att with friendly rounding 
strh r2, [r5, r3] @ 3/4 att for enemy when using a SE move against them 
mov r3, #0x5c @ def
ldsh r2, [r5, r3]  
cmp r2, #0 
bge NoCapEnemyDef
mov r2, #0 
NoCapEnemyDef:
add r2, #1 
lsr r2, #2 @ 1/4 of enemy def added to att 
lsl r0, #1 
add r0, r2 
b Store 

Store: 
@ given r0 as att to store 
mov r3, #0x5A @ att 
mov r2, #0x5C 
ldsh r1, [r5, r2] @ def 
add r0, r1 @ add back def after 
strh r0, [r4, r3] @ 2x att 

DoNothing:




pop {r4-r7}
pop {r0}
bx r0 
.ltorg 
.align 







