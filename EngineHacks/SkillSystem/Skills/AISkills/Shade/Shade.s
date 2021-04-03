.thumb
.align

@hook into AiBattleGetSubjectHpWeight (the last AI weight function)
@this is the last function and is a negative modifier
@so we can do the same thing as provoke does pretty much for Shade Plus to get an almost-zero value

.equ SkillTester,EALiterals+0
.equ ShadeID,EALiterals+4
.equ gActiveBattleUnit,0x203A4EC
.equ gDefendingBattleUnit,0x203A56C
.equ gpAiBattleWeightFactorTable,0x30017D8

@push {r14}
@ldr r0,=gActiveBattleUnit
@hook here with r1 (AiBattleGetSubjectHpWeight + 4)

@r4 contains the total AI weight and this is the last function in the lineup
@if we set r4 and return 0 it will subtract 0 from the value we set it as given these skills
@so we don't need to hook after this function
@set r4 to 1 if Shade (if 0 it would use r5 instead)


ShadeCheck:
ldr r0,=gDefendingBattleUnit
ldr r1,SkillTester
mov r14,r1
ldr r1,ShadeID
.short 0xF800
cmp r0,#0
beq VanillaFunc

mov r4,#1
mov r1,#0
b GoBack

VanillaFunc:
ldr r0,=gActiveBattleUnit
mov r1,#0x13
ldsb r1,[r0,r1]
mov r0,#0x14
sub r1,r0,r1
ldr r0,=gpAiBattleWeightFactorTable
ldr r0,[r0]
ldrb r0,[r0,#7]
mul r1,r0
cmp r1,#0
bge GoBack
mov r1,#0
GoBack:
mov r0,r1
pop {r1}
bx r1

.ltorg
.align

EALiterals:
@POIN SkillTester
@WORD ShadeID
@WORD ShadePlusID
