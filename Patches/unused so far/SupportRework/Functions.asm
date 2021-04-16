
.thumb
.type FindCharacter, %function
FindCharacter: @ r0 = character to find. Returns character struct.
cmp r0, #0xFF
bne FindCharacterNotTact
	ldr r0, =#0x0202BE4C @ Return first character struct if this is Tact we're looking for.
	bx lr
FindCharacterNotTact:
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
EndFindCharacter:
pop { r4 }
bx lr
FindCharacterNoCharacter:
mov r0, #0x00
b EndFindCharacter

.type GetTextStringFromID, %function
GetTextStringFromID: @ r0 = text ID. Returns pointer to text.
ldr r1, =TextTable
mov r2, #0x04
mul r0, r2
add r0, r0, r1
ldr r0, [ r0 ]
lsl r0, r0, #0x01
lsr r0, r0, #0x01
bx lr

.type CopyString, %function
CopyString: @ r0 = pointer to string to copy, r1 = destination. Returns the length of the string copied.
push { r4, r5 }
mov r4, r0
mov r5, r1
mov r0, #0x00
CopyStringLoop:
ldrb r1, [ r4, r0 ]
cmp r1, #0x00
beq EndCopyString
strb r1, [ r5, r0 ]
add r0, r0, #0x01
b CopyStringLoop
EndCopyString:
pop { r4, r5 }
bx lr

.type ClearMemorySlot2, %function
ClearMemorySlot2:
mov r0, #0x00
ldr r1, =#0x030004C4
str r0, [ r1 ]
bx lr

.type ClearRAM, %function
ClearRAM: @ r0 = start offset, r1 = number of bytes to clear.
mov r2, #0x00
ClearRAMLoop:
strb r2, [ r0 ]
sub r1, r1, #0x01
add r0, r0, #0x01
cmp r1, #0x00
bne ClearRAMLoop
bx lr

