@GoddessDance Check
@true if unit has GoddessDance skill

.equ GoddessDanceID, SkillTester+4
.equ GetUnitsInRange, GoddessDanceID+4
.thumb
.org 0

push {r4-r7,lr}
ldr r0,=0x3004e50
ldr r4,[r0] @save active unit in r4
ldr r1,[r4,#0xc]
mov r0, #0x40 @has not moved...
and r0,r1
cmp r0,#0
bne False

@ check if active unit has GoddessDance
mov r0, r4 @test
ldr r1, GoddessDanceID
ldr r2, SkillTester
mov lr, r2
.short 0xf800 @test if unit has the skill
cmp r0, #0
beq False

@get list of all allied units in range
ldr r0, GetUnitsInRange
mov lr,r0
mov r0,r4
mov r1,#0x0          @check for same allegiance
mov r2,#0x1          @check if unit is in 1 tile of active unit (adjacent)
.short 0xf800        @return list of unit ids that meet this criteria in r0
cmp r0, #1           @check if GetUnitsInRange returned anything (1 is the active unit, so anything greater will mean allies)
ble False            @if not, branch to the end

True:
mov r0,#1
b End

False:
mov r0,#3

End:
pop {r4-r7}
pop {r1}
bx r1

.align
.ltorg
SkillTester:
@POIN AuraSkillCheck
@WORD GoddessDanceID