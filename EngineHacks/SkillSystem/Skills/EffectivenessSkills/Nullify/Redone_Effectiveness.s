.thumb

@r0=attacker's item id, r1=defender battle struct

.equ NullifyID, SkillTester+4
.equ IsAccessory, SkillTester+8
.equ HoverBoardID, SkillTester+12 
.equ WepGroundType, SkillTester+16 

push	{r4-r7,r14}
mov r4, r8 
push {r4} 
mov		r4,r0
mov		r5,r1
ldr		r0,[r5,#0x4]
cmp		r0,#0
beq		RetFalse

mov r0, r4 
ldr r3, =0x8017548 @ get item type 
mov lr, r3 
.short 0xf800 
mov r8, r0 @ item type 


mov		r0,r4
ldr		r3,=#0x80176D0		@get effectiveness pointer
mov		r14,r3
.short	0xF800
cmp		r0,#0
beq		RetFalse			@if weapon isn't effective, end
ldr		r1,[r5,#0x4]
mov		r6,#0x50
ldr		r6,[r1,r6]			@class weaknesses
cmp		r6,#0
beq		RetFalse			@if class has no weaknesses, end

mov		r4,r0				@save effectiveness ptr
mov		r7,#0				@inventory slot counter


mov r0, r8 @ type 
ldr r1, WepGroundType 
cmp r0, r1 
bne ProtectiveItemsLoop 
@ do they have an air balloon 
mov		r0,r5
ldr		r1,HoverBoardID
ldr		r3,SkillTester
mov		r14,r3
.short	0xF800
cmp		r0,#0
beq ProtectiveItemsLoop 
ldr r7, WepGroundType 
b EffectiveWeaponLoop 

GotoEffectiveWeaponLoop:
mov r7, #0 
b EffectiveWeaponLoop 



ProtectiveItemsLoop:
lsl		r0,r7,#1
add		r0,#0x1E
ldrh	r0,[r5,r0]
cmp		r0,#0
beq		GotoEffectiveWeaponLoop
mov		r1,#0xFF
and		r0,r1
ldr		r3,=#0x80177B0		@get_item_data
mov		r14,r3
.short	0xF800

ldr		r1,[r0,#0x8]		@weapon abilities
ldr r2, IsAccessory 
lsl r2, #24 
lsr r2, #8 	@accessory bit, aka 'protector item'	
@0x00400000 	
and r2, r1 
cmp r2, #0 
beq NextItem 
lsl r1, r7, #1 
add r1, #0x1E 
ldrh r1, [r5, r1] 
mov r2, #0x80 
lsl r2, #8 
@ 0x8000 
and r2, r1 
cmp r2, #0 
beq NextItem 



ldr		r1,[r0,#0x10]		@pointer to types it protects
cmp		r1,#0
beq		NextItem

ldrh	r1,[r1,#2] @ type attack to nullify 



ldrh	r2,[r4,#2]			@bitfield of types this weapon is effective against

and r1, r2 
cmp r1, #0 
beq NextItem 
@ r1 = type to protect against 
mov r0, r8 
cmp r0, r1 
bne GotoEffectiveWeaponLoop  
mov r7, r0 @ type to protect against 
@ attacker is using a weapon we are protected against 

b EffectiveWeaponLoop 

NextItem:
add		r7,#1
cmp		r7,#4
ble		ProtectiveItemsLoop
mov r7, #0 @ no protected types 

EffectiveWeaponLoop:
ldrh	r1,[r4,#2]			@bitfield of types this weapon is effective against
ldrb r3, [r4, #1] 
cmp r3, #4 
bne Continue 
cmp r7, #0 
bne RetFalse 
Continue: 
cmp		r1,#0
beq		RetFalse
and		r1,r6				@see if they have bits in common
cmp		r1,#0
bne		NullifyCheck
add		r4,#4
b		EffectiveWeaponLoop

NullifyCheck:
@mov		r0,r5
@ldr		r1,NullifyID
@ldr		r3,SkillTester
@mov		r14,r3
@.short	0xF800
@cmp		r0,#0
@bne		RetFalse

ldrb	r0,[r4,#0x1]		@coefficient
b		GoBack
RetFalse:
mov		r0,#0
GoBack:
pop {r4} 
mov r8, r4 
pop		{r4-r7}
pop		{r1}
bx		r1

.ltorg
.align 
SkillTester:
@
