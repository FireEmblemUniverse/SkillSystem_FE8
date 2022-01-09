.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ MemorySlot, 0x30004B8 
.global SelectTileHook
.type SelectTileHook, %function 

SelectTileHook:

push {r4-r5, lr}
mov r4, r0 
mov r5, r1 

mov r0, r6 @ parent proc?
bl SelectTileCalcLoop @ Returns T/F whether taking over or not 
cmp r0, #0 
bne SkipUnitMenu 

mov r0, r4 
mov r1, r5 
movs r2, #1
movs r3, #0x17
blh 0x0804EB98, r4   //NewMenu_DefaultAdjusted 
blh 0x80832CC @ bl to bx lr 

SkipUnitMenu:

pop {r4-r5}
pop {r3}
bx r3

.ltorg 
.align 

.type SelectTileCalcLoop, %function 

SelectTileCalcLoop:
push {r4-r7, lr}


@blh Call

ldr r4, =MemorySlot 
mov r5, #0x8
lsl r5, #24 @ |0x8------ 

ldr r0, =UnitGroupExample_A 
orr r0, r5 
blh 0x8017ac4 @LoadUnit

mov r0, #0x10
str r0, [r4, #4] @ Slot 1 

ldr r0, =UnitGroupExample_B 
orr r0, r5 
blh 0x8017ac4 @LoadUnit

mov r0, #0x11 
str r0, [r4, #2*4] @ Slot 2

ldr r0, =UnitGroupExample_C 
orr r0, r5 
blh 0x8017ac4 @LoadUnit

mov r0, #0x12 
str r0, [r4, #3*4] @ Slot 3 


ldr r0, =UnitGroupExample_D
orr r0, r5 
blh 0x8017ac4 @LoadUnit


mov r0, #0 
str r0, [r4, #4*0x4] @ s4 


mov r0, #0x13 
str r0, [r4, #4*5] @ s5 


ldr r0, =#2000 
lsl r0, #8 
lsr r0, #8 
str r0, [r4, #4*6]
mov r0, #0 
str r0, [r4, #4*7]
ldr r0, =98765 
lsl r0, #8 
lsr r0, #8 
str r0, [r4, #4*8]
mov r0, #0 
str r0, [r4, #4*9]
str r0, [r4, #4*10]

@blh SkillDebugCommand_OnSelect
blh SelectCharacter_ASMC
@blh CallCharacterSelector
@blh SkillDebugCommand_OnSelect



mov r0, #1 @ Taking over 

pop {r4-r7}
pop {r1} 
bx r1


.align 



