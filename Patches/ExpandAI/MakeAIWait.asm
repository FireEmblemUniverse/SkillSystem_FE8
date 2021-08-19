.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ MemorySlot,0x30004B8
	.equ CurrentUnit, 0x3004E50
	
.global MakeAIWait
.type MakeAIWait, %function 
MakeAIWait: 
push {r4, lr} 

sub sp, #0xC 
ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldrb r0, [r3, #0x10] @ X
ldrb r1, [r3, #0x11] @ Y 
@mov r2, #0 @ Action: noop @ when they move to a coord, it had 0 here (but runs the range event in some other way I guess) 
mov r11, r11 
@ #0x00 - noop (does not trigger range events) 
@ #0x01 - attacks target? but since I have no target it just crashes the game 
@ #0x02 - moved two tiles to the left 
@ #0x03 - gold was stolen 
@ #0x04 - the village was destroyed 
@ #0x05 - wait, I guess? it ran the range event, which is good enough for me

mov r2, #0x05 
mov r3, #0 @ store into item slot / X / Y coord 
str r3, [sp, #0] @ Item slot 
str r3, [sp, #4] @ X Coord2 (0 is fine) 
str r3, [sp, #8] @ Y Coord2 (0 is fine)
mov r3, #0 @ Target 
blh 0x8039C21, r4 @ AiSetDecision
add sp, #0xC 
@ mov r11, r11 
@ breaks once per enemy with this AI, so perfect 
@ but doesn't actually 'wait' at the spot, so it doesn't trigger range events.. 
@ so we manually trigger them now 
@ but first, let's put the active unit's coord into sB and their unit id in s2 
ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldr r2, =MemorySlot 
ldrb r1, [r3, #0x10] 
ldrb r0, [r3, #0x11] 
lsl r0, #16 
add r0, r1 
str r0, [r2, #0x0B*4] @ ----YY--XX coord in sB 
ldr r1, [r3] 
ldrb r1, [r1, #4] @ Unit ID 
str r1, [r2, #0x02*4] @ ------ID in s2 


@ Tried invoking the EventEngine and it didn't work
@ so it's running this 3x then running the event 3x 
@ when it runs the event 3x, the current unit is the same for all 3 hmm 
@ldrb r0, [r3, #0x10] @ X 
@ldrb r1, [r3, #0x11] @ Y 
@bl RunMiscBasedEvents - this was from Sme's FreeMovement hack. 
@ Since it didn't work correctly in this context, it is no longer included below 
@ldr r0, =DoNothingEvent 
@mov r1, #1 
@blh EventEngine 


mov r0, #1 
pop {r4}
pop {r1} 
bx r1 

