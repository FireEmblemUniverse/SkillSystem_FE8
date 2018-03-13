.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ CounterID, SkillTester+4
.equ d100Result, 0x802a52c
@ r0 is attacker, r1 is defender, r2 is current buffer, r3 is battle data
push {r4-r7,lr}
mov r4, r0 @attacker
mov r5, r1 @defender
mov r6, r2 @battle buffer
mov r7, r3 @battle data
ldr     r0,[r2]           @r0 = battle buffer                @ 0802B40A 6800     
lsl     r0,r0,#0xD                @ 0802B40C 0340     
lsr     r0,r0,#0xD        @Without damage data                @ 0802B40E 0B40     
mov r1, #0x2 @miss
tst r0, r1
bne End	@if miss, don't do anything

b	DEBUG

@make sure attacker has devil weapon
mov	r0,r4
mov	r1,#0x4A    @Move to the attacker's weapon
ldrh	r0,[r0,r1]
ldr	r1,=#0x8017724	@get item word
mov	lr,r1
.short	0xF800
mov	r2,#0x04	@devil effect
tst	r0,r2
beq     End	@do nothing if devil bit not set

@make sure damage > 0
mov r0, #4
ldrsh r0, [r7, r0]
cmp r0, #0
ble End

@roll devil chance
mov	r0,r4
ldr	r1,=#0x8019298	@luck getter
mov	lr,r1
.short	0xF800
cmp	r0,#31	@check if luck is over cap, just in case
bhi	End
mov	r1,#31	@devil chance
sub	r0,r1,r0	@devil chance - luck
ldr	r1,=#0x8000CA0	@roll 1rn
mov	lr,r1
.short	0xF800
lsl	r0,#0x18
cmp	r0,#0
beq	End	@if the roll fails we are safe

DEBUG:

@if we proc, set the offensive skill flag
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
	@mov     r0, #0x1
	@lsl     r0, #8           @0x100, attacker skill activated and hp draining
	
mov	r0,#0x80
	
orr     r1, r0
ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018  

@@and recalculate damage with healing
@mov r0, #4
@ldrsh r0, [r7, r0]
@mov r1, #5
@ldsb r1, [r6, r1] @existing hp change
@sub	r1,r0
@strb r1, [r6, #5] @write hp change
@mov	r1,#1
@strb r1, [r6, #3] @no damage
@strh r1, [r7, #4] @final damage
@
@ldrb r1, [r4, #0x13]	@update hp
@sub	r1,r0
@cmp	r1,#0
@bhi	NP
@mov	r1,#0
@NP:
@strb r1, [r4, #0x13]



End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD CounterID
