.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@r0=char data ptr

.equ StealID, SkillTester+4
.equ StealPlusID, StealID+4
.equ AlsoUseCheckVanillaSteal, StealPlusID+4

push	{r4-r5,r14}
mov		r4,r0
ldr		r5,SkillTester
ldr		r1,StealID
mov		r14,r5
.short	0xF800
cmp		r0,#0
bne		RetTrue
mov		r0,r4
ldr		r1,StealPlusID
mov		r14,r5
.short	0xF800
cmp		r0,#0
bne		RetTrue

ldr		r0,AlsoUseCheckVanillaSteal
cmp		r0,#0
beq		RetFlase

CheckVanillaSteal_Wrapper:
bl		StealCommandUsability
cmp		r0,#0
bne		RetTrue

RetFlase:
mov		r0,#0
b		GoBack

RetTrue:
mov		r0,#1

GoBack:
pop		{r4-r5}
pop		{r1}
cmp		r0,#0				@necessary due to laziness and space constraints
bx		r1

StealCommandUsability:
push {r4,lr}
ldr r4, =0x03004E50
ldr r2, [r4, #0x0] 
ldr r0, [r2, #0x0]
ldr r1, [r2, #0x4]
ldr r0, [r0, #0x28]
ldr r1, [r1, #0x28]
orr r0 ,r1
mov r1, #0x4
and r0 ,r1
cmp r0, #0x0
beq StealCommandUsability_RetFalse
	ldr r0, [r2, #0xc]
    mov r1, #0x40
    and r0 ,r1
    cmp r0, #0x0
    bne StealCommandUsability_RetFalse
        mov r0 ,r2
        blh 0x08025c00   @MakeTargetListForSteal
        blh 0x0804fd28   @GetTargetListSize Gets list size (used to check for empty lists in usability routines) Number of entries in the list
        cmp r0, #0x0
        beq StealCommandUsability_RetFalse

ldr r0, [r4, #0x0] 
blh 0x080179d8   @GetUnitItemCount
cmp r0, #0x5
beq StealCommandUsability_RetFalse   @ItemFull

StealCommandUsability_RetTrue:
mov		r0,#1
b		StealCommandUsability_GoBack

StealCommandUsability_RetFalse:
mov		r0,#0

StealCommandUsability_GoBack:
pop {r4}
pop {r1}
bx r1

.align
.ltorg
SkillTester:
