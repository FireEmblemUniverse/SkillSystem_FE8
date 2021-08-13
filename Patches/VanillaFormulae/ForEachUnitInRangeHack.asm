@ hook with r1 at 8024EE4 
@ Necessary\ItemRangeFix\ItemTargeting is a place where this gets called 

@ Prevent targeting unit id 0xFA 
@ & Prevent targeting unit IDs below 0xA0 while capturing bit is set on the current unit 

.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ GetUnit, 0x8019431
	.equ CurrentUnit, 0x3004E50
	
.thumb 
.align 4 

.global ForEachUnitInRangeHack
.type ForEachUnitInRangeHack, %function 

ForEachUnitInRangeHack:
 
add r0, r5, r0 
ldr r0, [r0] 
add r1, r0, r4 
ldrb r0, [r1] 


cmp r0, #0 
beq Skip

push {r0} 
push {r2-r3} @ Just in case .. ? 
blh GetUnit @19431 
ldr r1, [r0] @ Unit poitner 
ldrb r1, [r1, #4] @ Char ID 
@mov r11, r11 
cmp r1, #0xFA 
beq OtherExit
ldr r1, =CurrentUnit 
ldr r3, [r1]
cmp r3, #0 
beq WeCanCaptureEnemiesBelowUnitID0xA0 

ldr r1, [r3, #0x0C] @ Current Unit State 

mov r2, #0x40 
lsl r2, #24 @ Capture bit 
@mvn r0, r0
and r2, r1  
cmp r2, #0 
beq WeAreNotCapturing 
ldr r1, [r0] 
ldrb r1, [r1, #4] 
cmp r1, #0xA0 
blt WeCanCaptureEnemiesBelowUnitID0xA0 
b OtherExit 


WeCanCaptureEnemiesBelowUnitID0xA0:
@ Check that they are adjacent ! 
@ r0 is target unit ram pointer, r3 is current unit ram pointer 
ldrb r1, [r3, #0x10] @ Coords 
ldrb r2, [r0, #0x10] @ Coords 
cmp r2, r1 
beq XWasEqual
ldrb r1, [r3, #0x11] @ Coords 
ldrb r2, [r0, #0x11] @ Coords 
cmp r2, r1 
bne OtherExit @ Neither X nor Y was equal, so ExitB 
YWasEqual:
ldrb r1, [r3, #0x10] @ Coords 
ldrb r2, [r0, #0x10] @ Coords 
b EitherCase

XWasEqual:
ldrb r1, [r3, #0x11] @ Coords 
ldrb r2, [r0, #0x11] @ Coords 


EitherCase:
sub r1, #1 @ 
cmp r1, r2 
beq AdjacentSoWeCanCapture
add r1, #2 
cmp r1, r2 
beq AdjacentSoWeCanCapture
b OtherExit @ 

AdjacentSoWeCanCapture:
WeAreNotCapturing: 



pop {r2-r3}
pop {r0}
@ r0 should be their deployment ID eg. unit ram + 0x0B 

Skip:
ldr r1, =0x8024EED @ Return address 
bx r1 


OtherExit:
pop {r2-r3}
pop {r0}

mov r0, #0 
b Skip 

