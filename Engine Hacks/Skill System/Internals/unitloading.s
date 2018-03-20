@ unit loading routine

@ 8017ef4 handles supports, this oughta be a good place to branch off imo

@ jumptohack at 8017ef4

.thumb
.equ ChargeupTable, SkillAdder+4
.equ SkillAdder, LevelUpSkillTable+4
.equ Skill_Getter, ChargeupTable+4
.set BWLTable, 0x203e884
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@r0 contains ram data
push {r4-r7, lr}
mov r5, r0

@let's uh clear out the existing skills first... just in case
ldr r4, [r5]
ldrb r4, [r4, #4] @char num in r4
cmp r4, #0x46
bhi NoSkills
ldr r0, =BWLTable
lsl r1, r4, #4 @r1 = char*0x10
add r0, r1
add r0, #1 @start at byte 1, not 0
mov r1, #0
strb r1, [r0]
strb r1, [r0, #1]
strb r1, [r0, #2]
strb r1, [r0, #3]

  ldrb r4, [r5, #8] @level
  ldr r1, [r5, #4] @class
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
    beq NoSkills
    cmp r0, #0xff @skills with level of 0xFF are only learned on loading. Use these for promoted units.
    beq FoundSkill
    cmp r0, r4
    ble FoundSkill @if the skill is lower/equal level
    add r6, #2
    b CheckLoop

    FoundSkill:
    ldr r0, SkillAdder
    mov lr, r0
    ldrb r1, [r6, #1] @skill number
	
	
	@ push {r2}
	@ ldr r0,ChargeupTable
	@ Loop:
	@ ldrb r2,[r0]
	@ add r0,#2
	@ cmp r2,#0
	@ beq Next
	@ cmp r2,r1
	@ bne Loop
	@ sub r0,#0x1
	@ ldrb r0,[r0]
	@ add r0,#0x10
	@ mov r2,#0x47
	@ strb r0,[r5,r2]
	
	@ Next:
	@ pop {r2}
    mov r0, r5
    .short 0xf800 @try to add the skill
    add r6, #2
    b CheckLoop @keep checking

NoSkills:
@do the personal and class skills now
AddCharge:
push {r4}
mov r0, r5 @char data
ldr r2, Skill_Getter
mov lr, r2
.short 0xf800
mov r4, r0 @skill buffer
Main_loop:@loop through skills checking if they're chargeable
ldrb r1, [r4]
cmp r1, #0
beq End_main
  ldr r0,ChargeupTable
  Loop:
  ldrb r2,[r0]
  add r0,#2
  cmp r2,#0
  beq Next
  cmp r2,r1
  bne Loop
  sub r0,#0x1
  ldrb r0,[r0]
  add r0,#0x10
  mov r2,#0x47
  strb r0,[r5,r2]
  Next:
  add r4, #1
  b Main_loop
End_main:
@avoid skill forgetting issues after loading units that learn more than 4 skills
mov	r0,#0
ldr	r4,=#0x202BCDE
strh	r0,[r4]
pop {r4}

@original
mov r0, r5
blh 0x80281c8
ldr r6, =0x8017efd
bx r6

.ltorg
LevelUpSkillTable:
@POIN LevelUpSkillTable
@POIN SkillAdder
@POIN ChargeupTable
@POIN Skill_Getter
