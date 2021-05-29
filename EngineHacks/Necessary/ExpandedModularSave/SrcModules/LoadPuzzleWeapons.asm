.thumb

	WriteAndVerifySramFast = 0x080D184C+1
	ReadSramFastAddr       = 0x030067A0   @ pointer to the actual ReadSramFast function
	PuzzleWeaponFlags 		= 0x3003BFE		@some free space in ram 

push  {r4, r14}
mov   r2, r1
ldr   r1, =PuzzleWeaponFlags
ldr   r4, =ReadSramFastAddr
ldr   r4, [r4]
bl    GOTO_R4

pop   {r4}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4
