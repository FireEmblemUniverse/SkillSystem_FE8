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

ldr        r2,[r6]                @attacker data
ldrb    r1,[r0,#0x10]        @defender x
strb    r1,[r2,#0x10]
ldrb    r1,[r0,#0x11]
strb    r1,[r2,#0x11]
ldrb    r1,[r5,#0xE]        @attacker x
strb    r1,[r0,#0x10]        @store attacker x coord in defender x coord
ldrb    r1,[r5,#0xF]
strb    r1,[r0,#0x11]

GoBack:
ldr r0, LungeMarker
mov r1, #0
strb r1, [r0]
ldr        r0,[r2,#0xC]
pop        {r4-r7}
pop        {r1}
bx        r1

.align
Somewhere:
.long 0x0203A958
GetCharData:
.long 0x08019430
DefenderStruct:
.long 0x0203A56C
LungeMarker:
.long 0x203f101
