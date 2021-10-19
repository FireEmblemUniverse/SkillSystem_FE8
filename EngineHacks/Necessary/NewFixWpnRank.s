.thumb
.align 4
FixWpnRnkHook:
	@ STATE: r7 is a bu
	mov  r0, #0x50 @ BattleUnit.wpnType
	ldrb r0, [r7, r0]

	cmp r0, #7 @ Dark wep type 
	bgt no_gains @ If we are using monster weapons etc., don't try to give wexp lol 
	

	add  r0, #0x28 @ BattleUnit.unit.wexp
	ldrb r0, [r7, r0]

	cmp r0, #0
	beq no_gains

	@ REPLACED
	mov  r0, #0x52
	ldrb r0, [r7, r0]

	ldr r3, =0x0802C0FA+1
	bx  r3

no_gains:
	mov r0, #1
	neg r0, r0

	ldr r3, =0x0802C1AA+1
	bx  r3
	