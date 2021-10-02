@ Hooks at 805904C with jumpToHack.
@ Animation skills.
@   r0: AIS
.thumb

push  {r4-r7}
mov   r7, r0


ldr   r3, =GetAISSubjectId
bl    GOTO_R3
mov   r5, r0
ldrh  r0, [r7, #0xE]
sub   r0, #0x1
lsl   r0, #0x1
add   r0, r5
ldr   r3, =GetBattleAnimRoundTypeFlags
bl    GOTO_R3
ldr   r1, =0x800
tst   r0, r1
bne   OffensiveSkill
  ldr   r1, =0x400
  tst   r0, r1
  bne   DefensiveSkill
    b     NoAnim

OffensiveSkill:
  ldr   r6, =0x806E310
  b     L1
DefensiveSkill:
  mov   r0, #0x1
  eor   r5, r0
  ldr   r6, =0x806E58C
L1:

@ Check if some flag (activating skill?) is set.
@ Seems to prevent unit proccing more than once
@ per battle, so I commented it out.
@ldrh  r1, [r7, #0x10]
@mov   r0, #0x20
@and   r0, r1
@cmp   r0, #0
@bne   NoAnim2
  @ Check if skillID is set to 0xFF.
  ldrh  r0, [r7, #0xE]          @ nth round of combat.
  sub   r0, #1
  lsl   r0, #3                  @ Multiply by 8.
  ldr   r1, =0x802AEC4          @ Pointer to the base rounds.
  ldr   r1, [r1]
  add   r0, r1                  @ The nth round.
  ldrb  r4, [r0, #4]            @ Skill number to show.
  cmp	  r4, #0xFF
  beq	  NoAnim

@ Set some flag (activating skill?).
ldrh  r1, [r7, #0x10]
mov   r0, #0x20
orr   r0, r1
strh  r0, [r7,#0x10]

@ Check if we're front AIS layer.
mov   r0, r7
ldr   r3, =GetAISLayerId
bl    GOTO_R3
cmp   r0, #0
bne   End

  @ Start SkillProcDisplay (prefix SPD) proc.
  ldr   r0, =gProc_ekrGauge
  ldr   r3, =ProcFind
  bl    GOTO_R3
  cmp   r0, #0x0
  beq   L2                      @ This proc should exist, so this shouldn't happen.
    mov   r1, r0
    ldr   r0, =SPD_main_Proc
    ldr   r3, =ProcStart
    bl    GOTO_R3
    mov   r1, #0x29
    strb  r4, [r0, r1]            @ +0x29, byte, is procced skill.
    mov   r1, #0x2A
    strb  r5, [r0, r1]            @ +0x2A, byte, true if left unit, false otherwise.
    ldrh  r2, [r7, #0xA]
    add   r2, #0x1
    strh  r2, [r0, #0x2C]         @ +0x2C, short, AIS depth.
  L2:
  
  @ Now we find the anim to show.
  lsl   r0, r4, #2
  ldr   r1, =SkillAnimationTable
  ldr   r3, [r1, r0]              @ Pointer to the skill animation to display.
  cmp   r3, #0
  bne   FoundAnim
    mov   r3, r6                  @ If 0, show the default animation.
  FoundAnim:
  add   r3, #1
  mov   r0, r7
  bl    GOTO_R3

End:
pop   {r4-r7}
ldr   r0, =0x8059141
bx    r0

NoAnim:
pop   {r4-r7}
ldr   r0, =0x80590D3
bx    r0

NoAnim2:
pop   {r4-r7}
ldr   r0, =0x8059675
bx    r0

GOTO_R3:
bx    r3
