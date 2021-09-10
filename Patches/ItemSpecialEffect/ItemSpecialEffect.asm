@Hard coded item menu usability 
.thumb 

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.equ gActionData, 0x203A958
.equ CurrentUnit, 0x3004E50
.equ CheckEventId,0x8083da8

.global ItemSpecialEffectUsability
.type ItemSpecialEffectUsability, %function
ItemSpecialEffectUsability:
push {r4-r6, lr} 


ldr r5, =CurrentUnit 
ldr r5, [r5]
ldr r3, =gActionData 
ldrb r4, [r3, #0x12] @ inventory slot # 
lsl r4, #1 @ 2 bytes per inv slot 
add r4, #0x1E 
add r4, r5 @ unit ram address of actual item to load 
ldrh r1, [r4] 
mov r4, #0xFF 
and r4, r1 @ item id 

ldr r6, =ItemSpecialEffectTable
sub r6, #8
FindValidItemLoop:
add r6, #8 
ldr r0, [r6] 
cmp r0, #0 
beq RetFalse 
ldrb r0, [r6] @ item id 
cmp r0, r4 @ if they match, return true 
bne FindValidItemLoop 
ldrb r0, [r6, #1] @ flag 
cmp r0, #0 
beq RetTrue @ Always true if flag is 0 
blh CheckEventId
cmp r0, #1 
bne FindValidItemLoop 

RetTrue: 
mov r0, #1
b ExitUsability 

RetFalse: 
mov r0, #3 @ 3 is false lol 
b ExitUsability
@ if hover item = our item, return true 

ExitUsability:
pop {r4-r6} 
pop {r1} 
bx r1

.equ RemoveUnitBlankItems,0x8017984
.equ GetItemAfterUse, 0x08016AEC
.equ EventEngine, 0x800D07C
.equ CurrentUnitFateData, 0x203A958


.equ ClearBG0BG1, 0x0804E884
.equ SetFont, 0x8003D38
.equ Font_ResetAllocation, 0x8003D20  
.equ EndAllMenus, 0x804EF20 


.global ItemSpecialEffect
.type ItemSpecialEffect, %function
ItemSpecialEffect:
push {r4-r7, lr} 

@ reduce durability and remove item if 0 durability 

ldr r5, =CurrentUnit 
ldr r5, [r5]
ldr r3, =gActionData 
ldrb r4, [r3, #0x12] @ inventory slot # 
lsl r4, #1 @ 2 bytes per inv slot 
add r4, #0x1E 
add r4, r5 @ unit ram address of actual item to load 
ldrh r0, [r4]
blh GetItemAfterUse

ldrh r1, [r4] 
strh r0, [r4] @ version after use 
mov r4, #0xFF 
and r4, r1 @ item id 

ldr r6, =ItemSpecialEffectTable
sub r6, #8
FindValidItemLoop_Effect:
add r6, #8 
ldr r0, [r6] 
cmp r0, #0 
beq ExitItemSpecialEffect
ldrb r0, [r6] @ item id 
cmp r0, r4 @ if they match, return true 
bne FindValidItemLoop_Effect 
ldrb r0, [r6, #1] @ flag 
cmp r0, #0 
beq RunEvent @ Always true if flag is 0 
blh CheckEventId
cmp r0, #1 
bne FindValidItemLoop_Effect

blh ClearBG0BG1
@ copied from vanilla 
mov r0, #0 
blh SetFont 
blh Font_ResetAllocation 

RunEvent: 
add r6, #4 
ldr r0, [r6] @ event address 
mov r1, #1 
blh EventEngine 

mov r0, r5 
blh RemoveUnitBlankItems

ExitItemSpecialEffect:
ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]

@Effect/Idle Routine Return Value (r0 Bitfield):
@        & 0x01 | Does things? idunno - pause the hand selector ? 
@        & 0x02 | Ends the menu
@        & 0x04 | Plays the beep sound
@        & 0x08 | Plays the boop sound
@        & 0x10 | Clears menu graphics
@        & 0x20 | Deletes E_FACE #0
@        & 0x40 | Nothing (Not handled)
@        & 0x80 | Orrs 0x80 to E_Menu+0x63 bitfield (Ends the menu on next loop call (next frame))
@




blh EndAllMenus

mov r0, #0xb7 


pop {r4-r7} 
pop {r1} 
bx r1



