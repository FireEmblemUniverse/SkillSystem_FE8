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
push {r4, lr} 
mov r4, r0 

mov r0, r1 		@ Item ID 
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
beq Exit
mov r0, #1


Exit:

pop {r4} 
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
	lsl r1, #16 
	lsr r1, #16
	b End 
.endm 

 
EffectivenessToTypeBitfield: 
push {lr} 

ldrb r1, =NormalWepType 
byteonlycmp 
beq Normal 

ldrb r1, =ElectricWepType 
byteonlycmp 
beq Electric

ldrb r1, =WaterWepType 
byteonlycmp 
beq Water

ldrb r1, =FireWepType 
byteonlycmp 
beq Fire

ldrb r1, =GrassWepType 
byteonlycmp 
beq Grass 

ldrb r1, =GroundWepType 
byteonlycmp 
beq Ground

ldrb r1, =PsychicWepType 
byteonlycmp 
beq Psychic

ldrb r1, =FightingWepType 
byteonlycmp 
beq Fighting

ldrb r1, =IceWepType 
byteonlycmp 
beq Ice


ldrb r1, =PoisonWepType 
byteonlycmp 
beq Poison 

ldrb r1, =FlyingWepType 
byteonlycmp 
beq Flying

ldrb r1, =RockWepType 
byteonlycmp 
beq Rock

ldrb r1, =GhostWepType 
byteonlycmp 
beq Ghost 

ldrb r1, =DragonWepType 
byteonlycmp 
beq Dragon 

ldrb r1, =BugWepType 
byteonlycmp 
beq Bug 

ldrb r1, =SteelWepType 
byteonlycmp 
beq Steel

mov r0, #0 @ Error 
b End 




Normal: 
ldr r0, =#0xFFFF
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
