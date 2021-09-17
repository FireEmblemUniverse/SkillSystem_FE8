.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.thumb

	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51
	.equ RemoveUnitBlankItems,0x8017984
	.equ EventEngine, 0x800D07C
	.equ ReturnTMRam,			0x30017ba

.global ReturnTMIfUnused
.type ReturnTMIfUnused, function 

ReturnTMIfUnused: 
push {lr} 

ldr r3, =ReturnTMRam
ldrb r0, [r3] 
cmp r0, #0
beq DoNotReturnTM
blh unitRamSilentGiveItemWithDurability

DoNotReturnTM:
pop {r1}
bx r1 

.global PostForgetOldMoveMenu
.type PostForgetOldMoveMenu, function 
PostForgetOldMoveMenu:
push {lr} 

	
	@ldr r0, [r3, #4*0x01] @Unit
	@str r0, [r3, #4*0x06] @ [0x30004D0]?!! 
	
	@ldr r4, [r3, #4*0x03] @ Item ID to combine with 
	@ldr r5, [r3, #4*0x04] @ Durability to add 

ldr r3, =MemorySlot
ldr r2, [r3, #4*0x06] @ Bool result 
cmp r2, #1 
bne SkipEvent



@blh 0x8022861 @ From SkillDebugMenu.c 
				@ Something to do with refreshing graphics/gamestate? 
ldr	r0, =LearningNewMoveEvent	@this event is 
b ExecuteEvent

DeclinedToLearn: 
@blh unitRamSilentGiveItemWithDurability

ldr r0, =ExitedNewMoveMenuEvent
mov	r1, #0x01		@0x01 = wait for events
blh EventEngine 

SkipEvent:



pop {r1}
bx r1 

.global BPressForgetOldMoveMenu
.type BPressForgetOldMoveMenu, function
BPressForgetOldMoveMenu:
push {lr} 
ldr r0, =ExitedNewMoveMenuEvent

ExecuteEvent:
mov	r1, #0x01		@0x01 = wait for events
blh EventEngine 

blh  0x0801a1f8   @RefreshFogAndUnitMaps
@blh  0x080271a0   @SMS_UpdateFromGameData
blh  0x08019c3c   @UpdateGameTilesGraphics
blh  0x80311a8 		@ReloadGameCoreGraphics
pop {r1}
bx r1 



.global ReplaceMove
.type ReplaceMove, function 
ReplaceMove:
push {lr} 
ldr r3, =MemorySlot
ldr r2, [r3, #4*0x01] @ Unit ram struct pointer 
add r2, #0x28 @ first wexp rank 
ldrb r1, [r3, #4*0x04] @ Move to learn 
ldrb r0, [r3, #4*0x05] @ WEXP offset 
strb r1, [r2, r0] @ Store new move where it should go 

blh  0x0801a1f8   @RefreshFogAndUnitMaps
@blh  0x080271a0   @SMS_UpdateFromGameData
@blh  0x08019c3c   @UpdateGameTilesGraphics
blh  0x80311a8 		@ReloadGameCoreGraphics

pop {r1}
bx r1 

.global ClearSpellLearnedRam
.type ClearSpellLearnedRam, function 
ClearSpellLearnedRam:
push {lr} 
mov r1, #0 
ldr  r0, =0x0202BCDE @ pExtraItemOrSkill
strh r1, [r0] 
ldr r0, =0x30017ba @ ReturnTMRam
strb r1, [r0] 


pop {r1}
bx r1 



