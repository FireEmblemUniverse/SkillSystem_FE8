@0x8031B8A is where the opcode that stores the weapon for the player from r0
@strh r0,[r4,#0x1A]
@I may need to start at 0x08031B84

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ ConcealedWeaponID, SkillTester+4
.equ ReturnPoint,0x8031B8D
.equ MakeItem, 0x8016540
.equ CurrentUnit, 0x3004E50

.thumb

ldrb r0,[r0]
blh  MakeItem, r1

push {r1-r7}
push {r0}
ldr r5,=CurrentUnit         @load the current unit pointer
ldr r5,[r5]                 @load their struct
ldr r0, SkillTester
mov lr, r0
mov r0, r5                  @unit data
ldr r1, ConcealedWeaponID
.short 0xf800
cmp r0, #0
beq SaveDefault

ldrh r0,[r5,#0x1E]          @overwrite the default weapon with the unit's first equipped weapon
strh r0,[r4,#0x1A]          @save that weapon as the one to bring into the arena
pop {r0}
b    End

SaveDefault:
pop {r0}
strh r0,[r4,#0x1A]          @save the default weapon

End:
pop {r1-r7}
ldr r0,=ReturnPoint
bx r0

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD ConcealedWeaponID
