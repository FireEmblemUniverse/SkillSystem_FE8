.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ SetupBattleStructForStaffUser, 0x0802cb24
.equ FinishUpItemBattle, 0x0802cc54
.equ BeginBattleAnimations, 0x0802ca14
.equ UnlockDoor, 0x0808320c
.equ UnlockChest, 0x080831c8

@hook at 2F280, return at 2F290
@r0 is unit data
@make sure to push and pop r6 too

mov r6, r0
	
	ldrb r1, [r4, #0x12] //slot number
	lsl r1, r1, #0x1
	mov r0, r6
	add r0, #0x1E
	add r0, r0, r1
	ldrh r0, [r0, #0x0]
	
	strb r0, [r4, #0x6]	//item id
	
mov r0, r6
ldrb r1, [r4, #0x12]
blh SetupBattleStructForStaffUser
ldr r0, =0x0203a56c
ldrb r1, [r4, #0x13] @target x
strb r1, [r0, #0x10]
ldrb r2, [r4, #0x14] @target y
strb r2, [r0, #0x11]
	mov r3, r0
	add r3, #0x73
	strb r1, [r3, #0x0]
	add r0, #0x74
	strb r2, [r0, #0x0]

mov r0, r5
blh FinishUpItemBattle
blh BeginBattleAnimations

ldr r3, =0x0802f2a5
bx r3

.align
.ltorg
