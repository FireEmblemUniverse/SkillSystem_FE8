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
push {r4-r7,lr}
@goes in the battle loop.
@r0/r4 is the attacker battle struct 
@r1/r5 is the defender battle struct 
mov r4, r0
mov r5, r1


@check attacker weapon's item ID
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
beq GoBack
cmp r1,r0
beq LoopEnd
add r3,#1
b LoopStart

LoopEnd: @now we find the might of the weapon whose ID is in r0
@mov r1,#0x24
@mul r0,r1
@ldr r1,=ItemTable
@add r1,r0
@ldrb r0,[r1,#0x15] @r0 = item might

mov r1, #0x14 @ Str 
ldrb r0, [r4, r1] 
mov r1, #0x3A 
ldrb r1, [r4, r1] @ Mag 
cmp r0, r1  
bgt StrHigher 
mov r0, r1 @ Mag was higher 

StrHigher:
mov r1, #0x5A @ Battle attack 
add r0, #3 @ For rounding 
lsr r0, #2 @ 1/4 of Str or Mag 
strh r0, [r4, r1] 

mov r1, #0x5C		
ldrh r0, [r5, r1] 	
lsr r0, #1 @ Halve enemy defense/res 
add r0, #1 @ nice rounding 
mov r1, #0x5A 
ldrh r2, [r4, r1]
add r0, r2  
cmp r0, #128
blt DontCap
mov r0, #127 @ Max dmg 

DontCap:
strh r0, [r4, r1]	@ store back in 

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.align


