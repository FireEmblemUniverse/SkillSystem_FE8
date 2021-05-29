.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb
	
	WriteAndVerifySramFast = 0x080D184D
	ReadSramFastAddr       = 0x030067A0   @ pointer to the actual ReadSramFast function
	@Ram16thNPC 		= 0x202E204		@some free space in ram 
	AfterDebuffsTable 		= 0x203F548		@some free space in ram @203F540
	
	
	@ arguments:
@ a saving and loading function (they take r0 = chunk save address; r1 = size; and are responsible for writing to/reading from SRAM)
@ arguments:
@ - r0 = target address (SRAM)
@ - r1 = target size
	
	.global SavePokeSuspend
	.type   SavePokeSuspend, function
	.global StorePokeRamToSaveFile
	.type   StorePokeRamToSaveFile, function
	

SavePokeSuspend:
StorePokeRamToSaveFile:
push {r4, r14}
mov   r2, r1
mov   r1, r0
ldr   r0, =AfterDebuffsTable
ldr   r4, =WriteAndVerifySramFast
bl    GOTO_R4
pop   {r4}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4

.pool
.align 4



	.global LoadPokeSuspend
	.type   LoadPokeSuspend, function
	.global LoadPokeRamFromSaveFile
	.type   LoadPokeRamFromSaveFile, function

LoadPokeSuspend:
LoadPokeRamFromSaveFile:
push {r4, r14}
mov   r2, r1
ldr   r1, =AfterDebuffsTable
ldr   r4, =ReadSramFastAddr
ldr   r4, [r4]
bl    GOTO_R4B
pop   {r4}
pop   {r0}
bx    r0
GOTO_R4B:
bx    r4

.pool
.align 4

