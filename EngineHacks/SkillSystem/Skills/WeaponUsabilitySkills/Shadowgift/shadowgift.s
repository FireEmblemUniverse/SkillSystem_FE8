.equ ShadowgiftID, SkillTester+4
.equ LuminaID, ShadowgiftID+4
.equ ShadowgiftStaffOption, LuminaID+4
.equ LuminaStaffOption, ShadowgiftStaffOption+4
.equ ItemTable,LuminaStaffOption+4
.thumb

push	{r4-r6, r14}

@r4 = character pointer
@r5 = item halfword
@r6 = rank

mov r4,r0
mov r5,r1
mov r6,r2

mov r0,#0xFF
and r0,r5
mov r1,#0x24
mul r0,r1
ldr r1,ItemTable
add r1,r0
ldrb r2,[r1,#7]

@shadowgift
cmp	r2,#7	@if dark rank
bne	noShadowgift
mov	r0,r4
ldr	r1,ShadowgiftID
ldr	r3,SkillTester
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	noShadowgift
mov	r0,r4
add	r0,#0x28
ldrb	r2,[r0,#6]
cmp	r2,r6
bhs	True
ldrb	r2,[r0,#5]
cmp	r2,r6
bhs	True
ldr	r1,ShadowgiftStaffOption
cmp	r1,#0
beq	noShadowgift
ldrb	r2,[r0,#4]
cmp	r2,r6
bhs	True
noShadowgift:

@lumina
cmp	r2,#6	@if light rank
bne	noLumina
mov	r0,r4
ldr	r1,LuminaID
ldr	r3,SkillTester
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	noLumina
mov	r0,r4
add	r0,#0x28
ldrb	r2,[r0,#7]
cmp	r2,r6
bhs	True
ldrb	r2,[r0,#5]
cmp	r2,r6
bhs	True
ldr	r1,LuminaStaffOption
cmp	r1,#0
beq	noLumina
ldrb	r2,[r0,#4]
cmp	r2,r6
bhs	True
noLumina:

False:
mov	r0,#0
b	End

True:
mov	r0,#1

End:
pop {r4-r6}
pop	{r1}
bx	r1

.ltorg
.align
SkillTester:
@POIN SkillTester
@WORD ShadowgiftID
@WORD LuminaID
@WORD ShadowgiftStaffOption
@WORD LuminaStaffOption
