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



.global MultiSpellScrollPrepUsability
.type MultiSpellScrollPrepUsability, %function

.global MultiSpellScrollUsability
.type MultiSpellScrollUsability, %function

.global MultiSpellScrollEffect
.type MultiSpellScrollEffect, %function

.global MultiSpellScrollPrepEffect
.type MultiSpellScrollPrepEffect, %function


MultiSpellScrollPrepUsability:
ldr r0,=MultiSpellScrollUsability
mov r14,r0
mov r0,r5
.short 0xF800

pop {r4-r5}
pop {r1}
bx r1

.ltorg
.align


MultiSpellScrollUsability:
lsr r1, r5, #8 @ get the durability of the item

mov r0, r4 
blh UsabilityByType

b GoBack

mov r0, #1 @always usable 
b GoBack 



ReturnFalse:
mov r0,#0

GoBack:
pop {r4,r5}
pop {r1}
bx r1

.ltorg
.align



MultiSpellScrollEffect: @hybridized from some Tequila code

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

ldr 		r3, =prLearnNewSpell
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


MultiSpellScrollPrepEffect:

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char

mov r1,r6
lsr r1,r1,#8 @r1 = skill ID

@now learn the skill specified in item uses

blh prLearnNewSpell

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


