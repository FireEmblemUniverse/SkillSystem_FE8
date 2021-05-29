.thumb

	WriteAndVerifySramFast = 0x080D184C+1
	ReadSramFastAddr       = 0x030067A0   @ pointer to the actual ReadSramFast function

push  {r4, r14}
mov   r2, r1
mov   r1, r0
ldr   r0, =PuzzleWeaponFlags
ldr   r4, =WriteAndVerifySramFast
bl    GOTO_R4

pop   {r4}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4
