.thumb
.align

.global AdvWeaponLocks
.type AdvWeaponLocks, %function
AdvWeaponLocks: @return usability bool in r0

push {r4-r7,r14}
mov r4,r0 @character pointer
mov r5,r1 @item halfword
mov r6,r2 @character wrank
push {r6}

mov r0,r5
bl GetItemTableLoc
ldrb r1,[r0,#0xB] @Load weapon ability byte 4
cmp r1,#0
beq RetTrue @if no array ID, there's no lock


ldr r7,=WeaponLockArrayPointerTable
lsl r1,#2
ldr r7,[r1,r7]
cmp r7,#0
beq RetTrue @if pointer is null, there's no lock

@Now the actual locks part begins

EitherOrInitial:
ldrb r2,[r7]
mov r3,#0x8
and r3,r2
cmp r3,#0
beq LockSort
mov r3,#0x4
and r3,r2
mov r0,#0
add r7,#1

ldrb r6,[r7,r1]
cmp r6,#0
beq EitherOrLoopEnd
pop {r0}
cmp r0,#0
beq FalseCheck
cmp r3,#0
bne EitherOrLoopEnd_2
b EitherOrLoopEnd
FalseCheck:
cmp r3,#0
bne EitherOrLoopEnd
b RetFalse

EitherOrLoopEnd:
add r1,#1
cmp r1,#7
ble EitherOr
EitherOrLoopEnd_2:
add r7,#7
push {r0-r1}
mov r0,r5
bl GetItemTableLoc
ldrb r2,[r0,#0x1C] @get weapon level of item
pop {r0-r1}

LockSort:
mov r3,#1
and r3,r6
cmp r3,#0
beq Sort_3

Hardlock:
mov r2,#0xFF

Sort_3:
mov r3,#0x2
and r6,r3
cmp r6,#0
beq Sort_4

Classlock:
mov r6,r4
add r6,#4
ldr r3,[r6]
b Sort5

Sort_4:
mov r3,r4
ldr r3,[r3]
Sort5:
add r3,#4
ldrb r3,[r3]

Sort_Loop_Start:
add r7,#1
ldrb r6,[r7]
cmp r6,r3
beq Lock_Match
cmp r7,#0
beq RetTrue
b Sort_Loop_Start

Lock_Match:
mov r2,#1

RetTrue:
mov r0,#1
b GoBack

RetFalse:
mov r0,#0

pop {r4-r7}
pop {r1}
bx r1


.ltorg
.align


GetItemTableLoc:
@r0 = item halfword
mov r1,#0xFF
and r1,r0
mov r0,#36
mul r1,r0
ldr r0,=ItemTable
add r0,r1
bx r14

.ltorg
.align

