.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ gChapterData, 0x202BCF0
.equ NextRN_100, 0x8000C64 
	.equ MemorySlot,0x30004B8
.equ DespoilID, SkillTester+4
.equ DespoilEvent, DespoilID+4
.thumb
push	{r7, lr}

@check if dead
ldrb	r0, [r4,#0x13]
cmp	r0, #0x00
beq	End

@check if attacked this turn
ldrb 	r0, [r6,#0x11]	@action taken this turn
cmp	r0, #0x2 @attack
bne	End
ldrb 	r0, [r6,#0x0C]	@allegiance byte of the current character taking action
ldrb	r1, [r4,#0x0B]	@allegiance byte of the character we are checking
cmp	r0, r1		@check if same character
bne	End

@check for inventory space, but only if not a player unit
cmp	r1, #0x40
blo	SkipInventoryCheck

ldr	r0,=#0x80179D8	@inventory space check routine
mov	lr, r0
mov	r0, r4		@attacker
.short	0xF800
cmp	r0, #0x04
bhi	End
SkipInventoryCheck:

@check if killed enemy
cmp r5, #0 
beq End
ldrb	r0, [r5,#0x13]	@currhp
cmp	r0, #0
bne	End

@check for skill
mov	r0, r4
ldr	r1, DespoilID
ldr	r3, SkillTester
mov	lr, r3
.short	0xf800
cmp	r0, #0x00
beq	End

ldrb r0, [r4, #0x8] @ level 
ldrb r1, [r5, #0x8] @ level 
cmp r0, r1 
bgt End @ only if we're equal or higher level can we get the item 

@killed enemy, roll luck
ldr	r0,=#0x8019298	@luck getter
mov	lr, r0
mov	r0, r4		@attacker
.short	0xF800
mov r7, r0 
lsl r0, #1 
ldr	r2,=#0x802a52c	@1rn routine
mov	r1, r4		@attacker
mov	lr, r2
.short	0xF800
cmp	r0, #0x01
bne	End


ldrb r0, [r4, #0x8] @ level 
mul r0, r7 @ level * luck 
mov r7, r0 @ amount to give 

blh NextRN_100 
mov r1, #10 
mul r0, r1 
add r0, r7 @ total amount to give 
ldr r1, =#24999 
cmp r0, r1 
ble NoCap 
mov r0, r1 
NoCap: 


ldr r1, [r4, #4] @ class pointer 
ldrb r1, [r1, #4] @ class id 
ldr r2, =Meowth 
lsl r2, #24 
lsr r2, #24 
cmp r1, r2 
beq ExtraMoneyEarned 
ldr r2, =Persian
lsl r2, #24 
lsr r2, #24 
cmp r1, r2 
beq ExtraMoneyEarned 
b RegularAmount 
ExtraMoneyEarned: 
lsl r1, r0, #1 @ 2x 
add r1, r0 @ 3x 
lsr r0, r1, #1 @ 1.5x for Meowth and Persian 

RegularAmount: 



@ see $34704
ldr r2, =gChapterData
ldrb r2, [r2, #0x14] 
mov r1, #0x40 
and r1, r2 
neg r1, r1 
lsr r1, #0x1F 
lsl r1, #1 @ 2 in r1 only on lunatic 
lsr r0, r1 @ 1/4 gold on lunatic 


add r0, #5 
ldr r3, =MemorySlot 
str r0, [r3, #0x03*4] @ s3 as gold to give 

@successful roll, give item/money
Event:
ldr	r0,=#0x800D07C		@event engine thingy
mov	lr, r0
ldr	r0, DespoilEvent	@this event is just "give gem"
mov	r1, #0x01		@0x01 = wait for events
.short	0xF800

End:
pop {r7} 
pop	{r0}
bx	r0
.ltorg
.align
SkillTester:
@POIN SkillTester
@WORD DespoilID
@POIN DespoilEvent
