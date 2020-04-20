@Disciple Skill
@doubles weapon EXP received
.thumb

@WEXP increase asm
@WEXP of unit in r6
@WEXP that weapon gives in r0, return this value    
@r1 holds some kind of relevant pointer, probably the kill bonus
@r7 holds pointer to 203A4EC

.equ Skill_ID, SkillTester+4
.equ SkillPlus_ID, Skill_ID+4
.equ DisciplinePlusReturn, 0x802C177
push {r4-r5,r14}

@stuff replaced by callHack
@from $2C138
mov     r1, r7
add     r1, #0x7B
ldr     r1, [r1]
lsl     r1, r1, #0x18
asr     r1, r1, #0x18
mul     r1, r0

@go to skill check
mov     r4, r1    @hold that WEXP value for me buddy
ldr     r1, SkillPlus_ID
ldr     r2, SkillTester
mov     r0, r7
mov     lr, r2
.short     0xF800    @two byte bl to lr
mov	r5, r0     @save vaue in r5 while we check for regular discipline
ldr	r1, Skill_ID
ldr     r2, SkillTester
mov 	r0,r7
mov	lr, r2
.short     0xF800
orr	r0, r5
cmp     r0, #0x0
beq	NoSkill
lsl     r4, r4, #0x1    @double WEXP if you have the skill
cmp	r5, #0x0
bne 	DisciplinePlus

NoSkill:
mov     r0, r4
pop     {r4-r5}
pop     {r1}
bx         r1

DisciplinePlus:
mov     r0, r4
pop     {r4-r5}
pop     {r1}
@vanilla code we're skipping over:
add	r6, r6, r0
mov	r1, #0x0
ldrb	r3, [r5, #0x0]
ldr	r2, [r7, #0x4]
ldr	r0, =DisciplinePlusReturn
bx	r0


.ltorg
.align
SkillTester:
@POIN SkillTester
@WORD Skill_ID
@WORD SkillPlus_ID
