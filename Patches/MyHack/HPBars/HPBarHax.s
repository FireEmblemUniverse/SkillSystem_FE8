
.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ LeftBattleStruct, 0x0203E188
.equ RightBattleStruct, 0x0203E18C
.equ Palette1BBuffer, 0x02022C08
.equ Palette1CBuffer, 0x02022C28
.equ BattleHPDisplayedValue, 0x0203E1AC
.equ CpuSet, 0x080D1678
.equ BreakProcLoop, 0x08002E94
.equ EnablePaletteSync, 0x08001F94
.equ EndProc, 0x08002D6C
.equ gpEfxHPBarColorChange, 0x0201777C
.equ gEfxFlashHPBar, 0x085B9994
.equ EndEachProc, 0x08003078
.equ DarkDefault, 0x08802B04
.equ LightDefault, 0x08802BC4

.type GetPalette, %function
GetPalette: @ r0 = character struct, r1 = allegiance. Returns the pointer to the palette for the HP bar.
push { r4 - r7, lr }
ldr r4, =HPBarTable
mov r5, r0 @ Battle struct.
mov r6, r1 @ Allegiance.
sub r4, r4, #16
StartHPBarLoop:
add r4, r4, #16
ldr r0, [ r4 ]
cmp r0, #0xFF
beq CheckLightOrDark @ Terminator. If we branch there, that should handle the default.
cmp r6, #0x04
blt NotLightPalette
	add r0, r0, #0x04
