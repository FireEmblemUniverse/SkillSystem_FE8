.thumb 

.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ MemorySlot,0x30004B8
.equ IncreaseUnitStatsByLevelCount, 0x8017FC4
.equ GetUnitStructFromEventParameter, 0x800bc50
.equ EnsureNoUnitStatCapOverflow, 0x80181c8
.equ InitBattleUnitFromUnit, 0x0802a584  
.equ CheckForLevelUp, 0x802ba28 

@ s8 CanBattleUnitGainLevels(struct BattleUnit* bu) {


.type ASMC_ApplyBonusLevels, %function 
.global ASMC_ApplyBonusLevels
@ Given r0 unit, r1 levels recompute stats 
@ r1 can be negative 
ASMC_ApplyBonusLevels:
push {r4-r7, lr}

ldr r5, =MemorySlot
ldr r0, [r5, #4] @ s1 as unit id 
blh GetUnitStructFromEventParameter
cmp r0, #0 
beq Exit
mov r4, r0

ldr r1, [r4, #4]
ldrb r1, [r1, #4] @ class id 

ldr r2, [r5, #4*0x03] @ Slot 3 as number of levels 
blh IncreaseUnitStatsByLevelCount @ // str/mag split compatible

ldr r0, [r5, #4*0x04] @ Slot 4 as bool should levels be visible or not 
cmp r0, #1 
bne Exit
ldr r1, [r5, #4*0x03] @ lvls to gain
cmp r1, #0xFF 
blt NoCapLevelsToGain 
mov r1, #0xFF 
NoCapLevelsToGain: 
mov r7, r1 
ldr r6, =#0x203A4EC @BattleAttacker 


@ Now we have to figure out the level cap 
@ this is rather convoluted 
@ we just try to level up until their exp is set to 0xFF... 
@ r4 = unit we're doing stuff to 
@ r6 = battleattacker 
cmp r7, #0 
beq Exit 
sub r7, #1 
mov r0, r6 
mov r1, r4 
blh InitBattleUnitFromUnit 
mov r0, #100 
strb r0, [r6, #9] 
b AlwaysStartWith100Exp


LevelUpLoop:
cmp r7, #0 
ble Exit @ We finished our loop 
sub r7, #1 
mov r0, r6
mov r1, r4 
blh InitBattleUnitFromUnit

AlwaysStartWith100Exp:
ldrb r0, [r6, #9] @ exp. This gets stuff from unit in r4 anyway, so r6 is correct 

cmp r0, #0xFF @ cannot level up anymore 
beq Exit 
mov r1, #100 
strb r1, [r6, #9] @ store exp into imaginary battle 
mov r0, r6 
blh CheckForLevelUp @ r0 as battle unit 
@mov r3, #0x71 @ exp 
ldrb r0, [r6, #9] @exp 
@ldrb r1, [r6, r3] @ exp 
strb r0, [r4, #9] @ battle unit stored into our unit 


ldrb r2, [r6, #8] @ Level afterwards 
strb r2, [r4, #8] @Current level 


b LevelUpLoop 



Exit:
ldrb r0, [r4, #0x12] 
cmp r0, #127 
blt NoHpCap 
@ skillsys bug? IncreaseUnitStatsByLevelCount will lvl hp above #127 
mov r0, #127 
strb r0, [r4, #0x12] 
NoHpCap: 

mov r0, r4 
blh EnsureNoUnitStatCapOverflow



pop {r4-r7}
pop {r0} 
bx r0
