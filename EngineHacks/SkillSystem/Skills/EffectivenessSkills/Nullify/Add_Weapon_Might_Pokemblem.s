.thumb

@called from 2AAEC

.equ origin, 0x802AAEC			@unused now I think
@.equ Check_Effectiveness, . + 0x16BEC - origin
.equ Check_Effectiveness,  0x8016BEC
.equ Next, . + 0x802AB4A - origin	@unused now I think
 
@r6=attacker, r8=defender, r4=attacker+0x5A (attack)

push { r14 }

mov		r5,#0
cmp		r0,#0
beq		Label1
mov		r5,r0
Label1:
ldrh	r0,[r7]		@attacker's item
mov		r1,r8
ldr r3,=Check_Effectiveness 	@added
mov r14,r3			@added
.short 0xF800			@added
cmp		r0,#0
beq		NoEffectiveness
cmp		r0,r5
ble		NoEffectiveness
mov		r5,r0
NoEffectiveness:
mov		r0,#0
ldsh	r0,[r4,r0]	@current attack
cmp		r5,#0
beq		Exit




cmp r5, #9
beq Neutral
cmp r5, #7
beq Ineffective
cmp r5, #2
beq Ineffective
cmp r5, #1
beq Immune


SuperEffective:
@supereffective (+60 hit, +30 avo)
mov r3, #0x53		@0x53	Byte	Weapon triangle hit adv effect
mov r2, r6		@attacker battle struct	
ldsb r2, [r6, r3] 	@hit 
add r2, r2, #60		@+60 hit attacker 

cmp r2, #128
blt DontCapHitSinceUnder255  
mov r2, #127
DontCapHitSinceUnder255:

strb r2, [r6, r3] 	@put our hit back into attacker battle struct



mov r3, #0x62 		@0x62 entry as attacker's avoid
mov r2,r6 		@attacker battle struct					
ldsh r2, [r6, r3] 	@avo
add r2, r2, #30		@+30 avo attacker

cmp r2, #127 
blt DontCapAvoSinceUnder127  
mov r2, #127 
DontCapAvoSinceUnder127:


strh r2, [r6, r3] 	@put our avo back into attacker battle struct



mov		r0,#0
ldsh	r0,[r4,r0]	@current attack (only has weapon might so far)

b		Exit

Neutral:		@failsafe, unnecessary
b		Exit

Ineffective:
mov r3, #0x53		@0x53	Byte	Weapon triangle hit adv effect
mov r2, r6		@attacker battle struct	
ldsb r2, [r6, r3] 	@hit 

@ no need to cap afaik 
@ well probably need to if it started at values other than 0 

sub r2, r2, #40		@-40 hit attacker 
strb r2, [r6, r3] 	@put our hit back into attacker battle struct
mov		r0,#0
ldrh	r1,[r4,r0]	@current attack
lsr r1, #1
sub r0, r1 
mov		r0,#0
ldsh	r0,[r4,r0]	@current attack

b		Exit



MuchIneffect:
mov r3, #0x53		@0x53	Byte	Weapon triangle hit adv effect
mov r2, r6		@attacker battle struct	
ldsb r2, [r6, r3] 	@hit 
sub r2, r2, #60		@-45 hit attacker 
strb r2, [r6, r3] 	@put our hit back into attacker battle struct
mov		r0,#0
ldsh	r1,[r4,r0]	@current attack
add r2, r1, #1 @ bad rounding 
lsr r2, #2 @ 1/4
lsr r1, #1 @ 1/2 
add r1, r2 @ 3/4 to take away 

sub r0, r1 
b		Exit

Immune:
b Ineffective
mov r3, #0x53		@0x53	Byte	Weapon triangle hit adv effect
mov r2, r6		@attacker battle struct	
ldsb r2, [r6, r3] 	@hit 
sub r2, r2, #80		@-60 hit attacker 
strb r2, [r6, r3] 	@put our hit back into attacker battle struct
mov r2, #0 
mov		r0,#0
ldsh	r1,[r4,r0]	@current attack
lsl r1, #1 @ no idea why 
sub r0, r1 
b		Exit

Exit:
mov		r5,r0
b		GoBack

GoBack:
pop {r1}
bx    r1
