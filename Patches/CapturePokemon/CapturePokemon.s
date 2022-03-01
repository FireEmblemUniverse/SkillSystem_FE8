.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb

	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51
	.equ HandleAllegianceChange, 0x801034D 
	.equ EventEngine, 0x800D07C
	
	.equ GetUnit, 0x8019431

.global ChangeS1UnitIntoLowestUnitID
.type ChangeS1UnitIntoLowestUnitID, %function 
ChangeS1UnitIntoLowestUnitID:
push {r4, lr}
bl FindFreeSlot
mov r4, r0 
ldr r3, =MemorySlot 
ldr r0, [r3, #0x1*4] @ s1 as unit ID 
blh GetUnitByEventParameter
cmp r0, #0 
beq Change_Error
mov r2, r0 @ Unit ram 

mov r0, r4 
mov r1, #0x34 @ Size of Character table 
mul r0, r1 
ldr r3, =0x8017D64 @ POIN CharacterTable 
ldr r3, [r3] @ Char table unit 0 
add r0, r3 @ Character table entry 
str r0, [r2] @ change unit pointer 

Change_Error:

pop {r4} 
pop {r0}
bx r0
.ltorg 
.align 



.global FindFreeSlot
.type FindFreeSlot, %function 
FindFreeSlot:
push {r4, lr}
ldr r3, =0x8017D64 @ POIN CharacterTable 
ldr r3, [r3] @ Char table unit 0 

mov r4, #0x01 @counter 


LoopThroughUnits:
mov r0, r4 
cmp r4, #40 @ 0x3F theoretical maximum 
bgt Error 		@ Can't have more than 40 units. Ten Units (0x29 - 0x33) are reserved for special events 
blh GetUnitByEventParameter @ 0x0800BC51
cmp r0,#0
beq FoundUnit
@NextUnit:
add r4,#1
b LoopThroughUnits 
Error:
mov r4, #0xFF 
FoundUnit:
mov r0, r4 

pop {r4}
pop {r1}
bx r1 

.ltorg 
.align 

	
	.global CapturePokemon
	.type   CapturePokemon, function

CapturePokemon:	@Make

	push {r4-r7, lr}	
	@normally r4 = attacker, r5 = defender, r6 = action struct 
	ldr r4, =0x203A4EC 
	ldr r5, =0x203A56C
	ldr r6, =0x203A958 
	@ we need the actual unit structs 
	ldrb r0, [r4, #0x0B] @ Captured pokemon deployment byte 
	blh GetUnit 
	mov r4, r0 
	ldrb r0, [r5, #0x0B] @ rescuing pkmn deployment byte 
	blh GetUnit 
	mov r5, r0 
	

@check if active unit is dead
ldrb	r0, [r4,#0x13]
cmp	r0, #0x00
bne Continue 
b Break 
Continue:
@ [203A969]!! - handle post action trap was changing action to "wait" if you'd stepped on a trap 
@check if attacked this turn
ldrb 	r0, [r6,#0x11]	@action taken this turn
cmp	r0, #0x2 @attack
bne	Break
ldrb 	r0, [r6,#0x0C]	@allegiance byte of the current character taking action
ldrb	r1, [r4,#0x0B]	@allegiance byte of the character we are checking
cmp	r0, r1		@check if same character
bne	Break



@check that we killed the enemy 
ldrb	r0, [r5,#0x13]	@currhp
cmp	r0, #0
bne	Break

@check that we're capturing the enemy 
ldrb 	r0, [r5, #0x0C] @unit state 
mov r1, #0x20 @being rescued 
and r1, r0
cmp r1, #0
beq Break 		@if they are not being rescued, Break 


mov r3, #0x1D 
mov r0, #0 
@clear out inventory 
WipeInventoryLoop:
add r3, #1 @start at #0x1E 
strb r0, [r5, r3]
cmp r3, #0x27 
blt WipeInventoryLoop

	
@remove rescuee/er for player & enemy 
mov r0, #0
mov r1, #0x1B
strb r0, [r5, r1]
strb r0, [r4, r1] 
ldr r2, =0x203A4EC @ atkr/dfdr 
ldr r3, =0x203A56C
mov r0, #0
mov r1, #0x1B
strb r0, [r2, r1]
strb r0, [r3, r1] 

@remove 'Rescuing' flag 
ldrb 	r0, [r4, #0xC]
mov		r1,#0x10 
mvn		r1,r1
and		r0,r1
@mov 	r0, #0
strb	r0, [r4, #0xC]

@remove 'Dead', 'Undeployed', 'Rescued' flag 
ldrb 	r0, [r5, #0xC]
@ mov		r1,#0x24 
mov r1, #0x2C @ Undeployed flag, too 
mvn		r1,r1
and		r0,r1
strb	r0, [r5, #0xC]

@give defender 5/8 hp 
ldrb r0, [r5, #0x12] 
add r0, #3 @for generous rounding purposes 
add r1, r0, #4 @for rounding purposes 
lsr r1, r1, #3 @1/8 hp 
lsr r0, #1 @2/4 hp 
add r0, r1 
strb 	r0,[r5,#0x13]	


bl FindFreeSlot
cmp r0, #40 
bgt FullBox


@push {r3} 
@blh 0x080956d8 @ReorderPlayerUnitsBasedOnDeployment
@ not needed afaik 
@pop {r3} 


@ We only continue if we found a result of r0 = 0 



@ turn into first free player unit id from 0x01 - 0x35 
mov r1, #0x34 @ Size of each char entry in char table 
@ r0 as unit ID 
mul r0, r1
ldr r1, =0x8017D64 @ POIN CharacterTable 
ldr r1, [r1] @ Char table unit 0 
add r1, r0 
str r1, [r5] 


mov r0, #1
lsl r0, #8 @0x100 
add r0, #6 @0x106 
blh GetUnitByEventParameter @ 0x0800BC51
@mov r11, r11
cmp r0, #0 
beq AddToParty @no 6th deployed unit, so add to party 
@otherwise, add 'Escaped, Undeployed' flags
ldr 	r0, [r5, #0xC]
mov 	r1, #1 
lsl 	r1, #16 @10000 = escaped  
add 	r1, #0x9 @8 = undeployed 
orr		r0,r1
str		r0, [r5, #0xC]


mov	r3, #0x00
ldrb	r0, [r4,#0x11]		@load y coordinate of character
lsl	r0, #16
add	r3, r0
ldrb	r0, [r4,#0x10]		@load x coordinate of character
add	r3, r0
ldr r2, =MemorySlot
str	r3, [r2, #4*0x0B] 		@and store them in sB for the event engine

ldr r0, [r5]
ldrb r0, [r0, #4] 	
str r0, [r2, #4*0x02] @unit ID in s2 

ldr	r0, =PCBoxFullEvent	@this event is 
mov	r1, #0x01		@0x01 = wait for events
blh EventEngine 

b End 

AddToParty: 



b End_LoopThroughUnits


@ run event where unit was not caught 
FullBox:
ldr	r0, =PCBoxFullEvent	@this event is 
mov	r1, #0x01		@0x01 = wait for events
blh EventEngine 
b End 


End_LoopThroughUnits:

@@r0 = 3007DB8 
@@ldr r1, =3007DB8 
@@ldrb r1, [r1] @ which is 0 
@
@@r0 = 202CFBC 
@@gave 202BEDC 
@@r5 is defender, but we need their ram unit pointer, not ram defender 
@@ change into player finally 

@ldrb r0, [r5, #0xB] @deployment / allegiance byte  
@blh GetUnit 
@mov r5, r0 @unit ram pointer now 

@@r0 = unit pointer 
@@r1 should be faction which is 0 for players 

@mov r1, #0
@blh HandleAllegianceChange @10298
@ this never returns for whatever reason so oh well 
@ just doing this part with events since I realized I can since 
@ they'll have a unique unit ID by the end 




@ run event where unit was caught 
Event:
mov	r3, #0x00
ldrb	r0, [r4,#0x11]		@load y coordinate of character
lsl	r0, #16
add	r3, r0
ldrb	r0, [r4,#0x10]		@load x coordinate of character
add	r3, r0
ldr r2, =MemorySlot
str	r3, [r2, #4*0x0B] 		@and store them in sB for the event engine

@strh r4, [r3, #4*0x0B+0] @ XX
@strh r5, [r3, #4*0x0B+2] @ YY 

ldr r0, [r5]
ldrb r0, [r0, #4] 	
str r0, [r2, #4*0x02] @unit ID in s2 


ldr	r0, =CapturePokemonEvent	@this event is 
mov	r1, #0x01		@0x01 = wait for events
blh EventEngine 





End:
	blh  0x0801a1f4   @RefreshFogAndUnitMaps
	blh  0x080271a0   @SMS_UpdateFromGameData
	blh  0x08019c3c   @UpdateGameTilesGraphics
Break:
	
	pop {r4-r7}
	pop {r0}
	bx r0 
	