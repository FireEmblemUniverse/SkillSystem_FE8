.thumb
.org 0x0

@Rerun battle calculations if at least one combatant has an item that changes by round (like Frenzy)
@branched to from 2B3EC, branch back to 2B3FA when done. No, this is not clean or recommended, but I'm tired and annoyed
push	{r4-r7,r14}
mov		r7,r10
mov		r6,r9
mov		r5,r8
push	{r5-r7}
mov		r6,r0
mov		r8,r1
ldr		r4,BattleDisplayData
ldrh	r0,[r4]
mov		r1,#0x1
tst		r0,r1
beq		GoBack				@seems to have 2 for pre-battle display, 1 for actual battle
@ ldr		r4,Item_Checker
@ mov		r14,r4
@ mov		r0,r6
@ mov		r1,#0xB2			@Frenzy should be the only thing we need to check for at the moment
@ .short	0xF800
@ cmp		r0,#0x0
@ bne		RedoCalcs
@ mov		r14,r4
@ mov		r0,r8
@ mov		r1,#0xB2
@ .short	0xF800
@ cmp		r0,#0x0
@ beq		GoBack				@if neither combatant has the item, don't rerun calculations
RedoCalcs:
ldr		r4,BattleCalcs1
mov		r14,r4
mov		r0,r6
mov		r1,r8
.short	0xF800
mov		r14,r4
mov		r0,r8
mov		r1,r6
.short	0xF800
ldr		r4,BattleCalcs2
mov		r14,r4
mov		r0,r6
mov		r1,r8
.short	0xF800
mov		r14,r4
mov		r0,r8
mov		r1,r6
.short	0xF800
ldr		r0,BattleInfoBufferFunc
mov		r14,r0
mov		r0,r6
mov		r1,r8
.short	0xF800
GoBack:
ldr		r4,GoBackAddr
bx		r4

.align
BattleCalcs1:
.long 0x0802A95C
BattleCalcs2:
.long 0x0802A9A8
BattleInfoBufferFunc:
.long 0x0802B1C4
GoBackAddr:
.long 0x0802B3FA+1
BattleDisplayData:
.long 0x0203A4D4
@ Item_Checker:
@
