.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ MemorySlot,0x30004B8
push {lr} @ function identical to $154F4 
ldr r1, =0x203A958 
mov r0, #9 @ autosave killer patch disables this, so that's why I copied it over here 
@enum {
@	SUSPEND_POINT_PLAYERIDLE = 0,
@	SUSPEND_POINT_DURINGACTION = 1,
@	SUSPEND_POINT_CPPHASE = 2,
@	SUSPEND_POINT_BSKPHASE = 3,
@	SUSPEND_POINT_DURINGARENA = 4,
@	SUSPEND_POINT_5 = 5,
@	SUSPEND_POINT_6 = 6,
@	SUSPEND_POINT_7 = 7,
@	SUSPEND_POINT_8 = 8,
@	SUSPEND_POINT_PHASECHANGE = 9
@};
strb r0, [r1, #0x16] @ ActionData@gActionData.suspendPointType
mov r0, #3 
blh 0x80A5A48 @SaveSuspendedGame
pop {r0}
bx r0

.ltorg
.align 


@ldr r3, =0x202BCB0 @ BattleMapState -> 
@ldr r2, =MemorySlot
@add r2, #4*0x0B 
@ldrh r0, [r2] @ XX 
@ldrh r1, [r2, #2] @ YY 
@strh r0, [r3, #0x14] @ gCursorMapPosition XX 
@strh r1, [r3, #0x16] @ gCursorMapPosition YY 
@ldr r3, =0x202BE48 
@strh r0, [r3] @ XX 
@strh r1, [r3, #2] @ YY 
