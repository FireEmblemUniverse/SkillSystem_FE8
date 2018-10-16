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

@check for draining weapon
mov	r0,#0x4A
ldrh	r0,[r4,r0]	@equipped item
mov	r1,#0xFF
and	r0,r1		@only item id
mov	r1,#36		@size of entry
mul	r0,r1
add	r0,#31		@offset of weapon effect byte
ldr	r1,=0x080177C0	@has table pointer
ldr	r1,[r1]
ldrb	r0,[r1,r0]	@weapon effect
mov	r1,#2		@steal hp effect
and	r0,r1
cmp	r0,#0
beq	End

@make sure damage > 0
mov	r0,#4
ldrsh	r0,[r7,r0]
cmp	r0,#0
ble	End

@if we proc, set the hp update flag
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0, #0x1
lsl     r0, #8           @0x100, hp drain/update
orr     r1, r0

ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018

@check for liquid ooze
ldr r0, SkillTester
mov lr, r0
mov r0, r5 @defender data
ldr r1, CounterID
.short 0xf800
cmp r0, #0
beq	doHeal

@check if attacker would die
mov	r2,#4
ldsh	r2,[r7,r2]	@damage
mov	r0,#0x13
ldrb	r0,[r4,r0]	@remaining hp
cmp	r2,r0
blo	noproblem
@gonna kill, so lower it
mov	r2,r0
sub	r2,#1
mov	r0,#1
noproblem:
strb	r0,[r4,#0x13]
neg	r2,r2
ldrb	r1,[r6,#5]
add	r2,r1
strb	r2,[r6,#5]
b	End

doHeal:
mov	r2,#4
ldsh	r2,[r7,r2]	@damage
mov	r0,#0x13
ldrb	r0,[r4,r0]	@remaining hp
mov	r1,#0x13
ldrb	r1,[r4,r1]	@max hp
add	r0,r2 @new hp
cmp	r0,r1
blo	notmaxed
mov	r0,r1
notmaxed:
strb	r0,[r4,#0x13]
ldrb	r1,[r6,#5]
add	r2,r1
strb	r2,[r6,#5]	@hp change

End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD CounterID
