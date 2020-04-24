.thumb
@.equ RenewalID, SkillTester+4
@.equ AuraSkillCheck, RenewalID+4
@.equ AmaterasuID, AuraSkillCheck+4
@.equ CamaraderieID, AmaterasuID+4
@.equ ReliefID, CamaraderieID+4
@.equ BondID, ReliefID+4
@.equ ChapterDataStruct, BondID+4
@.equ GetChapterEvents, ChapterDataStruct+4
@.equ HealTrapID, GetChapterEvents+4

@.equ ChapterDataStruct, #0x0202BCF0
@.equ GetChapterEvents, #0x080346B0
@.equ CheckEventID, #0x08083DA8

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

push {r4 - r6, lr}
ldr r1, Some_Offset
add r0, r0, r1
ldrb r0, [r0]
lsl r0, r0, #0x18
asr r4, r0, #0x18
@That much is copy-paste from vanilla.
@It loads %HP to heal from terrain into r4

@Now check for Renewal skill

ldr r0, =SkillTester
mov lr, r0
mov r0, r5
ldr r1, =RenewalRenewalIDLink
ldrb r1, [ r1 ]
.short 0xf800
cmp r0, #0x0
beq no_renewal
 @add hp
 add r4, #30
no_renewal:

@Now check for Amaterasu
ldr r0, =AuraSkillCheck
mov lr, r0
mov r0, r5 @unit
ldr r1, =RenewalAmaterasuIDLink
ldrb r1, [ r1 ]
mov r2, #0 @same_team
mov r3, #2 @range
.short 0xf800
cmp r0, #0
beq no_amaterasu
add r4, #20 @heal 20% hp

no_amaterasu:

@Now check for Camaraderie
ldr r0, =SkillTester
mov lr, r0
mov r0, r5
ldr r1, =RenewalCamaraderieIDLink
ldrb r1, [ r1 ]
.short 0xf800
cmp r0, #0x0
beq no_camaraderie
  @check for allies in range:
  ldr r0, =AuraSkillCheck
  mov lr, r0
  mov r0, r5 @unit
  mov r1, #0 @always true
  mov r2, #0 @same_team
  mov r3, #2 @range
  .short 0xf800
  cmp r0, #0
  beq no_camaraderie
    @if allies in range, heal 10%
    add r4, #10

no_camaraderie:

@check for relief
ldr r0, =SkillTester
mov lr, r0
mov r0, r5
ldr r1, =RenewalReliefIDLink
ldrb r1, [ r1 ]
.short 0xf800
cmp r0, #0x0
beq no_relief
  @check for allies in range:
  ldr r0, =AuraSkillCheck
  mov lr, r0
  mov r0, r5 @unit
  mov r1, #0 @always true
  mov r2, #0 @same_team
  mov r3, #2 @range
  .short 0xf800
  cmp r0, #0
  bne no_relief
    @if no allies in range, heal 20%
    add r4, #20

no_relief:

@Now check for bond
ldr r0, =AuraSkillCheck
mov lr, r0
mov r0, r5 @unit
ldr r1, =RenewalBondIDLink
ldrb r1, [ r1 ]
mov r2, #0 @same_team
mov r3, #3 @range
.short 0xf800
cmp r0, #0
beq no_bond
add r4, #10 @heal 10% hp

no_bond:

@Now check for forager
ldr	r0, =SkillTester
mov	lr,r0
mov	r0,r5
ldr	r1, =RenewalForagerIDLink
ldrb r1,[r1]
.short 0xf800
cmp	r0,#0x0
beq	no_forager

@check the terrain the unit is on, compare it against the list
ldrb	r0,[r5,#0x10]	@x coord of unit
ldrb	r1,[r5,#0x11]	@y coord of unit
lsl	r1,#2		@y times 4 since it's pointer
ldr	r2,=0x202E4DC	@tile id map pointer
ldr	r2,[r2]		@tile id map offset
ldr	r2,[r2,r1]	@load pointer to y row
ldrb	r0,[r2,r0]	@load x byte of the row, which gets us tile id
ldr	r1, =ForagerList
ForagerLoop:
ldrb	r2,[r1]
cmp	r2,#0
beq	no_forager
cmp	r2,r0
beq	yes_forager
add	r1,#1
b	ForagerLoop

@if on correct terrain, heal 20%
yes_forager:
add	r4,#20

no_forager:

@ Check for healing tiles
ldr r0, =#0x0202BCF0
ldrb r0, [ r0, #0x0E ]
@blh GetChapterEvents, r1
ldr r1, =#0x080346B0
mov lr, r1
.short 0xF800
ldr r3, [ r0, #0x20 ] @ Pointer to trap data in r3.
sub r3, #6
ldrb r0, [ r5, #0x10 ] @ X coordinate of current unit in r0
ldrb r1, [ r5, #0x11 ] @ Y coordinate of current unit in r1
ldr r6, =RenewalHealTrapID
ldrb r6, [ r6 ]

BeginHealingTileLoop:
add r3, #6
ldrh r2, [ r3 ]
cmp r2, #0x00
beq NoHealingTiles @ If this is an ENDTRAP, end.
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
add r4, r2, r4 @ Add to the main healing percentage.

@346B0: (Get_Chapter_Events) (FE8J: 345B8) (FE7: 315BC)
@Params: r0=chapter number
@Returns: Pointer to that chapter's events

@83DA8: (Check_Event_ID) (FE7: 798F8) (FE8J: 860D0) (FE6: 6BA5C)
@Params: r0=event id to check
@Returns: True if event id is set

NoHealingTiles:

@check for Imbue
ldr	r0, =SkillTester
mov	lr,r0
mov	r0,r5
ldr	r1, =RenewalImbueIDLink
.short 0xf800
cmp	r0,#0x0
beq	NoImbue

@add magic stat to r4
mov r0,r5
add r0,#0x3A
ldrb r0,[r0]
add r4,r0


NoImbue:

mov r0, r4 @return the amount healed.
pop {r4 - r6}
pop {r1}
bx r1
.align
Some_Offset:
.long 0x880C744
@SkillTester:
@POIN SkillTester
@WORD RenewalID
@POIN AuraSkillCheck
@WORD AmaterasuID
@WORD CamaraderieID
@WORD ReliefID
@WORD BondID
@WORD ChapterDataStruct
@POIN GetChapterEvents
@WORD HealTileTrapID	
