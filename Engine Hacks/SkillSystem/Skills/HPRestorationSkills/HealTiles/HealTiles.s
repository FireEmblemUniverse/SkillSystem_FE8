.thumb
.align


.global HealTiles
.type HealTiles, %function



HealTiles:
push {r4-r6,r14}
mov r4,r0 @r4 = unit
mov r5,r1 @r5 = heal %

ldr r0, =#0x0202BCF0
ldrb r0, [ r0, #0x0E ]
@blh GetChapterEvents, r1
ldr r1, =#0x080346B0
mov lr, r1
.short 0xF800
ldr r3, [ r0, #0x20 ] @ Pointer to trap data in r3.
sub r3, #6
ldrb r0, [ r4, #0x10 ] @ X coordinate of current unit in r0
ldrb r1, [ r4, #0x11 ] @ Y coordinate of current unit in r1
ldr r6, =HealTrapIDLink
ldrb r6, [ r6 ]

BeginHealingTileLoop:
add r3, #6
ldrh r2, [ r3 ]
cmp r2, #0x00
beq GoBack @ If this is an ENDTRAP, end.
ldrb r2, [ r3 ]
cmp r2, r6
bne BeginHealingTileLoop @ If this isn't an 0x23, loop back and try again.
ldrb r2, [ r3, #1 ]
cmp r0, r2
bne BeginHealingTileLoop @ If the X coordinates don't match up, loop back.
ldrb r2, [ r3, #2 ]
cmp r1, r2
bne BeginHealingTileLoop @ If the Y coordinates don't match up, loop back.
push { r0, r1, r3 }
ldrb r0, [ r3, #5 ] @ Event ID of this one in r0.
ldr r1, =#0x08083DA8
mov lr, r1
.short 0xF800
cmp r0, #0x01
pop { r0, r1, r3 }
beq BeginHealingTileLoop @ If the event ID is set, loop back.

@ If I'm here, this unit is on a good healing tile. Spooky.

ldrb r2, [ r3, #4 ] @ Percent healed in r2
add r5, r2, r5 @ Add to the main healing percentage.

@346B0: (Get_Chapter_Events) (FE8J: 345B8) (FE7: 315BC)
@Params: r0=chapter number
@Returns: Pointer to that chapter's events

@83DA8: (Check_Event_ID) (FE7: 798F8) (FE8J: 860D0) (FE6: 6BA5C)
@Params: r0=event id to check
@Returns: True if event id is set


GoBack:
mov r0,r5
pop {r4-r6}
pop {r1}
bx r1

.ltorg
.align

