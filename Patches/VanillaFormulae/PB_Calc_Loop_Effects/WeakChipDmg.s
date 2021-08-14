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
push {r4-r5,lr}
@goes in the battle loop.
@r0/r4 is the attacker battle struct 
@r1/r5 is the defender battle struct 
mov r4, r0
mov r5, r1

@check attacker weapon's item ID
mov r2, #0 @ First time through loop 
mov r0,r4
add r0,#0x4A
ldrh r0,[r0]
mov r1,#0xFF
and r0,r1 @r0 = item ID

@load list of fixed damage weapon item IDs
ldr r3,=ChipDamageWeaponList

LoopStart:
ldrb r1,[r3]
cmp r1,#0
beq CheckDefender
cmp r1,r0
beq LoopEnd
add r3,#1
b LoopStart

CheckDefender:
cmp r2, #0 
bne GoBack 
mov r2, #1 @ Second time through loop 
mov r0,r5
add r0,#0x4A
ldrh r0,[r0]
mov r1,#0xFF
and r0,r1 @r0 = item ID
b LoopStart 

LoopEnd:
cmp r2, #0 
beq AttackerInR3
mov r3, r5 @ Defender
b CheckHigherStrOrMag
AttackerInR3:
mov r3, r4 @ Attacker 

CheckHigherStrOrMag:

mov r1, #0x14 @ Str 
ldrb r0, [r3, r1] 
mov r1, #0x3A 
ldrb r1, [r3, r1] @ Mag 
cmp r0, r1  
bgt StrHigher 
@ Mag was higher
mov r0, r1  

StrHigher:

@mov r11, r11 

@r0 has Str or Mag 
add r2, r0, #7 @ Ceiling up 
lsr r2, #3 @ 1/8th 
@add r0, #1 @ Ceiling up 
lsr r0, #1 @ 1/2 
add r0, r2 @ 5/8ths 

 
@add r0, #3 @ For rounding 
@lsr r0, #2 @ 1/4 of Str or Mag 


@ preview shows up wrong 
@mov r1, #0x5C		
@ldrh r0, [r5, r1] 	
@add r0, #1 @ nice rounding 
@lsr r0, #1 @ Halve enemy defense/res 

@mov r1, #0x5A 
@ldrh r2, [r4, r1]
@add r0, r2  



cmp r0, #128
blt DontCap
mov r0, #127 @ Max dmg 

DontCap:
mov r1, #0x5A 
strh r0, [r3, r1]	@ store back in 

GoBack:
pop {r4-r5}
pop {r0}
bx r0

.align


