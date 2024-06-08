.thumb

.equ GoddessDanceMarker, 0x203F101
.equ GetUnit, 0x8019430
.equ ActionStruct, 0x203A958

push {lr}
mov r0, #1           @the byte for the 'wait' acition
ldr r1,=ActionStruct @load the action struct
strb r0,[r1,#0x11]   @store the action take as 
mov r0, #0x17        @makes the unit wait?? makes the menu disappear after command is selected??
push {r0-r7}

ldr r4, =0x3004E50   @load the address of the active unit
ldr r4,[r4]          @load the unit struct stored at this address

@get list of all allied units in range
ldr r0, GetUnitsInRange
mov lr,r0
mov r0,r4
mov r1,#0x0          @check for same allegiance
mov r2,#0x1          @check if unit is in 1 tile of active unit (adjacent)
.short 0xf800        @return list of unit ids that meet this criteria in r0
cmp r0, #1           @check if GetUnitsInRange returned anything (1 is the active unit, so anything greater will mean allies)
ble End              @if not, branch to the end
mov r6, r0           @r0 contains the active list of units in range

Loop:                @start loop
ldrb r0,[r6]         @load the unit ID
cmp	r0,#0            @check if it's 0
beq	End              @if so, we have no more units to check
ldr	r1,=GetUnit	     @otherwise, get the character from the ID data
mov	lr,r1            @now move the address in r1 into the link register
.short	0xf800		 @now branch to the address, r0 = pointer to unit in ram
ldr	r2, [r0,#0x0C]	 @status bitfield
mov	r1, #0x42
mvn	r1, r1
and	r2, r1			 @unset bits 0x42
mov	r1, #0x04
lsl	r1, #0x08
orr	r2, r1
str	r2, [r0,#0x0C]
add	r6,#1            @increment the list of units in range
b	Loop             @continue the loop

End:
pop {r0-r7}
pop {r1}
bx r1

.align
.ltorg
GetUnitsInRange:
