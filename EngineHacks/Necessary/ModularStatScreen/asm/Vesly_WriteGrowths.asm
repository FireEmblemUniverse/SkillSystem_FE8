.thumb		@if you don't put this, the assembler assuming it's in ARM mode, which would be a Bad Thing
.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@setting up the literal pool
.equ Get_Hp_Growth, Class_Level_Cap_Table+4
.equ Get_Str_Growth, Class_Level_Cap_Table+8
.equ Get_Mag_Growth, Class_Level_Cap_Table+12 @ If strmag split isn't installed, this will be 0, and code inserted in here will do nothing.
.equ Get_Skl_Growth, Class_Level_Cap_Table+16
.equ Get_Spd_Growth, Class_Level_Cap_Table+20
.equ Get_Def_Growth, Class_Level_Cap_Table+24
.equ Get_Res_Growth, Class_Level_Cap_Table+28
.equ Get_Luk_Growth, Class_Level_Cap_Table+32
.equ Growth_Options, Class_Level_Cap_Table+36
.equ TieredGrowthOptions, Class_Level_Cap_Table+40 
.equ GetAverageStat, Class_Level_Cap_Table+44 
.equ TieredLevelUp, Class_Level_Cap_Table+48
.equ MinimumStatsOnLevelUp, Class_Level_Cap_Table+52 



@jumped here from 2BA28
@r0=battle struct of person who's levelling up

push	{r4-r7,r14}		@ save the usual registers by pushing them to the stack
mov r7, r8 
push {r7}
mov		r7,r0			@ save battle struct ptr by mov-ing it from r0 to a saved register (r7)
ldr		r1,Can_Gain_Exp	
mov		r14,r1			@ this is a function call to Can_Gain_Exp routine, which is out of normal BL range
.short	0xF800			@ BL lr+0 (returns 1 if person can gain exp, 0 if false)

