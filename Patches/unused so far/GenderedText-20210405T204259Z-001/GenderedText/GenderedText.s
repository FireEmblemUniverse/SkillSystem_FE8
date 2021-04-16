
.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ Text_GetStringTextWidth, 0x08003EDC
.equ gpDialogueState, 0x0859133C
.equ CheckEventId, 0x08083DA8

/*
struct GenderedTextEntry
{
	u16 controlCode; // Text control code.
	u16 eventID;
	char* string1; // String to inject if true.
	char* string2; // String to inject if false.
} // Size = 12 bytes.
*/

@ This hack pretty much looks at how the [Tact] control code works.

.global GenderedTextWidthHack
.type GenderedTextWidthHack, %function
GenderedTextWidthHack: @ Autohook to 0x08008DDC.
@ r4 has the pointer to the current control code.
ldrb r0, [ r4 ]
bl IsGenderedTextControlCode
cmp r0, #0x00
beq NormalTextWidth
	ldrb r0, [ r4 ]
	bl GetGenderedTextString
	blh Text_GetStringTextWidth, r1
	ldr r1, =#0x08008EC3
	bx r1
NormalTextWidth: @ Vanilla behavior.
ldrb r0, [ r4 ]
cmp r0, #0x25
bls TextWidthVanillaSwitch
	ldr r0, =#0x08008B67
	bx r0
TextWidthVanillaSwitch:
lsl r0, r0, #0x02
ldr r1, =#0x08008DF4
add r0, r0, r1
ldr r0, [ r0 ]
mov pc, r0 @ Heh why bx back to this switch when we can use the switch to return?

.ltorg

.global GenderedTextStringHack
.type GenderedTextStringHack, %function
GenderedTextStringHack: @ Autohook to 0x08007598.
@ [r2 + 0x01] has the current control code.
ldrb r0, [ r2, #0x01 ]
push { r0 }
bl IsGenderedTextControlCode
pop { r1 }
cmp r0, #0x00
beq NormalText
	ldr r4, =gpDialogueState @ This mimics [Tact] behavior.
	ldr r2, [ r4 ]
	ldr r0, [ r2 ]
	sub r0, r0, #0x01
	str r0, [ r2, #0x04 ]
	mov r0, r1
	bl GetGenderedTextString
	ldr r1, [ r4 ]
	str r0, [ r1 ]
	ldr r0, =#0x08006FDB
	bx r0
NormalText:
cmp r1, #0x25
bls TextVanillaSwitch
	ldr r0, =#0x080072A1
	bx r0
TextVanillaSwitch:
lsl r1, r1, #0x02
ldr r0, =#0x080075B0
add r0, r0, r1
ldr r0, [ r0 ]
mov pc, r0

.ltorg

.global IsGenderedTextControlCode
.type IsGenderedTextControlCode, %function
IsGenderedTextControlCode: @ Return a boolean for whether this control code is a gender switch control code.
@ Loop through the control code table and search for the code.
ldr r1, =GenderedTextList
StartIsGenderedLoop:
ldrh r2, [ r1 ]
lsr r2, r2, #0x08
cmp r0, r2
beq IsGenderedTextReturnTrue
	add r1, r1, #0x0C
	cmp r2, #0x00
	bne StartIsGenderedLoop
		mov r0, #0x00
		b EndIsGenderedTextControlCode
IsGenderedTextReturnTrue:
mov r0, #0x01
EndIsGenderedTextControlCode:
bx lr

.ltorg

.global GetGenderedTextString
.type GetGenderedTextString, %function
GetGenderedTextString: @ Return the pointer to the appropriate string.
push { r4, lr }
ldr r4, =GenderedTextList
StartGetGenderedLoop:
ldrh r1, [ r4 ]
lsr r1, r1, #0x08
cmp r0, r1
beq GetGenderedTextEntryFound
	add r4, r4, #0x0C
	cmp r1, #0x00
	bne StartGetGenderedLoop
		mov r0, #0x00 @ No entry found. Just... return NULL.
		b EndGetGenderedTextControlCode
GetGenderedTextEntryFound: @ We've found the entry. Check the event ID.
ldrh r0, [ r4, #0x02 ]
blh CheckEventId, r1
lsl r0, r0, #0x02 @ Multiply the boolean result by 4.
add r0, r0, #0x04
ldr r0, [ r4, r0 ]
EndGetGenderedTextControlCode:
pop { r4 }
pop { r1 }
bx r1

.ltorg
