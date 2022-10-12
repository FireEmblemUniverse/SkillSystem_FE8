.thumb
.global ImmuneToDamage
.type ImmuneToDamage, %function
ImmuneToDamage:

push {r4-r6,r14}

mov r4,r0 @attacker
mov r5,r1 @defender
mov r6, #0 

Start: 
ldr r3, [r4, #4] @ class pointer 
ldrb r3, [r3, #4] @ class id 

ldr r0, =SableyeID 
lsl r0, #24 
lsr r0, #24 
cmp r0, r3 
beq Immune 
ldr r0, =ShedinjaID 
lsl r0, #24 
lsr r0, #24 
cmp r0, r3 
bne NotImmune 
Immune: 
mov r0, #0 
mov r1, r5 
add r1, #0x5A
strh r0, [r1] 

NotImmune: 
add r6, #1 
mov r3, r4 @ atkr 
mov r4, r5 @ dfdr 
mov r5, r3 @ atkr 
cmp r6, #1 
beq Start @ try dfdr 

pop {r4-r6} 
pop {r0} 
bx r0 
.ltorg 










