.thumb
.align

.equ OutdoorFighterID,SkillTester+4
.equ OutdoorTerrainList,OutdoorFighterID+4

.equ gMapTerrain,0x202E4DC

@inOutdoor/outOutdoor fighter func

push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

ldrb r1,[r4,#0x10] @r1=y pos
ldrb r0,[r4,#0x11] @r0=x pos
ldr r2,=gMapTerrain
mov r3,#4
mul r0,r3
add r2,r0
ldr r0,[r2]
add r0,r1
ldrb r6,[r0] @r6= current terrain

ldr r7,OutdoorTerrainList
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
@WORD OutdoorFighterID
@POIN OutdoorTerrainList

