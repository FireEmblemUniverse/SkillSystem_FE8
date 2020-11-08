.thumb
.align


.global Forager
.type Forager, %function



Forager:
push {r4-r5,r14}
mov r4,r0 @r4 = unit
mov r5,r1 @r5 = heal %

ldr r0,=SkillTester
mov r14,r0
mov r0,r4
ldr r1,=ForagerIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#0
beq GoBack

@check the terrain the unit is on, compare it against the list
ldrb	r0,[r4,#0x10]	@x coord of unit
ldrb	r1,[r4,#0x11]	@y coord of unit
lsl	r1,#2		@y times 4 since it's pointer
ldr	r2,=0x202E4DC	@tile id map pointer
ldr	r2,[r2]		@tile id map offset
ldr	r2,[r2,r1]	@load pointer to y row
ldrb	r0,[r2,r0]	@load x byte of the row, which gets us tile id
ldr	r1, =ForagerList
ForagerLoop:
ldrb	r2,[r1]
cmp	r2,#0
beq	GoBack
cmp	r2,r0
beq	yes_forager
add	r1,#1
b	ForagerLoop

@if on correct terrain, heal 20%
yes_forager:
add	r5,#20

GoBack:
mov r0,r5
pop {r4-r5}
pop {r1}
bx r1

.ltorg
.align


