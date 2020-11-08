.thumb
.align

@GetItemNameString 80174F4
.global GetItemNameString
.type GetItemNameString, %function

@GetItemDescStringIndex 8017518
.global GetItemDescStringIndex
.type GetItemDescStringIndex, %function

.global NewItemNameGetter1
.type NewItemNameGetter1, %function

.global NewItemNameGetter2
.type NewItemNameGetter2, %function

.global NewItemNameGetter3
.type NewItemNameGetter3, %function


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

push {r4-r7}
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

ldr r5,=DurabilityBasedItemNameList

Loop1Start:
ldrh r1,[r5]
cmp r1,#0
beq VanillaFunc1
cmp r0,r1
beq Loop1Exit
add r5,#8
b Loop1Start

Loop1Exit:


ldr r1,[r5,#4]

mov r0,r4
lsr r0,r0,#8 @just durability
lsl r0,r0,#1 @*2

add r0,r1
ldrh r0,[r0] @r0 = text ID for skill desc text for current item



blh String_GetFromIndex

ldrh r1,[r5,#2] @boolean
cmp r1,#0
beq SkipDoingColonTerminaton

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

SkipDoingColonTerminaton:
LoopExit:
pop {r4-r7}
ldr r3,=ReturnPoint2
bx r3


VanillaFunc1:
pop {r4-r7}
ldr r3,=ReturnPoint1
bx r3

.ltorg
.align


.equ ReturnPoint3,0x8016A61
.equ ReturnPoint5,0x8016A5D

NewItemNameGetter1: @hook at 16A54

lsl r1,r1,#2
ldr r0,=ItemTable
add r6,r1,r0
ldrh r0,[r6]

@r0 = name ID string

ldr r3,=DurabilityBasedItemNameList

Loop2Start:
ldrh r1,[r3]
cmp r1,#0
beq VanillaFunc2
cmp r0,r1
beq Loop2Exit
add r3,#8
b Loop2Start


Loop2Exit:

ldr r1,[r3,#4]

mov r0,r9
lsr r0,r0,#8 @just durability
lsl r0,r0,#1 @*2

add r0,r1
ldrh r0,[r0] @r0 = text ID for skill desc text for current item

blh String_GetFromIndex

ldrh r0,[r3,#2]
cmp r0,#0
beq SkipColonTermination2

@string is now loaded in memory to gCurrentTextString, now we go through and look for a colon (0x3A) byte by byte

ldr r0,=gCurrentTextString

LoopStart2:
ldrb r1,[r0]
cmp r1,#0
beq LoopExit2
cmp r1,#0x3A @ ":"
beq FoundColon2
add r0,#1
b LoopStart2

FoundColon2:
@address in r0
mov r1,#0
strb r1,[r0]

SkipColonTermination2:
LoopExit2:
ldr r3,=ReturnPoint3
bx r3

VanillaFunc2:
ldr r3,=ReturnPoint5
bx r3

.ltorg
.align



.equ ReturnPoint4,0x8016881
.equ ReturnPoint6,0x801687D

NewItemNameGetter2: @ hook at 16874
lsl r1,r1,#2
ldr r0,=ItemTable
add r4,r1,r0
ldrh r0,[r4]

@r0 = name ID string

ldr r3,=DurabilityBasedItemNameList

Loop3Start:
ldrh r1,[r3]
cmp r1,#0
beq VanillaFunc3
cmp r0,r1
beq Loop3Exit
add r3,#8
b Loop3Start

Loop3Exit:

ldr r1,[r3,#4]

mov r0,r6
lsr r0,r0,#8 @just durability
lsl r0,r0,#1 @*2

add r0,r1
ldrh r0,[r0] @r0 = text ID for skill desc text for current item

blh String_GetFromIndex

ldrh r1,[r3,#2]
cmp r1,#0
beq SkipColonTermination3

@string is now loaded in memory to gCurrentTextString, now we go through and look for a colon (0x3A) byte by byte

ldr r0,=gCurrentTextString

LoopStart3:
ldrb r1,[r0]
cmp r1,#0
beq LoopExit3
cmp r1,#0x3A @ ":"
beq FoundColon3
add r0,#1
b LoopStart3

FoundColon3:
@address in r0
mov r1,#0
strb r1,[r0]

SkipColonTermination3:
LoopExit3:
ldr r3,=ReturnPoint4
bx r3

VanillaFunc3:
ldr r3,=ReturnPoint6
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

ldr r2,=DurabilityBasedItemDescList
DescLoopStart:
ldrh r1,[r2]
cmp r1,#0
beq GoBack
cmp r0,r1
beq DescLoopExit
add r2,#8
b DescLoopStart

DescLoopExit:
mov r0,r4
lsr r0,r0,#8
lsl r0,r0,#1 @*2

ldr r1,[r2,#4]
add r0,r1
ldrh r0,[r0]

GoBack:
pop {r4}
bx r14

.ltorg
.align




.equ ReturnPointDelta,0x80169CB
.equ ReturnPointBravo,0x80169CF

NewItemNameGetter3: @r6 = item halfword
mov r0,#0xFF
and r0,r6
mov r1,#36
mul r0,r1
ldr r1,=ItemTable
add r5,r0,r1
ldrh r0,[r5]

ldr r3,=DurabilityBasedItemNameList

LoopDeltaStart:
ldrh r1,[r3]
cmp r1,#0
beq LoopDeltaUseID
cmp r0,r1
beq LoopDeltaExit
add r3,#8
b LoopDeltaStart

LoopDeltaExit:

ldr r1,[r3,#4]

mov r0,r6
lsr r0,r0,#8 @just durability
lsl r0,r0,#1 @*2

add r0,r1
ldrh r0,[r0] @r0 = text ID for skill desc text for current item

blh String_GetFromIndex

ldrh r1,[r3,#2] @boolean
cmp r1,#0
beq SkipDoingColonTerminatonDelta

@string is now loaded in memory to gCurrentTextString, now we go through and look for a colon (0x3A) byte by byte

ldr r0,=gCurrentTextString

LoopStartDelta:
ldrb r1,[r0]
cmp r1,#0
beq SkipDoingColonTerminatonDelta
cmp r1,#0x3A @ ":"
beq FoundColonDelta
add r0,#1
b LoopStartDelta

FoundColonDelta:
@address in r0
mov r1,#0
strb r1,[r0]

SkipDoingColonTerminatonDelta:
ldr r0,=gCurrentTextString
ldr r3,=ReturnPointBravo
bx r3

LoopDeltaUseID:
ldr r3,=ReturnPointDelta
bx r3

.ltorg
.align

