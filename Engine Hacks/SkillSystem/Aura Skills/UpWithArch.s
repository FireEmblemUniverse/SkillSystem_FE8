@Spur Def: adjacent allies gain +4 defense in combat.
.equ UpWithArchID, AuraSkillCheck+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov	r4, r0
mov	r5, r1

CheckName:
ldr	r0,[r4]
ldrh	r0,[r0]
ldr	r1,=#0x815D48C
lsl	r0,#2
add	r0,r1
ldr	r0,[r0]
ldrb	r1,[r0]
cmp	r1,#0x41
bne	Done
ldrb	r1,[r0,#1]
cmp	r1,#0x72
bne	Done
ldrb	r1,[r0,#2]
cmp	r1,#0x63
bne	Done
ldrb	r1,[r0,#3]
cmp	r1,#0x68
bne	Done

CheckSkill:
@now check for the skill
ldr	r0, AuraSkillCheck
mov	lr, r0
mov	r0, r4 @attacker
ldr	r1, UpWithArchID
mov	r2, #0 @can_trade
mov	r3, #1 @range
.short	0xf800
mov	r5, #0x00
mov	r6, r1
mov	r7, #0x00
cmp	r0, #0
beq Done

Loop:
ldrb	r0, [r6,r5]
cmp	r0, #0x00
beq	StoreMight
@testing
ldr	r3,=#0x8019430	@gets character ram pointer
mov	lr, r3
.short	0xf800
ldr	r3,=#0x80191B0	@gets character power
mov	lr, r3
.short	0xf800
add	r7, r0		@add character power to total
ldrb	r0, [r6,r5]
ldr	r3,=#0x8019430	@gets character ram pointer
mov	lr, r3
.short	0xf800
ldr	r3,=#0x8016B28	@gets character weapon id and uses
mov	lr, r3
.short	0xf800
ldr	r3,=#0x80175DC	@gets weapon might from weapon short
mov	lr, r3
.short	0xf800
add	r7, r0		@add to total
add	r5, #0x01
b	Loop

StoreMight:
lsr	r7, #0x01	@divide total by 2
add	r4, #0x5A
ldrh	r0, [r4]	@load damage
add	r0, r7		@add total to damage
strh	r0, [r4]	@store damage

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD UpWithArchID
