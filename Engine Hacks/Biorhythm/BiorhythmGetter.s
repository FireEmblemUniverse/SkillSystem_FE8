.thumb
.align 4
.equ Value1, BiorhythmTable+4

push {r4-r7,r14}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r5, r0 @attacker


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
mov r1,#12 @denominator
swi 0x6 @div
mov r4,r1 @returns remainder (the number we need) in r1, move it to r4 so when we pop we don't lose it
pop {r0,r1,r3} 
mov r0,r4 @move our biorhythm phase # into r0

@r0 now contains current phase of biorhythm

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
