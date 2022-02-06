
.thumb
.global StairsUsability
.type StairsUsability, %function

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ CheckEventID, 0x08083DA8

StairsUsability:
push { r4 - r7, lr }
sub sp, #0x08
@ First, I want to prevent someone using multiple stairs in one turn.
ldr r0, =#0x03004E50
ldr r4, [ r0 ] @ Keep character struct in r4 for the time being.
ldr r1, =CharacterStructStairByte
ldrb r1, [ r1 ]
ldrb r0, [ r4, r1 ] @ This should be 0 if no stairs were messed with this turn.
cmp r0, #0x00
bne EndFalseNoPop

@ Also ensure that this unit isn't cantoing or rescuing.
ldr r0, [ r4, #0x0C ]
mov r1, #0x50 @ isRescuing||isCantoing.
tst r0, r1
bne EndFalseNoPop

ldr r0, =#0x0202BCF0 @ Chapter data struct
ldrb r0, [ r0, #0x0E ] @ Chapter ID
blh #0x080346B0, r1 @ Pointer to chapter events in r0
ldr r7, [ r0, #0x08 ] @ Pointer to location events in r7
sub r7, #12

ldr r0, =#0x0203A958
ldrb r5, [ r0, #0x0E ] @ X coordinate moving to in r5
ldrb r6, [ r0, #0x0F ] @ Y coordinate moving to in r6

push { r7 }
BeginCheck1:
add r7, #12
ldrh r3, [ r7 ]
cmp r3, #0x00
beq EndFalse @ If this is an END_MAIN, end. No correct LOCAs exist.
ldrb r3, [ r7, #10 ] @ Command ID of first LOCA
cmp r3, #0x22
bne BeginCheck1 @ This doesn't have a 0x22 command. Try again.
ldrb r3, [ r7, #8 ] @ X coordinate of this LOCA
cmp r5, r3
bne BeginCheck1
ldrb r3, [ r7, #9 ] @ Y coordinate of this LOCA
cmp r6, r3
bne BeginCheck1
ldrh r0, [ r7, #2 ] @ Event ID of this LOCA
blh CheckEventID, r1
cmp r0, #0x00
bne BeginCheck1
@ If it made it this far, then this is an applicable LOCA.

@ Now to check whether there's a unit on the other end of the stairs.
@ X coordinate in r5, Y coordinate in r6.
ldr r4, [ r7, #4 ] @ Keep the relevant stair ID in r4

pop { r2 } @ Get begining of location events back into r2.
BeginCheck4:
add r2, #12
ldrb r3, [ r2, #10 ] @ Command ID of first LOCA
cmp r3, #0x22
bne BeginCheck4 @ This doesn't have a 0x22 command. Try again.
ldr r3, [ r2, #4 ] @ This stair ID in r3
cmp r3, r4
bne BeginCheck4
@ Great. If I got this far, I have the pointer to the LOCA I'm looking for (except I still need to check that this isn't the LOCA that I'm currently at). I can get the coordinates to move to from here.
ldrb r0, [ r2, #8 ] @ X coordinate in r0
ldrb r1, [ r2, #9 ] @ Y coordinate in r1
cmp r0, r5
bne Skip2 @ If the X coordinates are different, then this isn't the same LOCA. Continue.
cmp r1, r6
beq BeginCheck4 @ If the X and Y coordinates are the same, try again.

Skip2:
@ Now I need to check if there's a unit at these matching coordinates.
@ Aaaahhhhh we can't use the unit map because it doesn't work in fog.
mov r4, r0 @ r4 = X coord to check.
mov r5, r1 @ r5 = Y coord to check.
mov r6, #0x00 @ r6 = counter.
StartGreyLoop:
add r6, r6, #0x01
cmp r6, #0xC0
bge EndTrue @ No units found at these coordinates. Return usabile.
mov r0, r6
blh 0x08019430, r1 @ GetUnit. r0 = character struct to check.
cmp r0, #0x00
beq StartGreyLoop @ No character here.
ldrb r1, [ r0, #0x10 ]
cmp r1, r4
bne StartGreyLoop @ X coords don't match.
ldrb r1, [ r0, #0x11 ]
cmp r1, r5
bne StartGreyLoop @ Y coords don't match.

@ If it's here, then the X coordinate is the same along with the Y. There's a unit on the other end, so return grey.
@ EndGrey:
mov r0, #2
add sp, #0x08
pop { r4 - r7 }
pop { r1 }
bx r1

EndTrue:
mov r0, #1
add sp, #0x08
pop { r4 - r7 }
pop { r1 }
bx r1

EndFalse:
pop { r2 } @ Oopsie I broke the stack because I left my loop within a push / pop.
EndFalseNoPop:
mov r0, #3
add sp, #0x08
pop { r4 - r7 }
pop { r1 }
bx r1

@346B0: (Get_Chapter_Events) (FE8J: 345B8) (FE7: 315BC)
@Params: r0=chapter number
@Returns: Pointer to that chapter's events

.global StairsEffect
.type StairsEffect, %function
StairsEffect:
push { r4 - r7, lr }
mov r5, r0 @ First to check if the "someone's on the other side" flag is set.
mov r4, r1
mov r0, r4
add r0, #0x3D
ldrb r0, [ r0 ]
cmp r0, #0x2
bne EffectCheck
ldr r1, =StairErrorTextLocation
ldrh r1, [ r1 ]
mov r0, r5
blh #0x0804F580, r2 @ Sets that text ID for the error text
mov r0, #0x08
b EndEffect

EffectCheck:
ldr r0, =#0x0202BCF0 @ Chapter data struct
ldrb r0, [ r0, #0x0E ] @ Chapter ID
blh #0x080346B0, r1 @ Pointer to chapter events in r0
ldr r7, [ r0, #0x08 ] @ Pointer to location events in r7
sub r7, #12

ldr r0, =#0x0203A958
ldrb r5, [ r0, #0x0E ] @ X coordinate moving to in r5
ldrb r6, [ r0, #0x0F ] @ Y coordinate moving to in r6

push { r7 }
BeginCheck2:
add r7, #12
ldrb r3, [ r7, #10 ] @ Command ID of first LOCA
cmp r3, #0x22
bne BeginCheck2 @ This doesn't have a 0x22 command. Try again.
ldrb r3, [ r7, #8 ] @ X coordinate of this LOCA
cmp r5, r3
bne BeginCheck2
ldrb r3, [ r7, #9 ] @ Y coordinate of this LOCA
cmp r6, r3
bne BeginCheck2
ldrh r0, [ r7, #2 ] @ Event ID of this stair event
blh CheckEventID, r1
cmp r0, #0x00
bne BeginCheck2
ldr r4, [ r7, #4 ] @ Stair ID in r4

pop { r2 } @ Get the pointer to beginning of location events back
BeginCheck3:
add r2, #12
ldrb r3, [ r2, #10 ] @ Command ID of first LOCA
cmp r3, #0x22
bne BeginCheck3 @ This doesn't have a 0x22 command. Try again.
ldr r3, [ r2, #4 ] @ This stair ID in r3
cmp r3, r4
bne BeginCheck3
@ Great. If I got this far, I have the pointer to the LOCA I'm looking for (except I still need to check that this isn't the LOCA that I'm currently at). I can get the coordinates to move to from here.
ldrb r0, [ r2, #8 ] @ X coordinate in r0
cmp r0, r5
beq SameX
ldrb r1, [ r2, #9 ] @ Y coordinate in r1
b Skip

SameX:
ldrb r1, [ r2, #9 ] @ Y coordinate in r1
cmp r1, r6
beq BeginCheck3

Skip:
ldr r4, =#0x03004E50
ldr r4, [ r4 ]
ldr r2, =#0x0203A958
strb r0, [ r2, #0x0E ]
strb r1, [ r2, #0x0F ] @ Sets new coordinates in the action struct
mov r3, #0x01
strb r3, [ r2, #0x11 ] @ Sets "wait"

strb r0, [ r4, #0x10 ]
strb r1, [ r4, #0x11 ]

ldrb r2, [ r2, #0x10 ] @ Has squares moved.
cmp r2, #0x00
bne SquaresMoved
	mov r2, #0x7F
	
SquaresMoved:
ldr r1, =CharacterStructStairByte
ldrb r1, [ r1 ]
strb r2, [ r4, r1 ]

ldr r0, =StairCameraEvent
mov r1, #0x00
blh #0x0800D07C, r2 @ Call event engine to take the camera to the other end of the stairs.

mov r0, #0x17

EndEffect:
pop { r4 - r7 }
pop { r1 }
bx r1

.global FixWait2
.type FixWait2, %function
FixWait2: @ Incorporated into Post-Action calc loop.
/*
cmp r0, #0x00
beq EndWaitFix2 @ From vanilla routine
ldr r0, [ r6 ]

ldr r3, =CharacterStructStairByte
ldrb r3, [ r3 ]
ldrb r1, [ r0, r3 ]
cmp r1, #0x00
beq NormalFixWait2 @ There is no debuff, so let's just proceed normally.
lsr r1, r1, #0x07 @ r1 has the boolean for whether their turn has already been extended by taking the stairs.
cmp r1, #0x00
beq WeGotStairs

NormalFixWait2:
ldr r1, [ r0, #0x0C ]
mov r2, #0x02
neg r2, r2
and r1, r2
str r1, [ r0, #0x0C ]
mov r1, #0x00
strb r1, [ r0, r3 ]
b EndWaitFix2

WeGotStairs:
mov r1, #0x00
strb r1, [ r0, #0x0C ]
ldrb r2, [ r0, r3 ]
mov r1, #0x80
orr r2, r1, r2 @ Sets the top bit to mark that stairs are being used this turn.
cmp r2, #0xFF
bne FixWait2SquaresMoved
	@ Oh they didn't move. Let's just set to 0x80 which shows 0 mov debuff but has the top bit set.
	mov r2, #0x80
FixWait2SquaresMoved:
strb r2, [ r0, r3 ]

EndWaitFix2:
ldr r0, [ r6 ]
blh #0x0801849C, r1
pop { r4 - r6 }
pop { r0 }
bx r0
*/
@ This function is now called by the Post-Action calc loop!
@ r0 = character struct.
@ Immediately end if there is no debuff or if their turn has already been extended (top bit is set.)

@ The first time this is called, they JUST took the stairs. If so, upon entry, the top bit is NOT set, and the stair debuff byte is squares moved only.
	@ Set the top bit of the stair debuff byte and refresh the unit.
@ The second time this is called, they are performing an action AFTER taking the stairs. If so, upon entry, the top bit IS set, and bits below are the stair debuff byte.
	@ Clear the stair debuff byte.
ldr r3, =CharacterStructStairByte
ldrb r3, [ r3 ]
ldrb r1, [ r0, r3 ] @ Current stair debuff byte.
cmp r1, #0x00
beq EndFixWait2 @ Immediately end if no stair debuff is detected.
mov r2, #0x80
bic r2, r1
cmp r2, #0x00
beq EndFixWait2Store @ Fancy way of testing if the top bit is set and setting 0 if so.
	@ They just took the stairs. Get the turn status bitfield and unset "Turn ended". Also set the top bit of the stair debuff while we're here.
	mov r2, #0x00
	strb r2, [ r0, #0x0C ] @ Unit is completely refreshed.
	mov r2, #0x80
	orr r2, r1, r2
	cmp r2, #0xFF
	bne EndFixWait2Store
		mov r2, #0x80 @ Oh they didn't move. Let's just set to 0x80 which shows 0 mov debuff but has the top bit set.
EndFixWait2Store:
strb r2, [ r0, r3 ]
EndFixWait2:
bx lr

.global StairsMoveDebuff
.type StairsMoveDebuff, %function
StairsMoveDebuff: @ Incorporated into MSG
/*
push { r4 - r6, lr }
mov r6, r0
mov r4, #0x01
ldr r5, =#0x03004E50
ldr r0, [ r5 ]
ldr r1, [ r0, #0x04 ]
ldrb r1, [ r1, #0x12 ]
ldrb r2, [ r0, #0x1D ]
add r1, r2 @ All from vanilla. Basically calculates movement.

@ Now to add my debuff.
ldr r3, =CharacterStructStairByte
ldrb r3, [ r3 ]
ldrb r2, [ r0, r3 ]
lsl r2, r2, #25
lsr r2, r2, #25 @ Remove the stair flag... Won't be needing that here.
cmp r2, #0x7F @ 0x7F because the top bit has been unset?
beq ItsZero
sub r1, r2
ItsZero:
ldr r2, =#0x0203A958
ldr r3, =#0x0801CB85
bx r3
*/
@ This is a function call now from MSG!
push { lr } @ r0 = this stat, r1 = this character struct.
ldr r2, =CharacterStructStairByte
ldrb r2, [ r2 ]
ldrb r2, [ r1, r2 ]
cmp r2, #0xFF
beq EndStairsMoveDebuff
	lsl r2, r2, #25
	lsr r2, r2, #25 @ Remove the stair flag
	sub r0, r0, r2
EndStairsMoveDebuff:
pop { pc }


.global EndTurnFix
.type EndTurnFix, %function
EndTurnFix:
push { lr }

@ Now to loop through the character structs and unset all 0x3A bytes.
ldr r0, =#0x0202BE4C
mov r1, #0x00
ldr r2, =CharacterStructStairByte
ldrb r2, [ r2 ]
BeginEndTurnLoop:
strb r1, [ r0, r2 ]
add r0, #0x48
ldr r3, [ r0 ]
cmp r3, #0x00
bne BeginEndTurnLoop
@ If I'm here, I've run out of character entries.

ldr r0, =#0x0859AAD8 @ From vanilla
blh #0x08003078, r1
mov r0, #0x17
pop { r1 }
bx r1

.global UnsetMoveDebuff
.type UnsetMoveDebuff, %function
UnsetMoveDebuff:
ldr r1, =#0x03004E50
ldr r1, [ r1 ]
ldr r3, =CharacterStructStairByte
ldrb r3, [ r3 ]
ldrb r2, [ r1, r3 ] @ Movement debuff with the top bit set if stairs were taken.
lsr r3, r2, #7 @ r3 has the reverse boolean on whether stairs were taken in this action.
cmp r3, #0x00
beq StairsTaken

@ If I'm here, they're NOT taking the stairs. Therefore, they're ending their turn. I need to completely unset the movement debuff.
mov r2, #0x00
ldr r3, =CharacterStructStairByte
ldrb r3, [ r3 ]
strb r2, [ r1, r3 ]
b EndUnsetDebuff

StairsTaken: @ If I'm here, they're taking the stairs. I need to unset the top bit and preserve the movement debuff.
lsl r2, r2, #25
lsr r2, r2, #25
ldr r3, =CharacterStructStairByte
ldrb r3, [ r3 ]
strb r2, [ r1, r3 ]
@b EndUnsetDebuff

EndUnsetDebuff:
pop { r4 - r5 }
pop { r1 }
bx r1

.global ActionPickRepoint
.type ActionPickRepoint, %function
ActionPickRepoint:
mov r0, r4
blh #0x0802FFB4, r2 @ ActionPick
mov r0, #0x00
b UnsetMoveDebuff
