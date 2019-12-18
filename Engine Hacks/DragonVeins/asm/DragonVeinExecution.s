.thumb
push {r4, lr}

@Basically the execute event routine.

@But first, we need to find the event associated with this location.
ldr r2, CurrentUnitPointer
ldr r2, [r2]

mov r0, #0x10 @x
mov r1, #0x11 @y
ldsb r0, [r0, r2]
ldsb r1, [r1, r2]

ldr r3, GetTrap
bl goto_r3

mov r4, r0  @&The DV
ldrb r1, [r4, #0x3]     @effect id
lsl r1, #0x2
ldr r0, DVTable
ldr r0, [r0, r1]
mov r1, #0x0            @Fade at the end?
@At this point, r0 should be the pointer to the event to execute.

ldr r3, ExecuteEvent
bl goto_r3

    @check if DV should be removed.
    @ldrb r0, [r4, #6] @nope, can only have 6 bytes per trap data
    @cmp r0, #1
    @bgt ReduceUses

@Remove the DV trap from the map.
mov r0, r4

ldr r3, RemoveTrap
bl goto_r3

@b Continue
@ReduceUses: 
@cmp r0, #0xFF @0xff means infinite use
@beq Continue
@sub r0, #1

Continue:
ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??

pop {r4}
pop {r3}
goto_r3:
bx r3

.align
.ltorg
ExecuteEvent:
	.long 0x800D07D @AF5D
CurrentUnitFateData:
	.long 0x203A958
CurrentUnitPointer:
	.long 0x3004E50
GetTrap:
    .long 0x802E1F1
RemoveTrap:
    .long 0x802EA91
DVTable:
    @.long 0xDEADBEEF @Should be defined in the install file
