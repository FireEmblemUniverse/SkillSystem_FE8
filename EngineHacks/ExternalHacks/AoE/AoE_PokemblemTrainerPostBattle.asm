.thumb 

.global AoE_PokemblemTrainerPostBattle
.type AoE_PokemblemTrainerPostBattle, %function 
AoE_PokemblemTrainerPostBattle: 
push {r4-r5, lr} 

mov r4, r0 @ actor 
mov r5, r1 @ target 



ldr r3, =0x203A56C
ldrb r0, [r5, #0x13] @ hp 
cmp r0, #0 
bne Exit 
strb r0, [r3, #0x13] @ curr hp of defender. AoE is always the 'attacker' 

ldrb r1, [r5, #0x0B] @ deployment byte 
strb r1, [r3, #0x0B] 
lsr r1, #6
cmp r1, #0 
beq Exit 
ldr r3, =0x203A56C

mov r1, #0x38 @ leader 
ldrb r2, [r5, r1] 
strb r2, [r3, r1] @ copy into the defender for trainer death flags stuff 

bl IsTrainersTeamDefeated


Exit: 

pop {r4-r5} 
pop {r0} 
bx r0 
.ltorg 


