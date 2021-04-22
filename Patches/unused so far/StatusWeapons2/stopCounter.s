@If the enemy has a bad status, suppress the counterattack.
@
@Hook 2B8E0
@r5 gpCurrentRound
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ Get_Item_Data, 0x080177B0

ldrb r0, [r0, #0x0]  @gpCurrentRound->0x6f statusOut

mov  r1, #0x0f
and  r0, r1

cmp r0, #0x2    @sleep
beq stopCounter
cmp r0, #0x3    @silence
beq CheckSilence
cmp r0, #0x4    @bersak
beq stopCounter
cmp r0, #0x9    @freeze(skillsystems extends)
beq stopCounter
cmp r0, #0xb    @stone
beq stopCounter
cmp r0, #0xd    @stone2
beq stopCounter
b   Exit

CheckSilence:
mov r0,r5
add r0,#0x4A
ldrb r0,[r0]
blh Get_Item_Data
ldrb r1,[r0,#0x7]
cmp r1,#0x4 @staff
beq stopCounter
cmp r1,#0x5 @anima
beq stopCounter
cmp r1,#0x6 @light
beq stopCounter
cmp r1,#0x7 @dark
beq stopCounter

Exit:
ldr r3, =0x802b918+1
bx  r3

stopCounter:
ldr r3, =0x802b8ee+1
bx  r3
