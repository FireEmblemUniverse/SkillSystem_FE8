@gets a list of all units within range
@applies the rally to all those units

.thumb
.equ UnitsBuffer, 0x202b256
.equ ExtraDataLocation, 0x203f100
.equ CurrentUnitFateData, 0x203a958
.equ MaxRange, 2
.equ SkillTester, RallySkillList+4
.equ AuraSkillCheck, SkillTester+4

push {r4-r7,lr}

ldr r0, =0x3004e50
ldr r0, [r0]
mov r4, r0

@first, figure out how many rally skills to do
ldr r5, RallySkillList
mov r6, #0
mov r7, #0
RallyLoopStart:
mov r0, r4 @active unit
ldrb r1, [r5,r6] @get the nth rally skill
ldr r2, SkillTester
mov lr, r2
.short 0xf800
cmp r0, #0
beq NextRallyLoop
  @if they have the rally skill, add it to r7
  mov r0, #1
  lsl r0, r6 @the nth bit
  orr r7, r0
NextRallyLoop:
add r6, #1
cmp r6, #8
blt RallyLoopStart
@once we get here, r7 contains the bitfield to orr.

@next, get all units within range.
mov r1, #0 @always true
mov r2, #0 @are on the same side
mov r3, #MaxRange
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @r0 is unit
.short 0xf800
cmp r0, #0
beq End @should never happen but hey just in case

ldr r5, =ExtraDataLocation @location of debuff/rally data
ldr r6, =UnitsBuffer @start of the buffer
UnitLoopStart:
ldrb r0, [r6] @deployment number of the unit
cmp r0, #0
beq PlaySound
@otherwise, taking r0, set the debuff.
lsl r0, #3 @8 bytes per entry
add r0, r5
ldrb r1, [r0, #3]
orr r1, r7
strb r1, [r0, #3]
@done
add r6, #1
b UnitLoopStart

@now play a sound? set the action? idk

PlaySound:
ldr r0, MuteCheck
ldrb r0,[r0]
lsl r0,r0,#0x1e
cmp r0,#0
blt End
mov r0, #136       @sound ID (some kind of staff sound?)
ldr r3, SoundRoutine    @play sound routine
mov lr, r3
.short 0xf800

End:

ldr r1, =CurrentUnitFateData @these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17 @makes the unit wait?? makes the menu disappear after command is selected??


pop {r4-r7}
pop {r1}
bx r1

.ltorg

SoundRoutine:
.long 0x080d01fc+1

MuteCheck:
.long 0x0202bd31

RallySkillList:
@POIN RallySkillList
@POIN SkillTester
@POIN AuraSkillCheck

@the order of RallySkillList is the same as in the debuffs:
@str skl spd def res luck move spectrum
