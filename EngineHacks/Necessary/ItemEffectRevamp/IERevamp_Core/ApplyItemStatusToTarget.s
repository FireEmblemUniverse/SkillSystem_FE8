.thumb

	.set gActionData,                  0x0203A958
	.set gTargetBattleUnit,            0x0203A56C @defender

	.set GetUnit,                      0x08019430
	.set SetUnitStatus,                0x80178F4

@replaces routine at x803001C

push {r4-r5,lr}
ldr r0, =gTargetBattleUnit
mov r4, r0
add r4, #0x6F
mov r0,#0x0
ldsb r5, [r4,r0]
cmp r5, #0x0
beq End
ldr r0, =gActionData
ldrb r0, [r0,#0xD]

bl GetUnit
mov r1, #0xF
asr r2, r5, #0x4
and r2, r1
and r1, r5
bl SetUnitStatus
mov r0, #0xFF
strb r1, [r0]
End:
pop {r4-r5}
pop {pc}
.align
.ltorg
