.thumb
.equ DetonateFlag, 0x203F101

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

ldr r0, =DetonateFlag
ldrb r0, [r0]
cmp r0, #17         @was detonate selected?
bne End

ldr r0, =0x203A4EC  @is attacker?
cmp r4, r0
bne End

mov r1,#0x4A        @get the short for equipped items and uses BEFORE battle
ldrh r2,[r4,r1]     @load its value
lsr r2,#8           @shift the short two places to the right to isolate the weapon uses (as each byte takes 4 shifts - 2^4)
mov r6,#0x5A        @get the attack short
strh r2,[r4,r6]     @store the weapon uses as the unit's attack
mov r1,#0x48        @get the short for equipped items and uses AFTER battle
ldrb r5,[r4,r1]     @load its ID seperately
strh r5,[r4,r1]     @now store it as a short so the weapon uses will count as 0

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD DetonateID
