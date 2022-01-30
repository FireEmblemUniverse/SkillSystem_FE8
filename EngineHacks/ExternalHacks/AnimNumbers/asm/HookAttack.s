@ Hooked at 0x52304. Displays numbers for most attacks. Args:
@   r0: Recipient's AIS. Can be initiator if devil effect.
.thumb

push  {r4-r6, r14}
mov   r4, r0


@ Recipient's AIS.
mov   r1, #0x0
bl    BAN_DisplayDamage

@ Opposing AIS. Can heal or take damage due to
@ Sol/Aether or Counter/Countermagic respectively.
mov   r0, r4
ldr   r3, =GetOpponentFrontAIS
bl    GOTO_R3
mov   r1, #0x1
bl    BAN_DisplayDamage


@ Vanilla. Overwritten by hook.
mov   r0, r4
ldr   r3, =GetAISSubjectId
bl    GOTO_R3
ldr   r3, =0x805230D
GOTO_R3:
bx    r3
