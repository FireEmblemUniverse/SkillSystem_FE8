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
beq		Label2
cmp		r0,r5
ble		Label2
mov		r5,r0
Label2:
mov		r0,#0
ldsh	r0,[r4,r0]	@current attack
cmp		r5,#0
beq		Label3

cmp r5, #9
beq Neutral
cmp r5, #7
beq Ineffective
cmp r5, #2
beq MuchIneffect
cmp r5, #1
beq Immune

@add stuff here
@supereffective (+30 hit, +15 avo)
mov r3, #0x53		@0x53	Byte	Weapon triangle hit adv effect
mov r2, r6		@attacker battle struct	
ldrb r2, [r6, r3] 	@hit 
add r2, r2, #30		@+30 hit attacker 

cmp r2, #255
blt DontCapHitSinceUnder255  
mov r2, #255
DontCapHitSinceUnder255:

strb r2, [r6, r3] 	@put our hit back into attacker battle struct

mov r3, #0x62 		@0x62 entry as attacker's avoid
mov r2,r6 		@attacker battle struct					
ldsh r2, [r6, r3] 	@avo
add r2, r2, #15		@+15 avo attacker

cmp r2, #127 
blt DontCapAvoSinceUnder127  
mov r2, #127 
DontCapAvoSinceUnder127:


strh r2, [r6, r3] 	@put our avo back into attacker battle struct

@mov r3, #0x5A 		@0x62 entry as attacker's attack
@mov r2,r6 		@attacker battle struct					
@ldsh r2, [r6, r3] 	@atk
@lsl r2,r2,#0x1		@2x attack
@strh r2, [r6, r3] 	@put our avo back into attacker battle struct
@mov		r5,r0 	@remove 2x MT
mov r5, #4 @ just 2x mt 

mov r3, #0x5C 		@0x64 entry as attacker's def/res
mov r2,r6 		@attacker battle struct					
ldsh r2, [r6, r3] 	@
add r2, r2, #5		@+5 def/res attacker

cmp r2, #127 
blt DontCapDefResSinceUnder127  
mov r2, #127 
DontCapDefResSinceUnder127:

strh r2, [r6, r3] 	@put our def/res back into attacker battle struct

mul		r0,r5
lsr		r0,#1

b		Label3

Neutral:		@failsafe, unnecessary
b		Label3

Ineffective:
mov r3, #0x53		@0x53	Byte	Weapon triangle hit adv effect
mov r2, r6		@attacker battle struct	
ldsb r2, [r6, r3] 	@hit 

@ no need to cap afaik 
@ well probably need to if it started at values other than 0 

sub r2, r2, #30		@-30 hit attacker 
strb r2, [r6, r3] 	@put our hit back into attacker battle struct
sub r0, #3
b		Label3



MuchIneffect:
mov r3, #0x53		@0x53	Byte	Weapon triangle hit adv effect
mov r2, r6		@attacker battle struct	
ldsb r2, [r6, r3] 	@hit 
sub r2, r2, #45		@-45 hit attacker 
strb r2, [r6, r3] 	@put our hit back into attacker battle struct
sub r0, #6
b		Label3

Immune:
mov r3, #0x53		@0x53	Byte	Weapon triangle hit adv effect
mov r2, r6		@attacker battle struct	
ldsb r2, [r6, r3] 	@hit 
sub r2, r2, #60		@-60 hit attacker 
strb r2, [r6, r3] 	@put our hit back into attacker battle struct
sub r0, #45		@-45 dmg if 'immune' 
b		Label3

Label3:
mov		r5,r0
b		GoBack

GoBack:
pop {r1}
bx    r1
