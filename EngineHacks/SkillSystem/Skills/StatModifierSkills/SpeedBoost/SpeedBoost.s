@ @SpeedBoost: Gain +1 move per turn up to a maximum of +6

@ .thumb
@ .equ SpeedBoostID, SkillTester+4

@ push {r4-r5, lr}
@ mov	r4, r0 @attacker

@ @has skill
@ ldr	r0, SkillTester
@ mov	lr, r0
@ mov	r0, r4
@ ldr	r1, SpeedBoostID
@ .short	0xf800
@ cmp	r0, #0
@ beq	End

@ @get turn
@ ldr	 r5,=#0x202BCF0
@ ldrh r5, [r5,#0x10]
@ mov	 r0, #0x01
@ sub	 r5, r0
@ cmp	 r5, #0x06
@ bls	 SkipSet
@ mov	 r5, #0x06

@ SkipSet:
@ @add turn to movement bonus (if turn is higher than 6, add 6)
@ mov	 r0, #0x1D
@ ldrb r1, [r4,r0]	@load movement
@ add	 r1, r5		    @add turn to movement (max 6)
@ strb r1, [r4,r0]    @store

@ End:
@ pop	{r4-r5, r15}
@ .align
@ .ltorg
@ SkillTester:
@ @Poin SkillTester
@ @WORD SpeedBoostID


.thumb

.type SpeedBoost, %function 
.global SpeedBoost 
SpeedBoost: 
push {r4-r5, lr} 
mov r4, r0 @ stat value
mov r5, r1 @ unit 

mov r0, r5 
ldr r1, =SpeedBoostID_Link 
ldr r1, [r1] 
bl SkillTester 
cmp r0, #0 
beq Exit2

@get turn
ldr	 r3,=#0x202BCF0
ldrh r3, [r3,#0x10]
mov	 r0, #0x01
sub	 r3, r0
cmp	 r3, #0x06
bls	 SkipSet
mov	 r3, #0x06

SkipSet:
@add turn to movement bonus (if turn is higher than 6, add 6)
add r4, r3

Exit2: 
mov r0, r4 @ value 
mov r1, r5 @ unit 
pop {r4-r5} 
pop {r2} 
bx r2 
.ltorg



