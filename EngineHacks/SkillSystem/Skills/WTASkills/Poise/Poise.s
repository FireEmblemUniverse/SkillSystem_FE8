.thumb
.equ	PoiseID,SkillTester+4

push {r4-r6,lr}
mov r4,r0 @ Attack struct
mov r5,r1 @ Defense struct

@ check if defender has poise
ldr r6,SkillTester
mov r0,r5
ldr r1,PoiseID
mov r14,r6
.short 0xF800
cmp r0,#0
beq CheckAttacker

@check if weapon triangle disadvantage
mov r0,#0x53
ldsb r1,[r4,r0]
cmp r1,#0
ble CheckAttacker

@zero out the hit bonus
mov r1,#0
strb r1,[r4,r0]

CheckAttacker:
ldr r6,SkillTester
mov r0,r4
ldr r1,PoiseID
mov r14,r6
.short 0xF800
cmp r0,#0
beq End

@check if weapon triangle disadvantage
mov r0,#0x53
ldsb r1,[r5,r0]
cmp r1,#0
ble End

@zero out the hit bonus
mov r1,#0
strb r1,[r5,r0]

End:
pop {r4-r6}
pop {r0}
bx r0

.align 4
.ltorg
SkillTester:
@POIN SkillTester
@WORD PoiseID
