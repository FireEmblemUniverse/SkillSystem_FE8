@BiorhythmTable as a csv that gets INLINEd, 2 byte entries; first byte is starting position in sequence and second byte is amplitude (# of states you advance per turn x4)

.thumb
.align 4
.equ Value1, BiorhythmTable+4
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

push {r4-r7,r14}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r5, r0 @attacker
mov r6, r1 @defender


@get unit ID in r0
ldr r0,[r0] @attacker location, already moved to a higher register but is still present here so can just also take it from here
ldrb r0,[r0,#4] @value in character data at + 4 (unit ID)
mov r1,#2 
mul r0,r1 @this is to properly index the table

@get biorhythm table data in r1 and r2
ldr r1,BiorhythmTable @each entry is 2 bytes long, first is starting phase and second is amplitude (more on below)
add r0,r1
ldrb r1,[r0] @loads starting phase (0-11)
ldrb r2,[r0,#1] @loads amplitude (# of phases to advance each turn *4)

@get current turn in r3
ldr r3,ChapterData
ldrh r3,[r3,#0x10] @r3 now has current turn count; counts from 1, not 0
sub r3,#1 @now it's # of turns that have passed, which is what we need for this calculation
mov r4,#4 @we need to multiply tuns passed by 4 to multiply with phases to advance *4 then divide it all by 4 so fractions will actually work

mul r2,r3 @r2 = # of phases each turn * # of turns passed
lsr r2,r2,#2 @divides by 4 which previously allowed for fractions for slower biorhythms 
add r1,r2 @add initial starting phase to above value

@r1 now contains the step # but it can be a number over 11 which will break things so we need to mod 11

mov r2,r1 @r2 isn't touched by the swi, so to maintain value in r1 we move it here
push {r0,r1,r3} @some of this is redundant but these are the 3 registers the swi returns values to
mov r0,r2 @numerator
mov r1,#11 @denominator
swi 0x6 @div
mov r4,r1 @returns remainder (the number we need) in r1, move it to r4 so when we pop we don't lose it
pop {r0,r1,r3} 
mov r0,r4 @move our biorhythm phase # into r0

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
BiorhythmTable:
@POIN BiorhythmTable
