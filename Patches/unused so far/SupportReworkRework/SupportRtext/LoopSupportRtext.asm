.thumb

.equ UpFunc, 0x08089354
.equ DownFunc, 0x08089384
.equ LeftFunc, 0x080893B4
.equ RightFunc, 0x080893E4

/*
GetSupportPartnerID: @r0 = character struct, r1 = counter
push {lr}
ldr r0, [r0] @ROM data
ldr r0, [r0, #0x2C] @support partner pointer
cmp r0, #0x00
beq NoSupportPartnerID
	add r0, r0, r1
	ldrb r0, [r0, #0x0]
	b EndGetSupportPartnerID
NoSupportPartnerID:
mov r0, #0x00
EndGetSupportPartnerID:
pop {r1}
bx r1
*/

/*
Might need to assemble a list of supports which are >50 and navigate based on that.
*/

PUSH {r4,r5,r6,lr}   //StatusRMenu_Item0Loop
MOV r4, r0 //proc address
LDR r5, =0x02003BFC //(Stat Screens StatScreenStruct )
LDR r0, [r5, #0xC] //(gpStatScreenUnit )
ldr r1, [r0]
ldr r0, [r1, #0x2C]	//support data

CMP r0, #0x0 //does this unit have supports?
BNE label1
	NoSupportFound:
    MOV r0, r4  //if no support, get proc address back and go to one of the 3 funcs
    ldr r3, =LeftFunc+1
	bl JumpWithR3
	b ExitFunc
label1:
LDR r1, [r5, #0xC] //(gpStatScreenUnit )
LDR r0, [r4, #0x2C] //rtext data?
LDRH r0, [r0, #0x12] //slot no.
mov r2, r1
add r2, #0x32				//start of support data
mov r5, r0					//save the slot no. in r5

mov r6, #0x0
sub r6, #0x1
LoopStart:
	add r6, #0x1
	cmp r6, #0x7
	bge NoDisplayedSupport
		ldrb r3, [r2, r6]	//support level
		cmp r3, #0x50
		ble LoopStart
	add r6, r5				//r5 is offset from first displayed support

ldrb r0, [r2, r6] //just the byte is fine

//once support level is in r0..
CMP r0, #0x50 //is the support high enough to display?
BGT ExitFunc //if so, just act according to Rtext map and exit

//If moving to an item that doesn't exist
NoDisplayedSupport:
    MOV r0 ,r4 //proc storage
    ADD r0, #0x50 //direction moved
    LDRH r0, [r0, #0x0]
    CMP r0, #0x0
    BEQ NotDown
        CMP r0, #0x10 
        BEQ NotDown
            CMP r0, #0x40
            BNE CheckIfDown
		NotDown:
        MOV r0 ,r4
		ldr r3, =UpFunc+1
		bl JumpWithR3
        B ExitFunc

	CheckIfDown:
    CMP r0, #0x80
    BNE ExitFunc
        MOV r0 ,r4 //get proc storage
		ldr r3, =DownFunc+1
		bl JumpWithR3
ExitFunc:
POP {r4,r5,r6}
POP {r0}
BX r0

.align
.ltorg

JumpWithR3:
bx r3

.align

SpellsGetter:
@POIN SpellsGetter
