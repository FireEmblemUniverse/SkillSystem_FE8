.thumb
@replaces routine at 0x18A9C in Fe8
@r0 holds character pointer
.equ InventoryCheck, LockpickCheck + 4

push {r4-r7, r14}
mov 	r4, r0
mov 	r5, r1
mov 	r6, #0x0
ldr 	r7, LockpickCheck
mov 	r14, r7
.short 0xF800
ldr 	r7, InventoryCheck
cmp 	r0, #0x0
beq 	SkipLockpick
mov 	r0, r4
@load lockpick effect ID to r1
mov 	r1, #0x20
mov 	r14, r7
.short 0xF800
cmp 	r0, #0x0
bge PopBack
SkipLockpick:
cmp 	r5, #0x1E
beq 	DoorKeyCheck
cmp 	r5, #0x21
bne 	DefaultCheck
mov r0, r4
@Load chest key ID to r1
mov 	r1, #0x1E
mov 	r14, r7
.short 0xF800
b MasterKeyCheck

DoorKeyCheck:
mov r0, r4
@Load door key ID to r1
mov 	r1, #0x1F
mov 	r14, r7
.short 0xF800
MasterKeyCheck:
cmp r0, #0x0
bge	PopBack
mov r6, #0x26
DefaultCheck:
mov r0, r4
mov r1, r6
mov 	r14, r7
.short 0xF800
PopBack:
pop {r4-r7, r15}
@pop {r15}
@bx r1
.align
LockpickCheck:
