@ Hooked at 0x553C0.
@ Start Damage/Heal numbers AISes.
@ r5: Recipient's AIS. Can be initiator if devil effect.
@ r7: Opposing AIS.
@ r10: Reserved.
@ r0-r4, r6, & r9 are free.
.thumb

push  {r14}

ldr   r0, =BATTLE_ANIMATION_NUMBERS_FLAG
lsl   r0, #0x5
lsr   r0, #0x5
ldr   r3, =CheckEventId
bl    GOTO_R3
cmp   r0, #0x0
bne   End

  @ Flag unset, display damage numbers.
  ldrh  r0, [r5, #0xE]
  sub   r0, #0x1
  ldr   r1, =0x802b90a      @ &BattleBufferWidth.
  ldrb  r1, [r1]
  mul   r0, r1
  ldr   r1, =0x802aec4      @ &Battle buffer.
  ldr   r1, [r1]
  add   r4, r0, r1          @ Current round in battle buffer.
  
  @ Recipient's AIS.
  mov   r0, r5
  ldr   r3, =GetAISSubjectId
  bl    GOTO_R3
  mov   r6, r0
  mov   r1, #0x6
  ldsh  r1, [r4, r1]
  bl    PutDigitsInVRAM
  cmp   r0, #0x0
  beq   Next
    mov   r3, r0
    mov   r2, r6
    sub   r1, r6, #0x1
    neg   r1, r1
    add   r1, r1, #0x5
    mov   r0, r5
    bl    StartAIS
  Next:

  @ Opposing AIS.
  mov   r0, r7
  ldr   r3, =GetAISSubjectId
  bl    GOTO_R3
  mov   r6, r0
  mov   r1, #0x5
  ldsb  r1, [r4, r1]
  bl    PutDigitsInVRAM
  cmp   r0, #0x0
  beq   End
    mov   r3, r0
    mov   r2, r6
    sub   r1, r6, #0x1
    neg   r1, r1
    add   r1, r1, #0x5
    mov   r0, r7
    bl    StartAIS

@ Vanilla. Overwritten by hook.
End:
mov   r0, r5
ldr   r3, =StartEfxHpBar
bl    GOTO_R3
mov   r0, r7
ldr   r3, =0x805A269
bl    GOTO_R3

pop   {r1}
bx    r1
GOTO_R3:
bx    r3
GOTO_R12:
bx    r12


@ Put participant's digits in OBJ VRAM. Args:
@   r0: AISSubjectId. 0 if left, 1 if right.
@   r1: Damage/Heal value.
@ Returns:
@   Number of digits.
PutDigitsInVRAM:
push  {r4-r7, r14}
mov   r4, r8
mov   r5, r9
push  {r4-r5}
mov   r4, r0
mov   r5, r1
mov   r6, #0x0


cmp   r5, #0x0
beq   Return
  ldr   r0, =BAN_DigitsPalette
  mov   r6, #0x0
  cmp   r5, #0x0
  bgt   Plus
    add   r0, #0x20
    mov   r6, #0x1
    neg   r5, r5
  Plus:
  
  @ Load palette.
  ldr   r1, =gPaletteBuffer+0x2A0
  sub   r2, r4, #0x1
  neg   r2, r2
  lsl   r2, #0x5
  add   r1, r2
  mov   r2, #0x8
  swi   #0xC                @ CpuFastSet
  ldr   r3, =EnablePaletteSync
  bl    GOTO_R3
  
  @ Put minus or plus in OBJ VRAM.
  ldr   r0, =0x85C8278      @ Bigger stat-ups digits.
  mov   r8, r0
  mov   r0, #0x1C
  add   r0, r6
  lsl   r0, #0x6
  add   r0, r8
  ldr   r1, =0x6012400
  lsl   r2, r4, #0x9
  add   r1, r2
  mov   r2, #0x8
  swi   #0xC                @ CpuFastSet.
  
  @ Find highest power of 10 denominator.
  mov   r6, #0x6
  ldr   r7, =Denom-2
  FindInitialDenom:
  sub   r6, #0x1
  add   r7, #0x2
  ldrh  r0, [r7]
  cmp   r0, #0x0
  beq   Return              @ This branch should never be taken.
    cmp   r5, r0
    blt   FindInitialDenom
  
  @ Put digits in OBJ VRAM.
  ldr   r0, =0x6012040
  lsl   r4, #0x9
  add   r4, r0
  Loop:
    ldrh  r1, [r7]
    cmp   r1, #0x0
    beq   Return
      mov   r0, r5
      swi   #0x6                @ Div.
      mov   r2, r0
      ldrh  r1, [r7]
      mul   r2, r1
      sub   r5, r2
        
      @ Put digit in OBJ VRAM.
      cmp   r0, #0x0
      bne   L1
        mov   r0, #0xF          @ Zero is a special case.
      L1:
      sub   r0, #0x1
      lsl   r0, #0x6
      add   r0, r8
      mov   r9, r0
      mov   r1, r4
      mov   r2, #0x10
      swi   #0xC                @ CpuFastSet.
      mov   r0, r9
      mov   r1, r4
      mov   r2, #0x40
      lsl   r2, #0x4
      add   r0, r2
      add   r1, r2
      mov   r2, #0x10
      swi   #0xC                @ CpuFastSet.
      
      @ Prepare next iteration.
      add   r4, #0x40
      add   r7, #0x2
      b     Loop


Return:
mov   r0, r6
pop   {r4-r5}
mov   r8, r4
mov   r9, r5
pop   {r4-r7}
pop   {r1}
bx    r1


Denom:
.short 10000
.short 1000
.short 100
.short 10
.short 1
.short 0


@ Starts an EkrsubAnimeEmulator which mimics an AIS.
@ Also starts an gProc_efxDamageMojiEffectOBJ to align
@ the EkrsubAnimeEmulator X value and end it when it finishes.
@ Args:
@   r0: AIS. Used for its X and Y values.
@   r1: palette index
@   r2: AISSubjectId. 0 if left, 1 if right.
@   r3: Number of digits. Determines which frameData to use.
@ Returns:
@   The EkrsubAnimeEmulator proc.
StartAIS:
push  {r4-r6, r14}
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

@ Prep other args.
mov   r3, #0x2            @ Idk this arg. Copying what 0x6C6D6 does here.
ldr   r0, =frameData-4
lsl   r1, r6, #0x2
ldr   r2, [r0, r1]        @ frameData, differs depending on number of digits.
mov   r0, #0x2
ldsh  r0, [r4, r0]        @ X.
@lsl   r1, r6, #0x3       @ Can centre X like this. But I decided to bake this
@add   r1, #0x4           @ into the frameData. If someone decides to use one
@sub   r0, r1             @ frameData for each digitcount, this block could be used.
ldr   r1, =StartEkrsubAnimeEmulator
mov   r12, r1
mov   r1, #0x4
ldsh  r1, [r4, r1]
sub   r1, #0x28           @ Y.
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
pop   {r4-r6}
pop   {r1}
bx    r1

.align
frameData:
.word BAN_Digits1FD
.word BAN_Digits2FD
.word BAN_Digits3FD
.word BAN_Digits4FD
.word BAN_Digits5FD
