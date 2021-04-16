.thumb

.align 4
.macro blh to, reg=r6
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ Text_InsertNumberOr2Dashes, 0x080044a4

@hook at 89fd8, just add an extra condition for 0x4

mov r0, r4
blh 0x080892d0, r3 @GetRtextItemBoxType
cmp r0, #0x1
beq WeaponType
	cmp r0, #0x3
	beq SaveMenuType
		cmp r0, #0x4
			beq SupportType
				b DefaultCase
			SupportType:
			mov r0, r5				@ 29-2b data here
			bl DrawRtextStatValues
			b DefaultCase
		SaveMenuType: @89ff4
		ldr r1, =0x08089ff5
		bx r1
	WeaponType:
	mov r0, r4
	ldr r1, =0x08089fef
	bx r1
DefaultCase: @89ff8
ldr r1, =0x08089ff9
bx r1

.ltorg
.align

@row 1: Atk, Hit, Avo
@row 2: Def, Crit, CEV

DrawRtextStatValues:
push {r4-r6, lr}
mov r5, r0						@proc
ldr r4, =0x0203e7ac				@text buffer

mov r0, #0x29					@unit1 = r0
ldrb r0, [r5, r0]
mov r1, #0x2a					@unit2 = r1
ldrb r1, [r5, r1]
mov r2, #0x2b					@point total = r2
ldrb r2, [r5, r2]

bl GetBonusesFromTable
mov r5, r0 						@bonuses pointer. if return address is 0, then dont try to load bytes from it

@Internal order of bonuses:
@ 0=atk 1=def 2=hit 3=avoid 4=crit 5=cev

@r0=buffer, r1= x pos, r2= y pos, r3= number
@should probably use a buffer to store the support bonuses and just load from that byte by byte
@for testing im just gonna hardcode some numbers

@atk
mov r3, #0x0
cmp r5, #0x0
beq DrawAtk
	ldrb r3, [r5, #0x0]
DrawAtk:
mov r0, r4
mov r1, #0x1a						@was 0x1f. Need to scoot more.
mov r2, #0x7
blh Text_InsertNumberOr2Dashes

@hit
mov r3, #0x0
cmp r5, #0x0
beq DrawHit
	ldrb r3, [r5, #0x2]
DrawHit:
mov r0, r4
mov r1, #0x42						@was 0x4c. Need to scoot more.
mov r2, #0x7
blh Text_InsertNumberOr2Dashes

@avo
mov r3, #0x0
cmp r5, #0x0
beq DrawAvo
	ldrb r3, [r5, #0x3]
DrawAvo:
mov r0, r4
mov r1, #0x78						@was 0x81
mov r2, #0x7
blh Text_InsertNumberOr2Dashes

add r4, #0x8					@move to next line

@def
mov r3, #0x0
cmp r5, #0x0
beq DrawDef
	ldrb r3, [r5, #0x1]
DrawDef:
mov r0, r4
mov r1, #0x1a
mov r2, #0x7
blh Text_InsertNumberOr2Dashes

@crit
mov r3, #0x0
cmp r5, #0x0
beq DrawCrt
	ldrb r3, [r5, #0x4]
DrawCrt:
mov r0, r4
mov r1, #0x42
mov r2, #0x7
blh Text_InsertNumberOr2Dashes

@crit avo
mov r3, #0x0
cmp r5, #0x0
beq DrawCev
	ldrb r3, [r5, #0x5]
DrawCev:
mov r0, r4
mov r1, #0x78
mov r2, #0x7
blh Text_InsertNumberOr2Dashes

pop {r4-r6}
pop {r0}
bx r0

.ltorg
.align

GetBonusesFromTable:
push {r4-r7, lr}
mov r4, r0 						@unit1
mov r5, r1						@unit2
mov r6, r2						@point total

cmp r2, #0xF0
ble CheckB
	mov r6, #0x3		@ A
	b ContinueGetBonusTable
CheckB:
cmp r2, #0xA0
ble CheckC
	mov r6, #0x2		@ B
	b ContinueGetBonusTable
CheckC:
cmp r2, #0x50
ble NoSupportLevel
	mov r6, #0x1		@ C
	b ContinueGetBonusTable
NoSupportLevel:
	mov r0, #0x00
	mov r1, #0x00
	mov r2, #0x00
	b EndGetSupportBonusTableEntry

ContinueGetBonusTable:
ldr r7, SupportBonusTable
sub r7, r7, #20
StartSupportBonusLoop:
add r7, r7, #20
ldr r1, [ r7 ]
mov r0, #0x00
cmp r1, #0x00
beq EndGetSupportBonusTableEntry @ End if the end of the bonus table was reached.
	ldrb r0, [ r7 ] @ First character in the bonus table.
	ldrb r1, [ r7, #0x01 ] @ Second character in the bonus table.
	cmp r0, r4
	bne NotFirstSupporting
		cmp r1, r5
		bne StartSupportBonusLoop
		b SupportBonusLoopSuccess
	NotFirstSupporting:
	cmp r0, r5
	bne StartSupportBonusLoop
		cmp r1, r4
		bne StartSupportBonusLoop
	SupportBonusLoopSuccess: @ r7 = entry in the table for these 2 characters.
	add r7, r7, #0x02 @ Remove character IDs.
	sub r0, r6, #0x01
	mov r1, #0x06
	mul r0, r1 @ Get entry for this support level.
	add r0, r0, r7
	
EndGetSupportBonusTableEntry:
@Return pointer in r0

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

SupportBonusTable:
@POIN SupportBonusTable
