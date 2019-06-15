.thumb
.equ RenewalID, SkillTester+4
push {r4, lr}
ldr r1, Some_Offset
add r0, r0, r1
ldrb r0, [r0]
lsl r0, r0, #0x18
asr r4, r0, #0x18
@That much is copy-paste from vanilla.
@It loads %HP to heal from terrain into r4

@Now check for Renewal skill

ldr r0, SkillTester
mov lr, r0
mov r0, r5
ldr r1, RenewalID
.short 0xf800
cmp r0, #0x0
beq no_renewal
 @add hp
 add r4, #30
no_renewal:
mov r0, r4 @return the amount healed.
pop {r4}
pop {r1}
bx r1
.align
Some_Offset:
.long 0x880C744
SkillTester:
@POIN SkillTester
@WORD RenewalID
