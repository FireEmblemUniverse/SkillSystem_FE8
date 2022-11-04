.thumb
.org 0x0
.align 4 
.equ SkillTester, Fill_Capture_Range_Map+4
.equ CaptureID, SkillTester+4

.global Capture_Usability
.type Capture_Usability, %function 

Capture_Usability:
push	{r4-r6,r14}

ldr		r0,CurrentCharPtr
ldr		r0,[r0]
ldr		r1,[r0,#0xC]		@status word
mov		r2,#0x50			@is rescuing + has moved
tst		r1,r2
bne		RetFalse
mov		r2,#0x80
lsl		r2,#0x4				@is in ballista
tst		r1,r2
bne		RetFalse

@ Vesly added 
ldr r2, =0x202BCF0 @ Chapter Data Struct 
ldr r2, [r2, #8] @ Gold 
mov r1, #255 
add r1, #45 
cmp r2, r1 
blt RetFalse @ Not enough money to capture 



mov		r5,r0
mov		r6,#0x0
ItemLoop:
lsl		r4,r6,#0x0 @ not short, byte 
add		r4,#0x28 @ wexp 
add		r4,r5
ldrh	r4,[r4]
cmp		r4,#0x0
beq		RetFalse
ldr		r0,Weapon_Wield_Check
mov		r14,r0
mov		r0,r5
mov		r1,r4
.short	0xF800
cmp		r0,#0x0
beq		NextWeapon

ldr		r0,Fill_Capture_Range_Map		@Fill_Capture_Range_Map
mov		r14,r0
mov		r0,r5
.short	0xF800
ldr		r0,TargetQueueCounter	@I think that's what this is
ldr		r0,[r0]


cmp		r0,#0x0
beq		NextWeapon
mov		r0,#0x1
b		GoBack
NextWeapon:
add		r6,#0x1
cmp		r6,#0x4
ble		ItemLoop
RetFalse:
mov		r0,#0x0 @ changed to 0 for the C code in gaiden magic as boolean answer 
GoBack:
@mov r11, r11 @ break 
pop		{r4-r6}
pop		{r1}
bx		r1

.ltorg
CurrentCharPtr:
.long 0x03004E50
Weapon_Wield_Check:
.long 0x08016750
TargetQueueCounter:
.long 0x0203E0EC
Fill_Capture_Range_Map:
@SkillTester
@CaptureID
