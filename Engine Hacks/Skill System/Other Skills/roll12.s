.thumb
.equ Roll12ID, SkillTester+4
.equ _12SkillList, Roll12ID+4
push	{r4, lr}
mov	r4, r0 @attacker
mov	r5, r1 @defender

ldr	r0,=#0x203A4EC
cmp	r4,r0
bne	End

@For the attacker:
@check skill
ldr	r0, SkillTester
mov	lr, r0
mov	r0, r4
ldr	r1, Roll12ID
.short	0xf800
cmp	r0, #0
beq	Defender

@get random number here
ldr	r0,=#0x8000C64	@random number
mov	lr,r0
.short	0xF800
mov	r1,#12
swi	6
ldr	r0,_12SkillList
ldrb	r3,[r0,r1]
mov	r2,#0
ldr	r1,=#0x30004E4

AttackerLoop:
ldrb	r0,[r1,r2]
cmp	r0,#0
beq	AttackerStore
add	r2,#1
cmp	r2,#4
beq	Defender
b	AttackerLoop
AttackerStore:
strb	r3,[r1,r2]

@For the defender:
@check skill
Defender:
ldr	r0, SkillTester
mov	lr, r0
mov	r0, r5
ldr	r1, Roll12ID
.short	0xf800
cmp	r0, #0
beq	End

@get random number here
ldr	r0,=#0x8000C64	@random number
mov	lr,r0
.short	0xF800
mov	r1,#12
swi	6
ldr	r0,_12SkillList
ldrb	r3,[r0,r1]
mov	r2,#0
ldr	r1,=#0x30004E8

DefenderLoop:
ldrb	r0,[r1,r2]
cmp	r0,#0
beq	DefenderStore
add	r2,#1
cmp	r2,#4
beq	End
b	DefenderLoop
DefenderStore:
strb	r3,[r1,r2]

End:
pop	{r4, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD Roll12ID
@POIN _12SkillList
