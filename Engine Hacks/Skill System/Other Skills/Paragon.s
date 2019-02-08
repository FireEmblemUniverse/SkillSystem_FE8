.thumb
@hook at 802b960, r0=exp
.equ ParagonID, SkillTester+4
push {r4}

mov r4, r0 @store the exp value here
mov r6, r5
add r6, #0x6e @location to store exp

@Now check for Paragon skill

ldr r0, SkillTester
mov lr, r0
mov r0, r5 @defender
ldr r1, ParagonID
.short 0xf800
cmp r0, #0x0
beq no_Paragon1
 @double exp
 bl MultiplyExpR4
 cmp r4, #100
 ble no_Paragon1
  mov r4, #100
no_Paragon1:
mov r0, r4 @return the amount healed.
pop {r4}

strb r0, [r6]

@and again for the attacker
ldr r0, =0x802c534
mov lr, r0
mov r0, r4
mov r1, r5
.short 0xf800
push {r5}
mov r5, r0

@Now check for Paragon skill again

ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker
ldr r1, ParagonID
.short 0xf800
cmp r0, #0x0
beq no_Paragon
 @double exp
 bl MultiplyExpR5
 cmp r5, #100
 ble no_Paragon
  mov r5, #100
no_Paragon:
mov r0, r5 @return the amount healed.
pop {r5}

mov r1, r4
add r1, #0x6e
strb r0, [r1]

@get the return value
ldr r1, =0x802b96f
bx r1

MultiplyExpR4: @1.5x exp
push {r0-r3}
mov r0, r4
mov r1, #2
swi 0x6   @division
add r4, r0
pop {r0-r3}
bx lr

MultiplyExpR5: @1.5x exp
push {r0-r3}
mov r0, r5
mov r1, #2
swi 0x6   @division
add r5, r0
pop {r0-r3}
bx lr

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD ParagonID
