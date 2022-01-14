.thumb
.align 4

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ	StartProc, 0x08002C7D
.equ CurrentUnit, 0x3004E50
.equ MemorySlot,0x30004B8
.equ EventEngine, 0x800D07C
.equ CurrentUnitFateData, 0x203A958 

	
.global HardenCommandUsability 
.type HardenCommandUsability, %function 

HardenCommandUsability:
push {lr} 

ldr r0, =CurrentUnit 
ldr r0, [r0] 
ldr r1, =Harden 
lsl r1, #24 
lsr r1, #24 
bl MoveTester 

cmp r0, #0
beq RetFalse @ Full hp, so cannot heal self 
cmp r0, #1 
beq RetTrue 
RetFalse: 
mov r0, #3 @ Menu false usability is 3 

RetTrue: 

pop {r1} 
bx r1 


.global HardenCommandEffect 
.type HardenCommandEffect, %function 

HardenCommandEffect:
push {lr} 

ldr r3, =CurrentUnit 
ldr r0, [r3] 
blh GetBuff 

ldr r2, [r0] 
@ldr r3, =0xF000 
ldr r3, =0x0F000000 
and r2, r3 

@ldr r1, =0xFEDCBA98 @ Empty Mag, Luck Res, Def Spd, Skl Str 
@ldr r1, =0x5000 @ 5 def 
ldr r1, =0x0E00000E @ 5 def 
mov r11, r11 
cmp r1, r2 
blo DoNothing @ New buff is less than current buff / bhs 
ldr r2, [r0] 
bic r2, r3 
orr r2, r1

str r2, [r0] @ store buffs back in 
DoNothing: 

blh StartRallyFx2





ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??




pop {r0} 
bx r0 


.ltorg 
.align 

.equ ProcFind, 0x8002E9D
.equ gProc_MoveUnit, 0x89A2C48

.type SelfBuff, %function 
.global SelfBuff 
SelfBuff:
	@ Arguments: r0 = function (void(*)(struct Unit*, void*))
	@ Returns:   nothing
push {r4, lr} 

ldr r0, =gProc_MoveUnit
blh ProcFind 
cmp r0, #0 
beq SkipHidingInProc
@mov r4, r0 @ gProc_MoveUnit 
add r0, #0x40 @this is what MU_Hide does @MU_Hide, 0x80797D5
mov r1, #1 
strb r1, [r0] @ store back 0 to show active MMS again aka @MU_Show, 0x80797DD

SkipHidingInProc: 
ldr r4, =CurrentUnit
ldr r4, [r4] 

ldr r1, [r4, #0x0C] @ Unit state 
mov r2, #1 @ Hide 
bic r1, r2 @ Show SMS 
str r1, [r4, #0x0C] 

blh  0x0801a1f8   @RefreshUnitMaps
blh  0x080271a0   @SMS_UpdateFromGameData
blh  0x08019c3c   @UpdateGameTilesGraphics

mov r0, r4 @ CurrentUnit 
blh AddMapAuraFxUnit

pop {r4}

pop {r1}
bx r1



BXR3:
	bx r3 
	
	
