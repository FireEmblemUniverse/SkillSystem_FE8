.thumb
.org 0x0
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ CheckEventId,0x8083da8
.equ WatchfulID, SkillTester+4

@checks if target unit is an enemy and can be rescued
@r0=current target's data ptr
push	{r4,r5,r14}
mov		r4,r0
ldr		r1,WatchfulID
ldr		r3,SkillTester
mov		r14,r3
.short	0xF800
cmp		r0,#1
beq		GoBack 		@can't be captured if they have watchful
ldr		r0,Comp_Allegiance_Func
mov		r14,r0
ldr		r0,TargetQueuePtr
ldr		r5,[r0] @ this is the actor 
mov		r1,#0xB
ldsb	r0,[r5,r1]
ldsb	r1,[r4,r1]
.short	0xF800
cmp		r0,#0x0
bne		GoBack @ allied unit should not be added to the target list 

ldr r0, [r4] @ Unit Struct 
ldrb r0, [r0, #4] @ Unit ID 
cmp r0, #0xA0 
bge GoBack @ Never allow capturing for unit IDs 0xA0 and greater 

mov r11, r11 
ldr r0, =CannotEvolveFlag
lsl r0, #16 
lsr r0, #16 
blh CheckEventId 
cmp r0, #0 
beq CanCapture 
mov r0, r4 
bl IsTargetEvolved
cmp r0, #0 
bne GoBack 

@ Vesly commented out so con is ignored 
@mov		r0,r5
@ldr		r1,Can_Rescue_Check
@mov		r14,r1
@mov		r1,r4
@.short	0xF800
@cmp		r0,#0x0
@beq		GoBack				@can't capture if you can't rescue

CanCapture: 
ldr		r0,Fill_Target_Queue
mov		r14,r0
ldrb	r0,[r4,#0x10]
ldrb	r1,[r4,#0x11]
ldrb	r2,[r4,#0xB]
mov		r3,#0x0
.short	0xF800
GoBack:
pop		{r4-r5}
pop		{r0}
bx		r0

.align
TargetQueuePtr:
.long 0x02033F3C
Comp_Allegiance_Func:
.long 0x08024D8C
Can_Rescue_Check:
.long 0x0801831C
Fill_Target_Queue:
.long 0x0804F8BC
.ltorg 
.align 4 
SkillTester:
@
