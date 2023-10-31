.thumb
.align

.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm
.equ ActiveChar,0x3004E50
.equ RemoveUnitBlankItems,0x8017984
.equ BG2Buffer, 0x02023CA8
.equ FillBgMap, 0x08001221
.equ EnableBgSyncByIndex, 0x08001FBD
.equ UnitDecreaseItemUse, 0x08018995
.equ BWL_GetEntry, 0x80A4CFD



.global MultiScrollPrepUsability
.type MultiScrollPrepUsability, %function

.global MultiScrollUsability
.type MultiScrollUsability, %function

.global MultiScrollEffect
.type MultiScrollEffect, %function

.global MultiScrollPrepEffect
.type MultiScrollPrepEffect, %function


MultiScrollPrepUsability:
mov r0,r5
mov r5,r4 @r5 = item
mov r4,r0 @r4 = unit

@do we have 4 learned skills?
ldr r0,[r4]
ldrb r0,[r0,#4]
blh BWL_GetEntry
add r0,#1
mov r2,#0

PrepUse_LoopStart:
cmp r2,#4
beq PrepUse_LoopExit
ldrb r1,[r0]
cmp r1,#0
beq PrepUse_LoopExit
cmp r1,#255
beq PrepUse_LoopExit
add r2,#1
add r0,#1
b PrepUse_LoopStart

PrepUse_LoopExit:
cmp r2,#4
beq PrepUse_False
b PrepUse_NormalVersion

PrepUse_False:
mov r0,#0
b PrepUse_Return

PrepUse_NormalVersion:
ldr r0,=MultiScrollUsability
mov r14,r0
.short 0xF800

PrepUse_Return:

pop {r4-r5}
pop {r1}
bx r1

.ltorg
.align


MultiScrollUsability:
lsr r1, r5, #8 @ top 8 bits of item (normally durability) hold the scroll's skill id
mov r0, r4

ldr 	r3, =SkillTester @r0 = char ID, r1 = skill ID; returns true/false in r0
mov 	lr, r3
.short 	0xF800
cmp r0,#1
beq ReturnFalse

mov r0,#1
b GoBack

ReturnFalse:
mov r0,#0

GoBack:
pop {r4,r5}
pop {r1}
bx r1

.ltorg
.align



MultiScrollEffect: @hybridized from some Tequila code

@r4 = action struct, r6 = parent proc

push {r4-r7}

ldr        r0,Get_Char_Data
mov        r14,r0
ldrb    r0,[r4,#0xC]        @character using
.short    0xF800
ldrb    r1,[r4,#0x12]        @item slot

mov r4,r0
mov r5,r1

@char struct is in r0, item slot is in r1, use together to get item uses & char ID

mov 		r2,r4 @get char struct
add 		r2,#0x1E @get start of inventory data
lsl 		r1,r1,#1 @multiply item slot by 2, for length of inventory entry
add 		r2,r1 @r2 = offset of item entry

ldrh r7,[r2] @get item halfword
lsr r7,r7,#8 @keep only durability byte, which is skill ID

@delete the item from the inventory

mov r0,#0
strh r0,[r2] @store 0x0000 to the item entry in question, thus removing it
mov r0,r4 @r0 = char struct
blh RemoveUnitBlankItems,r3 @move everything else up


mov r0,r4 @r0 = char
mov r2,r6 @r2 = parent proc
mov r1,r7@r1 = skill ID

@now learn the skill specified in item uses

ldr 		r3, =prLearnNewSkill
mov 		lr, r3
.short 		0xF800


pop {r4-r7}
ldr        r0,GoBackLoc
bx        r0

.ltorg
.align

Get_Char_Data:
.long 0x08019430
Battle_Struct_For_Items:
.long 0x0802CB24
GoBackLoc:
.long 0x0802FF76+1


MultiScrollPrepEffect:

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char

mov r1,r6
lsr r1,r1,#8 @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

@This decrements uses by 1, we want to remove the item entirely upon use since uses is skill ID
@mov r0,r4
@mov r1,r7
@blh UnitDecreaseItemUse
mov r1,r7

mov 		r2,r4 @get char struct
add 		r2,#0x1E @get start of inventory data
lsl 		r1,r1,#1 @multiply item slot by 2, for length of inventory entry
add 		r2,r1 @r2 = offset of item entry

@delete the item from the inventory

mov r0,#0
strh r0,[r2] @store 0x0000 to the item entry in question, thus removing it
mov r0,r4 @r0 = char struct
blh RemoveUnitBlankItems,r3 @move everything else up

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align


