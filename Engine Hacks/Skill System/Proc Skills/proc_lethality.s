.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ LethalityID, SkillTester+4
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
mov r1, #0xC0 @skill flag
lsl r1, #8 @0xC000
add r1, #2 @miss
tst r0, r1
bne End

@if another skill already activated, don't do anything

@check if crit is to be ignored
mov	r1, #0x6C
ldrb	r1,[r4,r1]
mov	r5,#0xFF
cmp	r1,#0x7F	@I set the value to FF in the battle calculations if crit is to be ignored (skill% based activation)
bhi	RollRN
cmp	r1,#0x7F	@check if Bane triggered
beq	End
cmp	r1,#0x00	@check if 0 chance
beq	End

@only activate if crit
mov r5, #0x64
mov r1, #0x1
tst r0, r1
beq End

RollRN:
ldr	r0,=#0x80191D0	@call skill getter
mov	r14,r0
mov	r0,r4
.short	0xF800
mov	r1,#0x6C
ldrb	r1,[r4,r1]
sub	r5,r1		@FF or 64 - Lethality Chance = modifier (depending on if crit needed or not)
lsr	r0,r5		@divide skill by modifier to get our chance (modifier was set in NonGBALethalitySkill)

mov r1, r4 @skill user
blh d100Result
cmp r0, #1		@check if roll was successful
bne End


@ @check for Lethality proc - this check may be done elsewhere...
@ ldr r0, SkillTester
@ mov lr, r0
@ mov r0, r4 @attacker data
@ ldr r1, LethalityID
@ .short 0xf800
@ cmp r0, #0
@ beq End
@ @if user has lethality:

@ mov r0, r4	@commented this out because it now checks for lethality ability to determine immunity (no demon king/necromancer immunity if they don't have lethality)
@ mov r1, r5
@ blh 0x802B38C @check for demon king/necromancer
@ cmp r0, #0
@ beq End

@if we proc, set offensive skill flag
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0, #0x40
lsl     r0, #8           @0x4000, attacker skill activated
orr     r1, r0
ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018  

ldrb  r0, LethalityID
strb  r0, [r6,#4] 

@if we proc, set the lethality flag
ldr     r3,[r6]    
lsl     r1,r3,#0xD                @ 0802B4D0 0359     
lsr     r1,r1,#0xD                @ 0802B4D2 0B49     
mov     r0,#0x80                @ 0802B4D4 2080     
lsl     r0,r0,#0x4  @ 0x800, lethality flag     @ 0802B4D6 0100     
orr     r1,r0                @ 0802B4D8 4301     
ldr     r2,=#0xFFF80000                @ 0802B4DA 4A0A     
mov     r0,r2                @ 0802B4DC 1C10     
and     r0,r3                @ 0802B4DE 4018     
orr     r0,r1                @ 0802B4E0 4308     
str     r0,[r6]                @ 0802B4E2 6020  

ldrb  r0, LethalityID
strb  r0, [r6,#4] 

@set damage to max (127?)
mov     r0,#0x7F                @ 0802B4E4 207F     
strh    r0,[r7,#0x4]                @ 0802B4E6 80A8  

ldr     r3,[r6]                @ 0802B4E8 6823     
lsl     r0,r3,#0xD                @ 0802B4EA 0358     
lsr     r0,r0,#0xD                @ 0802B4EC 0B40     
ldr     r1,=#0xFFFF7FFF                @ 0802B4EE 4906     
and     r0,r1                @ 0802B4F0 4008     
and     r2,r3                @ 0802B4F2 401A     
orr     r2,r0                @ 0802B4F4 4302     
str     r2,[r6]                @ 0802B4F6 6022       

End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD LethalityID