NotLightPalette:
cmp r0, r6
bne StartHPBarLoop @ Allegiances don't match. Reiterate.
	ldr r7, [ r4, #0x0C ]
	cmp r7, #0x00
	beq CheckLightOrDark
	mov r0, r5
	bl WhichSideOfScreen
	mov r1, r0 @ Which side of the screen they're on.
	mov r0, r5 @ Battle struct.
	mov lr, r7
	.short 0xF800
	cmp r0, #0x00
	beq StartHPBarLoop
		CheckLightOrDark: @ We found an entry that works! Let's detremine whether to return the light or dark palette.
		add r0, r4, #0x04
		mov r1, #0x04
		and r1, r1, r6 @ Isolate the (is this light or dark) bit.
		ldr r0, [ r0, r1 ] @ Palette pointer.
		cmp r0, #0x00
		bne EndGetPalette
			@ Oh none is defined. Just return the default.
			ldr r0, =DarkDefault
			cmp r6, #0x04
			blt EndGetPalette
				ldr r0, =LightDefault
EndGetPalette:
pop { r4 - r7 }
pop { r1 }
bx r1

.align
.ltorg

.global HPBarNormal1
.type HPBarNormal1, %function
HPBarNormal1: @ Autohook to 0x08050F5C. Left side. These two seem to be necessary for the very initial display of the palettes.
ldr r0, =#0x0203E114
ldrh r1, [ r0 ] @ r1 is an indicator of allegiance of the left side: 0 = player, 1 = enemy, 2 = NPC, 3 = 4th allegiance.
ldr r0, =LeftBattleStruct
ldr r0, [ r0 ] @ r0 = left unit pointer.
bl GetPalette
ldr r1, =Palette1BBuffer
mov r2, #0x10

ldr r3, =#0x08050F6D
bx r3

.global HPBarNormal2
.type HPBarNormal2, %function
HPBarNormal2: @ Autohook to 0x08050FA0. Right side.
ldr r0, =#0x0203E114
ldrh r1, [ r0, #0x02 ] @ r1 is an indicator of allegiance of the right side: 0 = player, 1 = enemy, 2 = NPC, 3 = 4th allegiance.
ldr r0, =RightBattleStruct
ldr r0, [ r0 ] @ r0 = right unit pointer.
bl GetPalette
ldr r1, =Palette1CBuffer
mov r2, #0x10

ldr r3, =#0x08050FB1
bx r3

.global HPBarFlash
.type HPBarFlash, %function
HPBarFlash: @ Autohook to 0x080545F8. We can handle the 4 palettes worked with in this function all in one call.
ldr r5, =#0x0203E114
ldrh r1, [ r5 ] @ r1 is an indicator of allegiance of the right side: 0 = player, 1 = enemy, 2 = NPC, 3 = 4th allegiance.
ldr r0, =LeftBattleStruct
ldr r0, [ r0 ] @ r0 = left unit pointer.
bl GetPalette
ldr r6, =#0x0201F948
mov r1, r6
mov r2, #0x10
blh #0x080714DC, r3

ldrh r1, [ r5 ]
add r1, r1, #0x04 @ Has the allegiance +4 (for identification use with GetPalette).
ldr r0, =LeftBattleStruct
ldr r0, [ r0 ]
bl GetPalette
ldr r4, =#0x0201F978
mov r1, r4
mov r2, #0x10
blh #0x080714DC, r3 @ "Decompresses" the palette into RAM for... some reason. Each color takes 3 bytes for RGB.

ldr r2, =#0x0201F9A8
mov r0, #0x05
mov r8, r0
str r0, [ sp ]
mov r0, r6
mov r1, r4
ldr r3, =#0x08071574
mov lr, r3
mov r3, #0x10
.short 0xF800

ldrh r1, [ r5, #0x02 ] @ Right allegiance.
ldr r0, =RightBattleStruct
ldr r0, [ r0 ]
bl GetPalette
ldr r6, =#0x0201FA08
mov r1, r6
mov r2, #0x10
blh #0x080714DC, r3

ldrh r1, [ r5, #0x02 ]
add r1, r1, #0x04
ldr r0, =RightBattleStruct
ldr r0, [ r0 ]
bl GetPalette
ldr r4, =#0x0201FA38
mov r1, r4
mov r2, #0x10
blh #0x080714DC, r3

ldr r0, =#0x0805465D
bx r0

@ Note to self: vanilla implementation has a different palette at HP greater than or equal to 0x50. Uses the light palette instead of the dark palette.
@ It's pretty funny they set up suport for different palettes for allegiances and whatever but felt the need to hardcode high HP palette.
.global BeingStruckHPBar
.type BeingStruckHPBar, %function
BeingStruckHPBar: @ Autohook to 0x080544A4.
@ Following by a call to GetAISSubjectId.
push { r5 }
ldr r1, =LeftBattleStruct
ldr r5, =Palette1CBuffer
cmp r0, #0x00
bne BeingStruckLeft
	ldr r1, =RightBattleStruct
	ldr r5, =Palette1BBuffer
BeingStruckLeft:
ldr r2, =#0x0203E114
lsl r3, r0, #0x01
ldr r0, [ r1 ] @ Battle struct for this unit.
ldrh r1, [ r2, r3 ] @ Allegiance of this unit.
ldr r2, =BattleHPDisplayedValue
ldrh r2, [ r2, r3 ]
cmp r2, #0x50
blt NotExcessiveHP
	add r1, r1, #0x04
NotExcessiveHP:
bl GetPalette
mov r1, r5
mov r2, #0x10
blh CpuSet, r3

pop { r5 }
ldr r0, =#0x08054503
bx r0

.global FinishedDepletionHPBar
.type FinishedDepletionHPBar, %function
FinishedDepletionHPBar: @ Autohook to 0x0805452C. r0 = proc.
@ The function we're hooking into seems to be a dummy function for updating the palette after HP depletion? We can hijack that.
@ Except it also seems to beak the proc loop for efxFlashHPBar.
push { r4, lr }
mov r4, r0
bl FullPaletteUpdate
mov r0, r4
blh BreakProcLoop, r1
pop { r4 }
pop { r0 }
bx r0

.type FullPaletteUpdate, %function
FullPaletteUpdate: @ Updates all "decompressed" palettes with 0x080714DC.
push { r4, lr }
ldr r0, =LeftBattleStruct
ldr r0, [ r0 ] @ r0 = left unit pointer.
ldr r4, =#0x0203E114
ldrh r1, [ r4 ] @ r1 is an indicator of allegiance of the right side: 0 = player, 1 = enemy, 2 = NPC, 3 = 4th allegiance.
bl GetPalette
ldr r1, =#0x0201F948
mov r2, #0x10
blh #0x080714DC, r3

ldr r0, =LeftBattleStruct
ldr r0, [ r0 ]
ldrh r1, [ r4 ]
add r1, r1, #0x04 @ Has the allegiance +4 (for identification use with GetPalette).
bl GetPalette
ldr r1, =#0x0201F978
mov r2, #0x10
blh #0x080714DC, r3 @ "Decompresses" the palette into RAM for... some reason. Each color takes 3 bytes for RGB.

ldr r2, =#0x0201F9A8
mov r0, #0x05
str r0, [ sp ]
ldr r0, =#0x0201F948
ldr r1, =#0x0201F978
ldr r3, =#0x08071574
mov lr, r3
mov r3, #0x10
.short 0xF800

ldr r0, =RightBattleStruct
ldr r0, [ r0 ]
ldrh r1, [ r4, #0x02 ] @ Right allegiance.
bl GetPalette
ldr r1, =#0x0201FA08
mov r2, #0x10
blh #0x080714DC, r3

ldr r0, =RightBattleStruct
ldr r0, [ r0 ]
ldrh r1, [ r4, #0x02 ]
add r1, r1, #0x04
bl GetPalette
ldr r1, =#0x0201FA38
mov r2, #0x10
blh #0x080714DC, r3

ldr r2, =#0x0201FA68
mov r0, #0x05
str r0, [ sp ]
ldr r0, =#0x0201FA08
ldr r1, =#0x0201FA38
ldr r3, =#0x08071574
mov lr, r3
mov r3, #0x10
.short 0xF800

blh EnablePaletteSync, r0
pop { r4 }
pop { r0 }
bx r0

.global FixHPFlash
.type FixHPFlash, %function
FixHPFlash: @ Autohook to 0x080546B0. Huge lag happens without this because the FlashHPBars aren't being cleared.
push { lr }
ldr r0, =gpEfxHPBarColorChange
ldr r0, [ r0 ]
blh EndProc, r1
ldr r0, =gEfxFlashHPBar
blh EndEachProc, r1
pop { r0 }
bx r0

.global HPBarIsLowHP
.type HPBarIsLowHP, %function
HPBarIsLowHP: @ r0 = battle struct. r1 = which side they're on. Return a boolean.
ldrb r2, [ r0, #0x12 ] @ Max HP.
@ ldrb r1, [ r0, #0x13 ] @ Current HP. @ THIS DOESN'T WORK BECAUSE THIS IS ACTUALLY HP AFTER THE BATTLE.
ldr r0, =BattleHPDisplayedValue
lsl r1, r1, #0x01
ldrh r1, [ r0, r1 ] @ This method should get the HP that's being displayed.
lsr r2, r2, #0x01
mov r0, #0x00
cmp r1, r2
bge HPBarLowHPFalse
	mov r0, #0x01
HPBarLowHPFalse:
bx lr

.type WhichSideOfScreen, %function
WhichSideOfScreen: @ r0 = battle struct. Returns 0 for left side, 1 for right.
mov r1, #0x00
ldr r2, =LeftBattleStruct
ldr r2, [ r2 ]
cmp r0, r2
beq LeftSideOfScreen
	mov r1, #0x01
LeftSideOfScreen:
mov r0, r1
bx lr
