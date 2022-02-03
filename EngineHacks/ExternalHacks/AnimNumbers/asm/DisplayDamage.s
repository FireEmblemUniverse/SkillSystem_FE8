@ Start Damage/Heal numbers animations. Args:
@   r0: AIS.
@   r1: 0 if OverDamage or OverHeal (recipient). 1 otherwise.
@   r2: X of previous damage display. 0 if there is none.
@   r3: Digitcount of previous damage display. 0 if there is none.
@ Return:
@   Digitcount of new damage display.
.thumb

push  {r4-r7, r14}
sub   sp, #0x8
mov   r4, r0
mov   r5, r1
str   r2, [sp]
str   r3, [sp, #0x4]


ldr   r0, =BATTLE_ANIMATION_NUMBERS_FLAG
lsl   r0, #0x5
lsr   r0, #0x5
ldr   r3, =CheckEventId
bl    GOTO_R3
cmp   r0, #0x0
bne   End

  @ Flag unset, display damage numbers.
  @ Recipient's AIS might still be finishing up their round,
  @ so we grab the highest round.
  mov   r0, r4
  ldr   r3, =GetOpponentFrontAIS
  bl    GOTO_R3
  ldrh  r0, [r0, #0xE]
  ldrh  r1, [r4, #0xE]
  cmp   r0, r1
  bge   Max
    mov   r0, r1
  Max:
  
  sub   r0, #0x1
  ldr   r1, =0x802b90a      @ &BattleBufferWidth.
  ldrb  r1, [r1]
  mul   r0, r1
  ldr   r1, =0x802aec4      @ &Battle buffer.
  ldr   r1, [r1]
  add   r6, r0, r1          @ Current round in battle buffer.
  cmp   r5, #0x0
  bne   CapDmgHeal
    mov   r7, #0x6
    ldsh  r7, [r6, r7]      @ OverDamage/OverHeal.
    b     IfThenElse
  CapDmgHeal:
    mov   r7, #0x5
    ldsb  r7, [r6, r7]      @ Capped damage/heal.
  IfThenElse:
  cmp   r7, #0x0
  beq   End
  
    @ Start proc which will put digits in VRAM.
    ldr   r0, =BAN_Proc_DelayDigits
    mov   r1, #0x3
    ldr   r3, =ProcStart
    bl    GOTO_R3
    strh  r7, [r0, #0x2A]   @ Damage/heal.
    mov   r7, r0
    mov   r0, #0x2A
    ldsh  r0, [r7, r0]
    cmp   r0, #0x0
    bge   Abs
      neg   r0, r0          @ Take absolute value of damage/heal.
    Abs:
    mov   r6, #0x1
    FindDigitCountLoop:
      mov   r1, #0xA
      swi   #0x6
      cmp   r0, #0x0
      beq   EndLoop
        add   r6, #0x1
        b     FindDigitCountLoop
    EndLoop:
    mov   r0, #0x29
    strb  r6, [r7, r0]      @ Number of digits.
    mov   r0, r4
    ldr   r3, =GetAISSubjectId
    bl    GOTO_R3
    mov   r1, #0x2C
    strb  r0, [r7, r1]      @ AISSubjectId. 0 if left, 1 if right.

    @ Start AIS.
    mov   r3, r6
    mov   r2, r0
    sub   r1, r0, #0x1
    neg   r1, r1
    add   r1, r1, #0x5
    mov   r0, r4
    bl    StartAIS
    mov   r0, r5


End:
add   sp, #0x8
pop   {r4-r7}
pop   {r1}
bx    r1
GOTO_R3:
bx    r3
GOTO_R12:
bx    r12


@ Starts an EkrsubAnimeEmulator which mimics an AIS.
@ Also starts an gProc_efxDamageMojiEffectOBJ to align
@ the EkrsubAnimeEmulator X value and end it when it finishes.
@ Args:
@   r0:     AIS. Used for its X and Y values.
@   r1:     palette index
@   r2:     AISSubjectId. 0 if left, 1 if right.
@   r3:     Number of digits. Determines which frameData to use.
@   [sp]:   X of previous damage display. 0 if there is none.
@   [sp+4]: Digitcount of previous damage display. 0 if there is none.
@ Returns:
@   The EkrsubAnimeEmulator proc.
StartAIS:
push  {r4-r7, r14}
mov   r4, r0
mov   r5, r1
mov   r6, r3
sub   sp, #0xC


@ Prep stack args.
mov   r0, #0x3
strb  r0, [sp, #0x8]      @ Parent proc (tree 3).
mov   r0, #0x0
strb  r0, [sp, #0x4]      @ OAM0 cat OAM1.
lsl   r0, r5, #0x4
add   r0, #0x1
lsl   r0, #0x8
lsl   r2, #0x4
add   r0, r2
strb  r0, [sp]            @ OAM2.


@ Check if digits overlap.
@ If they do, raise current AIS' digits.
mov   r7, #0x28           @ Y if no overlap.
ldr   r2, [sp, #0x24]     @ Digitcount0.
cmp   r2, #0x0
beq   NoOverlap
  mov   r1, #0x2
  ldsh  r1, [r4, r1]      @ X0.
  ldr   r0, [sp, #0x20]   @ X1.
  @mov   r3, r6           @ Digitcount1.
  cmp   r0, r1
  ble   NoFlip
    mov   r7, r0          @ Ensure X0 <= X1.
    mov   r0, r1 
    mov   r1, r7
    mov   r7, r2
    mov   r2, r3
    mov   r3, r7
    mov   r7, #0x28       @ Y if no overlap.
  NoFlip:
  lsl   r2, #0x3          @ Half of length of digits (16 pixels each).
  add   r2, #0x4          @ Half of length of plus or minus (8 pixels).
  add   r2, r0            @ Right-most pixel of left number.
  lsl   r3, #0x3          @ Half of length of digits (16 pixels each).
  add   r3, #0x4          @ Half of length of plus or minus (8 pixels).
  sub   r3, r1, r3        @ Left-most pixel of right number.
  sub   r0, r3, r2
  cmp   r0, #0x0
  bge   Abs2
    neg   r0, r0          @ Take absolute value of distance.
  Abs2:
  cmp   r0, #0x8
  bgt   NoOverlap
    mov   r7, #0x38       @ Heighten digits to avoid overlap.
NoOverlap:


@ Prep other args.
mov   r3, #0x2            @ Idk this arg. Copying what 0x6C6D6 does here.
ldr   r0, =frameData-4
lsl   r1, r6, #0x2
ldr   r2, [r0, r1]        @ frameData, differs depending on number of digits.
mov   r0, #0x2
ldsh  r0, [r4, r0]        @ X.
@lsl   r1, r6, #0x3       @ Can centre X like this. But I decided to bake this
@add   r1, #0x4           @ into the frameData. If someone decides to use one
@sub   r0, r1             @ frameData for each digitcount, this code could be used.
ldr   r1, =StartEkrsubAnimeEmulator
mov   r12, r1
mov   r1, #0x4
ldsh  r1, [r4, r1]
sub   r1, r7              @ Y.
bl    GOTO_R12
mov   r5, r0

@ Start gProc_efxDamageMojiEffectOBJ
ldr   r0, =gProc_efxDamageMojiEffectOBJ
mov   r1, #0x3
ldr   r3, =ProcStart
bl    GOTO_R3
mov   r6, r0
str   r4, [r6, #0x5C]     @ AIS.
mov   r0, #0x0
strh  r0, [r6, #0x2C]     @ Timer.
mov   r0, #0x32
strh  r0, [r6, #0x2E]     @ Endtime, 50 frames.
str   r5, [r6, #0x60]     @ EkrsubAnimeEmulator proc.


mov   r0, r5
add   sp, #0xC
pop   {r4-r7}
pop   {r1}
bx    r1

.align
frameData:
.word BAN_Digits1FD
.word BAN_Digits2FD
.word BAN_Digits3FD
.word BAN_Digits4FD
.word BAN_Digits5FD