.type GetCharacterDistance, %function
GetCharacterDistance: @ r0 = character struct 1, r1 = character struct 2. Returns distance between units.
push { r4, r5 }
mov r4, r0 @ Character struct 1
mov r5, r1 @ Character struct 2
ldrb r0, [ r4, #0x0C ]
mov r1, #0x04
tst r0, r1
beq CharacterNotDead
	mov r0, #0xFF
	b EndIsCharacterWithin3Tiles @ This character is dead. Return 0xFF.
CharacterNotDead:
ldrb r0, [ r4, #0x10 ] @ X coordinate of character struct.
cmp r0, #0xFF
beq EndIsCharacterWithin3Tiles @ This character is not deployed. Return 0xFF.
ldrb r1, [ r5, #0x10 ] @ X coordinate of battle struct.
sub r0, r0, r1
cmp r0, #0x00
bge NotNegativeX
	neg r0, r0
NotNegativeX:
ldrb r1, [ r4, #0x11 ] @ Y coordinate of the character struct.
ldrb r2, [ r5, #0x11 ] @ Y coordinate of the battle struct.
sub r1, r1, r2
cmp r1, #0x00
bge NotNegativeY
	neg r1, r1
NotNegativeY:
add r0, r0, r1 @ Has the total distance between these units.
EndIsCharacterWithin3Tiles:
pop { r4, r5 }
bx lr

.type FindUnitCoords, %function
FindUnitCoords: @ r0 = X, r1 = Y. Returns character struct of the allied unit at these coords. Returns 0 if none.
ldr r2, =#0x0202BE4C @ Beginning of allied character struct.
sub r2, r2, #0x48
FindUnitLoop:
add r2, r2, #0x48
ldr r3, [ r2 ]
cmp r3, #0x00
beq FindUnitReturn0
	ldrb r3, [ r2, #0x10 ]
	cmp r0, r3
	bne FindUnitLoop
	ldrb r3, [ r2, #0x11 ]
	cmp r1, r3
	bne FindUnitLoop
	mov r0, r2
	bx lr
FindUnitReturn0:
mov r0, #0x00
bx lr

.type FindSupportData, %function
FindSupportData: @ r0 = character struct to look in, r1 = target character. Returns the number of bytes from 0x34 of the character struct to this support.
add r0, r0, #0x34 @ Start of support data.
mov r2, #0x00 @ r2 is a counter.
sub r2, r2, #0x01
FindSupportDataLoop:
add r2, r2, #0x01
cmp r2, #0x05
beq EndFindSupportDataNoSupport
ldrb r3, [ r0, r2 ]
cmp r1, r3
bne FindSupportDataLoop
mov r0, r2
bx lr
EndFindSupportDataNoSupport:
mov r0, #0x00
mvn r0, r0
bx lr @ Return -1 is no support was found.

.type GetSupportLevel, %function
GetSupportLevel: @ r0 = character struct, r1 = number of bytes to the support from 0x34. Returns support level.
ldrh r0, [ r0, #0x32 ] @ r0 has the support level halfword.
lsl r1, r1, #0x01 @ Multiply r1 by 2.
lsl r0, r0, r1
lsl r0, r0, #16
lsr r0, r0, #30 @ r0 has this isolated support level.
bx lr

.type IncreaseSupport, %function
IncreaseSupport: @ r0 = character struct to set in, r1 = supporting character. Assume we're increasing the support level by 1.
push { r4 - r6, lr }
mov r4, r0 @ Character struct.
mov r5, r1 @ Supporting character.
bl FindSupportData @ r0 has number of bytes from 0x34 to the support.
mov r1, #0x00
mvn r1, r1
cmp r0, r1
bne IncreaseSupportNotCSupport
	@ No support found. Add a support.
	mov r0, r4
	mov r1, r5
	bl AddSupport
	b EndIncreaseSupport
IncreaseSupportNotCSupport:
mov r6, r0 @ Store the support location in r6.
mov r0, r4
mov r1, r6
bl GetSupportLevel
cmp r0, #0x03
beq EndIncreaseSupport @ A support detected. Let's just end.
@ r0 has this isolated support level.
add r2, r0, #0x01
mov r0, r4
mov r1, r6
bl SetSupport
EndIncreaseSupport:
pop { r4 - r6 }
pop { r0 }
bx r0

.type SetSupport, %function
SetSupport: @ r0 = character struct, r1 = location of support, r2 = level to set to.
push { r4 }
mov r4, r0 @ Store the character struct in r0.
mov r3, #0x03
lsl r3, r3, #14
lsl r1, r1, #0x01 @ Multiply the location by 2.
lsr r3, r3, r1
mvn r3, r3
ldrh r0, [ r4, #0x32 ]
and r0, r0, r3 @ Clears the old support level.

lsl r2, r2, #14
lsr r2, r2, r1
orr r0, r0, r2
strh r0, [ r4, #0x32 ]
pop { r4 }
bx lr

.type AddSupport, %function
AddSupport: @ Finds new space for a support and adds it. r0 = character struct, r1 = target character.
push { r4, r5 }
mov r4, r0
mov r5, r1
mov r0, #0x00 @ r0 is a counter.
add r4, r4, #0x34
AddSupportLoop:
cmp r0, #0x05
beq EndAddSupport @ There is no room, so... let's just end.
ldrb r1, [ r4, r0 ]
add r0, r0, #0x01
cmp r1, #0x00
bne AddSupportLoop
sub r0, r0, #0x01
@ r0 has the number of bytes from 0x34 of the first free support.
mov r1, r5
strb r1, [ r4, r0 ] @ Stores the supporting character.
sub r4, r4, #0x02 @ 0x32 for the support level short.
mov r1, #0x01
lsl r0, r0, #0x01 @ Multiply r0 by 2.
lsl r1, r1, #14
lsr r1, r1, r0
ldrh r2, [ r4 ]
orr r1, r1, r2
strh r1, [ r4 ]
EndAddSupport:
pop { r4, r5 }
bx lr

.type CountSupports, %function
CountSupports: @ r0 = character struct. Returns the number of supports.
mov r2, #0x00
ldrb r1, [ r0, #0x0B ] @ Allegiance byte.
lsr r1, r1, #0x6
cmp r1, #0x00
bne EndCountSupports @ This character is not an ally. They can't have any supports.
mov r1, #0x00 @ r1 is a counter.
add r0, r0, #0x34
CountSupportsLoop:
cmp r1, #0x05
beq EndCountSupports
ldrb r3, [ r0, r1 ]
add r1, r1, #0x01
cmp r3, #0x00
beq CountSupportsLoop
add r2, r2, #0x01
b CountSupportsLoop
EndCountSupports:
mov r0, r2
bx lr

.align
.ltorg
