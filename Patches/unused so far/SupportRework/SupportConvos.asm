
.equ GetChapterEvents, 0x080346B0
.global SupportConvoUsability
.type SupportConvoUsability, %function
SupportConvoUsability: @ This function will be called from the support action menu usability to determine whether there is a viewable support. Autohook to 0x08023D14.
@ Return 0x1 for true and 0x3 for false.
push { r4 - r7, lr }
ldr r0, =#0x03004E50
ldr r4, [ r0 ] @ Store the current character struct in r4.
ldrb r0, [ r4, #0x0C ]
mov r1, #0x40
tst r0, r1
bne EndSupportConvoUsabilityFalse @ Active character is cantoing. End false.
ldr r0, [ r4 ] @ ROM character data
ldrb r6, [ r0, #0x04 ] @ Store the character ID in r6.
ldr r0, =#0x0202BE4C
cmp r0, r4
bne SupportConvoUsabilityNotActiveTact
	mov r6, #0xFF
SupportConvoUsabilityNotActiveTact:
ldr r0, =0x0202BCF0
ldrb r0, [ r0, #0x0E ] @ Chapter number.
blh GetChapterEvents, r1 @ r0 has this chapter's events.
ldr r5, [ r0, #0x04 ] @ r5 has this chapter's CharacterBasedEvents.
sub r5, r5, #0x10
SupportConvoUsabilityLoop:
add r5, r5, #0x10
ldrh r0, [ r5 ]
cmp r0, #0x00
beq EndSupportConvoUsabilityFalse @ End the loop if this is an END_MAIN. No support was found.
	ldr r0, [ r5, #12 ] @ This talk convo's extra condition.
	ldr r1, =SupportReturnFalse
	cmp r0, r1
	bne SupportConvoUsabilityLoop @ Loop back if this is not marked as a support convo.
		ldrb r0, [ r5, #0x08 ] @ Character 1
		cmp r0, r6
		beq SupportConvoUsabilityGetCharacter2
		ldrb r0, [ r5, #0x09 ] @ Character 2
		cmp r0, r6
		bne SupportConvoUsabilityLoop @ Neither character in this convo matches the active character. Loop back.
			@ SupportConvoUsabilityGetCharacter1:
			ldrb r7, [ r5, #0x08 ]
			b SupportConvoUsabilityGotCharacter
			SupportConvoUsabilityGetCharacter2:
			ldrb r7, [ r5, #0x09 ]
			SupportConvoUsabilityGotCharacter: @ The target character is in r7. Now to check if these units are adjacent.
			mov r0, r7
			bl FindCharacter
			mov r1, r4
			bl GetCharacterDistance @ r0 has the distance between these characters.
			cmp r0, #0x01
			bne SupportConvoUsabilityLoop @ These unit's aren't adjacent. Loop back.
				mov r0, r4
				mov r1, r7
				bl FindSupportData @ r0 = bytes from 0x34 for this support.
				mov r1, #0x00
				mvn r1, r1
				cmp r0, r1
				bne SupportConvoUsabilityFoundSupport
					@ No support was found. Let's see if they want to add a C support.
					ldrb r0, [ r5, #0x02 ] @ Support level of this convo.
					cmp r0, #0x01
					bne SupportConvoUsabilityLoop
						@ Let's make sure there's enough room to add this support.
						mov r0, r4
						bl CountSupports @ r0 = number of supports of the active character.
						cmp r0, #0x05
						beq SupportConvoUsabilityLoop @ Loop back if there are already 6 supports.
						mov r0, r7
						bl FindCharacter @ r0 = target character struct.
						bl CountSupports @ r0 = number of supports of the target character.
						cmp r0, #0x05
						beq SupportConvoUsabilityLoop @ Loop back if there are already 6 supports.
						mov r0, #0x01
						b EndSupportConvoUsability
				SupportConvoUsabilityFoundSupport:
				mov r1, r0
				mov r0, r4
				bl GetSupportLevel @ r0 = this support level.
				ldrb r1, [ r5, #0x02 ] @ Support level of this convo.
				add r0, r0, #0x01
				cmp r0, r1
				bne SupportConvoUsabilityLoop
					mov r0, #0x01
					b EndSupportConvoUsability
EndSupportConvoUsabilityFalse:
mov r0, #0x03
EndSupportConvoUsability:
pop { r4 - r7 }
pop { r1 }
bx r1

.equ InitTargets, 0x0804F8A4
.equ AddTarget, 0x0804F8BC
.global BuildSupportTargetList
.type BuildSupportTargetList, %function
BuildSupportTargetList: @ Sets up the target list for on-map support conversations. Autohook to 0x08025644.
push { r4 - r7, lr } @ r0 = current unit pointer.
ldr r4, =#0x02033F3C
str r0, [ r4 ]
mov r2, #0x10
ldsb r2, [ r0, r2 ]
mov r1, #0x11
ldsb r1, [ r0, r1 ]
mov r0, r2
blh InitTargets, r2
@ Now I need to add a target for each adjacent unit who can support.
@0804F8BC | AddTarget | Adds Target to the list
	@Arguments: r0 = x, r1 = y, r2 = Unit Index, r3 = Extra/Trap Id? (I don't think the game cares in general)
	@Returns:   nothing
mov r5, #0x00 @ r5 is a counter.
sub r5, r5, #0x01
BuildSupportTargetListLoop:
add r5, r5, #0x01
cmp r5, #0x04
beq EndBuildSupportTargetList
mov r1, r5
ldr r0, [ r4 ]
bl GetNextAdjacentUnit @ r0 = character struct of this adjacent unit.
cmp r0, #0x00
beq BuildSupportTargetListLoop
	@ r0 is an adjacent unit. Let's see if they are referenced in this chapter's CharacterBasedEvents.
	mov r6, r0 @ Save the character struct in r6.
	ldr r0, =#0x0202BCF0
	ldrb r0, [ r0, #0x0E ]
	blh GetChapterEvents, r1 @ r0 = this chapter's event pointer list.
	ldr r7, [ r0, #0x04 ] @ CharacterBasedEvents in r7.
	sub r7, r7, #0x10
	BuildSupportTargetListCHARLoop:
	add r7, r7, #0x10
	ldrh r0, [ r7 ] @ This event code.
	cmp r0, #0x00
	beq BuildSupportTargetListLoop @ Loop back to the main loop if this is an END_MAIN.
		ldr r0, [ r7, #12 ] @ Extra ASM condition.
		ldr r1, =SupportReturnFalse
		cmp r0, r1
		bne BuildSupportTargetListCHARLoop @ Loop back to the CHAR loop if this is not a support convo.
			ldr r2, [ r4 ]
			ldr r0, [ r2 ]
			ldrb r0, [ r0, #0x04 ] @ Active character's character ID.
			ldr r1, =#0x0202BE4C
			cmp r1, r2
			bne TargetsNotTact1
				mov r0, #0xFF
			TargetsNotTact1:
			ldrb r1, [ r7, #0x08 ] @ First character of this CHAR.
			cmp r0, r1
			beq BuildSupportTargetListFirstCharacter
				ldrb r1, [ r7, #0x09 ] @ Second character of this CHAR.
				cmp r0, r1
				bne BuildSupportTargetListCHARLoop @ Neither the first nor the second character in the CHAR matches the active character.
					@ The second character is the active character. Let's check if the first is the target character.
					ldr r2, [ r6 ]
					ldrb r0, [ r2, #0x04 ] @ Character ID of the target character.
					ldr r1, =#0x0202BE4C
					cmp r1, r6
					bne TargetsNotTact2
						mov r0, #0xFF
					TargetsNotTact2:
					ldrb r1, [ r7, #0x08 ]
					cmp r0, r1
					bne BuildSupportTargetListCHARLoop @ The target character isn't referenced in this CHAR. Try another.
					b BuildSupportTargetListCheckLevel
			BuildSupportTargetListFirstCharacter:
				ldr r2, [ r6 ]
				ldrb r0, [ r2, #0x04 ] @ Character ID of the target character.
				ldr r1, =#0x0202BE4C
				cmp r1, r6
				bne TargetsNotTact3
					mov r0, #0xFF
				TargetsNotTact3:
				ldrb r1, [ r7, #0x09 ]
				cmp r0, r1
				bne BuildSupportTargetListCHARLoop @ The Target character isn't referenced in this CHAR. Try another.			
			BuildSupportTargetListCheckLevel:
			@ Let's also check to ensure these characters have the correct support level.
			ldr r0, [ r4 ]
			ldr r2, [ r6 ]
			ldrb r1, [ r2, #0x04 ] @ Character ID of the target character.
			ldr r3, =#0x0202BE4C
			cmp r3, r6
			bne TargetsNotTact4
				mov r1, #0xFF
			TargetsNotTact4:
			bl FindSupportData
			mov r1, #0x00
			mvn r1, r1
			cmp r0, r1
			bne BuildSupportTargetListNotC
				@ There is no current support. Check if this CHAR is a C support.
				ldrb r0, [ r7, #0x02 ]
				cmp r0, #0x01
				bne BuildSupportTargetListCHARLoop @ The CHAR is not a C support. Loop back.
				@ We also need to check for both characters that there is enough room to hold another support.
				ldr r0, [ r4 ]
				bl CountSupports
				cmp r0, #0x05
				beq BuildSupportTargetListCHARLoop @ The active character already has 6 supports. Loop back.
				mov r0, r6
				bl CountSupports
				cmp r0, #0x05
				beq BuildSupportTargetListCHARLoop @ The target character already has 6 supports. Loop back.
				b AddTargetCharacter
			BuildSupportTargetListNotC:
				mov r1, r0
				ldr r0, [ r4 ]
				bl GetSupportLevel @ r0 = Current support level.
				cmp r0, #0x03
				beq BuildSupportTargetListCHARLoop @ This is an A support. Try to find another CHAR.
				add r0, r0, #0x01
				ldrb r1, [ r7, #0x02 ]
				cmp r0, r1
				bne BuildSupportTargetListCHARLoop @ The level in the CHAR is not one greater than the current level. Loop back.
			AddTargetCharacter:
			ldrb r0, [ r6, #0x10 ] @ X coordinate of the target character.
			ldrb r1, [ r6, #0x11 ] @ Y coordinate of the target character.
			ldrb r2, [ r6, #0x0B ]
			lsl r2, r2, #0x02
			lsr r2, r2, #0x02 @ Character struct ID
			ldr r3, =AddTarget
			mov lr, r3
			mov r3, #0x00
			.short 0xF800 @ No scratch registers ree.
			b BuildSupportTargetListLoop
EndBuildSupportTargetList:
pop { r4 - r7 }
pop { r0 }
bx r0

.equ GetUnit, 0x08019430
.global SupportSelected
.type SupportSelected, %function
SupportSelected: @ Autohook to 0x080323D4. 0 = parent proc (This is not useful whatsoever to me).
@ This function was a bitch to analyze because it's so unnecessarily convoluted.
@ All I need to do is TEXTSHOW 0xFFFF with the text to show. The text convo goes into memory slot 0x2.
@ Hm I also need to do the popup afterwards.
push { r4 - r6, lr }
ldr r0, =#0x03004E50
ldr r4, [ r0 ] @ Current character struct in r4.
ldr r0, =#0x0203A958
ldrb r0, [ r0, #0x0D ] @ Target's allegiance byte.
blh GetUnit, r1
mov r5, r0 @ Target character struct in r5.
ldr r0, =#0x0202BCF0
ldrb r0, [ r0, #0x0E ]
blh GetChapterEvents, r1 @ Pointer to this chapter's event pointer list in r0.
ldr r6, [ r0, #0x04 ] @ CharacterBasedEvents in r6.
sub r6, r6, #0x10
SupportSelectedLoop:
add r6, r6, #0x10
ldrh r0, [ r6 ]
cmp r0, #0x00
beq EndSupportSelected @ No CHAR was found... let's just end...
	ldr r0, =SupportReturnFalse
	ldr r1, [ r6, #12 ]
	cmp r0, r1
	bne SupportSelectedLoop @ Loop back if this isn't a support convo.
		ldr r1, [ r4 ]
		ldrb r0, [ r1, #0x04 ] @ Character ID of the active character.
		ldr r2, =#0x0202BE4C
		cmp r2, r4
		bne SelectedNotTact1
			mov r0, #0xFF
		SelectedNotTact1:
		ldrb r1, [ r6, #0x08 ] @ First character of this CHAR.
		cmp r0, r1
		beq SelectedFirst
			ldrb r1, [ r6, #0x09 ] @ Second character of this CHAR.
			cmp r0, r1
			bne SupportSelectedLoop @ The active character matches neither the first nor the last in the CHAR.
				@ So the active character is the second in the CHAR.
				ldr r1, [ r5 ]
				ldrb r0, [ r1, #0x04 ] @ Character ID of the target.
				ldr r2, =#0x0202BE4C
				cmp r2, r5
				bne SelectedNotTact2
					mov r0, #0xFF
				SelectedNotTact2:
				ldrb r1, [ r6, #0x08 ]
				cmp r0, r1
				bne SupportSelectedLoop @ The target character is not the first character.
				b SelectedFoundCharacters
		SelectedFirst:
			ldr r1, [ r5 ]
			ldrb r0, [ r1, #0x04 ] @ Character ID of the target.
			ldr r2, =#0x0202BE4C
			cmp r2, r5
			bne SelectedNotTact3
				mov r0, #0xFF
			SelectedNotTact3:
			ldrb r1, [ r6, #0x09 ]
			cmp r0, r1
			bne SupportSelectedLoop @ The second character isn't in the second CHAR slot.
				SelectedFoundCharacters: @ Now I need to make sure that this CHAR has the correct support to increase to.
				mov r0, r4
				ldr r2, [ r5 ]
				ldrb r1, [ r2, #0x04 ]
				ldr r3, =#0x0202BE4C
				cmp r3, r5
				bne SelectedNotTact4
					mov r1, #0xFF
				SelectedNotTact4:
				bl FindSupportData
				mov r1, #0x00
				mvn r1, r1
				cmp r0, r1
				bne SelectedNotCSupport
					@ No support found. Let's see if this is a C support to gain.
					ldrb r0, [ r6, #0x02 ]
					cmp r0, #0x01
					bne SupportSelectedLoop @ This is not a C support.
					b SelectedFoundIt
				SelectedNotCSupport:
				mov r1, r0
				mov r0, r4
				bl GetSupportLevel @ r0 = this support's level.
				ldrb r1, [ r6, #0x02 ]
				add r0, r0, #0x01
				cmp r0, r1
				bne SupportSelectedLoop
SelectedFoundIt: @ r6 has the pointer to this CHAR.
ldrh r0, [ r6, #0x06 ] @ 0 if this is just a regular convo.
cmp r0, #0x00
beq SelectedNoSpecial
	@ Ooh! The user has a special event to call instead of the default convo + support increase.
	ldr r0, [ r6, #0x04 ]
	mov r1, #0x00
	b SelectedCallEvents
SelectedNoSpecial:
ldrh r0, [ r6, #0x04 ] @ r0 = this support convo.
ldr r1, =#0x030004B8 @ Start of memory slots.
str r0, [ r1, #0x08 ] @ Store the convo in slot 0x2.
ldrb r0, [ r6, #0x08 ]
str r0, [ r1, #0x04 ] @ Put character 1 in slot 0x1.
ldrb r0, [ r6, #0x09 ]
str r0, [ r1, #0x0C ] @ Put character 2 in slot 0x3 (moved into slot 0x2 after text is playing in the events).
ldr r0, =SupportConvoEvents
mov r1, #0x00
SelectedCallEvents:
blh CallEventEngine, r2
EndSupportSelected:
ldr r0, =#0x0203A958
mov r1, #0x0F
strb r1, [ r0, #0x11 ]
mov r0, #0x00
pop { r4 - r6 }
pop { r1 }
bx r1

.type GetNextAdjacentUnit, %function
GetNextAdjacentUnit: @ r0 = Character struct, r1 = counter. Returns character struct of nth adjacent character or 0 if none.
push { lr }
cmp r1, #0x00
bne NextAdjacent1 @ Right
	ldrb r1, [ r0, #0x11 ] @ Y
	ldrb r0, [ r0, #0x10 ] @ X
	add r0, r0, #0x01
	bl FindUnitCoords
	b EndGetNextAdjacentUnit
NextAdjacent1:
cmp r1, #0x01
bne NextAdjacent2 @ Left
	ldrb r1, [ r0, #0x11 ] @ Y
	ldrb r0, [ r0, #0x10 ] @ X
	cmp r0, #0x00
	beq EndGetNextAdjacentUnit
	sub r0, r0, #0x01
	bl FindUnitCoords
	b EndGetNextAdjacentUnit
NextAdjacent2:
cmp r1, #0x02
bne NextAdjacent3 @ Up
	ldrb r1, [ r0, #0x11 ] @ Y
	ldrb r0, [ r0, #0x10 ] @ X
	cmp r1, #0x00
	bne DontEndUp
		mov r0, r1
		b EndGetNextAdjacentUnit
	DontEndUp:
	sub r1, r1, #0x01
	bl FindUnitCoords
	b EndGetNextAdjacentUnit
NextAdjacent3:
cmp r1, #0x03
bne EndGetNextAdjacentUnit @ Down
	ldrb r1, [ r0, #0x11 ] @ Y
	ldrb r0, [ r0, #0x10 ] @ X
	add r1, r1, #0x01
	bl FindUnitCoords
EndGetNextAdjacentUnit:
pop { r1 }
bx r1

.global SupportReturnFalse
.type SupportReturnFalse, %function
SupportReturnFalse: @ Used for storing support data in CharacterBasedEvents. This makes sure supports don't appear as regular talk events.
mov r0, #0x00
bx lr


.align
.ltorg
