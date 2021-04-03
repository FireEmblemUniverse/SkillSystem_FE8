@ aura skill checker
@ is there a unit within range that has X skill?

.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
@r0 is unit
@r1 is skill to check
@r2 is allegiance setting: 0 = same team, 1 = are allies, 2 = different team, 3 - are enemies
@r3 is maxrange

push {r4-r7, lr}
mov r4, r0 @unit
mov r5, r1 @skill num
mov r6, r2 @allegiance
mov r7, r3 @maxrange

ldr r2, =0x2033f3c
str r4, [r2] @save unit data in RAM

ldr r0, =0x3004e50 @active unit
ldr r0, [r0]
ldrb r0, [r0, #0xb] @deployment number
ldrb r1, [r4, #0xb]
cmp r1, r0
bne RangeZeroer
@write the unit to the unit map ONLY IF ACTIVE UNIT
@ ldr r0, =0x3004e50
@ ldr r0, [r0]

cmp r4, r0
mov r0, #0x10
ldrsb r0, [r4,r0] @unit x
mov r1, #0x11
ldrsb r1, [r4,r1] @unit y
ldrb r2, [r4, #0xb] @deployment number
ldr r3, =0x202e4d8 @unit map
ldr r3, [r3]
lsl r1, #2
add r1, r3
ldr r1, [r1] @row start
strb r2, [r1, r0] @write unit to map

@not needed???
@ mov r0, #0x10
@ ldrsb r0, [r4,r0] @unit x
@ mov r1, #0x11
@ ldrsb r1, [r4,r1] @unit y
@ blh 0x804f8a4
RangeZeroer:
ldr r0, =0x202e4e4 @range map
ldr r0, [r0]
mov r1, #0
blh 0x80197e4 @zero out the range map

ldr r0, =0x801b9a4
mov lr, r0
mov r0, #0x10
ldrsb r0, [r4,r0] @unit x
mov r1, #0x11
ldrsb r1, [r4,r1] @unit y
mov r2, #1 @minrange
mov r3, r7 @maxrange
.short 0xf800 @write range map

ldr r0, AuraSkillTest @checks if anyone in range has X skill
mov r1, #1
orr r0, r1
mov r1, r5 @skill to test
mov r2, r6 @allegiance setting
ldrb r3, [r4, #0xb] @current unit's deployment no
bl unitcheckloop
@now r0 is the number of units in range that match and r1 is the start of the buffer

pop {r4-r7}
pop {r2}
bx r2
@returns r0

unitcheckloop:
@returns the number of units with the skill. the actual numbers are stored at 202b256
push {r4-r7,lr}
mov r6, r8
push {r6}
mov r6, r9
push {r6}
mov r6, r10
push {r6}
mov r7, r0 @routine to run
mov r8, r1 @skill to test
mov r9, r2 @allegiance
mov r12, r3 @deployment no to ignore
ldr r2, =0x202b256 @buffer to store deployment numbers of units with the skill
mov r10, r2
ldr r0, =0x202e4d4 @unit map
mov r1, #2
ldsh r0, [r0,r1]
sub r1, r0, #1
cmp r1, #0
blt Return
loop_start:
ldr r0, =0x202e4d4 @unit map
mov r2, #0
ldsh r0, [r0,r2]
sub r4, r0, #1
sub r6, r1, #1
cmp r4, #0
blt loc_24efe
lsl r5, r1, #2
loc_24ecc:
ldr r0, =0x202e4e4
ldr r0, [r0]
add r0, r5
ldr r0, [r0]
add r0, r4
ldrb r0, [r0]
lsl r0, #0x18
asr r0, #0x18
cmp r0, #0
beq loc_24ef8
ldr r0, =0x202e4d8
ldr r0, [r0]
add r0, r5
ldr r0, [r0]
add r1, r0, r4
ldrb r0, [r1]
cmp r0, #0
beq loc_24ef8
    blh 0x8019430 @found a unit in range
    mov r1, r8 @skill to check
    mov r2, r9 @allegiance
    bl goto_r7
cmp r0, #0
beq loc_24ef8
    @if unit found, r0 is its deployment number.
    lsl r0, #0x18
    lsr r0, #0x18
    cmp r0, r12
    beq loc_24ef8
    mov r1, r10
    strb r0, [r1] @write to buffer
    add r1, #1
    mov r10, r1 @advance buffer
loc_24ef8:
sub r4, #1
cmp r4, #0
bge loc_24ecc
loc_24efe:
mov r1, r6
cmp r1, #0
bge loop_start
b Return

Return:
@sum up the number we added
mov r2, r10
ldr r1, =0x202b256 @r1 is the start of the buffer
mov r0, #0
strb r0, [r2,#1] @end with a zero
sub r0, r2, r1 @now r0 is the number of spaces the buffer advanced

End:
pop {r3}
mov r10, r3
pop {r3}
mov r9, r3
pop {r3}
mov r8, r3
pop {r4-r7}
pop {r2}
bx r2

goto_r7:
bx r7

.ltorg 

AuraSkillTest:
@POIN AuraSkillTest
