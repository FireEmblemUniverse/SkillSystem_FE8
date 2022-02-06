@ Hooked at 0x552D0. 
@ Kills all other DamageMoji procs and their subAnimeEmulator procs.
@ Also delays NODAMGEMIS! symbols being put in VRAM if miss or no damage.
@   r4: 1 if miss. 0 if hit/nodmg. Anything else is ignored.
@   r5: AIS.
@   r6: Free.
@   r7: AIS.
@   r8: AIS.
@   r9: AIS.
@   r10: Some arg.
.thumb


@ Vanilla, overwritten by hook.
mov   r8, r0


@ Kill existing DamageMoji procs.
Loop:
  ldr   r0, =gProc_efxDamageMojiEffectOBJ
  ldr   r3, =ProcFind
  bl    GOTO_R3
  cmp   r0, #0x0
  beq   EndLoop
    @ Kill it, and the subAnimeEmulator proc.
    mov   r6, r0
    ldr   r0, [r6, #0x60]
    ldr   r3, =EndProc
    bl    GOTO_R3
    mov   r0, r6
    ldr   r3, =EndProc
    bl    GOTO_R3
    b     Loop
EndLoop:


@ Vanilla, overwritten by hook.
ldr   r3, =0x80552E5
cmp   r4, #0x0
beq   GOTO_R3
  ldr   r3, =0x80552DD
  cmp   r4, #0x1
  bne   GOTO_R3
    ldr   r3, =0x805540F
GOTO_R3:
bx    r3
