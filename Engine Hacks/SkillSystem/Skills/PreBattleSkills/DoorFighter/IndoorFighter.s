.thumb
.align

.equ IndoorFighterID,SkillTester+4
.equ IndoorTerrainList,IndoorFighterID+4

.equ gMapTerrain,0x202E4DC

@indoor/outdoor fighter func

push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

mov r0,r4
ldr r1,SkillTester
mov r14,r1
ldr r1,IndoorFighterID
.short 0xF800
cmp r0,#0
beq GoBack

ldrb r0,[r4,#0x10] @r0=x pos
ldrb r1,[r4,#0x11] @r1=y pos
ldr		r2,=gMapTerrain	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r6,[r2]			@load datum at those coordinates

ldr r7,IndoorTerrainList
LoopStart:
ldrb r0,[r7]
cmp r0,#0
beq GoBack
cmp r0,r6
beq LoopSuccess
add r7,#1
b LoopStart

LoopSuccess:

mov r0,r4
@hit
add r0,#0x60
ldrh r3,[r0]
add r3,#10
strh r3,[r0]
@avo
add r0,#2
ldrh r3,[r0]
add r3,#10
strh r3,[r0]


GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD IndoorFighterID
@POIN IndoorTerrainList

