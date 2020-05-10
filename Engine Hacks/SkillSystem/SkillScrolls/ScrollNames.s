.thumb
.align

@GetItemNameString 80174F4
.global GetItemNameString
.type GetItemNameString, %function

@GetItemDescStringIndex 8017518
.global GetItemDescStringIndex
.type GetItemDescStringIndex, %function


.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ ReturnPoint1,0x8017507
.equ String_GetFromIndex,0x800A241
.equ gCurrentTextString,0x202A6AC
.equ ReturnPoint2,0x801750B

GetItemNameString: @hook at 174F8

push {r4}
mov r4,r0

@get ID from item table
mov r1,#0xFF
and r0,r1
lsl r1,r0,#3
add r1,r1,r0
lsl r1,r1,#2
ldr r0,=ItemTable
add r1,r0
ldrh r0,[r1] 

@r0 = name ID string

ldrh r1,=#0xFFFF @comparator string

cmp r0,r1
bne VanillaFunc1

@we want to get the skill desc text ID for this, then make a string that's just that text up to the colon and return that as the name string

ldr r1,=SkillDescTable

mov r0,r4
lsr r0,r0,#8 @just durability
lsl r0,r0,#1 @*2

add r0,r1
ldrh r0,[r0] @r0 = text ID for skill desc text for current item

blh String_GetFromIndex

@string is now loaded in memory to gCurrentTextString, now we go through and look for a colon (0x3A) byte by byte

ldr r0,=gCurrentTextString

LoopStart:
ldrb r1,[r0]
cmp r1,#0
beq LoopExit
cmp r1,#0x3A @ ":"
beq FoundColon
add r0,#1
b LoopStart

FoundColon:
@address in r0
mov r1,#0
strb r1,[r0]

LoopExit:
pop {r4}
ldr r3,=ReturnPoint2
bx r3


VanillaFunc1:
pop {r4}
ldr r3,=ReturnPoint1
bx r3

.ltorg
.align



GetItemDescStringIndex: @hook at 17518
push {r4}
mov r4,r0

mov r1,#0xFF
and r0,r1
lsl r1,r0,#3
add r1,r0
lsl r1,r1,#2
ldr r0,=ItemTable
add r1,r0
ldrh r0,[r1,#2] @r0 = desc ID

ldr r1,=#0xFFFF
cmp r0,r1
bne GoBack

mov r0,r4
lsr r0,r0,#8
lsl r0,r0,#2

ldr r1,=SkillDescTable
add r0,r1
ldrh r0,[r0]

GoBack:
bx r14

.ltorg
.align


