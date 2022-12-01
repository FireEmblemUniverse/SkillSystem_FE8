.thumb
.align

.global AdvWeaponLocks
.type AdvWeaponLocks, %function
AdvWeaponLocks: @return usability bool in r0

push {r4-r7,r14}
mov r4,r0 @character pointer
mov r5,r1 @item halfword
mov r6,r2 @character wrank

@load weapon ability word @@@@@this is not an attacker struct we can't use the version in ram!!!
mov r1,#0xFF
and r1,r5
mov r0,#0x24
mul r1,r0
ldr r0,=ItemTable
add r0,r1
add r0,#8
ldr r0,[r0]
lsr r0,#24 @r0 = ability byte 4
cmp r0,#0
beq RetTrue

@get array pointer
lsl r0,#2 @x4
ldr r1,=WeaponLockArrayPointerTable
add r7,r0,r1
ldr r0,[r7]
cmp r0,#0
beq RetTrue

@actually load the byte at the start of the array + set the array pointer in r7
mov r7,r0
ldrb r0,[r7]

@do we get character or class ID
cmp r0,#1
ble GetCharID

GetClassID:
ldr r1,[r4,#4]
ldrb r1,[r1,#4]
b GetIDEnd

GetCharID:
ldr r1,[r4]
ldrb r1,[r1,#4]

GetIDEnd:
push {r0} @first array byte, for later use

add r7,#1
LoopStart:
ldrb r0,[r7]
cmp r0,#0
beq LoopFail
cmp r0,r1
beq LoopSuccess
add r7,#1
b LoopStart

LoopFail:
@check if soft or hard lock
pop {r0}
cmp r0,#0
beq RetTrue
cmp r0,#1
beq RetFalse
cmp r0,#2
beq RetTrue
cmp r0,#3
beq RetFalse

LoopSuccess:
pop {r0}
@check if monster weapon as they do not have weapon ranks
mov r1,#0xFF
and r1,r5
mov r0,#0x24
mul r1,r0
ldr r0,=ItemTable
add r0,r1
add r0,#7
ldrb r0,[r0]
cmp r0,#0x0B
beq RetTrue

@If unit does not have rank in weapon with soft rank, prevent use with soft lock.
cmp r2,#0
beq RetFalse

@Return 2 to prevent conflict with Amische skill
mov r0,#2
b GoBack

RetTrue:
mov r0,#1
b GoBack

RetFalse:
mov r0,#0

GoBack:
pop {r4-r7}
pop {r1}
bx r1


.ltorg
.align

