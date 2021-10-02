@ Display procced skill icon during map battle.
@ Hooked at 0x7A89C.
@   r0: BattleBuffer for current round.
@   r4: Instance of gProc_MapAnimBattle (0x89A3508)
@   r5: gMapAnimData (0x203E1F0). We don't use this.
.thumb

push  {r5-r7}


@ Check if we have another round.
ldr   r5, [r0]
ldr   r2, =0x800000         @ Terminator flag.
tst   r2, r5
bne   NoRounds
  @ Check if either offensive or defensive skill was triggered.
  ldr   r1, =0xC000
  tst   r1, r5
  beq   Return
    @ Check if skill is valid.
    ldrb  r6, [r0, #0x4]
    cmp   r6, #0xFF
    beq   Return
      @ Check if mapbattlebox exists.
      ldr   r0, =gProc_MapAnimBattleInfoBox
      ldr   r3, =ProcFind
      bl    GOTO_R3
      cmp   r0, #0x0
      beq   Return
      
  
@ Start map battle SkillProcDisplay (prefix SPD) proc.
mov   r7, r0
ldr   r0, =SPD_Map_main_Proc
mov   r1, r4
ldr   r3, =ProcStart
bl    GOTO_R3

mov   r1, #0x29
strb  r6, [r0, r1]      @ +0x29: u8 skill.

@ Determine if right or left triggered skill.
mov   r3, #0x1
lsr   r1, r5, #0xF
and   r1, r3            @ 0: Offensive skill. 1: Defensive skill.
lsr   r2, r5, #0x16
and   r2, r3            @ 0: Initiator/right is attacking. 1: Defender/left is attacking.
eor   r2, r1
mov   r1, #0x2A
strb  r2, [r0, r1]      @ +0x2A: u8 left.

mov   r1, #0x2E
ldrb  r2, [r7, r1]
mov   r1, #0x2C
strb  r2, [r0, r1]      @ +0x2C: u8 x.

mov   r1, #0x2F
ldrb  r2, [r7, r1]
mov   r1, #0x2D
strb  r2, [r0, r1]      @ +0x2D: u8 y.


Return:
pop   {r5-r7}
ldr   r0, =0x807A8C5        @ Regular return address.
bx    r0

NoRounds:
pop   {r5-r7}
ldr   r0, =0x807A8AB        @ Return address when no more rounds.
bx    r0
GOTO_R3:
bx    r3
