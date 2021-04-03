
.thumb

.equ gpCurrentRound, 0x203A608

.global RemoveRoundHack
.type RemoveRoundHack, %function
RemoveRoundHack: @ jumpToHacked at 0x0802B918. If bit 5 in rounds data attributes is set, don't increment gpCurrentRound, and clear the round.
@ I think r4 has BattleUnit* attacker, and r5 has BattleUnit* defender for THIS round.
ldr r2, =gpCurrentRound
ldr r1, [ r2 ] @ Pointer to the current round.
ldr r0, [ r1 ]
mov r3, #0x20 @ Bit 5.
and r0, r0, r3 @ Attributes & 0x20.
cmp r0, #0x00
bne DontIncrementNormally
	@ Normal behavior. Increment gpCurrentRound by BattleBufferWidth.
	ldr r0, =gBattleBufferWidth
	ldrb r0, [ r0 ]
	add r1, r0, r1
	str r1, [ r2 ]
	b EndRemoveRoundHack
DontIncrementNormally:
	@ We should clear out this round. r1 has the pointer to it.
	mov r0, #0x00
	ldr r2, =gBattleBufferWidth
	ldrb r2, [ r2 ]
	StartRemoval: @ I'm going to assume that BattleBufferWidth is divisible by 4.
		str r0, [ r1 ]
		sub r2, r2, #0x04
		add r1, r1, #0x04
		cmp r2, #0x00
		bne StartRemoval
EndRemoveRoundHack:
mov r0, #0x00
pop { r4 - r6 }
pop { r1 }
bx r1
	
.ltorg
