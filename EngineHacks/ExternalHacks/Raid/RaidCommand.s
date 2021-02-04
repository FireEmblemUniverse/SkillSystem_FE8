
.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.global RaidUsability
.type   RaidUsability, %function

RaidUsability:
push { r4 - r7, r14 } @ 08023040
ldr r0, =#0x3004E50
ldr r2, [ r0 ]
ldr r1, [ r2, #0x4 ]
ldrb r1, [ r1, #0x4 ]
mov r4, r0
cmp r1, #0x51
beq End
ldr r0, [ r2, #0xC ]
mov r1, #0x40
and r0, r1
cmp r0, #0x0
bne End
mov r0, #0x11
ldsb r0, [ r2, r0 ]
ldr r1, =#0x202E4DC
ldr r1, [ r1 ]
lsl r0, r0, #0x2
add r0, r0, r1
mov r1, #0x10
ldsb r1, [ r2, r1 ]
ldr r0, [ r0 ]
add r0, r0, r1
ldrb r0, [ r0 ]
cmp r0, #0x5
b Label1
cmp r0, #0x5
bgt Label2
cmp r0, #0x3
beq Label1
b End
lsl r2, r0, #0x8
Label2:
cmp r0, #0x38
bgt End
cmp r0, #0x37
blt End
Label1:
ldr r1, [ r4 ]
mov r0, #0x10
ldsb r5, [ r1, r0 ] @ r5 = current X
ldrb r1, [ r1, #0x11 ]
lsl r1, r1, #0x18
asr r6, r1, #0x18 @ r6 = current Y
ldr r0, =0x0202BCF0
ldrb r0, [ r0, #0x0E ] @ Current chapter ID
blh 0x080346B0, r1 @ r0 = this chapter's events
ldr r7, [ r0, #0x08 ] @ r7 = this chapter's location events
sub r7, r7, #0x0C
UsabilityLoop:
add r7, r7, #0x0C
ldrh r1, [ r7 ]
cmp r1, #0x00
beq End @ End false if no Raids were found.
	ldrb r1, [ r7, #0x08 ]
	cmp r1, r5
	bne UsabilityLoop
	ldrb r1, [ r7, #0x09 ]
	cmp r1, r6
	bne UsabilityLoop
		ldrb r1, [ r7, #0x0A ]
		cmp r1, #0x21
		bne UsabilityLoop
			ldrb r0, [ r7, #0x02 ]
			blh 0x08083DA8, r1 @ Check event ID
			cmp r0, #0x01
			beq UsabilityLoop
@ldr r3, =#0x8084078
@mov lr, r3
@.short 0xF800
		@bl #0x8084078			@ Checks LOCA event at current location. Returns command ID. So 0x10 for visit, 0x21 for raid.
@cmp r0, #0x21		@ Here's a visit 0x10. CHANGE THIS
@bne End			@ If false end
ldr r0, [ r4 ]	@ Here if true

blh #0x8018D08, r1
lsl r0, r0, #0x18
cmp r0, #0x0
beq End2
mov r0, #0x2
b End3
End2:
mov r0, r1
b End3
End:
mov r0, #3
End3:
pop { r4 - r7 }
pop { r1 }
bx r1

.align
.ltorg

.global RaidEffect
.type   RaidEffect, %function
RaidEffect:
push { r4 - r6, lr }

@ldr r0, =#0x0203A958 @ Set waited
@add r0, #0x11
@mov r1, #0x01
@strb r1, [ r0 ]

ldr r0, =#0x03004E50 @ Location of current character's struct
ldr r0, [ r0 ] @ Pointer to character struct in r0
mov r1, r0
add r1, #0x10
add r0, r1, #0x01
ldrb r1, [ r1 ] @ X coordinate in r1
ldrb r2, [ r0 ] @ Y coordinate in r2

ldr r0, =#0x0202BCF0
add r0, #0x0E
ldrb r0, [ r0 ] @ Chapter ID in r0

push { r1 }
blh 0x080346B0, r3 @ Pointer to event pointer table in r0
pop { r1 }
ldr r0, [ r0, #0x08 ] @ Now THIS is pointer to LOCAs

mov r3, #0x00 @ Treat r3 as a loop index
LoopStart:
 mov r4, r0 @ Start pointer to location events in r4
 mov r6, #0x0C
 mul r6, r3
 add r4, r6 @ Now I'm at the nth LOCA
 ldrb r6, [ r4, #0x08 ] @ X coord in r6
 cmp r6, r1
 bne LoopFalse
	ldrb r6, [ r4, #0x09 ] @ Y coord in r6
	cmp r6, r2
	bne LoopFalse
		ldrb r6, [ r4, #0x0A ] @ Command ID
		cmp r6, #0x21
		bne LoopFalse
		@ Therefore r4 has the correct LOCA
	
@ LoopTrue:
ldrb r0, [ r4, #0x02 ]
blh 0x08083D80, r1 @ Sets new event ID
ldr r0, [ r4, #0x04 ] @ Now r0 does
mov r1, #0x00
blh 0x0800D07C, r2
ldr r0, =#0x0203A958 @ Set waited
add r0, #0x11
mov r1, #0x01
strb r1, [ r0 ]
mov r0, #0x16
pop { r4 - r6 }
pop { r1 }
@ldr r1, =#0x0804F3D9
@pop { r1 }
bx r1

LoopFalse:
add r3, #0x01
b LoopStart


@ Effect notes
@ 8015320: at 0x2026A70+0x14: True = 0x2025450, False = 0x20250F0


@D07C: (Call_Event_Engine)
@Params: r0=pointer to events, r1=0 (something to do with fading?) (this is fe8 only, I think)
@Can be used to run events whenever

@346B0: (Get_Chapter_Events)
@Params: r0=chapter number
@Returns: Pointer to that chapter's events

@83D80: (Set_Event_ID) (FE7: 798E4) (FE8J: 860BC) (FE6: 6BA48)
@Params: r0=event id to set
