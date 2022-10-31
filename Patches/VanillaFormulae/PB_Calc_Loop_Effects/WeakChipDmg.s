.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb

	.global WeakChipDmg
	.type   WeakChipDmg, function

WeakChipDmg:
push {r4-r6,lr}
@goes in the battle loop.
@r0/r4 is the attacker battle struct 
@r1/r5 is the defender battle struct 
mov r4, r0
mov r5, r1



@check attacker weapon's item ID
mov r2, #0 @ First time through loop 
mov r0,r4
add r0,#0x48
ldrh r0,[r0]
mov r1,#0xFF
and r0,r1 @r0 = item ID
cmp r0, #0 
beq GoBack 
@load list of fixed damage weapon item IDs
ldr r3,=ChipDamageWeaponList

LoopStart:
ldrb r1,[r3]
cmp r1,#0
beq GoBack
cmp r1,r0
beq LoopEnd
add r3,#1
b LoopStart
LoopEnd:



mov r1, #0x14 @ Str 
ldrb r0, [r4, r1] 
mov r1, #0x3A 
ldrb r1, [r4, r1] @ Mag 
cmp r0, r1  
bgt StrHigher 
@ Mag was higher
mov r0, r1  

StrHigher:



@r0 has Str or Mag 

add r0, #7 @ ceiling up 
lsr r0, #3 @ 1/8 

ldrb r1, [r4, #0x17] @ def 
ldrb r2, [r4, #0x18] @ res 
add r1, #7 @ round 
lsr r1, #3 @ 1/8 
add r2, #7 @ round 
lsr r2, #3 @ 1/8 


add r0, r1 
add r0, r2 
ldrb r1, [r5, #0x12] @ max hp 
add r1, #15 
lsr r1, #4 @ 1/16 hp 
@ 1/8 str + 1/8 def + 1/8 res + 1/16 enemy max hp 

ldrb r1, [r5, #0x18] @ Res 
lsr r1, #1 @ 1/2 res 

mov r3, #0x5C @ battle def 
ldsh r2, [r5, r3] 
cmp r2, #0 
bge NoCap
mov r2, #0 
NoCap:
cmp r2, r1 
blt NoCombination

@ if battle def > (1/2 res) 
@ battle def - (1/2 res) 
@ add this # to dmg 
sub r2, r1 
@add r2, #1 @ ceiling 
@lsr r2, #1 @ average of def+res 
add r0, r2 @ add to dmg we will deal 

NoCombination:
add r0, #1 
cmp r0, #128
blt DontCap
mov r0, #127 @ Max dmg 

DontCap:

mov r1, #0x5A 
strh r0, [r4, r1]	@ store back in 



GoBack:
pop {r4-r6}
pop {r0}
bx r0

.align


