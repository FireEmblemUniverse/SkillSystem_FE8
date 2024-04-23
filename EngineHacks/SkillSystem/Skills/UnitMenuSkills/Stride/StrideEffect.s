.thumb

@Stride effect: boosts mov of all allied units by +3 within a 3 tile radius
@Todo: add 'boost' animation effect like when using a barrier staff, for all units in range.
@Todo: make the command conditional, like one or twice a map?

.equ StrideMarker, 0x203F101
.equ GetUnit, 0x8019430

push {lr}
ldr r2, =StrideMarker
mov r3, #16
strb r3, [r2]
ldr r2, =0x8023E58   @chest effect - we choose this as it doesn't require combat
mov lr, r2
.short 0xf800
push {r0-r7}

ldr r4, =0x3004E50   @load the address of the active unit
ldr r4,[r4]          @load the unit struct stored at this address

@get list of all allied units in range
ldr r0, GetUnitsInRange
mov lr,r0
mov r0,r4
mov r1,#0x0          @check for same allegiance
mov r2,#0x3          @check if unit is in 3 tiles of active unit
.short 0xf800        @return list of unit ids that meet this criteria in r0

mov r6, r0           @r0 contains the active list of units in tange
Loop:                @start loop
ldrb r0,[r6]         @load the unit ID
cmp	r0,#0            @check if it's 0
beq	End              @if so, we have no more units to check
ldr	r1,=GetUnit	     @otherwise, get the character from the ID data
mov	lr,r1            @now move the address in r1 into the link register
.short	0xf800		 @now branch to the address, r0 = pointer to unit in ram
ldrb r1,[r0,#0x1D]   @load movement bonus
add  r1,#3           @increase the bonus by 3
strb r1,[r0,#0x1D]   @store the new bonus
add	r6,#1            @increment the list of units in range
b	Loop             @continue the loop

End:
pop {r0-r7}
pop {r1}
bx r1

.align
.ltorg
GetUnitsInRange:
