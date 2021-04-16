 
 .thumb
 
.global PrepScreenSupportUsability
.type PrepScreenSupportUsability, %function
PrepScreenSupportUsability: @ Whether to show the "Support" option in the prep screen.
@ Return true (0x01) if there are supports to be seen this chapter. Return false (0x00) if there are no supports or none left.
push { r4 - r6, lr }
ldr r4, =BaseSupportTable
ldr r0, =#0x0202BCF0
ldrb r0, [ r0, #0x0E ] @ Chapter ID
mov r1, #48 @ Bytes per entry
mul r0, r1
add r4, r4, r0 @ r4 contains the pointer to this chapter's entry of the Base Support Table.
sub r4, r4, #6
mov r1, #0x00 @ r1 is a counter.
sub r1, r1, #0x01
StartMainUsabilityLoop:
add r4, r4, #6 @ 6 bytes per support convo.
add r1, r1, #1
cmp r1, #8
beq EndPrepScreenSupportUsabilityFalse @ End of the list. No support was found.
ldrb r0, [ r4 ]
cmp r0, #0x00
beq EndPrepScreenSupportUsabilityFalse @ Terminator code. No support was found.
	@ I have a valid character. Let's make sure both this character and the partner exist and aren't dead.
	bl FindCharacter
	cmp r0, #0x00
	beq StartMainUsabilityLoop @ Character doesn't exist.
	mov r5, r0 @ r5 has 1st character's character struct.
	ldrb r0, [ r5, #0x0C ]
	mov r1, #0x04
	tst r0, r1
	bne StartMainUsabilityLoop @ Character is dead.
	
	ldrb r0, [ r4, #0x01 ] @ All the same as before except for the 2nd character.
	bl FindCharacter
	cmp r0, #0x00
	beq StartMainUsabilityLoop
	mov r6, r0 @ r6 has 2nd character's character struct.
	ldrb r0, [ r0, #0x0C ]
	mov r1, #0x04
	tst r0, r1
	bne StartMainUsabilityLoop @ This character is dead. Loop back.
		@ Now we need to check if this support can be attained based on the current support level. (i.e. if it's an A, they must currently have a B)
		mov r0, r5 @ Character struct
		ldrb r1, [ r4, #0x01 ] @ Target character ID
		bl FindSupportData @ r0 has the number of bits from 0x34 of the character struct.
		mov r2, #0x00
		mvn r2, r2
		cmp r0, r2
		beq NoSupportRank
			mov r1, r0 @ r1 = number of bytes from 0x34
			mov r0, r5 @ Character struct
			bl GetSupportLevel
			b HandleSupportLevel
		NoSupportRank:
			mov r0, #0x00
		HandleSupportLevel: @ At this point, r0 has the support level between these characters. Only allow a support if the support level is one less than what's granted for this convo.
		add r0, r0, #0x01
		ldrb r1, [ r4, #0x04 ] @ Support level gained by this convo.
		cmp r0, r1
		bne StartMainUsabilityLoop @ End if this support is unatainable depending on the current support levels.
			cmp r1, #0x01
			bne PrepScreenSupportDontCountSupports
				mov r0, r5
				bl CountSupports @ Number of supports in r0.
				cmp r0, #0x05
				beq StartMainUsabilityLoop
				mov r0, r6
				bl CountSupports
				cmp r0, #0x05
				beq StartMainUsabilityLoop
			PrepScreenSupportDontCountSupports:
			@ We've found at least one support that's attainable. Return true.
			mov r0, #0x01
			b EndPrepScreenSupportUsability
EndPrepScreenSupportUsabilityFalse:
mov r0, #0x00
EndPrepScreenSupportUsability:
pop { r4 - r6 }
pop { r1 }
bx r1

.equ LoadBGConfig, 0x08001B58
.equ GetBGMapBuffer, 0x08001C4C
.equ FillBGMap, 0x08001220
.equ Text_InitFont, 0x08003C94
.equ SetColorEffectsParameters, 0x08001EA0
.equ LoadObjUIGfx, 0x08015680
.type SetScrollingBackground, %function
SetScrollingBackground: @ Creates the scrolling beige background
push { r6, lr }
mov r6, r0
mov r0, #0x00
blh LoadBGConfig, r1
mov r0, #0x00
blh GetBGMapBuffer, r1
mov r1, #0x00
blh FillBGMap, r2
blh Text_InitFont, r0 @ Sets up the text (palette, font, etc.)
blh LoadObjUIGfx, r0 @ Sets up for the glove.
mov r0, r6
mov r1, #0x00
mov r2, #0x12
ldr r3, =#0x08086CE8 @ Seems to finalize the beige, scrolling background.
mov lr, r3
mov r3, #0x02 @ ree no scratch registers
.short 0xF800
mov r0, #0x03
mov r1, #0x00
mov r2, #0x00
ldr r3, =SetColorEffectsParameters
mov lr, r3
mov r3, #0x10 @ ree no scratch registers
.short 0xF800 @ Seems to disable preliminary fading.
pop { r6 }
pop { r0 }
bx r0

.equ TextInitClear, 0x08003D5C
.equ TextClear, 0x08003DC8
.equ String_GetFromIndex, 0x0800A240
.equ Text_GetStringTextCenteredPos, 0x08003F90
.equ Text_InsertString, 0x08004480
.equ Text_Display, 0x08003E70
.global DisplayBottomText
.type DisplayBottomText, %function
DisplayBottomText: @ Displays "Select a conversation." at the bottom
push { r4 - r7, lr }
ldr r6, =#0x02013590
blh #0x080A3544, r0
mov r7, r0
mov r4, r6
sub r4, #0x08
mov r0, r4
mov r1, #0x10
blh TextInitClear, r2
mov r0, r6
mov r1, #0x09
blh TextInitClear, r2
mov r0, r4
blh TextClear, r1
ldr r0, =BaseSupportSelectConvoTextLink
ldrh r0, [ r0 ]
blh String_GetFromIndex, r1
mov r5, r0
mov r0, #0x80
mov r1, r5
blh Text_GetStringTextCenteredPos, r2
mov r1, r0
lsl r1, r1, #0x10
asr r1, r1, #0x10
mov r0, r4
mov r2, #0x00
ldr r3, =Text_InsertString
mov lr, r3
mov r3, r5 @ ree no scratch registers
.short 0xF800
ldr r5, =#0x02023136
mov r0, r4
mov r1, r5
blh Text_Display, r2
pop { r4 - r7 }
pop { r0 }
bx r0

.align
.ltorg

.equ gLCDIOBuffer, 0x03003080
.equ Text_SetFont, 0x08003D38
.equ Font_LoadForUI, 0x080043A8
.equ LoadNewUIGraphics, 0x0804EB68
.equ StartMenuChild, 0x0804EBC8
.global CallBaseSupportMenu
.type CallBaseSupportMenu, %function
CallBaseSupportMenu: @ Does not clear BG0 and BG1
push { r4, lr }
mov r4, r0
ldr r2, =gLCDIOBuffer
ldrb r0, [ r2, #0x01 ]
mov r1, #0x01
orr r0, r1
mov r1, #0x02
orr r0, r1
mov r1, #0x04
orr r0, r1
mov r1, #0x08
orr r0, r1
mov r1, #0x10
orr r0, r1
strb r0, [ r2, #0x01 ]
mov r0, #0x00
blh Text_SetFont, r3
blh Font_LoadForUI, r3
blh LoadNewUIGraphics, r3
@ldr r0, =BaseSupportMenuGeometry
ldr r0, =#0x0203F278 @ This has been written to RAM to account for a variable number of menu items
mov r1, r4
blh StartMenuChild, r2
pop { r4 }
pop { r0 }
bx r0

.align
.ltorg

.equ ChapterDataStruct, 0x0202BCF0
.global BuildSupportMenuGeometry
.type BuildSupportMenuGeometry, %function
BuildSupportMenuGeometry:
push { r4 - r7, lr }
ldr r0, =BaseSupportTable
ldr r1, =ChapterDataStruct
ldrb r1, [ r1, #0x0E ]
mov r2, #48
mul r1, r2
add r0, r0, r1 @ r0 has this chapter's entry in the Base Support Table.
mov r4, r0 @ Save it in r4 for later.
mov r5, #0x00 @ r5 will equal the number of supports that are viewable.
mov r6, #0x00 @ r6 is a counter.
sub r4, r4, #0x06
sub r6, r6, #0x01
StartGeometryLoop:
add r4, r4, #0x06
add r6, r6, #0x01
cmp r6, #0x08
beq EndGeometryLoop
ldr r0, [ r4 ]
cmp r0, #0x00
beq StartGeometryLoop
	ldrb r0, [ r4 ] @ First character
	bl FindCharacter @ r0 has character struct
	cmp r0, #0x00
	beq StartGeometryLoop @ No character was found. Loop back.
	mov r7, r0 @ Save the character struct in r7 for later.
	ldrb r0, [ r0, #0x0C ]
	mov r1, #0x04
	tst r0, r1
	bne StartGeometryLoop @ This character is dead. Loop back.
	ldrb r0, [ r4, #0x01 ] @ Second character
	bl FindCharacter
	cmp r0, #0x00
	beq StartGeometryLoop @ No character was found. Loop back.
	ldrb r0, [ r0, #0x0C ]
	mov r1, #0x04
	tst r0, r1
	bne StartGeometryLoop @ This character is dead. Loop back.
		@ Both characters are alive. Let's check to make sure their support levels are OK.
		mov r0, r7
		ldrb r1, [ r4, #0x01 ]
		bl FindSupportData @ r0 has the number of bits to the support data from 0x34.
		mov r1, #0x00
		mvn r1, r1
		cmp r0, r1
		bne BuildMenuGeometryHandleSupport
			mov r0, #0x00
			b BuildMenuGeometryLevel
		BuildMenuGeometryHandleSupport:
		mov r1, r0
		mov r0, r7
		bl GetSupportLevel @ r0 has the support level.
		BuildMenuGeometryLevel:
		add r0, r0, #0x01
		ldrb r1, [ r4, #0x04 ]
		cmp r0, r1
		bne StartGeometryLoop
			add r5, r5, #0x01
			b StartGeometryLoop
EndGeometryLoop: @ At this point, r5 has the number of viewable supports.
ldr r7, =#0x0203F278 @ Let's store this data here.
mov r0, r7
mov r1, #36
bl ClearRAM @ Clear old rounds data just in case.
mov r0, #0x06
strb r0, [ r7 ] @ Store X position.
cmp r5, #0x08
bne NotMaxSupportGeometry
	@ Wow! They have 8 possible supports to view. Let's set the Y position to 0.
	mov r0, #0x00
	beq GeometrySetYPosition
NotMaxSupportGeometry:
lsr r0, r5, #0x1 @ Divide r5 by 2 and put it in r0.
mov r1, #0x05
sub r0, r1, r0
GeometrySetYPosition:
strb r0, [ r7, #0x01 ] @ Store Y position.
mov r0, #18
strb r0, [ r7, #0x02 ] @ Store width.
mov r0, #0x01
str r0, [ r7, #0x04 ]
ldr r0, =BaseSupportMenuCommands
str r0, [ r7, #0x08 ] @ Pointer to commands.
pop { r4 - r7 }
pop { r0 }
bx r0

.align
.ltorg

.global BuildSupportMenuText
.type BuildSupportMenuText, %function
BuildSupportMenuText: @ This function will take the names of the two characters in the
@ support and write their names to RAM. i.e. "Arc and Luke" for usage in the base support menu.
push { r4 - r6, lr }
ldr r0, =#0x0203EFC0
ldr r1, =#320
bl ClearRAM @ Clear the RAM where the text is written.
ldr r0, =BaseSupportTable
ldr r1, =ChapterDataStruct
ldrb r1, [ r1, #0x0E ]
mov r2, #48 @ Bytes per entry
mul r1, r2
add r0, r0, r1 @ r0 has this chapter's entry in the Base Support Table.
mov r6, r0 @ Save it in r6 for later.
mov r4, #0x00
	BuildMenuText:
	ldrb r0, [ r6 ] @ r0 has the first character.
	cmp r0, #0xFF
	bne BuildMenuTextNotTact1
		ldr r0, =#0x0202BE4C
		ldr r0, [ r0 ]
		b BuildMenuTextHasCharacter1
	BuildMenuTextNotTact1:
	cmp r0, #0x00
	beq BuildNextMenuText
	ldr r1, =CharacterTable
	mov r2, #52
	mul r0, r2
	add r0, r0, r1 @ r0 has this character's entry in the character table.
	BuildMenuTextHasCharacter1:
	ldrh r0, [ r0 ] @ r0 has the text ID for this character's name.
	bl GetTextStringFromID @ r0 has the pointer to the character's name data.
	ldr r5, =#0x0203EFC0
	mov r2, #40 @ Allocate 40 bytes in this bit of RAM for the string.
	mul r2, r4
	add r5, r2, r5
	mov r1, r5
	bl CopyString
	add r5, r5, r0 @ Add the length of the string added to the RAM text offset.
	mov r0, #0x20 @ ASCI (space)
	strb r0, [ r5 ]
	add r5, r5, #0x01
	mov r0, #0x61 @ ASCI a
	strb r0, [ r5 ]
	add r5, r5, #0x01
	mov r0, #0x6E @ ASCI n
	strb r0, [ r5 ]
	add r5, r5, #0x01
	mov r0, #0x64 @ ASCI d
	strb r0, [ r5 ]
	add r5, r5, #0x01
	mov r0, #0x20 @ ASCI (space)
	strb r0, [ r5 ]
	add r5, r5, #0x01
	@ At this point, we have "(Name of the first character) and ". Time to add the second character
	ldrb r0, [ r6, #0x01 ] @ Second character's character ID
	cmp r0, #0xFF
	bne BuildMenuTextNotTact2
		ldr r0, =#0x0202BE4C
		ldr r0, [ r0 ]
		b BuildMenuTextHasCharacter2
	BuildMenuTextNotTact2:
	ldr r1, =CharacterTable
	mov r2, #52
	mul r0, r2
	add r0, r0, r1 @ r0 has this character's entry in the character table.
	BuildMenuTextHasCharacter2:
	ldrh r0, [ r0 ] @ r0 has the text ID for this character's name.
	bl GetTextStringFromID @ r0 has the pointer to the character's name data
	mov r1, r5
	bl CopyString @ Now that string was copied to follow the other text we've added
BuildNextMenuText:
add r4, #0x01
add r6, r6, #0x06
cmp r4, #0x08
bne BuildMenuText
EndBuildMenuText:
pop { r4 - r6 }
pop { r0 }
bx r0

.align
.ltorg

.equ ProcGoto, 0x08002F24
.global EnsureSelection
.type EnsureSelection, %function
EnsureSelection:
push { lr }
ldr r1, =#0x030004C4
ldrh r1, [ r1 ]
cmp r1, #0x00
bne EndEnsureSelection
	mov r1, #0x02
	blh ProcGoto, r2 @ r0 already has the parent proc
EndEnsureSelection:
pop { r0 }
bx r0

.align
.ltorg

.equ gProcMenu, 0x085B64D0
.equ ProcFind, 0x08002e9c
.equ EndProc, 0x08002D6C
.equ EndBG3Slider, 0x08086DBC
.global SetUpConvo
.type SetUpConvo, %function
SetUpConvo:
push { lr }
ldr r0, =gProcMenu
blh ProcFind, r1
blh EndProc, r1 @ Ensures that the menu proc has ended.
blh EndBG3Slider, r0
ldr r0, =#0x0203EFC0
ldr r1, =#320
bl ClearRAM @ Clear the RAM where the text is written.
ldr r0, =#0x0203F278 @ Let's store this data here.
mov r1, #36
bl ClearRAM @ Clear the RAM where the geometry data is written.
ldr r0, =BaseSupportTable
ldr r1, =ChapterDataStruct
ldrb r1, [ r1, #0x0E ]
mov r2, #48
mul r1, r2
add r0, r0, r1
ldr r1, =#0x030004C8 @ Memory slot 0x4
ldr r1, [ r1 ] @ r1 has the convo index.
sub r1, r1, #0x01
mov r2, #0x06
mul r1, r2
add r0, r0, r1 @ r4 has this convo.
ldrb r0, [ r0, #0x04 ] @ r0 has this convo's level.
sub r0, r0, #0x01
mov r1, #0x43 @ ASCII "C"
sub r0, r1, r0 @ r0 has the ASCII code for the letter to write (C, B, or A).
ldr r1, =#0x0203EFC0
strb r0, [ r1 ]
mov r0, #0x00
strb r0, [ r1, #0x01 ]
ldr r0, =#0x030004CC @ Memory slot 0x5
mov r1, #0x00
str r1, [ r0 ] @ Clear memory slot 0x5.
pop { r0 }
bx r0

.align
.ltorg

.equ StartMapEventEngine, 0x0800D0B0
.equ CallEventEngine, 0x0800D07C
.global CallConversation
.type CallConversation, %function
CallConversation:
push { lr }
ldr r0, =CallBaseConvoEvents
mov r1, #0x02
blh StartMapEventEngine, r2
EndCallConversation:
pop { r0 }
bx r0

.equ NewPopup, 0x08011474
.global BaseSupportIncreaseSupport
.type BaseSupportIncreaseSupport, %function
BaseSupportIncreaseSupport: @ Memory slot 0x4 = convo index to look at in the base support table.
push { r4, r5, lr }
mov r5, r0 @ Parent proc
ldr r0, =BaseSupportTable
ldr r1, =ChapterDataStruct
ldrb r1, [ r1, #0x0E ]
mov r2, #48
mul r1, r2
add r0, r0, r1 @ r0 has this chapter's convos.
ldr r1, =#0x030004C8 @ Memory slot 0x4
ldr r1, [ r1 ] @ r1 has the convo index.
sub r1, r1, #0x01
mov r2, #0x06
mul r1, r2
add r4, r0, r1 @ r4 has this convo.
ldrb r0, [ r4 ]
bl FindCharacter @ r0 has character struct.
ldrb r1, [ r4, #0x01 ]
bl IncreaseSupport
ldrb r0, [ r4, #0x01 ]
bl FindCharacter @ r0 has character struct.
ldrb r1, [ r4 ]
bl IncreaseSupport
ldr r0, =IncreaseSupportPopupDefinitions
mov r1, #90 @ Duration of the popup
mov r2, #0x00 @ Style of popup window
ldr r3, =NewPopup
mov lr, r3
mov r3, r5 @ Parent proc
.short 0xF800 @ No scratch registers ree
pop { r4, r5 }
pop { r0 }
bx r0

.align
.ltorg

.type CheckToEnd, %function
CheckToEnd:
push { r4, lr }
mov r4, r0
ldr r0, =#0x030004CC @ Memory slot 0x5
ldr r0, [ r0 ]
cmp r0, #0x00
bne EndCheckToEnd
	@ The event ID hasn't been triggered. Continue the proc.
	mov r0, r4
	mov r1, #0x03
	blh ProcGoto, r2
EndCheckToEnd:
pop { r4 }
pop { r0 }
bx r0

.type UnsetFinalRAM, %function
UnsetFinalRAM:
ldr r0, =#0x0203EFC0
mov r1, #0x00
strb r1, [ r0 ]
bx lr

.align
.ltorg

.global BaseSupportConvo1
.type BaseSupportConvo1, %function
BaseSupportConvo1:
ldr r0, =#0x030004C0 @ Memory slot 0x2
ldr r1, =BaseSupportTable
ldr r2, =ChapterDataStruct
ldrb r2, [ r2, #0x0E ]
mov r3, #48
mul r2, r3
add r1, r1, r2
ldrh r2, [ r1, #2 ] @ Text ID for this conversation
strh r2, [ r0, #0x04 ] @ Store in memory slot 0x3.
ldrb r2, [ r1, #5 ] @ Background for this conversation.
strh r2, [ r0 ] @ Store in memory slot 0x2.
mov r1, #0x01
strb r1, [ r0, #0x08 ] @ Store 0x1 into slot 0x4 for later.
bx lr

.global BaseSupportConvo2
.type BaseSupportConvo2, %function
BaseSupportConvo2:
ldr r0, =#0x030004C0 @ Memory slot 0x2
ldr r1, =BaseSupportTable
ldr r2, =ChapterDataStruct
ldrb r2, [ r2, #0x0E ]
mov r3, #48
mul r2, r3
add r1, r1, r2
ldrh r2, [ r1, #8 ] @ Text ID for this conversation
strh r2, [ r0, #0x04 ] @ Store in memory slot 0x3.
ldrb r2, [ r1, #11 ] @ Background for this conversation.
strh r2, [ r0 ] @ Store in memory slot 0x2.
mov r1, #0x02
strb r1, [ r0, #0x08 ] @ Store 0x2 into slot 0x4 for later.
bx lr

.global BaseSupportConvo3
.type BaseSupportConvo3, %function
BaseSupportConvo3:
ldr r0, =#0x030004C0 @ Memory slot 0x2
ldr r1, =BaseSupportTable
ldr r2, =ChapterDataStruct
ldrb r2, [ r2, #0x0E ]
mov r3, #48
mul r2, r3
add r1, r1, r2
ldrh r2, [ r1, #14 ] @ Text ID for this conversation
strh r2, [ r0, #0x04 ] @ Store in memory slot 0x3.
ldrb r2, [ r1, #17 ] @ Background for this conversation.
strh r2, [ r0 ] @ Store in memory slot 0x2.
mov r1, #0x03
strb r1, [ r0, #0x08 ] @ Store 0x3 into slot 0x4 for later.
bx lr

.global BaseSupportConvo4
.type BaseSupportConvo4, %function
BaseSupportConvo4:
ldr r0, =#0x030004C0 @ Memory slot 0x2
ldr r1, =BaseSupportTable
ldr r2, =ChapterDataStruct
ldrb r2, [ r2, #0x0E ]
mov r3, #48
mul r2, r3
add r1, r1, r2
ldrh r2, [ r1, #20 ] @ Text ID for this conversation
strh r2, [ r0, #0x04 ] @ Store in memory slot 0x3.
ldrb r2, [ r1, #23 ] @ Background for this conversation.
strh r2, [ r0 ] @ Store in memory slot 0x2.
mov r1, #0x04
strb r1, [ r0, #0x08 ] @ Store 0x4 into slot 0x4 for later.
bx lr

.global BaseSupportConvo5
.type BaseSupportConvo5, %function
BaseSupportConvo5:
ldr r0, =#0x030004C0 @ Memory slot 0x2
ldr r1, =BaseSupportTable
ldr r2, =ChapterDataStruct
ldrb r2, [ r2, #0x0E ]
mov r3, #48
mul r2, r3
add r1, r1, r2
ldrh r2, [ r1, #26 ] @ Text ID for this conversation
strh r2, [ r0, #0x04 ] @ Store in memory slot 0x3.
ldrb r2, [ r1, #29 ] @ Background for this conversation.
strh r2, [ r0 ] @ Store in memory slot 0x2.
mov r1, #0x05
strb r1, [ r0, #0x08 ] @ Store 0x5 into slot 0x4 for later.
bx lr

.global BaseSupportConvo6
.type BaseSupportConvo6, %function
BaseSupportConvo6:
ldr r0, =#0x030004C0 @ Memory slot 0x2
ldr r1, =BaseSupportTable
ldr r2, =ChapterDataStruct
ldrb r2, [ r2, #0x0E ]
mov r3, #48
mul r2, r3
add r1, r1, r2
ldrh r2, [ r1, #32 ] @ Text ID for this conversation
strh r2, [ r0, #0x04 ] @ Store in memory slot 0x3.
mov r2, #35
ldrb r2, [ r1, r2 ] @ Background for this conversation.
strh r2, [ r0 ] @ Store in memory slot 0x2.
mov r1, #0x06
strb r1, [ r0, #0x08 ] @ Store 0x6 into slot 0x4 for later.
bx lr

.global BaseSupportConvo7
.type BaseSupportConvo7, %function
BaseSupportConvo7:
ldr r0, =#0x030004C0 @ Memory slot 0x2
ldr r1, =BaseSupportTable
ldr r2, =ChapterDataStruct
ldrb r2, [ r2, #0x0E ]
mov r3, #48
mul r2, r3
add r1, r1, r2
ldrh r2, [ r1, #38 ] @ Text ID for this conversation
strh r2, [ r0, #0x04 ] @ Store in memory slot 0x3.
mov r2, #39
ldrb r2, [ r1, r2 ] @ Background for this conversation.
strh r2, [ r0 ] @ Store in memory slot 0x2.
mov r1, #0x07
strb r1, [ r0, #0x08 ] @ Store 0x7 into slot 0x4 for later.
bx lr

.global BaseSupportConvo8
.type BaseSupportConvo8, %function
BaseSupportConvo8:
ldr r0, =#0x030004C0 @ Memory slot 0x2
ldr r1, =BaseSupportTable
ldr r2, =ChapterDataStruct
ldrb r2, [ r2, #0x0E ]
mov r3, #48
mul r2, r3
add r1, r1, r2
ldrh r2, [ r1, #44 ] @ Text ID for this conversation
strh r2, [ r0, #0x04 ] @ Store in memory slot 0x3.
mov r2, #47
ldrb r2, [ r1, r2 ] @ Background for this conversation.
strh r2, [ r0 ] @ Store in memory slot 0x2.
mov r1, #0x08
strb r1, [ r0, #0x08 ] @ Store 0x8 into slot 0x4 for later.
bx lr

.global BaseSupportUsability
.type BaseSupportUsability, %function
BaseSupportUsability: @ r7 = counter i.e. which menu item we're looking at. That's convenient.
push { r4, r6, r7, lr }
ldr r0, =BaseSupportTable
ldr r1, =ChapterDataStruct
ldrb r1, [ r1, #0x0E ]
mov r2, #48
mul r1, r2
add r0, r0, r1
mov r1, #0x06
mul r1, r7
add r4, r0, r1 @ r4 has this specific convo.
ldr r0, [ r4 ]
cmp r0, #0x00
beq BaseSupportUsabilityReturnFalse
	ldrb r0, [ r4 ] @ First character
	bl FindCharacter @ r0 has character struct
	cmp r0, #0x00
	beq BaseSupportUsabilityReturnFalse @ No character was found. Loop back.
	mov r7, r0 @ Save the character struct in r7 for later.
	ldrb r0, [ r0, #0x0C ]
	mov r1, #0x04
	tst r0, r1
	bne BaseSupportUsabilityReturnFalse @ This character is dead. Loop back.
	ldrb r0, [ r4, #0x01 ] @ Second character
	bl FindCharacter
	cmp r0, #0x00
	beq BaseSupportUsabilityReturnFalse @ No character was found. Loop back.
	mov r6, r0 @ Save the character struct in r6 for later.
	ldrb r0, [ r0, #0x0C ]
	mov r1, #0x04
	tst r0, r1
	bne BaseSupportUsabilityReturnFalse @ This character is dead. Loop back.
		@ Both characters are alive. Let's check to make sure their support level matches tbe convo.
		mov r0, r7
		ldrb r1, [ r4, #0x01 ]
		bl FindSupportData @ r0 has the number of bits to the support data from 0x34.
		mov r1, #0x00
		mvn r1, r1
		cmp r0, r1
		bne BaseSupportUsabilityHandleSupport
			mov r0, #0x00
			b BaseSupportUsabilityLevelCheck
		BaseSupportUsabilityHandleSupport:
		mov r1, r0
		mov r0, r7
		bl GetSupportLevel @ r0 has the support level.
		BaseSupportUsabilityLevelCheck:
		add r0, r0, #0x01
		ldrb r1, [ r4, #0x04 ] @ r1 has the support level of this convo.
		cmp r0, r1
		bne BaseSupportUsabilityReturnFalse
			cmp r1, #0x01
			bne BaseSupportUsabilityDontCountSupports
				@ This convo wants to increase to a C support. Let's make sure that both characters have room.
				mov r0, r7
				bl CountSupports
				cmp r0, #0x05
				beq BaseSupportUsabilityReturnFalse @ There are 6 supports already. This convo can't be added.
				mov r0, r6
				bl CountSupports
				cmp r0, #0x05
				beq BaseSupportUsabilityReturnFalse
			BaseSupportUsabilityDontCountSupports:
			mov r0, #0x01
			b EndBaseSupportUsability
BaseSupportUsabilityReturnFalse:
mov r0, #0x03
EndBaseSupportUsability:
pop { r4, r6, r7 }
pop { r1 }
bx r1

@ The proc that seems to be called to handle the support screen is 0x08A1962C. (Called at function 0x080A0944)
@ No wait the one I should be looking at seems to be 0x08A1975C. (Called at function 0x080A196C)

.align 4
.equ gProc_MapEventEngine, 0x08591ac0
.global PrepScreenSupportProc
PrepScreenSupportProc: @ This is the proc that is called to build the prep screen support screen.
.word 0x000E, 0
.short 0x000B, 0x0, 0x0, 0x0 @ Label 0x0
	.word 0x0002, ClearMemorySlot2
	.word 0x0002, SetScrollingBackground @ The vanilla support screen is constructed at 0x080A1270
	.word 0x0002, DisplayBottomText
	.word 0x0002, 0x08013D8D @ Fade out from black
	.word 0x0003, 0x08014069 @ Wait for fade out
	.word 0x0002, BuildSupportMenuGeometry
	.word 0x0002, BuildSupportMenuText
	.short 0x000B, 0x2, 0x0, 0x0 @ Label 0x2
	.short 0x000E, 0x08, 0x0, 0x0 @ Wait 0x08
	.word 0x0002, CallBaseSupportMenu
	.word 0x0002, EnsureSelection @ Make sure a selection was made. If not, goto label 2
		@ If we're here, a selection was made.
		.word 0x0002, 0x08013CD1 @ StartFadeIntoBlack
		.word 0x0002, SetUpConvo
		.word 0x0002, CallConversation
		.short 0x000B, 0x3, 0x0, 0x0 @ Label 0x3
		.short 0x000E, 0x01, 0x0, 0x0 @ Wait for 0x1
		.word 0x0002, CheckToEnd @ Goto 0x3 if the convo hasn't finished
		.word 0x0002, UnsetFinalRAM
		.word 0x0002, 0x080A1931 @ Return to prep screen theme
.word 0x0000, 0x0 @ End

.align
.ltorg
