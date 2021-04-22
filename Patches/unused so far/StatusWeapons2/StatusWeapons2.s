.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
@B4BF60
.global Proc_StatusWeapons2
.type Proc_StatusWeapons2, %function

.equ Get_Item_Data, 0x080177B0

Proc_StatusWeapons2: 

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
ldrb r0,[r0]
blh Get_Item_Data

ldrb r0,[r0,#0x1F] @r0 = weapon effect

cmp r0, #0x6
beq Sleep
cmp r0, #0x7
beq Bersak
cmp r0, #0x8
beq Silence
cmp r0, #0x9
beq Freeze
b GoBack @if no special effect

Sleep:
mov r0, #0x2
b StoreBadStatus

Bersak:
mov r0, #0x4
b StoreBadStatus

Freeze:
mov r0, #0x9
b StoreBadStatus

Silence:
mov r0, #0x3
@b StoreBadStatus

@now we're ready to do our effect, but we need to do it to the unit's normal char struct
StoreBadStatus:
mov r1,r5
add r1,#0x6F
strb r0,[r1]


GoBack:
pop {r4-r7}
pop {r15}


.ltorg
.align
