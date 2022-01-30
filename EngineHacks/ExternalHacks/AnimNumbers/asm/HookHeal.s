@ Hooked at 0x52A0C. Displays numbers for heals. Args:
@   r0: Recipient's AIS.
.thumb

push  {r4-r7, r14}
mov   r7, r0


@ Recipient's AIS.
mov   r1, #0x0
bl    BAN_DisplayDamage

@ Opposing AIS. Can heal due to LiveToServe.
mov   r0, r7
ldr   r3, =GetOpponentFrontAIS
bl    GOTO_R3
mov   r1, #0x1
bl    BAN_DisplayDamage


@ Vanilla. Overwritten by hook.
ldr   r1, =0x2017728      @ gBattleAnimeCounter
ldr   r0, [r1]
ldr   r3, =0x8052A15
GOTO_R3:
bx    r3
