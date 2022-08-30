.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ d100Result, 0x802a52c
@ r0 is attacker, r1 is defender, r2 is current buffer, r3 is battle data
.type ExplosionEffect, %function 
.global ExplosionEffect 
ExplosionEffect:
push {r4-r7,lr}
mov r4, r0 @attacker
mov r5, r1 @defender
mov r6, r2 @battle buffer
mov r7, r3 @battle data


mov r0, #0x48 
add r0, r4 @ wep 
ldrb r0, [r0] @ wep ID only 
ldr r1, =Explosion 
lsl r1, #24 
lsr r1, #24 
cmp r0, r1 
bne Exit



ldr     r0,[r6]           @r0 = battle buffer                @ 0802B40A 6800     
lsl     r0,r0,#0xD                @ 0802B40C 0340     
lsr     r0,r0,#0xD        @Without damage data                @ 0802B40E 0B40    

mov r1, #0x86 @devil flag OR miss OR injured self already
tst r0, r1
beq Continue 
@mov r0, #0 
@strb r0, [r4, #0x13] @ post-battle hp to have 
b Exit 

Continue: @ @if another skill already activated, don't do anything

@set the hp update flag
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0, #0x1
lsl     r0, #8           
add r0, #0x4		@0x100, hp drain/update, 0x04 injured self already
orr     r1, r0

@and unset the crit flag
mov r0, #1
orr r1, r0 @ always crit 

ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018   


mov r0, #4
ldrsh r1, [r7, r0]
lsl r2, r1, #1 @ 2x 
add r1, r2 
lsr r1, #1 @ 1.5x damage always 
strh r1, [r7, #4] 
@sub r1, #1 
@mov r1, #9 

ldrb r1, [r4, #0x13] 
mov r0, #0
sub r0, r1 @if dealt dmg is lower than taken dmg, the battle animation
		@will show the wrong amount of health  
strb r0, [r6, #5] @set current hp change

mov r0, #0 
ldrb r0, [r4, #0x13] 
sub r0, r1 

mov r0, #0 
strb r0, [r4, #0x13] @ post-battle hp to have 

Exit: 

pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 






