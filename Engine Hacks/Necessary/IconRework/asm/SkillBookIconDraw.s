.thumb
.align

.global CheckIfSkillBookIcon
.type CheckIfSkillBookIcon, %function

.global CheckIfSkillBookIcon_Prep1
.type CheckIfSkillBookIcon_Prep1, %function

.global CheckIfSkillBookIcon_Prep2
.type CheckIfSkillBookIcon_Prep2, %function

.global CheckIfSkillBookIcon_Sell
.type CheckIfSkillBookIcon_Sell, %function


.equ ReturnPoint,0x8016ADD

CheckIfSkillBookIcon: @hook at 16AD4

ldrb r1,[r6,#0x1D] 	@icon ID
cmp r1,#0xFF 		@icon ID -1 = skill book icon of icon ID
bne IsItemIcon
@get icon based on durability of item; item halfword is in r9
mov r1,r9
lsr r1,r1,#8

mov r2,#5 			@skill book icon sheet ID
lsl r2,r2,#8 		@shifted 8 bits left
orr r1,r2
IsItemIcon:
mov r2,#0x80
lsl r2,r2,#7
mov r0,r7

ldr r3,=ReturnPoint
bx r3

.ltorg
.align


.equ ReturnPoint2,0x809A03D

CheckIfSkillBookIcon_Prep1: @hook at 9a034
@r5 = item halfword

mov r1,r0 @icon ID
cmp r1,#0xFF 		@icon ID -1 = skill book icon of icon ID
bne IsItemIcon_1
@get icon based on durability of item; item halfword is in r5
mov r1,r5
lsr r1,r1,#8

mov r2,#5 			@skill book icon sheet ID
lsl r2,r2,#8 		@shifted 8 bits left
orr r1,r2
IsItemIcon_1:

mov r0,r10
mov r2,#0x80
lsl r2,r2,#7

ldr r3,=ReturnPoint2
bx r3

.ltorg
.align


.equ ReturnPoint3,0x809B803

CheckIfSkillBookIcon_Prep2: @hook at 9B7F4
@r6 = item halfword

mov r0,r6
lsl r0,r0,#24
lsr r0,r0,#24
mov r1,#36 @table entry size
mul r0,r1
ldr r1,=ItemTable
add r0,r1
ldrb r0,[r0,#0x1D] @icon ID


mov r1,r0 @icon ID
cmp r1,#0xFF 		@icon ID -1 = skill book icon of (durability) ID
bne IsItemIcon_2
@get icon based on durability of item; item halfword is in r6
mov r1,r6
lsr r1,r1,#8

mov r2,#5 			@skill book icon sheet ID
lsl r2,r2,#8 		@shifted 8 bits left
orr r1,r2
IsItemIcon_2:

mov r0,r8
mov r2,#0x80
lsl r2,r2,#7

ldr r3,=ReturnPoint3
bx r3

.ltorg
.align


.equ ReturnPoint4,0x80168D1

CheckIfSkillBookIcon_Sell: @hook at 168C8
@item halfword in r6

ldrb r1,[r4,#0x1D]
cmp r1,#0xFF 		@icon ID -1 = skill book icon of icon ID
bne IsItemIcon_3

@get icon based on durability of item; item halfword is in r6
mov r1,r6
lsr r1,r1,#8

mov r2,#5 			@skill book icon sheet ID
lsl r2,r2,#8 		@shifted 8 bits left
orr r1,r2
IsItemIcon_3:

mov r2,#0x80
lsl r2,r2,#7
mov r0,r7

ldr r3,=ReturnPoint4
bx r3

.ltorg
.align


