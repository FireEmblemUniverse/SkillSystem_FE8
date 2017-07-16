.thumb
@replaces 80230c0? is visit command
@make 8023073 E0 to ignore terrain type when Visit.
@ORG $230c0; replaceWithHack(thishack)
@whatever, we're gonna hardcode it lol

push {r4-r7,r14}
@original goes here
@r0 contains menu struct
@r1 contains some other

@routine start
RoutineStart:
mov r7, r0 @should = 20252a0 what is this???
ldr r4, TargetData
mov r5,#0x17        @(17 is bought from armory - guaranteed safe!)
strb r5,[r4,#0x11]
ldr r4,=0x3004e50
ldr r4, [r4]
mov r2, #0x40
ldrb r3, [r4, #0xc]
orr r2, r3
@ strb r2,[r4, #0xC] @set has cantoed

@get active unit's position
ldrb r5, [r4,#0x10] @x in r5
ldrb r6, [r4,#0x11] @y in r6

@get the location event
ldr r0, =0x202bcf0
ldrb r0, [r0, #0xe]
ldr r3, =0x80346b0 @get chapter events
mov lr,r3
.short 0xf800
ldr r0, [r0, #8] @location data pointer
@structure is
@ 05 00 short(eventid) dxx dyy 00 08 xx yy 10 00 (0xc bytes per)
@terminated by 00 00 00 00.
sub r0, #0xC
NextLOCA:
add r0, #0xC
ldrb r1, [r0]
cmp r1, #0
beq End
cmp r1, #5
bne NextLOCA
@check the coords
ldrb r1, [r0, #8]
cmp r1, r5
bne NextLOCA
ldrb r1, [r0, #9]
cmp r1, r6
bne NextLOCA
@if we got this far it's the right one. get the destination.
ldrb r1, [r0,#5]
ldrb r0, [r0,#4]

@actually we should check if there's anyone at the destination
ldr r5, =0x202e4d8
ldr r5, [r5] @unit map
lsl r6, r1, #2 @row
ldr r5, [r5,r6]
ldrb r5, [r5, r0] @column
cmp r5, #0
bne NoGo

@x in r0, y in r1, write to current unit
strb r1, [r4, #0x11]
strb r0, [r4, #0x10]
@also update the action struct
ldr r3, =0x203a958
strb r0, [r3, #0xe]
strb r1, [r3, #0xf]

@remove menu?
mov r0,r4
ldr r3, =0x802810c
mov lr,r3
.short 0xf800


@clear active unit data
ldr r0, ActiveUnit
ldr r1, NoUnit
str r1,[r0]
mov r0, #0xFF
strb r0,[r1,#0xC]
ldr r2, CursorLoc
ldrb r0,[r2] @y
strb r0,[r1,#0x11]
ldrb r0,[r2,#2] @x
strb r0,[r1,#0x10]

    @Testing Unknown function

        @lookup table at 801cdf8 - jump to 0801ce50
        @whats at 2026a70 (2026a84?) 0 at 3000108?
        @try calling 800306c with r0=20251c8? e4d4/54bc/5084/5528/5594
        @we need to find the correct value of r0.
            @starting at 2024e68, look for 89a2c48 (count up to 3f loops) and increment 6c after.
            @if match, check byte 1c. If not 00000000, this is the one we want.
    ldr r4, =0x2024e68
    ldr r6, =0x89a2c48
    mov r5, #0x3f
    LoopStart:
    ldr r0, [r4]
    cmp r0, r6
    bne NextLoop
        @ ldr r0, [r4,#0x1c]
        @ cmp r0, #0
        @ beq NextLoop
            mov r0, r4
            ldr r1, =0x800306c
            mov lr,r1
            .short 0xf800
            b Break
    NextLoop:
    sub r5, #1
    add r4, #0x6c
    cmp r5, #0
    bge LoopStart
Break:
ldr r0, =0x8019fa0 @reload unit map
mov lr, r0
.short 0xf800
End:
mov r0,#0x17

pop {r4-r7}
pop {r1}
bx r1

NoGo:
ldr r4, TargetData
mov r5,#0x1D        @(1D is didn't trade)
strb r5,[r4,#0x11]
mov r0, r7 @menu struct
ldr r1, =0x84c @text id to show
ldr r2, =0x804f580 @show text ID
mov lr, r2
.short 0xf800
mov r0, #0x8 @don't hide menu??
pop {r4-r7}
pop {r1}
bx r1

.align
TargetData:
.long 0x203a958
GetUnitData:
.long 0x8019430
ActiveUnit:
.long 0x3004e50
NoUnit:
.long 0x3004e70
CursorLoc:
.long 0x202bcc6
NormalRescue:
.long 0x8032164
RescueMarker:
.long 0x203f101
