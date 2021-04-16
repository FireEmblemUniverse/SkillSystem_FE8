.thumb

.align 4
.macro blh to, reg=r5
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ GetStringFromIndex, 0x0800a240
.equ Text_InsertString, 0x08004480
.equ ReturnValue, 0x2 				@0-based index of how many lines of text are used

@hook at 89f70

mov r1, r0
cmp r1, #0x1
beq WeaponType
	cmp r1, #0x0
	beq NormalType
		cmp r1, #0x2
		beq StaffType
			cmp r1, #0x3
			beq SaveType
				cmp r1, #0x4
				beq SupportType
					b NotFound
				SupportType:	@custom
				mov r0, r5	@proc
				bl DrawRtextStatLabels
				mov r1, #ReturnValue			@not sure what this does just yet
				b NormalType
			SaveType:	@89fac
			ldr r1, =0x08099fad
			bx r1
		StaffType:	@89fa4
		ldr r1, =0x08089fa5
		bx r1
	NormalType:  @89f8e
	mov r0, r5
	add r0, #0x64
	strh r1, [r0]
	b NotFound
WeaponType:  @89f96
ldr r1, =0x08089f97
bx r1

NotFound:
ldr r1, =0x08089fb9
bx r1

.ltorg
.align

@row 1: Atk (4f3), Hit (4f4), Avo (4f5)
@row 2: Def (4ef), Crit (501), CEV (81 unless it doesnt fit lol)

@row 1: Atk, Hit, Avo
@row 2: Def, Crit, CEV

DrawRtextStatLabels:
push {r4, r5, lr}

ldr r4, =0x0203e7ac			@text buffer?
@when we call Text_InsertString, buffer goes in r0, x offset r1, 0x08 r2, stringID r3

@Atk
ldr r0, =0x4f3
blh GetStringFromIndex
mov r3, r0
mov r0, r4
mov r1, #0x0
mov r2, #0x8
blh Text_InsertString

@Hit
ldr r0, =0x4f4
blh GetStringFromIndex
mov r3, r0
mov r0, r4
mov r1, #0x25				@was 2a. Need to scoot more.
mov r2, #0x8
blh Text_InsertString

@Avo
ldr r0, =0x4f5
blh GetStringFromIndex
mov r3, r0
mov r0, r4
mov r1, #0x4d				@was 57. Need to scoot more.
mov r2, #0x8
blh Text_InsertString

@Move to second row
add r4, #0x8

@Def
ldr r0, =0x4ef
blh GetStringFromIndex
mov r3, r0
mov r0, r4
mov r1, #0x0				
mov r2, #0x8
blh Text_InsertString

@Crit
ldr r0, =0x501
blh GetStringFromIndex
mov r3, r0
mov r0, r4
mov r1, #0x25
mov r2, #0x8
blh Text_InsertString

@CritAvo
ldr r0, =0x51E
blh GetStringFromIndex
mov r3, r0
mov r0, r4
mov r1, #0x4d
mov r2, #0x8
blh Text_InsertString

mov r0, #ReturnValue

pop {r4, r5}
pop {r1}
bx r1

.ltorg
.align
