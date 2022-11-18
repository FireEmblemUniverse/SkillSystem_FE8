.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb

	.global LevelDamageReduction
	.type   LevelDamageReduction, function

LevelDamageReduction:
push {r4-r7,lr}
@goes in the battle loop.
@r0/r4 is the attacker battle struct 
@r1/r5 is the defender battle struct 
mov r4, r0
mov r5, r1

mov r7, #0 @ default 
bl GetDifficulty 
ldrb r1, [r4, #0x0B] @ deployment byte 
lsr r1, #7 

cmp r0, #0 
beq Easy 
cmp r0, #1 
beq Difficult 
cmp r0, #2 
beq Lunatic 
b Exit 

Easy: 
cmp r1, #0 
beq Exit @ players / npcs attacking an enemy get no damage reduction on easy 
mov r7, #0 @ enemies attacking players on easy get Level% damage reduction 
b CalcDamageReduction 

Difficult: 
mov r7, #1 @ players and enemies on difficult get (Level% / 2) damage reduction 
b CalcDamageReduction 

Lunatic: 
cmp r1, #0 
beq CalcDamageReduction @ players attacking enemies get Level% dmg reduction 
mov r7, #2 @ enemies attacking players get (Level%/4) damage reduction 
b CalcDamageReduction 


CalcDamageReduction: 
mov r3, #0x5A @ att 
ldsh r0, [r4, r3] 
mov r2, #0x5C 
ldsh r1, [r5, r2] @ def 
sub r0, r1 
cmp r0, #0 
blt Exit @ they will deal min damage twice 
mov r6, r0 @ dmg 
ldrb r1, [r5, #8] @ level 
cmp r1, #50 
blt NoCapLevel 
mov r1, #50 
NoCapLevel: 
mul r0, r1 
mov r1, #100 
swi 6 
lsr r0, r7 @ half of level% as dmg% reduction eg. lvl 50 = 25% dmg reduction ? 
sub r6, r0 

mov r2, #0x5C 
ldsh r1, [r5, r2] @ def 
cmp r1, #0 
bge NoCap 
mov r1, #0 
NoCap: 
add r6, r1 @ add back def again 
mov r3, #0x5A @ att 
strh r6, [r4, r3] 


Exit: 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 










