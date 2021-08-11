.thumb
.org 0x0

.equ SkillTester, Fill_Capture_Range_Map+4
.equ CaptureID, SkillTester+4

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
mov		r5,r0
ldr		r1,CaptureID
ldr		r2,SkillTester
mov		r14,r2
.short	0xF800				@check whether unit has the capture skill
cmp		r0,#0
beq		RetFalse
mov		r6,#0x0
ItemLoop:
lsl		r4,r6,#0x1
add		r4,#0x1E
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
mov		r0,r4
ldr		r1,=#0x801766C		@get min range
mov		r14,r1
.short	0xF800
cmp		r0,#0x1
bne		NextWeapon			@can only capture at 1 range
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
mov		r0,#0x3
GoBack:
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
