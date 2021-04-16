
.thumb

@ Vanilla does A > 0xF0 > B > 0xA0 > C > 0x50. This is read and analyzed at 0x0802823C
	@ The most efficient way to do this is store both the character ID and support level in the character struct, but this will take up 10 bits.
	@ Over 8 bytes of space in each character struct, this means there are 64 bits at our disposal.
	@ If we're fancy, we can fit 6 individual support partners into here.
	
	
@ It seems that while caculating support bonuses, they are written to a temporary bit of RAM: 0x03007CF0
	@ These are then used to add bonuses to the battle struct.
	@ These are added at 0x0802A9F4
		@ 0x01: Byte: Attack bonus
		@ 0x02: Byte: Defense bonus
		@ 0x03: Byte: Hit bonus
		@ 0x04: Byte: Avoid bonus
		@ 0x05: Byte: Crit bonus
		@ 0x06: Byte: Crit avoid bonus
		
		
		@ I think I should be able to completely rewrite the support calculation system. All I need to do is rewrite the master function to reflect this... easier said than done...?
	
	@ Here's the plan: Each support in a character struct takes 10 bits. The word at 0x32 of the character struct will hold the first 3, and 0x36 will have the last 3.
	@ Each support will have the bottom 2 bits as the support level (0, 1, 2, 3) and the top 8 as the character ID.
