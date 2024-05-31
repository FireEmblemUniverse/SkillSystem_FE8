.thumb
.equ SkillGetter, SkillDescTable+4
.equ SS_SkillsDefaultRText, SkillGetter+4
@given a skill number in r0, get the corresponding text ID
mov r1, #1
b Routine_Start
mov r1, #2
b Routine_Start
mov r1, #3
b Routine_Start
mov r1, #4
b Routine_Start
mov r1, #5
b Routine_Start
mov r1, #6
b Routine_Start

Routine_Start:
push {r4-r5,lr}
mov r4, r0 @6c struct
mov r5, r1 @nth skill
ldr r0, =0x2003bfc @current viewed unit
ldr r0, [r0, #0xc]
ldr r1, SkillGetter
mov lr, r1
.short 0xf800
cmp r1, r5
blt NoText
sub r5, #1
ldrb r0,[r0,r5] @nth skill

ldr r1, SkillDescTable
lsl r0, #1
add r0, r1
ldrh r0, [r0]
cmp r0, #0
bne GotText
ldr r0, SS_SkillsDefaultRText
GotText:
@got the text id, write it
mov r1,r4
add r1, #0x4c
strh r0, [r1]
NoText:
pop {r4-r5}
pop {r0}
bx r0

.ltorg
SkillDescTable:
@POIN SkillDescTable
@POIN SkillGetter
@WORD SS_SkillsDefaultRText
