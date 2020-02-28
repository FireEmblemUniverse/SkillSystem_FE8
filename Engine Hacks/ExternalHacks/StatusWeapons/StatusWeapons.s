.thumb
.align

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
mov r1,#36 @length of item table entry
mul r0,r1
ldr r1,=ItemTable
add r1,r0
ldrb r0,[r1,#0x1F] @r0 = weapon effect
cmp r0,#0xD
bne GoBack @if no status weapon bit, don't apply effect

@check if defender already has a status
add r1,#0x22
ldrb r0,[r1] @status to apply
mov r1,r5
add r1,#0x30 @defender status byte
ldrb r2,[r1]
cmp r2,#0
bne GoBack @don't apply an effect if there is already an effect on this unit

@now we're ready to do our effect, but we need to do it to the unit's normal char struct
push {r0}
mov r0,r5
add r0,#0x6F
pop {r1}
strb r1,[r0]


GoBack:
pop {r4-r7}
pop {r15}

.ltorg
.align
