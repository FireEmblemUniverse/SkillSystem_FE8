@hook at 8018878 with jumptohack
.thumb

cmp r6, #0x1 @if it's the first player unit
bne NotFirst
  push {r0-r3}
  bl ReduceEnemyFreeze
  pop {r0-r3}
NotFirst:
ldr r4, =0x8018881 @return position, r4 is immediately clobbered so it's fine
ldr r1, =0x859a5d0
mov r0, #0xff
and r0, r6
lsl r0, #2
bx r4


ReduceEnemyFreeze:
push {r4-r6, lr} @loop through all enemies and reduce their freeze status only
mov r4, #0x81 @first enemy
ldr r5, =0x859a5d0 @pointers to ram
EnemyLoop:
lsl r0, r4, #2
ldr r6, [r5,r0]
mov r0, #0x30
add r0, r6 @status
ldrb r1, [r0]
mov r2, #0xF
and r2, r1 @type of status in r2
cmp r2, #0x9
bne NextEnemy
@it has freeze, so reduce it
lsr r3, r1, #4 @turns remaining in r3
sub r3, #1
lsl r3, #4
orr r2,r3
strb r2, [r0]
cmp r3, #0
bne NextEnemy

ldr r0, =0x804f8bc
mov lr, r0

mov r0, #0x10
ldsb r0, [r6,r0]
mov r1, #0x11
ldsb r1, [r6,r1]
mov r2, #0xB
ldsb r2, [r6,r2]
mov r3, #0
.short 0xf800
NextEnemy:
add r4, #1
cmp r4, #0xC1
blt EnemyLoop
pop {r4-r6}
pop {r0}
bx r0
