.thumb
.align


.global Bond
.type Bond, %function



Bond:
push {r4-r5,r14}
mov r4,r0 @r4 = unit
mov r5,r1 @r5 = heal %

ldr r0, =AuraSkillCheck
mov lr, r0
mov r0, r4 @unit
ldr r1, =BondIDLink
ldrb r1, [ r1 ]
mov r2, #0 @same_team
mov r3, #3 @range
.short 0xf800
cmp r0, #0
beq GoBack
add r5, #10 @heal 10% hp



GoBack:
mov r0,r5
pop {r4-r5}
pop {r1}
bx r1

.ltorg
.align


