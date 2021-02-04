@Rule.
@1.Anyone with the Supply skill can access the convoy.
@2.Adjacent ones with Supply skills have access to convoys.
@3.If AlsoUseVanillaCheck is enabled, check the vanilla routine in addition to the above.
@4.If the above conditions are not met, the convoy will not be available.
@

.thumb
.align

.equ SupplyID,SkillTester+4
.equ AlsoUseVanillaCheck,SupplyID+4
.equ gActiveUnit,0x3004E50

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

push {r4,r14}

ldr r1, =gActiveUnit
ldr r1, [r1]
ldr r0, [r1, #0xC]
mov r1, #0x40
tst r0, r1
bne ReturnFalse

ldr r0, SkillTester
mov lr, r0
ldr r1, =gActiveUnit
ldr r0, [r1]
ldr r1, SupplyID
.short  0xf800
cmp r0, #1
beq ReturnTrue

bl IsPhantom
cmp r0,#0x1
beq ReturnFalse

bl IsAdjacent
cmp r0,#0x1
beq ReturnTrue

ldr r1,AlsoUseVanillaCheck
cmp r1,#0x00
beq ReturnFalse

ForAlsoUseVanillaCheck:
blh 0x08023F64 @VanillaSupplyUsability
b GoBack

ReturnFalse:
mov r0,#3
b GoBack

ReturnTrue:
mov r0,#1

GoBack:
pop {r4}
pop {r1}
bx r1


IsPhantom:
push {lr}
ldr r1,=gActiveUnit
ldr r3,[r1]

ldr r0,[r3,#4]  @RAMUnit->Class
ldrb r0,[r0,#4] @RAMUnit->Class->ID

ldr r1,=0x08023F78  @SupplyUsability => cmp r0, #0x51
ldrb r1,[r1]
cmp r0,r1           @check #0x51
beq IsPhantom_ReturnTrue

@check 7743's summon
ldrb r1, [r3, #0xF] @ramunit->status4
lsr  r1,#0x7
cmp r1,#0x01
beq IsPhantom_ReturnTrue

IsPhantom_ReturnFalse:
mov r0,#0x0
b IsPhantom_Exit

IsPhantom_ReturnTrue:
mov r0,#0x01

IsPhantom_Exit:
pop {r1}
bx r1



IsAdjacent:
push {r4,r5,r6,r7,lr}

ldr r1,=gActiveUnit
ldr r0,[r1]

mov r7, #0x10
ldsb r7, [r0, r7] @RAMUnit->X
mov r6, #0x11
ldsb r6, [r0, r6] @RAMUnit->Y
mov r5, #0x0
ldr r4, =0x080D7C04	@AjaxFourSides[4]

IsAdjacent_Loop:
mov r2, #0x0
ldsb r2, [r4, r2]
add r2 ,r7, r2
mov r0, #0x1
ldsb r0, [r4, r0]
add r0 ,r6, r0
ldr r1, =0x0202E4D8 @(gMapUnit )
ldr r1, [r1, #0x0]

lsl r0 ,r0 ,#0x2    @gMapUnit[x]
add r0 ,r0, r1
ldr r0, [r0, #0x0]

add r0 ,r0, r2      @gMapUnit[x][y]
ldrb r1, [r0, #0x0]
mov r0, #0x80       @???
and r0 ,r1
cmp r0, #0x0
bne IsAdjacent_Next
	mov r0 ,r1
	blh 0x08019430   @GetUnitStruct RET=RAM Unit:@UNIT
	cmp r0, #0x0
	beq IsAdjacent_Next

	ldrb r1, [r0, #0xB]  @ RAMUnit->Unit table ID
	cmp r1,#0x80         @ Enemy supply are not available.
	bge IsAdjacent_Next

	ldr r3, SkillTester
	mov lr, r3
	ldr r1, SupplyID
	.short  0xf800
	cmp r0, #1
	beq IsAdjacent_Return_True

IsAdjacent_Next:
add r4, #0x2
add r5, #0x1
cmp r5, #0x3
ble IsAdjacent_Loop

mov r0, #0x0
b IsAdjacent_Return_Exit

IsAdjacent_Return_True:
mov r0, #0x1

IsAdjacent_Return_Exit:
pop {r4,r5,r6,r7}
pop {r1}
bx r1


.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD SupplyID
@WORD AlsoUseVanillaCheck
