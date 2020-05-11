

@r0 = usable, but must become offset of item ROM data
@r3 = Offset Character number in Character data
@r4 = Offset of unit data in memory
@r5 = Unit's held weapon/item, in memory
.thumb
mov			r1,#0xFF @ Original routine here
and			r1,r5
lsl			r0,r1,#0x3
add			r0,r0,r1
lsl			r0,r0,#0x2
add			r0,r0,r3		@ Now r0 has the offset of the weapon
push		{r3-r7}			@ r0 and r1 will be overwritten later; r2 must be preserved
mov			r6,r8
mov			r7,r9
push		{r6,r7}			@Sort of like "push {r9}"
ldrb		r6,[r0,#0xB]	@ Load Ability Byte 4
ldrb		r2,[r0,#0x1C]	@ Loads rank of held weapon
mov			r9,r0			@Saves offset of item data
cmp			r6,#0x0
bne		Sort
b		Rank_Check

Sort:
ldr 		r7, BasePointer @Loads base pointer to weapon array
b		Sort_2
@.align 2
BasePointer:
.long	0xEEEEEEEE			@ Base pointer - should be 4 bytes before the first array pointer

Sort_2:
lsl			r6,#0x2			@ Increments to pointer to the weapon's lock array
ldr			r6,[r6,r7]		@Loads this pointer into r6
cmp			r6,#0x0			@If it's a null pointer, go straight to the rank check
beq			Rank_Check

EitherOrInitial:
ldrb		r7,[r6]
mov			r1,#0x8			@Checking for either/or weapon levels
and			r1,r7
cmp			r1,#0x0
beq			LockSort
mov			r3,#0x4
and			r3,r7
mov			r1,#0x0
add			r6,#0x1			@Advance to the list proper
EitherOr:
ldrb		r2,[r6,r1]		@Load the weapon level you need in that weapon type
mov			r8,r1
cmp			r2,#0x0
beq		EitherOrLoopEnd
bl		Ranker				@Checks if the character has that weapon rank
cmp			r0,#0x0
beq		FalseCheck
cmp			r3,#0x0
bne		EitherOrLoopEnd_2	@If a single one returns true for the OR, whole function will return true
b		EitherOrLoopEnd
FalseCheck:
cmp			r3,#0x0
bne		EitherOrLoopEnd		@OR-level will continue to next check
b		End					@AND-level will end it

EitherOrLoopEnd:
mov			r1,r8
add			r1,#0x1
cmp			r1,#0x7
ble		EitherOr
EitherOrLoopEnd_2:
add			r6,#0x7			@Ready to be used for the weapon lock stuff
mov			r0,r9
ldrb		r2,[r0,#0x1C]	@Loads normal weapon level of the item

LockSort:
mov			r3,#0x1			@Checks for hard/soft lock
and			r3,r7
cmp			r3,#0x0
beq		Sort_3				@Soft lock - can still wield without the lock if your weapon rank matches

Hardlock:
mov			r2,#0xFF		@ If you don't get a match, you can't hold this

Sort_3:
mov			r3,#0x2
and			r7,r3
cmp			r7,#0x0
beq		Sort_4

Classlock:
mov			r7,r4
add			r7,#0x4			@ Moves to class pointer in unit data
ldr			r3,[r7]			@ Loads class pointer instead of character
b		Sort5

Sort_4:
mov			r3,r4			@ Loads character pointer from unit data
ldr			r3,[r3]			@ Character Data
Sort5:
add			r3,#0x4
ldrb		r3,[r3]			@ Loads ID

Sort_Loop_Start:
add			r6,#0x1			@ Move to first/next entry
ldrb		r7,[r6]			@ Load character/class ID in entry
cmp			r7,r3			@ Compare with ID of character trying to wield
beq		Lock_Match
cmp			r7,#0x0			@ If we're at the end of this array, no match exists
beq			Rank_Check		@ Check rank for soft lock, or disallow for hard lock
b		Sort_Loop_Start

Lock_Match:
mov			r2,#0x1			@ Can use at level E

Rank_Check:
mov			r1,#0xFF
cmp			r5,#0x0
beq		Rank_2
ldrb		r1,[r0,#0x7]
Rank_2:
bl		Ranker

End:
pop		{r6,r7}
mov		r8,r6
mov		r9,r7
pop		{r3-r7}				@pop what we pushed
pop		{r4,r5}				@This code taken from original routine
pop		{r1}
bx		r1					@Back to the stream

.align 2
Ranker:
mov			r0,r4
add			r0,#0x28		@Unit's weapon levels
add			r0,r0,r1		@Weapon type
ldrb		r0,[r0]
mov			r1,#0x0
cmp			r0,r2
blt		RankEnd
mov			r1,#0x1
RankEnd:
mov			r0,r1
bx			r14
