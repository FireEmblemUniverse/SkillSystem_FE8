.thumb
.global ModularPreBattleSkill
.type ModularPreBattleSkill, %function

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm
.equ d100Result, 0x802a52c

ModularPreBattleSkill:
push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

mov r7, #0x00		@counter of which row in the table to check

CheckNextSkill:
cmp r7, #0x64		@quit if bigger than table's # of rows, or skill id was 0
bge End
add r7, #0x01
bl CheckSkill
cmp r0, #0x00
beq CheckNextSkill
b Preloop

End:
pop { r4 - r7 }
pop { r3 }
bx r3


@r0, r1, r2 free
@pre-loop set a counter

Preloop: 		@r7 has which row of the table to do in it
ldr r1, =ModularPreBattleTable
mov r0, r7		@copy skill id into r0
mov r2, #64 		@ 64 bytes per entry

mul r0, r2 		@entry of the skill we have eg. r0 = 1 * 64
add r2, r1, r0 		@Now we have the pointer to the table entry in r2

mov r6, #3		@r6 as counter for going through the columns

@iteration 1: we do stuff based on #0x04, #0x05, and #0x06 in ModularPreBattleTable
@iteration 2: we do stuff based on #0x07, #0x08, and #0x09 in ModularPreBattleTable
@iteration 3: we do stuff based on #0x0A, #0x0B, and #0x0C in ModularPreBattleTable
@etc.. 



