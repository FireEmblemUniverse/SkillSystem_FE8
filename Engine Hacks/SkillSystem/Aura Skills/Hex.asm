
.thumb

.global Hex
.type Hex, %function
Hex: @r0, r1 are battle structs
push { r4, r5, lr }
mov r4, r0
mov r5, r1
ldr r0, =AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, =HexIDLink
ldrb r1, [ r1 ]
mov r2, #3 @are enemies
mov r3, #1 @range
.short 0xf800
cmp r0, #0x00
beq End

mov r1, #0x62
ldrh r0, [ r4, r1 ]
sub r0, r0, #15
strh r0, [ r4, r1 ]

End:
pop { r4, r5 }
pop { r0 }
bx r0
