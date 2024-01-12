.thumb
.align
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ CurrentUnit, 0x3004E50 

.global AoE_AreAnyUsable
.type AoE_AreAnyUsable, %function

AoE_AreAnyUsable:
push {r4,r14}

bl IsPeacefulNoTrainers
cmp r0, #1
beq RetFalse

bl Pokemblem_Usability_Ram
cmp r0, #0 
beq RetFalse 


End: 
ldr r0, =CurrentUnit
ldr r0, [r0] 
ldr r0, [r0, #0xC] @ state 
mov r1, #0x40 @ canto 
tst r0, r1 
bne RetFalse 


@loop through all menu command usabilities looking for one that returns true
ldr r4,=AoEMenuCommandsList
add r4,#0xC @usability of first menu option

LoopStart:
ldr r3,[r4]
cmp r3,#0
beq RetFalse

mov r0, r4
sub r0, #0xC @r0=this menu struct
mov r14,r3
.short 0xF800

cmp r0,#1
beq GoBack

add r4,#36
b LoopStart

RetFalse:
mov r0,#3

GoBack:
pop {r4}
pop {r1}
bx r1

.ltorg
.align



.equ StartMenuAdjusted,0x804EB98	@{U}
@.equ StartMenuAdjusted,0x804F924	@{J}
.global AoE_Effect
.type AoE_Effect, %function

AoE_Effect:
push {r14}

@StartMenuAdjusted takes menu definition offset in r0
ldr r0, =0x0804F64C @NewMenu_AndDoSomethingCommands	{U}
@ldr r0,=StartMenuAdjusted
mov r14,r0
ldr r0,=AoESubmenuDef
ldr r2, =0x0202BCB0 @(BattleMapState@gGameState.boolMainLoopEnded )	{U}
mov r3, #0x1c
ldsh r1, [r2, r3] @(BattleMapState@gGameState._unk1C )
mov r3, #0xc
ldsh r2, [r2, r3] @(BattleMapState@gGameState.cameraRealPos )
sub r1 ,r1, r2

ldr r2, =0x801d4fa 
ldrb r2, [r2] @ UnitMenuLeftCoord 
ldr r3, =0x801d4fc
ldrb r3, [r3] @ UnitMenuRightCoord
.short 0xF800

mov r0,#0xB7		@play beep sound & end menu on next frame & clear menu graphics
pop {r1}
bx r1

.ltorg
.align


