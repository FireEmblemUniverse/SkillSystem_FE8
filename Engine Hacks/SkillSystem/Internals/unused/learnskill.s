.thumb
@ 75cee is the 'weapon level increased text'
@ 10fec for anims off
@ 75d62 for promo (prep screen is the same, thank fuck)
@ 802c1cc compares the wranks of before and after combat
@ 807600e branches based on if the two are different???

@ 878d588 has a series of routines that are to be run. repoint and expand? ekrPopup2
@ 878d520 is the same for level up???

@ okay so 76250 checks word 0x44 of the 6c struct for the weapon type now learned
@ 762d0 checks word 0x48 for the second.
@ need to change these words to bytes and make them 0x44,45 etc.. i think.

@ so. on levelup, look up the active unit's class in a table.
@ the table is a pointer to a list of skills and levels - BYTE level1 skill1 level2 skill2 00 00
.equ SkillAdder, LevelUpSkillTable+4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@@need to hook from somewhere, write halfword to 0x4e
@jumptohack from 8076018
@now check if leveled up by comparing 0x9 to 0x70
@ldr r0, [r4] @r0 is the battle data

@This part is for the "Display Weapon Rank Gained" hack (Teq)
@it writes weapon exp to ram, next to where the weapon type would be

blh 	0x802C0B4
ldr		r1,=#0x30005F4
strb	r0,[r1,#0x2]
ldr		r0,[r4]			@put things back

  push {r4}
ldrb r1, [r0, #0x8] @current level
mov r4, r1 @save the current level, we'll need it
mov r2, #0x70
ldrb r2, [r0, r2] @previous level
cmp r1, r2
beq NoLevelUp
  @now check the table for the class to see if it learns anything this level
  @write skill to r5, 4e
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
      mov r0, #0x4e
      strb r4, [r5,r0]

  @and if so, write the skill number to byte 0x4e
NoLevelUp:
@original
  pop {r4}
ldr r0, [r4]
blh 0x802ce9c
lsl r0, #0x18
asr r0, #0x18
ldr r1, =0x8076021
bx r1
.ltorg
.align
LevelUpSkillTable:
@POIN LevelUpSkillTable
@POIN SkillAdder
