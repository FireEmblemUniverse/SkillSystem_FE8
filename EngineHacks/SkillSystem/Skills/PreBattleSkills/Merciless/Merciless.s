.thumb
.equ MercilessID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has Merciless
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, MercilessID
.short 0xf800
cmp r0, #0
beq End

@check status of enemy
mov r0,#0x30            @get status byte
ldrb r1,[r5,r0]         @load the defender's status byte
mov r2,#0xF
and r1,r2               @and it with F to isolate the second bit
cmp r1,#1               @compare it to the poison status effect (#1)
bne End                 @if they're not poisoned, branch to the end

@apply Merciless
mov r0,#0x66            @get the critical hit rate
ldrh r1,[r4,r0]         @load the attacker's critical hit rate
mov r1,#0xFF            @set it to 255 (we could go much higher since it's a short but there's almost no point)
strh r1,[r4,r0]         @store the new value

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD MercilessID
