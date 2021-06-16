.thumb
.align 4
.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm
.equ ActiveChar,0x3004E50
.equ prLearnNewSkill,SkillTester+4
.equ SkillID,prLearnNewSkill+4
.equ RemoveUnitBlankItems,0x8017984

@r4 = action struct, r5 = parent proc

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


@delete the item from the inventory

mov r0,#0
strh r0,[r2] @store 0x0000 to the item entry in question, thus removing it
mov r0,r4 @r0 = char struct
blh RemoveUnitBlankItems,r3 @move everything else up


mov r0,r4 @r0 = char
mov r2,r6 @r2 = parent proc
ldr r1,SkillID @r1 = skill ID

@now learn the skill specified in item uses

ldr 		r3, prLearnNewSkill
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
SkillTester:
@POIN SkillTester
@POIN prLearnNewSkill
@WORD SkillID
