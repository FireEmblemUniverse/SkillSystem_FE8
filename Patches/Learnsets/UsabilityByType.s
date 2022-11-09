.thumb
.align

.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ GetItemIndex, 0x080174EC
.equ GetItemData, 0x080177B0


.global UsabilityByType
.type UsabilityByType, %function

@ Given r0 = UnitRamPointer, r1 = ItemID, return True or False 
@ whether class can learn this spell 
UsabilityByType:
push {r4-r5, lr} 
mov r4, r0 
mov r5, r1 @ item ID 

mov r2, #0x27 
CheckIfAlreadyLearnedLoop:
add r2, #1 
cmp r2, #0x2D 
bge Continue 
ldrb r0, [r4, r2] 
cmp r0, r5 
beq RetFalse 
b CheckIfAlreadyLearnedLoop 
Continue:

mov r0, r5 		@ Item ID 
@blh GetItemIndex 			@ GetItemIndex. r0 = item ID.
blh GetItemData 			@ GetItemData. r0 = pointer to ROM item data.
ldrb r0, [ r0, #0x07 ] 	@ r0 = this item's weapon type.


@ Get item wep type 

blh EffectivenessToTypeBitfield
@ r0 has matched weapon type to class type 

ldr r2, [r4, #4] @Class pointer 
mov r1, #0x50  		@ Class type 
ldrh r1, [r2, r1] 	@ Class type bitfield eg. 0x810 is Grass/Poison 

and r0, r1 
cmp r0, #0 
beq CheckSpecificList
mov r0, #1
b Exit
CheckSpecificList:
ldr r2, [r4, #4] @Class pointer 
ldrb r2, [r2, #4] @ Class ID 
lsl r2, #2 @ 4 bytes per class 
ldr r3, =TMListTable
add r3, r2 @ Class entry we want 
ldr r3, [r3] 
lsl r5, #24 
lsr r5, #24 @ just in case it includes durability i guess 
sub r3, #1 
Loop:
add r3, #1 
ldrb r0, [r3] 
cmp r0, #0
beq RetFalse
cmp r0, r5 
bne Loop
mov r0, #1 
b Exit 

RetFalse:
mov r0, #0 

Exit:

pop {r4-r5} 
pop {r1} 
bx r1 

.global EffectivenessToTypeBitfield
.type EffectivenessToTypeBitfield, %function

@ Given r0 as weapon type, return class type bitfield 
@ Eg. Fire is weapon type 3 (bows) but class bit 0x0002 
@ Buildfile\EngineHacks\SkillSystem\Skills\EffectivenessSkills

@#define FireType 0x01
@#define WaterType 0x02
@#define ElectricType 0x04
@#define FightingType 0x08
@#define PoisonType 0x10
@#define GroundType 0x20
@#define FlyingType 0x40
@#define RockType 0x80 
@
@#define GhostType 0x100
@#define NormalType 0x200
@#define DragonType 0x400
@#define GrassType 0x800
@#define IceType 0x1000
@#define SteelType 0x2000
@#define PsychicType 0x4000 
@#define BugType 0x8000

.macro byteonlycmp
	lsl r1, #24 
	lsr r1, #24 
	cmp r0, r1 
.endm 

.macro shortonlyend
	lsl r0, #16 
	lsr r0, #16
	b End 
.endm 

 
EffectivenessToTypeBitfield: 
push {lr} 

ldrb r1, =NormalTypeWep 
byteonlycmp 
beq Normal 

ldrb r1, =ElectricTypeWep 
byteonlycmp 
beq Electric

ldrb r1, =WaterTypeWep 
byteonlycmp 
beq Water

ldrb r1, =FireTypeWep 
byteonlycmp 
beq Fire

ldrb r1, =GrassTypeWep 
byteonlycmp 
beq Grass 

ldrb r1, =GroundTypeWep 
byteonlycmp 
beq Ground

ldrb r1, =PsychicTypeWep 
byteonlycmp 
beq Psychic

ldrb r1, =FightingTypeWep 
byteonlycmp 
beq Fighting

ldrb r1, =IceTypeWep 
byteonlycmp 
beq Ice


ldrb r1, =PoisonTypeWep 
byteonlycmp 
beq Poison 

ldrb r1, =FlyingTypeWep 
byteonlycmp 
beq Flying

ldrb r1, =RockTypeWep 
byteonlycmp 
beq Rock

ldrb r1, =GhostTypeWep 
byteonlycmp 
beq Ghost 

ldrb r1, =DragonTypeWep 
byteonlycmp 
beq Dragon 

ldrb r1, =BugTypeWep 
byteonlycmp 
beq Bug 

ldrb r1, =SteelTypeWep 
byteonlycmp 
beq Steel

mov r0, #0 @ Error 
b End 




Normal: 
ldr r0, =NormalType 
shortonlyend


Electric:
ldrb r0, =ElectricType 
shortonlyend

Water:
ldrb r0, =WaterType 
shortonlyend
	
Fire: 
ldrb r0, =FireType 
shortonlyend

Grass: 
ldrb r0, =GrassType 
shortonlyend

Ground: 
ldrb r0, =GroundType 
shortonlyend
Psychic:
ldrb r0, =PsychicType 
shortonlyend

Fighting:
ldrb r0, =FightingType 
shortonlyend
Ice:
ldrb r0, =IceType 
shortonlyend
Poison:
ldrb r0, =PoisonType 
shortonlyend

Flying: 
ldrb r0, =FlyingType 
shortonlyend
Rock: 
ldrb r0, =RockType 
shortonlyend
Ghost: 
ldrb r0, =GhostType 
shortonlyend
Dragon:
ldrb r0, =DragonType 
shortonlyend
Bug: 
ldrb r0, =BugType 
shortonlyend
Steel: 
ldrb r0, =SteelType 
shortonlyend

@[09024173]?

End: 
pop {r1} 
bx r1 