@Must be combat art? 0 = any
ldr r0,=#0x0203F101
ldrb r0,[r0]
ldrb r1,[r2,#2]		@r1 now holds cmb art id
cmp r0, r1 		@exit if not combat art ID
beq LoopStart
cmp r1, #0
bne CheckNextSkill	@it must be that combat art, so we break

LoopStart:
	@Step 1. Break if we are done looping. 
add r6, r6, #1		@counter +1 (4, 7, A, D, 10, 13, etc.)

			@r2 still has our =ModularPreBattleTable row
	@ldrb r0,[r2,#3]		@r0 now holds iteration goal
	@add r0, r0
	@add r0, r0		@r0 * 3 = when to stop 
mov r0, #0xFF
cmp r6, r0		@is counter is greater than # of iterations?
bge CheckNextSkill			@if so, break outta the loop



	@step 2. Load from character/battle struct 

			@r2 still has =SkillXNumbers 
ldrb r1,[r2,r6]		@r1 is 3x+1 entry of table (CBSByte)
			@eg. 4, 7, A, D, 10, 13, etc. 



	@step 3. loop to figure out byte vs short

mov r3, #0
CheckIfShortLoop:
ldr r0, =SignedShortList	@see ModularPreBattleSkill.event or Teq Doc battle struct for list
ldrb r0,[r0,r3]			@r0 iterates through a list of values that are Shorts
add r3, r3, #1
cmp r0, #0		
beq TryUnsignedShortInstead		@we reached the end of the list (cmp r0, #0)
cmp r0, r1
beq ItIsAShort
b CheckIfShortLoop

TryUnsignedShortInstead:
mov r3, #0

CheckIfUnsignedShortLoop:
ldr r0, =UnsignedShortList
ldrb r0,[r0,r3]		@r0 iterates through a list of values that are Bytes
add r3, r3, #1
cmp r0, #0
beq TryByteLoopInstead 		@we reached the end of the list (cmp r0, #0)
cmp r0, r1
beq ItIsAnUnsignedShort
b CheckIfUnsignedShortLoop

TryByteLoopInstead:
mov r3, #0

CheckIfByteLoop:
ldr r0, =SignedByteList
ldrb r0,[r0,r3]		@r0 iterates through a list of values that are Bytes
add r3, r3, #1
cmp r0, #0
beq CheckNextSkill	@end of list and invalid parameter given, so try next skill 
cmp r0, r1
beq ItIsAByte
b CheckIfByteLoop

ItIsAShort:
mov r3, #4
ldrh r0,[r4,r1]		@
b OperationToUse

ItIsAnUnsignedShort:
mov r3, #3
ldrh r0,[r4,r1]		@
b OperationToUse

ItIsAByte:
mov r3, #2
ldrb r0,[r4,r1]		@
b OperationToUse

OperationToUse:
add r6, r6, #1		@counter +1 (5, 8, B, E, 11, 14, etc.)

	@step 4. get 3x+2 entry of table and branch 
ldrb r1,[r2,r6]		@add? subtract? or fraction? etc.  
add r6, r6, #1		@counter +1 (6, 9, C, F, 12, 15, etc.)
			@3x+3 entry of table 

cmp r1, #1		@branch based on table's entry 
beq Add			@1 = add, 2 = sub, 3 = fraction 
cmp r1, #2
beq Sub			@subtracts unit's current value by specified amount
cmp r1, #3
beq Fraction		@4-bit: 0x32 = multiply by 3, then divide by 2
cmp r1, #4
beq LsFraction		@4-bit: 0x32 = shift left by 3 (eg. multiply by 2^3=8), then right by 2 (divide by 4)
mov r6, #0xFF
b CheckNextSkill		@invalid operation, so end 

Add:
ldrb r1,[r2,r6]		@by this number 
add r0,r1 		@
b ChooseCap

Sub:
ldrb r1,[r2,r6]		@by this number 
sub r0,r1 		@
b ChooseCap

LsFraction:
ldrb r1,[r2,r6]		 
lsr r1, r1, #4		@0000000X // # of left shifts
lsl r0,r1 		@shifted left

ldrb r1,[r2,r6]	
lsl r1, r1, #28		@Y0000000 
lsr r1, r1, #28		@0000000Y // # of right shifts
lsr r0,r1 		@shifted right
b ChooseCap


Fraction:
ldrb r1,[r2,r6]		@000000XY
	       @mov r1, #000000XY

@#0x080D18FC uses r0-r3 to divide?
@i'm using r2 as my table row and r3,r6-r7 as single byte counters
@rearrange/condense registers
lsl r7, r7, #8		@0000r700
add r7, r7, r6		@0000r7r6
lsl r7, r7, #8		@00r7r600
add r7, r7, r3		@00r7r6r3
mov r6, r2

@now take our fraction byte and get the multiplier r3 & divisor r1
mov r3, r1
lsr r3, r3, #4		@0000000X // Multiplier
lsl r1, r1, #28		@Y0000000 
lsr r1, r1, #28		@0000000Y // Divisor

@r0 / r1 = number
@mov r0, #45		@eg. dmg
@mov r1, #5		@divisor
mul r0, r0, r3		@Multiply first
blh #0x080D18FC, r2 	@Then divide. puts new value into r0


@fix registers afterwards
mov r2, r6
 			@r7 is = 00r7r6r3
mov r3, r7
lsl r3, r3, #24		@r3000000
lsr r3, r3, #24		@000000r3 // 

mov r6, r7		@00r7r6r3
lsl r6, r6, #16		@r6r30000 
lsr r6, r6, #24		@000000r6 // 

lsr r7, r7, #16		@000000r7


ChooseCap:
cmp r3, #3 		@was in UnsignedShortList
bne CheckCap

HigherCap:
mov r1, #0xFF
cmp r0, r1 @unsigned cap of 255
ble NotCap
mov r0, #0xFF
b NotCap

CheckCap:
cmp r0, #0x7f @signed cap of 127
ble NotCap
mov r0, #0x7f

NotCap:
sub r6, r6, #2		@counter -2 (4, 7, A, D, 10, 13, etc.)
			@r2 has our table CBS entry now 
ldrb r1,[r2,r6]		@r1 is now the 3x+1 entry of your table

cmp r3, #2		
beq StoreByte
cmp r3, #3
beq StoreShort
cmp r3, #4
beq StoreShort
b LoopStart		@store nothing if not a byte or short somehow

StoreByte:
strb r0, [r4, r1]
add r6, r6, #2
b LoopStart

StoreShort:
strh r0, [r4, r1] 	@final value stored back in
add r6, r6, #2		@counter +2 (6, 9, C, F, 12, 15, etc.)
b LoopStart




CheckSkill:
push { lr }
ldr r1, =ModularPreBattleTable
mov r0, r7		@copy skill id into r0
mov r2, #64 		@ 64 bytes per entry
mul r0, r2 		@entry of the skill we have eg. r0 = 1 * 64
add r2, r1, r0 		@Now we have the pointer to the entry we want

ldrb r1, [ r2, #1 ] 	@r1 now has the skill id to have the effect
cmp r1, #0
beq BreakOut		@no skill ID this row of the table 
mov r0, r4
blh SkillTester, r3
pop { r3 }
bx r3

BreakOut:
mov r0, r4
blh SkillTester, r3	@Skill id was 0 so we terminate by making the counter 0xFF
mov r7, #0xFF		@I'm sure there is a better way to do this *shrugs*
pop { r3 }
bx r3

