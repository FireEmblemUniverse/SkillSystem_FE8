.thumb
.align

.equ BG2Buffer, 0x02023CA8
.equ FillBgMap, 0x08001221
.equ EnableBgSyncByIndex, 0x08001FBD
.equ UnitDecreaseItemUse, 0x08018995

.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

@FillBgMap(BG2Buffer, 0);
@EnableBgSyncByIndex(0);
@EnableBgSyncByIndex(1);
@EnableBgSyncByIndex(2);

.global AdeptPrepScrollUsageEffect
.type AdeptPrepScrollUsageEffect, %function
AdeptPrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=AdeptIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

.global WrathPrepScrollUsageEffect
.type WrathPrepScrollUsageEffect, %function
WrathPrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=WrathIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

.global SolPrepScrollUsageEffect
.type SolPrepScrollUsageEffect, %function
SolPrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=SolIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

.global RenewalPrepScrollUsageEffect
.type RenewalPrepScrollUsageEffect, %function
RenewalPrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=RenewalIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

.global PavisePrepScrollUsageEffect
.type PavisePrepScrollUsageEffect, %function
PavisePrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=PaviseIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

.global PassPrepScrollUsageEffect
.type PassPrepScrollUsageEffect, %function
PassPrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=PassIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

.global ParagonPrepScrollUsageEffect
.type ParagonPrepScrollUsageEffect, %function
ParagonPrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=ParagonIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

.global NullifyPrepScrollUsageEffect
.type NullifyPrepScrollUsageEffect, %function
NullifyPrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=NullifyIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

.global NihilPrepScrollUsageEffect
.type NihilPrepScrollUsageEffect, %function
NihilPrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=NihilIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

.global LunaPrepScrollUsageEffect
.type LunaPrepScrollUsageEffect, %function
LunaPrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=LunaIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

.global CantoPlusPrepScrollUsageEffect
.type CantoPlusPrepScrollUsageEffect, %function
CantoPlusPrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=CantoPlusIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

.global BoonPrepScrollUsageEffect
.type BoonPrepScrollUsageEffect, %function
BoonPrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=BoonIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

.global AstraPrepScrollUsageEffect
.type AstraPrepScrollUsageEffect, %function
AstraPrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=AstraIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

.global AegisPrepScrollUsageEffect
.type AegisPrepScrollUsageEffect, %function
AegisPrepScrollUsageEffect:

@push {r4-r7,r14}

@r4 = unit pointer
@r6 = item used
@r7 = item slot

mov r0,r4 @r0 = char
ldr r1,=AegisIDLink
ldrb r1,[r1] @r1 = skill ID

@now learn the skill specified in item uses

blh SkillAdder+1

mov r0,r4
mov r1,r7

blh UnitDecreaseItemUse

ldr r0,=SkillScrollMessageReturnLink
ldrh r0,[r0]

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

