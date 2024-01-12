.thumb
.macro blh to,reg=r4
	push {\reg}
	ldr \reg,=\to
	mov r14,\reg
	pop {\reg}
	.short 0xF800
.endm


.global TrapHurt10HpASMC
.type   TrapHurt10HpASMC, function


TrapHurt10HpASMC:
@ Input r0 = Proc* ParentProc
@ Output = void
	push	{r4-r7, lr}
	mov		r7, r0
	
	ldr		r4, =gActiveUnit
	ldr		r4,[r4]
	
	@ Unit2Battle
	mov		r0, r4
	blh		SetupSubjectBattleUnitForStaff
	
	@ Setup ItemEffect Anime
	ldr		r3, =gSubjectBattleStruct
	mov		r1, #0x4A
	ldr		r0, =0x016C	@ Item-Use!
	strh	r0,[r3, r1]	
	
	@ Set Effect
	ldrb	r1,[r4, #0x13]
	cmp		r1, #0xA
	bhi		.L1
	add		r0, r1, #-1
	b		.L2
	.L1:
	mov		r0, #0xA
	.L2:
	sub		r1, r1, r0
	strb	r1,[r4, #0x13]
	
	@ Setup Hurt
	ldr		r3, =gpCurrentRound
	ldr		r2,[r3]
	strb	r0,[r2, #0x3]
	
	mov		r0, r4
	blh		BattleApplyItemEffect
	
	mov		r0, r7
	blh		BeginBattleAnimations

	
	pop		{r4-r7, pc}
