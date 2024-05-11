.thumb
.equ SolarPowerID, SkillTester+4
.equ ChapterData, 0x202BCF0

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@check the weather
ldr  r0, =ChapterData   @load the chapter data
ldrb r1, [r0,#0x15]     @load the weather byte
cmp  r1,#5              @compare it to the fiery weather effect
bne  End                @if it isn't active, we can't apply the skill so we skip to the end 

@has SolarPower
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, SolarPowerID
.short 0xf800
cmp r0, #0
beq End   

@check weapon type of unit
mov r0,#0x50            @get the weapon type byte
ldrb r0,[r4,r0]         @load its value
cmp r0,#4               @compare to the start of the first magic item byte
bge ApplySolarPower     @if the weapon is magic, branch to apply the skill
b   End                 @otherwise we exit

@apply the skill
ApplySolarPower:
mov r0, #0x14           @get the attack byte
ldrb r0,[r4,r0]         @load its value
mov r1,#0x5A            @get the attack short
ldrh r1,[r4,r1]         @load its value
sub r3,r1,r0            @subtract them from each other to get the weapon strength
lsr r2, r0, #2          @shift right twice (so 25% of the original value)
add r0,r2               @add it to the attack we loaded
add r3,r0               @add this attack to the weapon strength for the final total               
mov r0,#0x5A            @get the attack short
strh r3,[r4,r0]         @now store this new value

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD SolarPowerID
