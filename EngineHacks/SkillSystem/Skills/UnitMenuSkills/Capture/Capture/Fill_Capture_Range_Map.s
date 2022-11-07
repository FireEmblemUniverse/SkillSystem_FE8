.thumb
.org 0x0
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ ForEachUnitInRange, 0x8024EAC 
.equ FillMapAttackRangeForUnit, 0x801ACBC
@r0=char data
@based on the heal staff fill-in-range function at 25E7C
push	{r4-r5,r14}
mov		r4,#0x10
ldsb	r4,[r0,r4]
mov		r5,#0x11
ldsb	r5,[r0,r5]
ldr		r1,Const1
str		r0,[r1]
ldr		r0,Clear_Map_Func
mov		r14,r0
ldr		r0,RangeMap
ldr		r0,[r0]
mov		r1,#0x0
.short	0xF800

ldr		r0,Const1
ldr r0, [r0] @ unit 
mov r1, #0 
sub r1, #1 @(-1)
@r0 has char data, r1 has slot # (-1 in this case)
bl All_Weapons_One_Square 
@ fills range map for all weapons 

@ldr r1, Const1 
@ldr r0, [r1] @ unit 
@blh FillMapAttackRangeForUnit 

@extern u32 GetWeaponRangeMask(int item); // 0x080170D4.

@extern void MakeTargetListForWeapon(Unit* unit, int item); // 0x080251B4.

mov r0, r4 
mov r1, r5 
blh 0x804F8A4 @ Init Targets 

@mov r0, r4 
@mov r1, r5 
@mov r2, #1 
@mov r3, #1 @ value  
@blh 0x801AABC @ 
@mov r3, #1 
@neg r3, r3 
@mov r0, r4 
@mov r1, r5 
@mov r2, #0 @ can't attack at 0 range  
@blh 0x801AABC @ map add in range 


ldr		r0, =ForEachUnitInRange		
mov		r14,r0
ldr		r0,Capture_Target_Check 
.short	0xF800
pop		{r4-r5}
pop		{r0}
bx		r0
.ltorg 


.align
Const1:
.long 0x02033F3C
Clear_Map_Func:
.long 0x080197E4
RangeMap:
.long 0x0202E4E4

Fill_One_Range_Map:
.long 0x08024F70
Capture_Target_Check:
@.long 0x0802517C+1
