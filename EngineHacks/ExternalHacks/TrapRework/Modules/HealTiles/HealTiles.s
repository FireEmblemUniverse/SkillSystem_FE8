.thumb
.align


.global HealTiles_MapSpriteFunc
.type HealTiles_MapSpriteFunc, %function

.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ CheckEventId,0x8083da8


.global HealTileUsability
.type HealTileUsability, %function 
HealTileUsability: 
push {r4-r5, lr} 
ldr r0, CurrentUnitPointer
ldr r0, [r0]
ldr r1, =HealTileTrapID
lsl r1, #24 
lsr r1, #24 
bl GetTrapIndividual 
cmp r0, #0 
beq False

mov r0, #1 @ true 
b Exit 

False:
mov r0, #3 

Exit: 
pop {r4-r5} 
pop {r1} 
bx r1 
.ltorg 

GetTrapIndividual: @r0 = unit we're checking for adjacency to
push {r4-r5,r14}

mov r4,r0
mov r5, r1 
ldrb r0,[r4,#0x10] @x coord
ldrb r1,[r4,#0x11] @y coord
blh GetTrapAt
cmp r0, #0 
beq ReturnFalse2
ldrb r1,[r0,#2]

mov r2, r5
cmp r1, r2
beq RetTrapIndividual
ReturnFalse2:
mov r0,#0x0	@no trap so return 0x0

RetTrapIndividual:
pop {r4-r5}
pop {r1}
bx r1

.ltorg

.global HealTileEffect
.type HealTileEffect, %function 
HealTileEffect:
push {r4, lr} 
ldr r0, CurrentUnitPointer
ldr r0, [r0]
ldr r1, =HealTileTrapID
lsl r1, #24 
lsr r1, #24 
bl GetTrapIndividual
cmp r0, #0 
beq Continue 
mov r4, r0 @ trap address 

ldr r0, =HealTileEffectEvent 
mov	r1, #0x01		@0x01 = wait for events
ldr r3, ExecuteEvent
bl goto_r3

DeleteTrap:
@Remove the DV trap from the map.
mov r0, r4
ldr r3, RemoveTrap
bl goto_r3

ldr r0, CurrentUnitPointer
ldr r0, [r0]
ldrb r1, [r0, #0x12] @ max hp 
strb r1, [r0, #0x13] @ current hp 

Continue:
ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x10
strb r0, [r1,#0x11]
@mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics

pop {r4}
pop {r3}
goto_r3:
bx r3

.ltorg 
.align 
.equ GetTrapAt,0x802e1f0
ExecuteEvent:
	.long 0x800D07D @AF5D
CurrentUnitFateData:
	.long 0x203A958
CurrentUnitPointer:
	.long 0x3004E50
GetTrap:
    .long 0x802E1F1
RemoveTrap:
    .long 0x802EA91
	
