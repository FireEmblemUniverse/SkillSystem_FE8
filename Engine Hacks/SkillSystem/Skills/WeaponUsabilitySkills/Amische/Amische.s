.thumb
.align

@r0 = character pointer
@r1 = item halfword
@r2 = rank 
@return either true or false

.equ AmischeID, SkillTester+4
.equ IronWeaponsList, AmischeID+4

push {r4-r7,r14}

mov r4,r0 @r4=char struct
mov r5,r1 @r5=item halfword
mov r6,r2 @r6=rank

@See if we have the skill
ldr r0,SkillTester
mov r14,r0
mov r0,r4
ldr r1,AmischeID
.short 0xF800
cmp r0,#0
beq RetTrue

@if so, check item ID vs external list

ldr r2,IronWeaponsList
mov r0,r5
mov r1,#0xFF
and r0,r1
IronWeaponsLoop:
ldrb r1,[r2]
cmp r1,#0
beq RetFalse
cmp r0,r1
beq RetTrue
add r2,#1
b IronWeaponsLoop


RetFalse:
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

SkillTester:
