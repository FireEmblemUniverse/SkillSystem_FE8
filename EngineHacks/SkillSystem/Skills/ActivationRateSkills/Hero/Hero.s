.thumb
.align

.global HeroSkill
.type HeroSkill, %function


HeroSkill: @r0 = activation chance, r1 = unit ptr; return updated activation chance
push {r4-r5,r14}
mov r4,r0
mov r5,r1

ldr r0,=SkillTester
mov r14,r0
mov r0,r5
ldr r1,=HeroIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#0
beq GoBack

ldrb r0,[r5,#0x13] @current hp
ldrb r1,[r5,#0x12] @max hp
lsr r1,r1,#0x1 @50% of max hp
cmp r0,r1
bgt	GoBack @if below half, continue
add	r4,#30	@add 30

GoBack:
mov r0,r4
pop {r4-r5}
pop {r1}
bx r1


.ltorg
.align
