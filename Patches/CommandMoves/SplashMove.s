.thumb
.align 4

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ CurrentUnit, 0x3004E50
	.equ MemorySlot,0x30004B8
	.equ EventEngine, 0x800D07C
	
.global SplashCommandUsability 
.type SplashCommandUsability, %function 

SplashCommandUsability:
push {lr} 

ldr r0, =CurrentUnit 
ldr r0, [r0] 
ldr r1, =Splash 
lsl r1, #24 
lsr r1, #24 
bl MoveTester 

cmp r0, #0
beq RetFalse @ Full hp, so cannot heal self 
cmp r0, #1 
beq RetTrue 
RetFalse: 
mov r0, #3 @ Menu false usability is 3 

RetTrue: 

pop {r1} 
bx r1 


.global SplashCommandEffect 
.type SplashCommandEffect, %function 

SplashCommandEffect:
push {lr} 


ldr r0, =UseSplashEvent
mov r1, #1 @ Wait 

blh EventEngine 


ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
@mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics




pop {r0} 
bx r0 


.ltorg 
.align 
CurrentUnitFateData:
	.long 0x203A958