.global PrepScreenSupportUsability
.type PrepScreenSupportUsability, %function
PrepScreenSupportUsability: @ Whether to show the "Support" option in the prep screen.
@ Return true (0x01) if there are supports to be seen this chapter. Return false (0x03) if there are no supports or none left.
push { r4 - r6, lr }
ldr r4, =BaseSupportTable
ldr r0, =#0x0202BCF0
ldrb r0, [ r0, #0x0E ] @ Chapter ID
mov r1, #24 @ Bytes per entry
mul r0, r1
add r4, r0 @ r4 contains the pointer to this chapter's entry of the Base Support Table.
sub r4, #3
mov r1, #0x00 @ r1 is a counter.
sub r1, #0x01
StartMainUsabilityLoop:
add r4, #3 @ 3 bytes per support partner.
add r1, #1
cmp r1, #8
beq EndPrepScreenSupportUsabilityFalse @ End of the list. No support was found.
ldrb r0, [ r4 ]
cmp r0, #0x00
beq EndPrepScreenSupportUsabilityFalse @ Terminator code. No support was found.
	@ I have a valid character. Let's make sure both this character and the partner exist and aren't dead.
	bl FindCharacter
	cmp r0, #0x00
	beq StartMainUsabilityLoop @ Character doesn't exist. (tbh not sure when this would happen but w/e)
	mov r5, r0 @ r5 has 1st character's character struct.
	ldrb r0, [ r5, #0x0C ]
	mov r1, #0x04
	tst r0, r1
	bne StartMainUsabilityLoop @ Character is dead.
	
	ldrb r0, [ r4, #0x01 ] @ All the same as before except for the 2nd character.
	bl FindCharacter
	cmp r0, #0x00
	beq StartMainUsabilityLoop
	ldrb r0, [ r0, #0x0C ]
	mov r1, #0x04
	tst r0, r1
	bne StartMainUsabilityLoop
		@ Now we need to check if this support can be attained based on the current support level. (i.e. if it's an A, they must currently have a B)
		mov r0, r4 @ Character struct
		ldrb r1, [ r4, #0x01 ] @ Target character ID
		bl FindSupportData @ r0 has the number of bits from 0x32 of the character struct.
		mov r2, #0x00
		mvn r2, r2
		cmp r0, r2
		beq NoSupportRank
			mov r1, r0
			mov r0, r4
			bl GetSupportLevel
			b HandleSupportLevel
		NoSupportRank:
			mov r0, #0x00
		HandleSupportLevel: @ At this point, r0 has the support level between these characters. Only allow a support if the support level is one less than what's granted for this convo.
		ldrb r1, [ r4, #0x03 ] @ Support level gained by this convo.
		sub r1, #0x01
		cmp r0, r1
		bne StartMainUsabilityLoop @ End if this support is unatainable depending on the current support levels.
			@ We've found at least one support that's attainable. Return true.
			mov r0, #0x01
			b EndPrepScreenSupportUsability
EndPrepScreenSupportUsabilityFalse:
mov r0, #0x03
EndPrepScreenSupportUsability:
pop { r4 - r6 }
pop { r1 }
bx r1

.global PrepScreenSupportEffect
.type PrepScreenSupportEffect, %function
PrepScreenSupportEffect:
bx lr

FindCharacter: @ r0 = character to find. Returns character struct.
push { r4 }
mov r4, r0
ldr r0, =#0x0202BE4C
sub r0, #0x48
StartFindCharacterLoop:
add r0, #0x48
ldr r1, [ r0 ]
cmp r1, #0x00
beq FindCharacterNoCharacter
ldrb r1, [ r1, #0x04 ] @ Character number.
cmp r1, r4
bne StartFindCharacterLoop
mov r0, r4
pop { r4 }
bx lr
FindCharacterNoCharacter:
mov r0, #0x00
pop { r4 }
bx lr

FindSupportData: @ r0 = character struct to look in, r1 = target character. Returns the number of bits from 0x32 of the character struct to this support.
push { r4, r5 }
mov r4, r0 @ r4 = character struct
mov r5, r1 @ r5 = target character
add r4, #0x32 @ Start of this character's support data.
mov r0, #0x00 @ r6 is a counter.
sub r0, #0x01
ldr r1, [ r4 ] @ Holds the first 3 supports.
FindSupportDataLoop1:
add r0, #1
cmp r0, #3
beq ExitFindSupportDataLoop1
	mov r2, #10
	mul r2, r6
	lsl r1, r1, r2 @ Shifts to the left by 10 * the counter. Trims off already checked characters.
	mov r2, #20
	mov r3, #10
	mul r3, r0
	sub r2, r3
	lsr r1, r1, r2 @ Shifts to the right by 20 - ( 10 * the counter ). Trims off supports to check.
	@ r2 now has the current support to look at. Lowest 2 bits are the support level. 3rd - 10th are the character ID.
	lsr r1, r1, #0x02 @ r2 now has the character ID.
	cmp r1, r5
	bne FindSupportDataLoop1
		@ The characters are the same. Return the number of bits from 0x32. This will be the counter times 10 in this case.
		mov r1, #10
		mul r0, r1
		b EndFindSupportData
ExitFindSupportDataLoop1: @ If we're here, the support data doesn't exist in the first word. Let's check the second word.
mov r0, #0x00 @ r0 is a counter.
sub r0, #0x01
ldr r1, [ r4, #0x04 ] @ Holds the last 3 supports.
FindSupportDataLoop2:
add r0, #1
cmp r0, #3
beq ExitFindSupportDataLoop2
	mov r2, #10
	mul r2, r0
	lsl r1, r1, r2 @ Shifts to the left by 10 * the counter. Trims off already checked characters.
	mov r2, #20
	mov r3, #10
	mul r3, r0
	sub r2, r3
	lsr r1, r1, r2 @ Shifts to the right by 20 - ( 10 * the counter ). Trims off supports to check.
	@ r2 now has the current support to look at. Lowest 2 bits are the support level. 3rd - 10th are the character ID.
	lsr r1, r1, #0x02 @ r2 now has the character ID.
	cmp r1, r5
	bne FindSupportDataLoop2
		@ The characters are the same. Return the number of bits from 0x32. This will be the counter * 10 + 32 in this case.
		mov r1, #10
		mul r0, r1
		add r0, #32
		b EndFindSupportData
ExitFindSupportDataLoop2: @ If we're here, these characters have no support. Return -1.
mov r0, #0x00
mvn r0, r0
EndFindSupportData:
pop { r4, r5 }
bx lr

GetSupportLevel: @ r0 = character struct, r1 = number of bits to the support level. Returns support level.
cmp r1, #32
bge Spot2
	@ Spot1:
	ldr r0, [ r0 ]
	lsl r0, r0, r1
	lsl r0, r0, #8
	lsr r0, r0, #30
	bx lr
Spot2:
	sub r1, #32
	ldr r0, [ r0, #0x04 ]
	lsl r0, r0, r1
	lsl r0, r0, #8
	lsr r0, r0, #30
	bx lr

.global IncreaseSupport
.type IncreaseSupport, %function
IncreaseSupport: @ r0 = character struct to set in, r1 = supporting character. Assume we're increasing the support level by 1.
push { r4 - r6, lr }
mov r4, r0 @ Character struct
mov r5, r1 @ Supporting character
bl FindSupportData @ r0 has the number of bits to the support data from 0x32. -1 if there's no support.
mov r1, #0x00
mvn r1, r1
cmp r0, r1
bne IncreaseSupportSetC
	mov r6, r0 @ Number of bits to the support data from 0x32.
	mov r0, r4
	mov r1, r6
	bl GetSupportLevel @ r0 = this support level.
	add r0, r0, #1
	mov r2, r0
	mov r0, r4
	mov r1, r6
	bl SetSupportData
	b EndIncreaseSupport
IncreaseSupportSetC: @ Ah hell. If we're here, we need to add a support.
mov r0, r4
mov r1, r5
bl AddSupport
EndIncreaseSupport:
pop { r4 - r6 }
pop { r0 }
bx r0

SetSupportData: @ r0 = character struct to set in, r1 = number of bits from 0x32, r2 = level to set.
push { r4 - r6 }
mov r4, r0 @ r4 = character struct
mov r5, r1 @ r5 = location of support
mov r6, r2 @ r6 - level to set
cmp r5, #32
bge SetSupportDataSecond
	@ SetSupportDataFirst
	add r1, #8
	mov r2, #3
	lsl r2, r2, #30
	lsr r2, r2, r1 @ r2 has only where bits are set where this support level is.
	mvn r2, r2 @ r2 has all bits set EXCEPT where this support is.
	mov r3, #0x32
	ldr r0, [ r4, r3 ]
	and r0, r2, r2 @ r0 has the word with the support level cleared.
	mov r1, r6 @ r1 has the level to set.
	mov r2, r5 @ r2 has the location.
	lsl r1, r1, #30
	lsr r1, r1, r2
	lsr r1, r1, #8
	orr r0, r1
	str r0, [ r4, r3 ]
	b EndSetSupportData
SetSupportDataSecond:
	sub r5, #32
	add r1, #8
	mov r2, #3
	lsl r2, r2, #30
	lsr r2, r2, r1 @ r2 has only where bits are set where this support level is.
	mvn r2, r2 @ r2 has all bits set EXCEPT where this support is.
	mov r3, #0x36
	ldr r0, [ r4, r3 ]
	and r0, r2, r2 @ r0 has the word with the support level cleared.
	mov r1, r6 @ r1 has the level to set.
	mov r2, r5 @ r2 has the location.
	lsl r1, r1, #30
	lsr r1, r1, r2
	lsr r1, r1, #8
	orr r0, r1
	str r0, [ r4, r3 ]
EndSetSupportData:
pop { r4 - r6 }
bx lr
	
AddSupport: @ Finds new space for a support and adds it. r0 = character struct, r1 = target character.
push { r4, r5 }
mov r4, r0 @ Character struct
mov r5, r1 @ Target character
mov r0, #0x00 @ r0 is a counter.
mov r2, #0x32
ldr r1, [ r4, r2 ] @ r1 has the first support word.
StartAddSupportLoop1: @ First we need to find empty space.
cmp r1, #0x00
beq AddSupportFoundSpace1
	lsl r1, r1, #10
	add r0, #0x01
	cmp r0, #0x03
	bne StartAddSupportLoop1
@ Support Loop 2:
mov r2, #0x36
ldr r1, [ r4, r2 ] @ r1 has the second support word.
StartAddSupportLoop2:
cmp r1, #0x00
beq AddSupportFoundSpace2
	lsl r1, r1, #10
	add r0, #0x01
	cmp r0, #0x06
	bne StartAddSupportLoop2
		@ If we're here, they have max supports! Uh oh... let's just end.
		b EndAddSupport
AddSupportFoundSpace1: @ r0 has the counter: i.e. the number of bits from 0x32 divided by 10.
mov r1, r5 @ Target character
lsl r1, r1, #2
mov r2, #0x01
orr r1, r2 @ r1 has the support data to add.
mov r2, #10
mul r0, r2 @ r0 has the number of bits past 0x32
lsl r1, r1, #22
lsr r1, r1, r0
mov r2, #0x32
ldr r0, [ r4, r2 ]
orr r0, r1
str r0, [ r4, r2 ]
b EndAddSupport
AddSupportFoundSpace2: @ r0 has the counter.
sub r0, #0x03 @ r0 has the number of bits from 0x36
mov r1, r5 @ Target character
lsl r1, r1, #2
mov r2, #0x01
orr r1, r2 @ r1 has the support data to add.
mov r2, #10
mul r0, r2 @ r0 has the number of bits past 0x36
lsl r1, r1, #22
lsr r1, r1, r0
mov r2, #0x36
ldr r0, [ r4, r2 ]
orr r0, r1
str r0, [ r4, r2 ]
EndAddSupport:
pop { r4, r5 }
bx lr
