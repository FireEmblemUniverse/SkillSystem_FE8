
.thumb
.align 4

.equ MemorySlot,0x30004B8


.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


	.equ NewFlagsRam, 0x203F548
	.equ GetUnit, 0x8019430
	.equ EventEngine, 0x800D07C

.global TrainerDeathFlags
.type TrainerDeathFlags, %function
TrainerDeathFlags:
push {lr}

mov r11, r11 
ldr r1, [r2] @ Char pointer 
ldrb r1, [r1, #4] @ Unit ID 
cmp r1, #0xD0 
blt End 
sub r1, #0xD0 


ldr r3, =0x202BCF0 @ Chapter Data 
ldrb r0, [r3, #0x0E] @ +0x0E	Byte	Chapter ID
lsl r0, #4 @ 16 trainers per area allowed 

add r0, r1 @ which trainer exactly 


ldrb r3, =TrainerDefeatedFlagOffset @0xA0 
lsl r1, r3, #3 @ 8 flags per byte so +0x500 
add r0, r1 @ Full offset 
@ some ram address + 0x500 + ChapterID*8 + unit id over 0xD0 
blh SetNewFlag 

End:

pop {r0}
bx r0 


.global RemoveFoughtTrainers
.type RemoveFoughtTrainers, %function

RemoveFoughtTrainers:
@ Check if currently examindd unit's commander is the trainer 
@ Check if currently examined unit is the trainer 
@ If either is true, delete the unit 
push {r4-r7, lr}

ldr r0, =MemorySlot 
mov r4, #0x80 

LoopThroughUnits:
mov r0,r4

blh GetUnit @ 19430
cmp r0,#0
beq NextUnit
ldr r3,[r0] @ Char table pointer 
cmp r3,#0
beq NextUnit


ldrb r1, [r3, #4] @ Unit ID 
@ Their unit ID ranges from 0xD0 to 0xDF, so they are a trainer 
cmp r1, #0xD0 
blt CheckLeaderNow
cmp r1, #0xDF 
ble ValidUnit

CheckLeaderNow:
mov r2, #0x38 @ Leader unit ID 
ldrb r1, [r0, r2]

@ r1 is 
@ Their leader's ID ranges from 0xD0 to 0xDF, so they are a trainer 
cmp r1, #0xD0 
blt NextUnit 
cmp r1, #0xDF 
bgt NextUnit 

ValidUnit:
@mov r11, r11 
mov r5, r0 
mov r6, r1 @ Unit ID we're interested in 

sub r1, #0xD0 @ Unit ID offset 

ldr r3, =0x202BCF0 @ Chapter Data 
ldrb r0, [r3, #0x0E] @ +0x0E	Byte	Chapter ID
lsl r0, #4 @ 16 trainers per area allowed 

add r0, r1 @ which trainer exactly 


ldrb r3, =TrainerDefeatedFlagOffset @0xA0 
lsl r1, r3, #3 @ 8 flags per byte so +0x500 
add r0, r1 @ Full offset 

blh CheckNewFlag
@mov r11, r11 
cmp r0, #1 
@if completion flag is true, then we do not spawn this trap :-) 
bne NextUnit 


mov r0, r5 
blh 0x80177f4 @ClearUnit





NextUnit:
add r4,#1
cmp r4,#0xAF
ble LoopThroughUnits
End_LoopThroughUnits:


pop {r4-r7}
pop {r1}
bx r1 


