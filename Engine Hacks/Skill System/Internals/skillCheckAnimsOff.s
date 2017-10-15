.thumb

.equ SkillAdder, LevelUpSkillTable+4
.equ PopupStruct, SkillAdder+4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

push {r4-r6,lr}
mov r6, r0
@ mov r4, #0
@ ldr r5, =0x202a4ec
@ mov r0, r5
@ blh 0x807a770 @ what is this??? check if player unit? yep
@ lsl r0, #0x18
@ cmp r0, #0
@ beq label1
@ mov r4, r5
@ label1:
@ ldr r5, =0x202a56c
@ mov r0, r5
@ blh 0x807a770 @again
@ lsl r0, #0x18
@ cmp r0, #0
@ beq label2
@ mov r4, r5
@ label2:
@ cmp r4, #0
@ beq NoLearn
ldr r4, =0x203e18c
ldr r0, [r4]
@ mov r0, r4 @check for level up now
push {r4}
ldrb r1, [r0, #0x8] @current level
mov r4, r1 @save the current level, we'll need it
mov r2, #0x70
ldrb r2, [r0, r2] @previous level
cmp r1, r2
beq NoLevelUp
  @now check the table for the class to see if it learns anything this level
  ldr r1, [r0, #4] @class
  ldrb r1, [r1, #4] @class number
  ldr r2, LevelUpSkillTable
  lsl r1, #2
  add r1, r2
  ldr r1, [r1] @pointer to list of skills
  cmp r1, #0
  beq NoLevelUp
    @if we got here, check the table for learned skills
    CheckLoop:
    ldrb r0, [r1]
    cmp r0, #0
    beq NoLevelUp
    cmp r0, r4
    beq FoundSkill
    add r1, #2
    b CheckLoop

    FoundSkill:
    ldr r0, SkillAdder
    mov lr, r0
    ldrb r1, [r1, #1] @skill number
    mov r4, r1 @save the skill number
    pop {r0}
    push {r0}
    ldr r0, [r0] @char data
    .short 0xf800 @try to add the skill
    cmp r0, #0 @did it add?
    beq NoLevelUp
      @and if so, draw the skill popup
      mov r0, r4
      mov r1, r6
      bl DrawPopup

NoLevelUp:
pop {r4}

NoLearn:
pop {r4-r6}
pop {r0}
bx r0
.ltorg

DrawPopup:
@originally 80116e0
push {r4,lr}
mov r4, r1
blh 0x801145c @ set popup item
@ ldr r0, =0x8592420 @ for weapon broke
@ ldr r0, =0x8592468 @ for weapon level up
ldr r0, PopupStruct
mov r1, #0x60
mov r2, #0
mov r3, r4
blh 0x8011474, r4
pop {r4, r15}

@ wlvl up (8592468)
@ 0C 00 00 00 5A 00 00 00 
@ 06 00 00 00 01 00 00 00 
@ 0A 00 00 00 00 00 00 00 
@ 06 00 00 00 02 00 00 00 
@ 00 00 00 00 00 00 00 00

@ "Got [icon]"
@ 0C 00 00 00 5A 00 00 00 
@ 06 00 00 00 08 00 00 00 (text id)
@ 0A 00 00 00 00 00 00 00 (routine)
@ 06 00 00 00 01 00 00 00 (icon)
@ 00 00 00 00 00 00 00 00

@routine 0a is weapon type, 09 is weapon icon
@checked at 801105a, table at 8010f5c (pointer at 8010f58)
@10f48 has max index of table, increase this to add new ones

@ weapon broke (8592420)
@ 0C 00 00 00 5C 00 00 00 
@ 08 00 00 00 02 00 00 00 
@ 03 00 00 00 00 00 00 00 
@ 01 00 00 00 01 00 00 00 
@ 09 00 00 00 00 00 00 00 
@ 01 00 00 00 01 00 00 00 
@ 08 00 00 00 00 00 00 00 
@ 06 00 00 00 03 00 00 00 
@ 00 00 00 00 00 00 00 00

.ltorg
LevelUpSkillTable:
@POIN LevelUpSkillTable
@POIN SkillAdder
@POIN PopupStruct
