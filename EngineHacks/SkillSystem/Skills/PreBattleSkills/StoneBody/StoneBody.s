.thumb
.equ StoneBodyID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has StoneBody
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, StoneBodyID
.short 0xf800
cmp r0, #0
beq End

@reset the placeholders for the con stats
mov r0, #0
mov r2, #0

@Getting attacker CON
ldrb r1, [r4, #0x1A]
add r0, r1

@Getting defender CON
ldrb r1, [r5, #0x1A]
add r2, r1

cmp r0, r2          @compare the skill holder's CON to the enemy's con
bgt AddBoost        @if the skill holder's is greater, then branch to apply the boost
b   End             @otherwise branch to the end

AddBoost:
sub r0, r2          @calculate the difference in the CON values
mov r2, #0x5C       @defense short
ldrh r1,[r4, r2]    @load the defense value
add r1, r0          @add the remaining CON to the value
strh r1, [r4, r2]   @store the final result

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD StoneBodyID
