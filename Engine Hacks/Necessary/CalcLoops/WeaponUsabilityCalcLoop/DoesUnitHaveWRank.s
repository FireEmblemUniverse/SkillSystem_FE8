.thumb
.align

@formerly in CanUnitWieldWeapon, this adds compatibility for things that happen before WRank check (i.e. weapon locks) and needs lumina/shadowgift to happen after

.equ SkillTester,ItemTable+4
.equ ShadowgiftID, SkillTester+4
.equ LuminaID, ShadowgiftID+4
.equ ShadowgiftStaffOption, LuminaID+4
.equ LuminaStaffOption, ShadowgiftStaffOption+4

DoesUnitHaveWRank:
push {r4-r7,r14}

mov r4,r0 @character pointer
mov r5,r1 @item halfword
mov r6,r2 @rank

@get item's wrank requirement
mov r0,r5
mov r1,#0xFF
and r0,r1
mov r1,#0x24
mul r0,r1
ldr r1,ItemTable
add r0,r1
ldrb r0,[r0,#0x1C]
cmp r0,r6
ble RetTrue @if (item wrank <= user wrank)

mov r6,r0
mov r0,#0xFF
and r0,r5
mov r1,#0x24
mul r0,r1
ldr r1,ItemTable
add r1,r0
ldrb r2,[r1,#7]

@shadowgift
cmp	r2,#7	@if dark rank
bne	noShadowgift
mov	r0,r4
ldr	r1,ShadowgiftID
ldr	r3,SkillTester
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	noShadowgift
mov	r0,r4
add	r0,#0x28
ldrb	r2,[r0,#6]
cmp	r2,r6
bhs	RetTrue
ldrb	r2,[r0,#5]
cmp	r2,r6
bhs	RetTrue
ldr	r1,ShadowgiftStaffOption
cmp	r1,#0
beq	noShadowgift
ldrb	r2,[r0,#4]
cmp	r2,r6
bhs	RetTrue
noShadowgift:

@lumina
cmp	r2,#6	@if light rank
bne	noLumina
mov	r0,r4
ldr	r1,LuminaID
ldr	r3,SkillTester
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	noLumina
mov	r0,r4
add	r0,#0x28
ldrb	r2,[r0,#7]
cmp	r2,r6
bhs	RetTrue
ldrb	r2,[r0,#5]
cmp	r2,r6
bhs	RetTrue
ldr	r1,LuminaStaffOption
cmp	r1,#0
beq	noLumina
ldrb	r2,[r0,#4]
cmp	r2,r6
bhs	RetTrue
noLumina:

RetFalse:
mov r0,#0
b GoBack

RetTrue:
mov r0,#1

GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align


ItemTable:
