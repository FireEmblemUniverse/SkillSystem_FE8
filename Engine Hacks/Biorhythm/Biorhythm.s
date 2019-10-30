@BiorhythmTable as a csv that gets INLINEd, 2 byte entries; first byte is starting position in sequence and second byte is amplitude (# of states you advance per turn x4)

.thumb
.align 4
.equ Value1, BiorhythmGetter+4
.equ Value2, Value1+4
.equ Value3, Value2+4
.equ Value4, Value3+4
.equ Value5, Value4+4
.equ Value6, Value5+4
.equ Value7, Value6+4
.equ Value8, Value7+4
.equ Value9, Value8+4
.equ Value10, Value9+4
.equ Value11, Value10+4
.equ Value12, Value11+4
.equ TempestID, Value12+4
.equ SerenityID, TempestID+4
.equ SkillTester, SerenityID+4

push {r4-r7,r14}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r5, r0 @attacker
mov r6, r1 @defender

ldr r1,BiorhythmGetter
mov lr,r1
.short 0xF800

@r0 now contains current phase of biorhythm

@gratuitous checks and branches for each phase below, then two functions taken from aura skills to either raise or lower hit and avoid by the amount defined in the "Value"s (EA defines)

Check0:
cmp r0,#0
bne Check1
ldr r0,Value1
b NegativeEffect

Check1:
cmp r0,#1
bne Check2
ldr r0,Value2
b NegativeEffect

Check2:
cmp r0,#2
bne Check3
ldr r0,Value3
b NegativeEffect

Check3:
cmp r0,#3
bne Check4
b GoBack

Check4:
cmp r0,#4
bne Check5
ldr r0,Value5
b PositiveEffect

Check5:
cmp r0,#5
bne Check6
ldr r0,Value6
b PositiveEffect

Check6:
cmp r0,#6
bne Check7
ldr r0,Value7
b PositiveEffect

Check7:
cmp r0,#7
bne Check8
ldr r0,Value8
b PositiveEffect

Check8:
cmp r0,#8
bne Check9
ldr r0,Value9
b PositiveEffect

Check9:
cmp r0,#9
bne Check10
b GoBack

Check10:
cmp r0,#10
bne Check11
ldr r0,Value11
b NegativeEffect

Check11:
cmp r0,#11
bne GoBack
ldr r0,Value12
b NegativeEffect



NegativeEffect:
push {r0}

ldr		r1,SerenityID
mov 	r0,r5
ldr 	r3, SkillTester
mov		r14,r3
.short	0xF800
cmp r0,#0
beq NegTempestCheck
pop {r0}
lsr r0,#1
b ApplyNegativeEffect

NegTempestCheck:
ldr		r1,TempestID
mov 	r0,r5
ldr 	r3, SkillTester
mov		r14,r3
.short	0xF800
cmp r0,#0
beq NegNoSkills
pop {r0}
lsl r0,#1
b ApplyNegativeEffect

NegNoSkills:
pop {r0}

ApplyNegativeEffect:

mov r2, r5
add     r2,#0x60    @Move to the attacker's hit.
ldrh    r3,[r2]     @Load the attacker's hit into r3.
sub     r3,r0    	@subtract r0 hit.
strh    r3,[r2]     @Store.

add 	r2,#2 		@attacker's avoid
ldrh    r3,[r2]     @Load the attacker's avoid into r3.
sub     r3,r0    	@subtract r0 avoid.
strh    r3,[r2]     @Store.
b GoBack


PositiveEffect:
push {r0}

ldr		r1,SerenityID
mov 	r0,r5
ldr 	r3, SkillTester
mov		r14,r3
.short	0xF800
cmp r0,#0
beq PosTempestCheck
pop {r0}
lsr r0,#1
b ApplyPositiveEffect

PosTempestCheck:
ldr		r1,TempestID
mov 	r0,r5
ldr 	r3, SkillTester
mov		r14,r3
.short	0xF800
cmp r0,#0
beq PosNoSkills
pop {r0}
lsl r0,#1
b ApplyPositiveEffect

PosNoSkills:
pop {r0}

ApplyPositiveEffect:
mov r2, r5
add     r2,#0x60    @Move to the attacker's hit.
ldrh    r3,[r2]     @Load the attacker's hit into r3.
add     r3,r0    	@add r0 hit.
strh    r3,[r2]     @Store.

add 	r2,#2 		@attacker's avoid
ldrh    r3,[r2]     @Load the attacker's avoid into r3.
add     r3,r0    	@add r0 avoid.
strh    r3,[r2]     @Store.


GoBack:
pop {r4-r7}
pop {r1}
bx r1


.ltorg
.align 4

ActiveUnitPointer:
.word 0x3004E50
ChapterData:
.word 0x202BCF0
BiorhythmGetter:
@POIN BiorhythmGetter
