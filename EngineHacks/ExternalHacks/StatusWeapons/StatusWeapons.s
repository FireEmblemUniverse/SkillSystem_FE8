.thumb
.align
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global Proc_StatusWeapons
.type Proc_StatusWeapons, %function

.equ GetCharData, 0x8019431

Proc_StatusWeapons: @if byte at item table entry +0x1F for attacker's weapon = 0xD and we aren't going to miss this attack, write the byte at item table entry +0x22 to defender's status byte

@ r0 is attacker, r1 is defender, r2 is current buffer, r3 is battle data
push {r4-r7,lr}
mov r4, r0 @attacker
mov r5, r1 @defender
mov r6, r2 @battle buffer
mov r7, r3 @battle data
ldr     r0,[r2]           @r0 = battle buffer                @ 0802B40A 6800     
lsl     r0,r0,#0xD                @ 0802B40C 0340     
lsr     r0,r0,#0xD        @Without damage data                @ 0802B40E 0B40     
mov r1, #2 @miss
tst r0, r1
bne GoBack @if we miss, don't apply effect


@ check weapon effect
mov r0,r4
add r0,#0x4A
ldrh r0,[r0]
mov r1,#0xFF
and r0,r1

lsl r0, #1 @ 2 bytes per entry 

ldr r3,=StatusEffectTable
add r3, r0 
mov r7, r3 
ldrh r1, [r7] 
cmp r1, #0 
beq GoBack @ No data for this weapon, so exit. 
ldrb r0, [r7] 
mov r1, r4 @ Atkr 
mov r2, r5 @ Dfdr 
bl IsTargetTypeImmune
cmp r0,#0x1
beq GoBack @if type immunity, do nothing 
ldrb r0, [r7] @ Status type 


mov r1,r5
add r1,#0x30 @defender status byte
ldrb r2,[r1]
cmp r2,#0
bne GoBack @don't apply an effect if there is already an effect on this unit

@ check if we roll high enough to apply said effect 
blh 0x8000c64 @NextRN_100
ldrb r1, [r7, #1] @ Chance to inflict 
ldrb r2, [r5, #0x0B] @ deployment byte 
mov r3, #0x80 
and r2, r3 
lsr r2, #7 
lsl r1, r2 @ enemies as twice as likely to be inflicted by status 

cmp r1, r0 
blt GoBack @ No status inflicted 


@now we're ready to do our effect, but we need to do it to the unit's normal char struct
mov r0,r5
add r0,#0x6F
ldrb r1, [r7] @ Status Effect 
strb r1,[r0]


GoBack:
pop {r4-r7}
pop {r15}

.ltorg
.align
