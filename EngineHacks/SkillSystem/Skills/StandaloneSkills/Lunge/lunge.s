.thumb
.org 0x0

@stick a jumpToHack(here) at 18744. r0/1 have attacker coordinates.
push    {r4-r7,r14}
mov r4, r0
mov r7, r1
ldr        r5,Somewhere        @+0xC has attacker allegiance byte, 0xD has defender allegiance byte, 0xE has attacker x coord, 0xF has attacker y coord, 0x10 has distance moved
ldrb    r2,[r5,#0x11]        @I believe this is action taken this turn; 2 is combat
cmp        r2,#0x2
bne        NotLunge
ldr r2, LungeMarker
ldrb r2, [r2]
cmp r2, #3 @lunge selected
beq Lunge

NotLunge:
ldr        r2,[r6]
strb    r4,[r2,#0x10]
strb    r7,[r2,#0x11]
b        GoBack

Lunge:

ldrb        r2, [r5, #0xd] @the defender
cmp r2, #0x0 @if no defender it was a wall/snag
beq NotLunge

@check if lunging unit died
ldr r2, [r6]
ldrb r2, [r2, #0x13] @currenthp
cmp r2, #0
beq NotLunge

ldr        r0,GetCharData
mov        lr,r0
ldrb    r0,[r5,#0xD]
.short    0xF800                @returns defender's data in r0

@check if target is immovable (AI byte 4 is 0x20)
mov r2, #0x41
ldrb r2, [r0,r2] @AI byte 4
cmp r2, #0x20 @Guard Tile?
beq NotLunge

@check if target tile is passable terrain

mov r3,r0
ldrb r0,[r3,#0x10]
ldrb r1,[r3,#0x11]
ldr		r2,=#0x202E4DC	@terrain map
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates
@r0 = terrain ID of target tile
@check our movement data at that index
ldr        r1,[r6]                @attacker data
ldr r1,[r1,#4] @class data pointer
ldr r1,[r1,#0x38] @clear weather movement cost pointer; if we can't pass it in clear weather, we assume we can't pass it in any weather
add r1,r0 @index of our terrain
ldrb r0,[r1]
cmp r0,#0xFF
beq NotLunge

mov r0,r3


ldr        r2,[r6]                @attacker data
ldrb    r1,[r0,#0x10]        @defender x
strb    r1,[r2,#0x10]
ldrb    r1,[r0,#0x11]
strb    r1,[r2,#0x11]
ldrb    r1,[r5,#0xE]        @attacker x
strb    r1,[r0,#0x10]        @store attacker x coord in defender x coord
ldrb    r1,[r5,#0xF]
strb    r1,[r0,#0x11]

@update defender's rescuee coordinates to attacker coordinates if applicable
ldrb 	r0,[r0,#0x1B]
cmp 	r0,#0
beq 	GoBack

ldr 	r1,=#0x80182d8 @GetUnitByCharIdAndAllegiance
mov 	r14,r1
.short 	0xF800 @bl r14
cmp 	r0,#0 @if it returns null then don't try to do anything
beq 	GoBack

@ update coords
ldrb    r1,[r5,#0xE]        @attacker x
strb    r1,[r0,#0x10]        @store attacker x coord in defender x coord
ldrb    r1,[r5,#0xF]
strb    r1,[r0,#0x11]


GoBack:
ldr 	r0, LungeMarker
mov 	r1, #0
strb 	r1, [r0]
ldr     r0,[r2,#0xC]
pop     {r4-r7}
pop     {r1}
bx      r1

.align
Somewhere:
.long 0x0203A958
GetCharData:
.long 0x08019430
DefenderStruct:
.long 0x0203A56C
LungeMarker:
.long 0x203f101
