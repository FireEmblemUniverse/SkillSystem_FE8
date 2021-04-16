.thumb
@r0 is 020251C8 or 2025234. seems to be a proc address so exact place doesnt matter

/*
funcs: 89c40, 89cd4 (for drawing the info list in item box)
proc: a01650 (pointer at 8a114, 8a0fc spawns it, called by 88e9c)
help box stuff is a bit weird because hardcoded

so at help box proc+4E there's an item (short). Could be 0 (that's the case for most help boxes), could also be -2/0xFFFE which is I think used for savemenu help text that displays some info on save; but otherwise it's an item. func FE8U:080892D0 ('GetItemHelpBoxKind') gets a constant 0 to 3 based on that value (it returns 3 for 0xFFFE and otherwise interprets the value as an item and returns 0 (no info), 1 (weapon) or 2 (staff)).

So to display custom stuff the 'proper' way you'd have to hack that to return 4 or something and also hack all the functions that handle the result of that; and then also make sure that +4E is the value you want (like 0xFFFD or something).

functions that call that are ;X_FE8U:080891AC (sets up size of box); X_FE8U:08089320 (sets text id for desc); FE8U:08089F58 (draws labels and sets starting line for desc) and FE8U:08089FCC (draws actual stat values, idk why it's done at a different point)

*/

//891ac: we don't want it going to 891DE. 
//need 0x80 in r4 and 0x20 in r5 once we hit 89200. 891d4 to bge should work

//89f58: just hook at 89F70, you can BX back to the vanilla BLs and for 0x04 you can BL to a custom func in the same file.

//here's the plan: 0x4E will hold some value which indicates this is to be used for supports (0xFFFD?)
//0x29, 0x2a, 0x2b can store unitID1, unitID2, and support level

push {r4,r5,r6,lr}   				//StatusRMenu_Item0Getter
mov r4 ,r0
ldr r0, =0x02003BFC 		//(Stat Screens StatScreenStruct )
ldr r1, [r0, #0xC] 			//(gpStatScreenUnit - our guy)
ldr r0, [r4, #0x2C]
ldrh r0, [r0, #0x12]		//slot no.
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

//r6 is now our support index.
mov r5, r1 					//r5 is now our unit data

ldr r0, =0xFFFD				//flag to draw support bonuses in the box
MOV r1 ,r4					//proc code
ADD r1, #0x4E
STRH r0, [r1, #0x0]			//flag for rtext
mov r1, r4
add r1, #0x29
ldr r0, [r5, #0x0]
ldrb r0, [r0, #0x4]
strb r0, [r1, #0x0]			//support partner 1 (this unit) in 0x29
add r1, #0x1

ldr r3, [r5, #0x0]			//character ROM data
mov r0, #0x2c				//support data
ldr r0, [r3, r0]
ldrb r0, [r0, r6]			//character at support index r6

strb r0, [r1, #0x0]			//support partner 2 (partner unit) in 0x2a
add r1, #0x1
ldrb r3, [r2, r6]
strb r3, [r1, #0x0]			//support points total in 0x2b

//test value, will be overwritten
//ldr r0, =0x140
//add r0, r6
ldr r0, =0x46b

ADD r4, #0x4C
STRH r0, [r4, #0x0]			//text ID for rtext
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
