.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global SelectTileHook
.type SelectTileHook, %function 

SelectTileHook:

push {r4-r5, lr}
mov r4, r0 
mov r5, r1 

mov r0, r6 @ parent proc?
bl SelectTileCalcLoop @ Returns T/F whether taking over or not 
cmp r0, #0 
bne SkipUnitMenu 

mov r0, r4 
mov r1, r5 
movs r2, #1
movs r3, #0x17
blh 0x0804EB98, r4   //NewMenu_DefaultAdjusted 
blh 0x80832CC @ bl to bx lr 

SkipUnitMenu:

pop {r4-r5}
pop {r3}
bx r3

.ltorg 
.align 

.type SelectTileCalcLoop, %function 

SelectTileCalcLoop:
push {r4-r7, lr}



blh CallCharacterSelector
@blh SkillDebugCommand_OnSelect



mov r0, #1 @ Taking over 

pop {r4-r7}
pop {r1} 
bx r1


.align 



