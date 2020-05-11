.thumb
.equ ChargePlusID, SkillTester+4
.equ MovGetter, ChargePlusID+4

push {r4-r7, lr}
ldr     r5,=0x203a4ec @attacker
cmp     r0,r5
bne     End
mov r4, r0 @atkr
mov r5, r1 @dfdr


@has Charge
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @Attacker data
ldr r1, ChargePlusID
.short 0xf800
cmp r0, #0
beq GoBack

@get unit's move
ldr r0,MovGetter
mov r14,r0
mov r0,r4
.short 0xF800
@r0= unit's move

@get unit's used up movement from action struct
ldr r1,=0x203A958 @action struct
add r1,#0x10 @squares moved this turn
ldrb r1,[r1] @r1 = squares moved

@get remaining move
sub r0,r1
cmp r0,#0 @see if we've moved as far as possible
bne GoBack @if not, no bonus

@otherwise, set the brave flag on our weapon
mov r0,r4
add r0,#0x4C @item ability word
ldr r1,[r0]
mov r2,#0x20 @brave flag
orr r1,r2
str r1,[r0]


GoBack:
pop {r4-r7, r15}

.align
.ltorg

SkillTester:
@POIN SkillTester
@WORD ChargePlusID
@POIN prMovGetter
