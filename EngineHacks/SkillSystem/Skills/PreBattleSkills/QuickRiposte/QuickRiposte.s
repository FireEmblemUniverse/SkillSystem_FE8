.thumb
.align


@in 3H, Quick Riposte sets your AS to [enemy AS + 5]


.equ QuickRiposteID, SkillTester+4


push {r4-r5,r14}
mov r4,r0
mov r5,r1

@does defender have Quick Riposte?
ldr r0,=#0x203A56C @this gets run twice, once with attacker/defender as proper and once swapped; as such, we check just the defender directly
ldr r1,QuickRiposteID
ldr r2,SkillTester
mov r14,r2
.short 0xF800
cmp r0,#0
beq GoBack

@is the defender at 50% hp or greater?
ldr r3,=#0x203A56C
ldrb r0,[r3,#0x12] 	@max HP
ldrb r1,[r3,#0x13] 	@cur HP
lsr r0,r0,#1 		@halved
cmp r1,r0			@checking if r1 >= r0
blt GoBack			@if not, go back

@get attacker's AS
ldr r2,=#0x203A4EC
add r2,#0x5E
ldrh r2,[r2]
@add 5
add r2,#5
@store as defender's AS
add r3,#0x5E
strh r2,[r3]

GoBack:
pop {r4-r5}
pop {r0}
bx r0


.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD QuickRiposteID