cmp		r0,#0x0			@ compare r0 to 0 (ie, did it return false)
bne		CanLevelUp			@ (branch if not equal) using this here because the function is be too long to beq to directly (branch with comparison operator has a shorter range than direct branch)
b		Exit			@ if false, we're done here
CanLevelUp:
ldrb	r0,[r7,#0x9]	@ LoaD Register (r0) with Byte. Which byte? The one written at the location pointed to by (r7+0x9). In the battle struct, this is the unit's exp.
cmp		r0,#99			@ yes, you can use decimal numbers and the assembler converts to hex! Here, we check how the character's experience compares to 99
bhi		YesTheyLeveledUp			@ if it's higher than 99, keep going
b		Exit			@ otherwise, the character's not levelling up and we are done here
YesTheyLeveledUp:

ldr		r3,Calc_Level_Up	@ load r6 with word at Calc_Level_Up, which is a rom address (2B9A0, to be precise)
mov 	r8, r3


sub		r0,#100			@ subtract 100 from unit's exp
ldrb	r1,[r7,#0x8]	@ again, load register r1 with byte; here it's r7+0x8, which is the unit's level
add		r1,#1			@ add 1 to the unit's level
strb	r1,[r7,#0x8]	@ and SToRe that Byte back to r7+0x8
ldr		r2,[r7,#0x4]	@ load register r2 (with word) (it's not written, but it's implied) at r7+4. This is the character's (ROM) class data pointer
ldrb	r2,[r2,#0x4]	@ load register r2 with the byte at address (r2 + 4). If you look at the Class Editor.nmm, the 4th byte is the class number
ldr		r3,Class_Level_Cap_Table	@ our table containing the level cap for each class
ldrb	r2,[r3,r2]		@ load reg r2 with the byte contained at the address (r3 + r2), which would be the class's level cap
cmp		r1,r2			@ compare new level with cap
blt		SkipCappingExpGain			@ branch if less than to Label3
mov		r1,r7			@ copy battle struct to r1
add		r1,#0x6E		@ add 0x6E
ldrb	r2,[r1]			@ load byte at this location. Teq doq reveals that battle struct+0x6E is the experience this unit gained during this battle/interaction
sub		r2,r2,r0		@ subtract r0 from r2 and put the result in r2
strb	r2,[r1]			@ and store that result back to battle struct+0x6E. Why? Because we don't want to show the unit gaining exp past the level cap.
mov		r0,#0xFF		@ put 0xFF in r0
SkipCappingExpGain:
strb	r0,[r7,#0x9]	@ store the new exp. If the unit is capped, then we stored 0xFF (because we didn't skip the branch above), otherwise, we stored (exp - 100)

@This next part is writing the growths.
@The vanilla growth function is designed so that it's hard to get no-stat level-ups if none are capped. First, we go through all the stats and see whether any leveled up. If none did, then we do another pass until either a) a stat procs, or b) we looped through all stats again. Once done, we check if the level-up makes the stat go over its cap, and set that accordingly.

mov		r4,#0			@ zeroing out r4 to use as a flag.
mov		r5,#0			@ zeroing out r5 to use as a counter.



ldr 	r0, TieredGrowthOptions 
cmp 	r0, #0
beq TryOtherGrowths




mov r0, #0xAE @ flag 







ldr		r1,Check_Event_ID	@ bytes 2 and 3 of the opinion word are a (permanent) event ID, which is set if fixed growths are on (makes it easy to toggle)
mov		r14,r1
.short	0xF800
cmp r0, #0 
beq TryOtherGrowths
b UseTieredGrowths
TryOtherGrowths:

ldr		r0,Growth_Options	@ bit 1 is set if we should check for fixed growths mode
mov		r1,#0x1
tst		r0,r1				@ tst is a combination of 'and r0,r1; cmp r0,#0' except it doesn't store the result in a register, merely sets the z flag if the comparison is true (ie, r0&r1=0)
beq		NormalGrowths		@ if the bit isn't set, we go straight to the normal growths routine
lsr		r0,#0x10			@ logical shift right by 0x10 places (divide by 2^16, which strips the lower 2 bytes of this word)
ldr		r1,Check_Event_ID	@ bytes 2 and 3 of the opinion word are a (permanent) event ID, which is set if fixed growths are on (makes it easy to toggle)
mov		r14,r1
.short	0xF800				@ returns true (1) if the event id is set
cmp		r0,#0
beq		NormalGrowths		@ if not set, go to normal growths routine
b		FixedGrowths		@ if it's set, go to fixed growths routine


b Exit



.macro LevelUp
	mov		r14,r0			@ use the longcalling trick to bl to Get_Hp_Growth, whose location will be determined in the EA file
	mov		r0,r7			@ that function takes the character struct as a parameter (character data forms the first 0x48 bytes of the battle struct, so it doesn't matter which one is used)
	.short	0xF800			@ when we return, r0 will have the hp growth (which takes into account metis tome and any growth boosters the character has)
	mov		r14,r8			@ now we call the function Calc_Level_Up
	.short	0xF800			@ which returns the actual level-up number
	mov		r1,r7
	add		r1,r6
	strb	r0,[r1]			
	add		r5,r0			@ add r0 (level-up number) to r5 (counter) and store it in r5 (this is equal to add r5,r5,r0)
.endm

.macro FixedLevelUp
	mov		r14,r0
	mov		r0,r7
	.short	0xF800
	mov		r4,r0			@ save the growth, we'll need it
	mul		r0,r6			@ multiply growth by # of levels
	bl		DivideBy100		@ growth*level mod 100
	add		r0,r4			@ add growth to remainder (if this >100, stat increases)
	bl		DivideBy100		@ gotta do this just in case it goes over 200
	mov		r0,r7
	add		r0,r5
	strb	r1,[r0]
.endm






NormalGrowths:
@ This function is very repetitive, so I'm using a macro to save on rewriting the same 12 lines over and over again. 

HpGrowth:
mov r5, #0
ldr		r0,Get_Hp_Growth
mov r6, #0x73 @ store the hp growth to (battle struct+0x73), which will then be read later for the level-up display
LevelUp
ldr		r0,Get_Str_Growth
mov r6, #0x74 
LevelUp
ldr		r0,Get_Mag_Growth
cmp		r0,#0x00
beq		SklGrowth @ If Get_Mag_Growth is 0, str/mag isn't enabled.
mov r6, #0x7A 
LevelUp 
b SklGrowth

CheckCapsLadder:
b 		CheckCaps 

SklGrowth:
ldr		r0,Get_Skl_Growth
mov r6, #0x75 
LevelUp
ldr		r0,Get_Spd_Growth
mov r6, #0x76 
LevelUp
ldr		r0,Get_Def_Growth
mov r6, #0x77 
LevelUp
ldr		r0,Get_Res_Growth
mov r6, #0x78 
LevelUp
ldr		r0,Get_Luk_Growth
mov r6, #0x79 
LevelUp 
ldr r0, MinimumStatsOnLevelUp
cmp		r5,r0 @if 2 or more stats, we're happy 
bge		CheckCapsLadder
add 	r4, #1 
@ At the end of each iteration, we break if at least 2 stats leveled up 
				@ If 0 or 1 stats did, we do an entire iteration again 

cmp 	r4, #10 @ We will try up to 10 times 

blt 	HpGrowth
cmp r5, #1 
bge CheckCapsLadder
cmp r6, #20
blt HpGrowth
b CheckCapsLadder

@End of normal growths routine
FixedGrowths:
ldrb	r6,[r7,#0x8]	@ unit's level
sub		r6,#1			@subtract 1 from it (this is the number of previous level-ups)
ldr		r0,[r7]			@ rom character data pointer
ldr		r1,[r7,#0x4]	@ rom class data pointer
ldr		r0,[r0,#0x28]	@ character abilities
ldr		r1,[r1,#0x28]	@ class abilities
orr		r0,r1			@ bitwise 'or', which puts all of this unit's abilities in r0
mov		r1,#0x80
lsl		r1,#1			@multiply by 2^1 = 0x100, which is 'promoted'
tst		r0,r1
beq		FixedHpGrowth
add		r6,#19			@ add 2 levels if the unit is promoted (otherwise, without 100+ growths the first level-up will always be empty)

FixedHpGrowth:
ldr		r0,Get_Hp_Growth
mov r5, #0x73 
FixedLevelUp
ldr		r0,Get_Str_Growth
mov r5, #0x74 
FixedLevelUp
@Mag, do nothing if Get_Mag_Growth is 0 yeah yeah. - Snek
ldr		r0,Get_Mag_Growth
cmp		r0,#0x00
beq		FixedSklGrowth
mov r5, #0x7A 
FixedLevelUp
FixedSklGrowth:
ldr		r0,Get_Skl_Growth
mov r5, #0x75 
FixedLevelUp
ldr		r0,Get_Spd_Growth
mov r5, #0x76 
FixedLevelUp
ldr		r0,Get_Def_Growth
mov r5, #0x77 
FixedLevelUp
ldr		r0,Get_Res_Growth
mov r5, #0x78 
FixedLevelUp
ldr		r0,Get_Luk_Growth
mov r5, #0x79 
FixedLevelUp
b CheckCaps 




@End of normal growths routine
UseTieredGrowths:
ldrb	r6,[r7,#0x8]	@ unit's level
sub		r6,#1			@subtract 1 from it (this is the number of previous level-ups)
ldr		r0,[r7]			@ rom character data pointer
ldr		r1,[r7,#0x4]	@ rom class data pointer
ldr		r0,[r0,#0x28]	@ character abilities
ldr		r1,[r1,#0x28]	@ class abilities
orr		r0,r1			@ bitwise 'or', which puts all of this unit's abilities in r0
mov		r1,#0x80
lsl		r1,#1			@multiply by 2^1 = 0x100, which is 'promoted'
tst		r0,r1
beq		TieredHpGrowth
add		r6,#19			@ add 2 levels if the unit is promoted (otherwise, without 100+ growths the first level-up will always be empty)


TieredHpGrowth:
mov r5, #0 
ldr	r0,Get_Hp_Growth
mov r1, #0 @ hp 
mov r2, r7 @ Unit 
ldr r3, GetAverageStat
mov r14, r3
mov r3, r6 @ Levels gained 
.short 0xf800
@ r0 is the average stat 
mov r1, #0x12 @ stat 
mov r2, r7 @ unit 

@ r0 = average stat 
@ r1 = stat byte 
@ r2 = atkr/dfdr/unit 
@ r3 = growth function 
ldr r3, TieredLevelUp
mov r14, r3
ldr	r3,Get_Hp_Growth
.short 0xf800
add r5, r0 @ stats gained
mov r3, #0x73 
mov r2, r7 
strb r0, [r2, r3] 

ldr	r0,Get_Str_Growth
mov r1, #1 @ str
mov r2, r7 @ Unit 
ldr r3, GetAverageStat
mov r14, r3
mov r3, r6 @ Levels gained 
.short 0xf800
@ r0 is the average stat 
mov r1, #0x14 @ stat 
mov r2, r7 @ unit 
ldr r3, TieredLevelUp
mov r14, r3
ldr	r3,Get_Str_Growth
.short 0xf800
add r5, r0 @ stats gained
mov r3, #0x74 
mov r2, r7 
strb r0, [r2, r3] 

ldr	r0,Get_Mag_Growth
cmp r0, #0 
beq SkipMag
mov r1, #7 @ mag
mov r2, r7 @ Unit 
ldr r3, GetAverageStat
mov r14, r3
mov r3, r6 @ Levels gained 
.short 0xf800
@ r0 is the average stat 
mov r1, #0x3a @ stat 
mov r2, r7 @ unit 
ldr r3, TieredLevelUp
mov r14, r3
ldr	r3,Get_Mag_Growth
.short 0xf800
add r5, r0 @ stats gained
mov r3, #0x7a 
mov r2, r7 
strb r0, [r2, r3] 

SkipMag:

ldr	r0,Get_Skl_Growth
mov r1, #2 @ skl
mov r2, r7 @ Unit 
ldr r3, GetAverageStat
mov r14, r3
mov r3, r6 @ Levels gained 
.short 0xf800
@ r0 is the average stat 
mov r1, #0x15 @ stat 
mov r2, r7 @ unit 
ldr r3, TieredLevelUp
mov r14, r3
ldr	r3,Get_Skl_Growth
.short 0xf800
add r5, r0 @ stats gained
mov r3, #0x75 
mov r2, r7 
strb r0, [r2, r3] 

ldr	r0,Get_Spd_Growth
mov r1, #3 @ spd 
mov r2, r7 @ Unit 
ldr r3, GetAverageStat
mov r14, r3
mov r3, r6 @ Levels gained 
.short 0xf800
@ r0 is the average stat 
mov r1, #0x16 @ stat 
mov r2, r7 @ unit 
ldr r3, TieredLevelUp
mov r14, r3
ldr	r3,Get_Spd_Growth
.short 0xf800
add r5, r0 @ stats gained
mov r3, #0x76 
mov r2, r7 
strb r0, [r2, r3] 

ldr	r0,Get_Def_Growth
mov r1, #4 @ def 
mov r2, r7 @ Unit 
ldr r3, GetAverageStat
mov r14, r3
mov r3, r6 @ Levels gained 
.short 0xf800
@ r0 is the average stat 
mov r1, #0x17 @ stat 
mov r2, r7 @ unit 
ldr r3, TieredLevelUp
mov r14, r3
ldr	r3,Get_Def_Growth
.short 0xf800
add r5, r0 @ stats gained
mov r3, #0x77 
mov r2, r7 
strb r0, [r2, r3] 

ldr	r0,Get_Res_Growth
mov r1, #5 @ res 
mov r2, r7 @ Unit 
ldr r3, GetAverageStat
mov r14, r3
mov r3, r6 @ Levels gained 
.short 0xf800
@ r0 is the average stat 
mov r1, #0x18 @ stat 
mov r2, r7 @ unit 
ldr r3, TieredLevelUp
mov r14, r3
ldr	r3,Get_Res_Growth
.short 0xf800
add r5, r0 @ stats gained
mov r3, #0x78 
mov r2, r7 
strb r0, [r2, r3] 

ldr	r0,Get_Luk_Growth
mov r1, #6 @ luck 
mov r2, r7 @ Unit 
ldr r3, GetAverageStat
mov r14, r3
mov r3, r6 @ Levels gained 
.short 0xf800
@ r0 is the average stat 
mov r1, #0x19 @ stat 
mov r2, r7 @ unit 
ldr r3, TieredLevelUp
mov r14, r3
ldr	r3,Get_Luk_Growth
.short 0xf800
add r5, r0 @ stats gained
mov r3, #0x79
mov r2, r7 
strb r0, [r2, r3] 

ldr r0, MinimumStatsOnLevelUp
cmp		r5,r0 @if 2 or more stats, we're happy 
bge CheckCaps 
add r4, #1 
@ At the end of each iteration, we break if at least 2 stats leveled up 
				@ If 0 or 1 stats did, we do an entire iteration again 

cmp 	r4, #10 @ We will try up to 10 times 

bge 	Stupid
b UseTieredGrowths
Stupid:
cmp r5, #1 
blt Sexy
b CheckCapsLadder
Sexy: 
cmp r6, #20
bge Flanders
b CheckCapsLadder
Flanders:

b CheckCapsLadder


DivideBy100:
@takes r0=number, divides by 100, returns remainder in r0 and quotient in r1
mov		r1,#0
Label4:
cmp		r0,#100
blt		RetDiv
sub		r0,#100
add		r1,#1
b		Label4
RetDiv:
bx		r14

CheckCaps:
ldr		r0,Get_Char_Data
mov		r14,r0
ldrb	r0,[r7,#0xB]		@ allegiance byte
.short	0xF800
ldr		r1,Check_Caps_Func
mov		r14,r1
mov		r1,r7
.short	0xF800


Exit:
pop {r7}
mov r8, r7 
pop	{r4-r7}		
pop {r0}
bx r0 



.ltorg
.align
Can_Gain_Exp:
.long 0x0802B9F4
Calc_Level_Up:
.long 0x0802B9A0
Get_Char_Data:
.long 0x08019430
Check_Caps_Func:
.long 0x0802BF24
Check_Event_ID:
.long 0x08083DA8
Class_Level_Cap_Table:

