.thumb

@r0=attacker's item id, r1=defender battle struct

.equ NullifyID, SkillTester+4
.equ IsAccessory, SkillTester+8

push	{r4-r7,r14}
mov		r4,r0
mov		r5,r1
ldr		r0,[r5,#0x4]
cmp		r0,#0
beq		RetFalse
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
ProtectiveItemsLoop:
lsl		r0,r7,#1
add		r0,#0x1E
ldrh	r0,[r5,r0]
cmp		r0,#0
beq		EffectiveWeaponLoop
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
ldr r2, =0x80 
lsl r2, #24 
lsr r2, #16 @ chop of |0x8000000 if we had defined ldr r2, IsEquipped
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
b RetFalse 



bic		r6,r1				@remove bits that are protected from the class weaknesses bitfield
cmp		r6,#0
beq		RetFalse
NextItem:
add		r7,#1
cmp		r7,#4
ble		ProtectiveItemsLoop

EffectiveWeaponLoop:
ldrh	r1,[r4,#2]			@bitfield of types this weapon is effective against
cmp		r1,#0
beq		RetFalse
and		r1,r6				@see if they have bits in common
cmp		r1,#0
bne		NullifyCheck
add		r4,#4
b		EffectiveWeaponLoop

NullifyCheck:
mov		r0,r5
ldr		r1,NullifyID
ldr		r3,SkillTester
mov		r14,r3
.short	0xF800
cmp		r0,#0
bne		RetFalse

ldrb	r0,[r4,#0x1]		@coefficient
b		GoBack
RetFalse:
mov		r0,#0
GoBack:
pop		{r4-r7}
pop		{r1}
bx		r1

.ltorg
SkillTester:
@
