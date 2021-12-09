
.thumb 

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ CurrentUnit, 0x3004E50
	.equ MemorySlot,0x30004B8
	.equ EventEngine, 0x800D07C
	.equ CheckEventId,0x8083da8
	.equ pActionStruct, 0x203A958	
	.equ CurrentUnitFateData, 0x203A958

	.equ gMapMovement, 0x0202E4E0
	.equ gMapRange, 0x0202E4E4
	.equ BmMapFill, 0x080197E4+1
	.equ FillRangeMapForDangerZone, 0x0801B810+1


.global RefreshUnitASMC
.type RefreshUnitASMC, %function 

RefreshUnitASMC:


push  {lr}


ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldrb r0, [r3, #0x10] 
ldrb r1, [r3, #0x11] 



ldr r2, =0x202E4E8 @ fog 
@ldr		r2,=gMapRange	@Load the location in the table of tables of the map you want

ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates



cmp r0, #0 
bne DoNotRefresh

bl RefreshIfFlagsPermitIt
cmp r0, #0
bne Return



DoNotRefresh:
ldr r0, =AttackedThisTurnFlagLink
ldrb r0, [r0] 
blh 0x8083bd8 @SetLocalEventId




Return:
pop   {r0}
bx    r0





.align 
.ltorg 

RefreshIfFlagsPermitIt:
push {lr}

ldr r0, =TrainerBattleActiveFlagLink 
ldrb r0, [r0] 
blh CheckEventId 
cmp r0, #0 
bne DontRefresh

 
ldr r0, =AttackedThisTurnFlagLink 
ldrb r0, [r0] 
blh CheckEventId 
cmp r0, #0 
bne DontRefresh  

@ previously in event code has auto-refresh if no enemies 

	ldr r3, =pActionStruct 
	mov r0, #0 
	strb r0, [r3, #0x10] @ No squares moved this turn, as they're refreshed now 

ldr r3, =CurrentUnit
ldr r3, [r3] 


ldr r0, [r3, #0x0C]
mov r1, #0x42 @ Canto, Acted This turn 
bic r0, r1 
str r0, [r3, #0x0C]

YesRefresh:
mov r0, #1 
b Exit 

DontRefresh:
mov r0, #0 

Exit:
pop   {r1}
bx    r1


.align
.ltorg 

	.global RefreshUnitWithoutFogASMC
	.type   RefreshUnitWithoutFogASMC, function

RefreshUnitWithoutFogASMC:
push {lr}

bl RefreshIfFlagsPermitIt
cmp r0, #1
bne DoNotRefresh2 @ Don't bother calculating enemy range if prevent refresh flags are on. 


mov r0, #0 @ arg r0 = staff range?
blh FillRangeMapForDangerZone 


ldr r0, =gMapMovement @ arg r0 = gMapMovement
ldr r0, [r0]
mov r1, #1
neg r1, r1            @ arg r1 = -1
blh BmMapFill 

ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldrb r0, [r3, #0x10] 
ldrb r1, [r3, #0x11] 

	
ldr		r2,=gMapRange	@Load the location in the table of tables of the map you want

ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates

cmp r0, #0 
bne DoNotRefresh2
b Return2 




DoNotRefresh2:
ldr r0, =AttackedThisTurnFlagLink
ldrb r0, [r0] 
blh 0x8083bd8 @SetLocalEventId


Return2: 


pop {r3}
bx r3







