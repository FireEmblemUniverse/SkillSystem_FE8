.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ GetItemAttributes, 0x0801756C
.equ GetItemWType, 0x08017548
.equ IsItemCoveringRange, 0x08016B8C

@NOTE: if you are using Teraspark's Range Fixes, replace any calls to IsItemCoveringRange/16B8C to Tera_Can_Attack_Target_Func (and include the pointer to it in your EA file)

@ hooks at 2A8BC	
	
	push {r3}				@to be safe
	CheckCurrentWeapon:		@Start loop for weapon checking.
    LDRH r0, [r4, #0x0]		@item ID 
    LDR r1, =0x0203A4D4 	@some battle buffer
    LDRB r1, [r1, #0x2] 	@(Appears to be range)
    MOV r2 ,r5				@battle struct
	mov r4, #0x0			@initialize counter

	ldr r3, Tera_Can_Attack_Target_Func		  	@tera's IsItemCoveringRange r0=item r1=range r2=struct
	mov lr, r3
	.short 0xf800

    CMP r0, #0x0
    BEQ CheckNextWeapon		//this is where we loop for best possible weapon.

        MOV r1, r8
        LDRB r0, [r1, #0x0]
        CMP r0, #0xFE	@ballista flag idk
        BNE StatusChecks
		
		CantCounter:
		mov r4, r5
		add r4, #0x48
        MOV r1, #0x0
        MOV r0, #0x0
        STRH r0, [r4, #0x0]
        MOV r0, r9
        STRB r1, [r0, #0x0]
		B StatusChecks
		
	CheckNextWeapon:	
	//counter is r4
	add r4, #0x1
	cmp r4, #0x4
	bgt CantCounter			@this should check spell menu too but w/e
	lsl r4, r4, #0x1
	mov r0, r5
	add r0, #0x1E
	add r0, r0, r4
	ldrh r0, [r0, #0x0]		@get item from inventory position
	LDR r1, =0x0203A4D4 	@some battle buffer
    LDRB r1, [r1, #0x2] 	@(Appears to be range)
    MOV r2 ,r5				@battle struct

	ldr r3, Tera_Can_Attack_Target_Func		  	@tera's IsItemCoveringRange r0=item r1=range r2=struct
	mov lr, r3
	.short 0xf800

    CMP r0, #0x0
	BEQ CheckNextWeapon
	
		StoreSuccessfulWeaponFind:
		MOV r1, r8
        LDRB r0, [r1, #0x0]
        CMP r0, #0xFE	@ballista flag idk
        BEQ CantCounter
			mov r2, r5
			add r2, #0x51			@equipped weapon slot
			mov r3, r5
			add r3, #0x48
			mov r0, r5
			add r0, #0x1E
			add r0, r0, r4
			ldrh r0, [r0, #0x0]		@get item from inventory position
			lsr r4, r4, #0x1		@convert this back to 1-based
			strb r4, [r2, #0x0]		@store item slot
			strh r0, [r3, #0x0]		@store weapon
			add r3, #0x2
			strh r0, [r3, #0x0]		@store weapon to after battle
			blh GetItemAttributes
			str r0, [r5, #0x4c]
			mov r4, r5
			add r4, #0x48
			ldrh r0, [r4]
			blh GetItemWType
			mov r6, r5
			add r6, #0x50
			strb r0, [r6]
		
	StatusChecks:
	mov r4, r5
	add r4, #0x48
	
	//jump back to vanilla @2A8DF
	pop {r3}
	ldr r1, =0x802A8DF
	bx r1

.ltorg
.align
	
Tera_Can_Attack_Target_Func:
@POIN Tera_Can_Attack_Target_Func
