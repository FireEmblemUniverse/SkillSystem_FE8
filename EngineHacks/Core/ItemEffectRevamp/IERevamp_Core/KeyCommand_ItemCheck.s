.thumb

@replaces routine at 0x18A9C in Fe8
@arugments
	@r0 = unit pointer
	@r1 = 0x1E if door, 0x21 if chest

push 	{r4-r6, r14}
mov 	r4, r0
mov 	r5, r1
mov 	r6, #0x0
bl 	CanUseLockpicks
cmp 	r0, #0x0
beq 	SkipLockpick
mov 	r0, r4
@load lockpick effect ID to r1
mov 	r1, #0x20
bl 	Inventory_EIDCheck_Jump
cmp 	r0, #0x0
bge 	PopBack
SkipLockpick:
cmp 	r5, #0x1E
beq 	DoorKeyCheck
cmp 	r5, #0x21
bne 	DefaultCheck
mov 	r0, r4
@Load chest key ID to r1
mov 	r1, #0x1E
bl 	Inventory_EIDCheck_Jump
b MasterKeyCheck

DoorKeyCheck:
mov 	r0, r4
@Load door key ID to r1
mov 	r1, #0x1F
bl 	Inventory_EIDCheck_Jump
MasterKeyCheck:
cmp 	r0, #0x0
bge 	PopBack
mov 	r6, #0x26
DefaultCheck:
mov 	r0, r4
mov 	r1, r6
bl 	Inventory_EIDCheck_Jump
PopBack:
pop 	{r4-r6}
pop 	{r15}
.align

