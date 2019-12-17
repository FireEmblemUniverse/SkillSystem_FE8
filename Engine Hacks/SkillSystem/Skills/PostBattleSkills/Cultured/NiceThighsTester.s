.thumb
.align 4

.equ NiceThighsID, SkillTester+4
.equ GetUnit, 0x8019431
.equ UnitMap, 0x202E4D8

push {r4-r7,r14}

@r0=character struct

mov r4,r0 @r4 = char to test for adjacent units with Nice Thighs

ldrb r5,[r4,#0x10] @x coord
ldrb r6,[r4,#0x11] @y coord

mov r0,r5
sub r0,#1
mov r1,r6
bl GetUnitAtCoords
ldr r1,SkillTester
mov r14,r1
ldr r1,NiceThighsID
.short 0xF800
cmp r0,#1
beq RetTrue

mov r0,r5
add r0,#1
mov r1,r6
bl GetUnitAtCoords
ldr r1,SkillTester
mov r14,r1
ldr r1,NiceThighsID
.short 0xF800
cmp r0,#1
beq RetTrue

mov r0,r5
mov r1,r6
sub r1,#1
bl GetUnitAtCoords
ldr r1,SkillTester
mov r14,r1
ldr r1,NiceThighsID
.short 0xF800
cmp r0,#1
beq RetTrue

mov r0,r5
mov r1,r6
add r1,#1
bl GetUnitAtCoords
ldr r1,SkillTester
mov r14,r1
ldr r1,NiceThighsID
.short 0xF800
cmp r0,#1
beq RetTrue

mov r0,#0
b GoBack

RetTrue:
mov r0,#1

GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

GetUnitAtCoords:
push {r14}
ldr		r2,=UnitMap		@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates
ldr		r1,=GetUnit
mov		r14,r1
.short 0xF800
pop {r1}
bx r1

.ltorg
.align


SkillTester:
@POIN SkillTester
@WORD NiceThighsID
