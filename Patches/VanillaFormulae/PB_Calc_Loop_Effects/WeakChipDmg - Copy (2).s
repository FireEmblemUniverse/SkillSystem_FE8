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

@load list of fixed damage weapon item IDs
ldr r3,=ChipDamageWeaponList

LoopStart:
ldrb r1,[r3]
cmp r1,#0
@beq CheckDefender
cmp r1,r0
beq LoopEnd
add r3,#1
b LoopStart

@CheckDefender:
@cmp r2, #0 
@bne GoBack 
@mov r2, #1 @ Second time through loop 
@mov r0,r5
@add r0,#0x48
@ldrh r0,[r0]
@mov r1,#0xFF
@and r0,r1 @r0 = item ID
@b LoopStart 
@
LoopEnd:
cmp r2, #0 
beq AttackerInR3
mov r6, r5 @ Defender
mov r5, r4 
mov r4, r6 
b CheckHigherStrOrMag
AttackerInR3:
mov r6, r4 @ Attacker 
CheckHigherStrOrMag:
@r6 as atkr or dfdr 


mov r1, #0x14 @ Str 
ldrb r0, [r6, r1] 
mov r1, #0x3A 
ldrb r1, [r6, r1] @ Mag 
cmp r0, r1  
bgt StrHigher 
@ Mag was higher
mov r0, r1  

StrHigher:



@r0 has Str or Mag 

add r0, #3 @ ceiling up 
lsr r0, #2 @ 1/4 

ldrb r1, [r6, #0x17] @ def 
ldrb r2, [r6, #0x18] @ res 
add r1, #3 @ round 
lsr r1, #3 @ 1/8 
add r2, #3 @ round 
lsr r2, #3 @ 1/8 


add r0, r1 
add r0, r2 
@ 1/4 str + 1/8 def + 1/8 res 
mov r11, r11 
ldrb r1, [r5, #0x18] @ Res 
mov r3, #0x5C @ battle def 
ldsh r2, [r5, r3] 
cmp r2, #0 
bge NoCap
mov r2, #0 
NoCap:
cmp r2, r1 
blt NoCombination
sub r2, r1 
add r2, #1 @ ceiling 
lsr r2, #1 @ average of def+res 
add r0, r2 @ add to dmg we will deal 

NoCombination:
cmp r0, #128
blt DontCap
mov r0, #127 @ Max dmg 

DontCap:
mov r1, #0x5A 
strh r0, [r6, r1]	@ store back in 



GoBack:
pop {r4-r6}
pop {r0}
bx r0

.align


