@SkillTester - given ram data in r0 and skill number in r1, returns 1 for true or 0 for false
.thumb

.set SkillsBuffer, 0x202a6ac
.set ClassSkillTable, PersonalSkillTable+4
.set LevelUpSkillTable, ClassSkillTable+4
.set BWLTable, 0x203e884

push {r4-r7,lr}
mov r4, r0 @save char
mov r5, r1 @save skill to test

@personal skill first, if any
ldr r0, [r4]
ldrb r6, [r0, #4] @char number saved in r6 for later
ldr r1, PersonalSkillTable
ldrb r2, [r1, r6] @skill byte
cmp r2, r5
beq True

@class skill, if any
ldr r0, [r4,#4]
ldrb r0, [r0,#4] @class number
ldr r1, ClassSkillTable
ldrb r2, [r1, r0] @skll byte
cmp r2, r5
beq True

@learned skills, up to 4
cmp r6, #0x4F
bhi GenericUnit
ldr r0, =BWLTable
lsl r1, r6, #4 @r1 = char*0x10
add r0, r1
add r0, #1 @start at byte 1, not 0
mov r2, #0
LoopStart:
ldrb r1, [r0,r2] @get nth skill
cmp r1, #0
beq NextLoop
cmp r1, r5
beq True
cmp r2, #3
bge False
NextLoop:
add r2, #1
b LoopStart

GenericUnit: @grab the skills based on level i suppose
mov r0, r4
ldrb r7, [r0, #8] @level
ldr r1, [r0, #4] @class
ldrb r1, [r1, #4] @class number
ldr r2, LevelUpSkillTable
lsl r1, #2
add r1, r2
ldr r6, [r1] @pointer to list of skills
cmp r6, #0
beq NoSkills
CheckLoop:
  ldrb r0, [r6]
  cmp r0, #0
  beq False
  cmp r0, r7
  ble FoundSkill @if the skill is lower/equal level
  add r6, #2
  b CheckLoop
  FoundSkill:
  ldrb r1, [r6, #1]
  cmp r1, r5 @is it the same skill?
  beq True
  add r6, #2
  b CheckLoop

True:
mov r0, #1
b End

False:
mov r0, #0
End:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
PersonalSkillTable:
@POIN PersonalSkillTable
@POIN ClassSkillTable
@POIN LevelUpSkillTable
