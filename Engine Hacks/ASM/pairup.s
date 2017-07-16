.thumb
.org 0 @replaces 8032164, hook at 320ee
@paste to e17e8 and write af f0 7b fb to 320ee
@nop at 1833e for con check
@fff725fd at 25356 for disable green units

@rescue command has usability pointer at 80228a4, effect pointer at 80228dc


push {r4-r6,r14}
@unset 0x40 bit of target
mov r6, r0 @6c struct
ldr r4, TargetData
ldrb r0, [r4,#0xD]

ldr r1, GetUnitData
mov lr,r1
.short 0xf800

@r0 is target data
ldrb r1, [r0, #0xC] @status
mov r2, #0xBF
and r1, r2 @unset 0x40 bit
strb r1, [r0,#0xC]
mov r0, r6 @put r0 back


@check if should be rescuing

ldr r4, RescueMarker
ldrb r2,[r4]
cmp r2,#2
beq RoutineStart @pair up selected
cmp r2,#1 @rescue selected
bne End @if neither, something went wrong
ldr r1, NormalRescue
mov lr,r1
.short 0xf800
b End

@routine start
RoutineStart:
mov r6, r0 @should = 20252a0 what is this???
ldr r4, TargetData
ldrb r0, [r4,#0xD]

ldr r1, GetUnitData
mov lr,r1
.short 0xf800

@r0 = unit data of target
@mov r6, r0
@add r6, #0xC @ptr to turn status of target
mov r5, r0 @as original
ldrb r0, [r4,#0xC]

ldr r1, GetUnitData
mov lr,r1
.short 0xf800

mov r4, r0

ldr r1, =0x8037a6c
mov lr,r1
.short 0xf800

mov r2, #0x10
ldsb r0, [r5,r2]
mov r3, #0x11
ldsb r1,[r5,r3]
ldsb r2,[r4,r2]
ldsb r3,[r4,r3]

push {r4}
ldr r4, =0x801dbd4
mov lr,r4
.short 0xf800
pop {r4}

mov r1,r0
mov r0,r4
mov r2,#0
mov r3,r6

push {r4}
ldr r4, =0x801dc7c
mov lr,r4
.short 0xf800
pop {r4}

mov r0,r5
mov r1,r4

ldr r3, =0x801834c
mov lr,r3
.short 0xf800

mov r0,r4

ldr r3, =0x802810c
mov lr,r3
.short 0xf800

    @switch position data
    @mov r0, r7
    @add r0, #0xC
    @ldrb r1, [r0,#7]
    @strb r1, [r0,#2] @x pos
    @ldrb r2, [r0,#8]
    @strb r2, [r0,#3] @y pos

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
        ldr r0, [r4,#0x1c]
        cmp r0, #0
        beq NextLoop
            mov r0, r4
            ldr r1, =0x800306c
            mov lr,r1
            .short 0xf800
    NextLoop:
    sub r5, #1
    add r4, #0x6c
    cmp r5, #0
    bge LoopStart
mov r0,#0

End:
pop {r4-r6}
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
