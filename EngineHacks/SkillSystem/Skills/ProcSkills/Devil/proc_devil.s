.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ DevilsLuckID, SkillTester+4
.equ DevilsPactID, DevilsLuckID+4
.equ DevilsWhimID, DevilsPactID+4
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
bne End	@if miss, dont do anything

@make sure damage > 0
mov r0, #4
ldrsh r0, [r7, r0]
cmp r0, #0
ble End

@if the unit has DevilsLuck or DevilsPact, no devil effect
mov	r0,r4
ldr	r1,DevilsLuckID
ldr	r3,SkillTester
mov	lr,r3
.short	0xF800
cmp	r0,#1
beq	End
mov	r0,r4
ldr	r1,DevilsPactID
ldr	r3,SkillTester
mov	lr,r3
.short	0xF800
cmp	r0,#1
beq	End

@check if defender has DevilsPact
mov	r0,r5
ldr	r1,DevilsPactID
ldr	r3,SkillTester
mov	lr,r3
.short	0xF800
cmp	r0,#1
beq	isDevil

@check if defender has devil weapon
mov	r0,r5
mov	r1,#0x4A    @Move to the attacker's weapon
ldrh	r0,[r0,r1]
ldr	r1,=#0x8017724	@get item word
mov	lr,r1
.short	0xF800
cmp	r0,#0x04	@devil effect
bne     noLuck	@do nothing if not devil

@check if defender has DevilsLuck
mov	r0,r5
ldr	r1,DevilsLuckID
ldr	r3,SkillTester
mov	lr,r3
.short	0xF800
cmp	r0,#1
beq	isDevil

noLuck:

@check if either of the units has DevilsWhimID
mov	r0,r4
ldr	r1,DevilsWhimID
ldr	r3,SkillTester
mov	lr,r3
.short	0xF800
cmp	r0,#1
beq	isDevil
mov	r0,r5
ldr	r1,DevilsWhimID
ldr	r3,SkillTester
mov	lr,r3
.short	0xF800
cmp	r0,#1
beq	isDevil

@make sure attacker has devil weapon
mov	r0,r4
mov	r1,#0x4A    @Move to the attacker's weapon
ldrh	r0,[r0,r1]
ldr	r1,=#0x8017724	@get item word
mov	lr,r1
.short	0xF800
cmp	r0,#0x04	@devil effect
bne     End	@do nothing if not devil

@roll devil chance
isDevil:
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

@if we proc, set the offensive skill flag
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0, #0x40
lsl     r0, #8		@0x4000, attacker skill activated
add	r0,#0x80	@+ devil flag
orr     r1, r0
ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018 

mov	r0,#0xFF	@no animation!
strb	r0,[r6,#4]

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
cmp	r0,#2		@steal hp effect
beq	NoDamage 

mov r0, #4
ldrsh r0, [r7, r0]	@damage being dealt
ldrb r1, [r4, #0x13]	@update hp
sub	r1,r0
cmp	r1,#0x7F
blo	NP
mov	r1,#0
NP:
strb r1, [r4, #0x13]

End:
pop {r4-r7}
pop {r15}

NoDamage:
@unset reversal
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0,#0x80
mvn	r0,r0
and     r1,r0

ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018

@mov	r0,#0x13
@ldsb	r0,[r4,r0]	@remaining hp
@mov	r2,#4
@ldsb	r2,[r7,r2]	@damage
@add	r0,r2
@strb	r0,[r4,#0x13]	@remaining hp
mov	r0,#0
strb	r0,[r7,#4]
strb	r0,[r7,#5]

mov	r0,#0xFF	@no animation!
strb	r0,[r6,#4]
b	End

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD DevilsLuckID
@WORD DevilsPactID
@WORD DevilsWhimID
