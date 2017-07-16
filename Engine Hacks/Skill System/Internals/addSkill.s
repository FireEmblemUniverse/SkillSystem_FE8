.thumb
@adds a skill to the given unit's list of skills. Returns 0 if unit already has 4 skills
@r0 is unit in ram
.set BWLTable, 0x203e884

push {r4-r5,lr}

mov r5, r1

ldr r4, [r0]
ldrb r4, [r4, #4] @char num in r4
cmp r4, #0x46
bhi False

ldr r0, =BWLTable
lsl r1, r4, #4 @r1 = char*0x10
add r0, r1
add r0, #1 @start at byte 1, not 0
mov r2, #0
LoopStart:
ldrb r1, [r0,r2] @get nth skill
cmp r1, r5
beq False @if skill already known, don't learn
cmp r1, #0
bne NextLoop @if skill already here, skip ahead

strb r5, [r0, r2]
b True

NextLoop:
cmp r2, #3
bge False
add r2, #1
b LoopStart

True:
mov r0, #1
b End

False:
mov r0, #0

End:
pop {r4-r5}
pop {r1}
bx r1
