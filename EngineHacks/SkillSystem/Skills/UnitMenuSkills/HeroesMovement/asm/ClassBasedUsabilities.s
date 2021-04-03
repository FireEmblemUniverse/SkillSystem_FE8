.thumb
.align

.global PivotClassCheck
.type PivotClassCheck, %function

.global RepositionClassCheck
.type RepositionClassCheck, %function

.global SwapClassCheck
.type SwapClassCheck, %function

.global ShoveClassCheck
.type ShoveClassCheck, %function

.global SmiteClassCheck
.type SmiteClassCheck, %function

.global SwarpClassCheck
.type SwarpClassCheck, %function



PivotClassCheck:

push {r4-r7,r14}

@passed unit in r0
mov r4,r0

@check unit's class

ldr r0,[r4,#4]
ldrb r0,[r0,#4] @r0 = class

@get class list 
ldr r1,=PivotClassList

Pivot_LoopStart:
ldrb r2,[r1]
cmp r2,#0
beq Pivot_RetFalse
cmp r2,r0
beq Pivot_RetTrue
add r1,#1
b Pivot_LoopStart

Pivot_RetFalse:
@first, can we allow the skill to work?
ldr r0,=UseSkillCheckSettingLink
ldrb r0,[r0]
cmp r0,#0
beq Pivot_GoBack @if false, return false

@otherwise, do we have the skill?
mov r0,r4
ldr r1,=SkillTester
mov r14,r1
ldr r1,=PivotIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#1
beq Pivot_RetTrue
b Pivot_GoBack

Pivot_RetTrue:
mov r0,#1

Pivot_GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align


RepositionClassCheck:

push {r4-r7,r14}

@passed unit in r0
mov r4,r0

@check unit's class

ldr r0,[r4,#4]
ldrb r0,[r0,#4] @r0 = class

@get class list 
ldr r1,=RepositionClassList

Reposition_LoopStart:
ldrb r2,[r1]
cmp r2,#0
beq Reposition_RetFalse
cmp r2,r0
beq Reposition_RetTrue
add r1,#1
b Reposition_LoopStart

Reposition_RetFalse:
@first, can we allow the skill to work?
ldr r0,=UseSkillCheckSettingLink
ldrb r0,[r0]
cmp r0,#0
beq Reposition_GoBack @if false, return false

@otherwise, do we have the skill?
mov r0,r4
ldr r1,=SkillTester
mov r14,r1
ldr r1,=RepositionIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#1
beq Reposition_RetTrue
b Reposition_GoBack


Reposition_RetTrue:
mov r0,#1

Reposition_GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

SwapClassCheck:

push {r4-r7,r14}

@passed unit in r0
mov r4,r0

@check unit's class

ldr r0,[r4,#4]
ldrb r0,[r0,#4] @r0 = class

@get class list 
ldr r1,=SwapClassList

Swap_LoopStart:
ldrb r2,[r1]
cmp r2,#0
beq Swap_RetFalse
cmp r2,r0
beq Swap_RetTrue
add r1,#1
b Swap_LoopStart

Swap_RetFalse:
@first, can we allow the skill to work?
ldr r0,=UseSkillCheckSettingLink
ldrb r0,[r0]
cmp r0,#0
beq Swap_GoBack @if false, return false

@otherwise, do we have the skill?
mov r0,r4
ldr r1,=SkillTester
mov r14,r1
ldr r1,=SwapIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#1
beq Swap_RetTrue
b Swap_GoBack

Swap_RetTrue:
mov r0,#1

Swap_GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

ShoveClassCheck:

push {r4-r7,r14}

@passed unit in r0
mov r4,r0

@check unit's class

ldr r0,[r4,#4]
ldrb r0,[r0,#4] @r0 = class

@get class list 
ldr r1,=ShoveClassList

Shove_LoopStart:
ldrb r2,[r1]
cmp r2,#0
beq Shove_RetFalse
cmp r2,r0
beq Shove_RetTrue
add r1,#1
b Shove_LoopStart

Shove_RetFalse:
@first, can we allow the skill to work?
ldr r0,=UseSkillCheckSettingLink
ldrb r0,[r0]
cmp r0,#0
beq Shove_GoBack @if false, return false

@otherwise, do we have the skill?
mov r0,r4
ldr r1,=SkillTester
mov r14,r1
ldr r1,=ShoveIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#1
beq Shove_RetTrue
b Shove_GoBack

Shove_RetTrue:
mov r0,#1

Shove_GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

SmiteClassCheck:

push {r4-r7,r14}

@passed unit in r0
mov r4,r0

@check unit's class

ldr r0,[r4,#4]
ldrb r0,[r0,#4] @r0 = class

@get class list 
ldr r1,=SmiteClassList

Smite_LoopStart:
ldrb r2,[r1]
cmp r2,#0
beq Smite_RetFalse
cmp r2,r0
beq Smite_RetTrue
add r1,#1
b Smite_LoopStart

Smite_RetFalse:
@first, can we allow the skill to work?
ldr r0,=UseSkillCheckSettingLink
ldrb r0,[r0]
cmp r0,#0
beq Smite_GoBack @if false, return false

@otherwise, do we have the skill?
mov r0,r4
ldr r1,=SkillTester
mov r14,r1
ldr r1,=SmiteIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#1
beq Smite_RetTrue
b Smite_GoBack

Smite_RetTrue:
mov r0,#1

Smite_GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

SwarpClassCheck:

push {r4-r7,r14}

@passed unit in r0
mov r4,r0

@check unit's class

ldr r0,[r4,#4]
ldrb r0,[r0,#4] @r0 = class

@get class list 
ldr r1,=SwarpClassList

Swarp_LoopStart:
ldrb r2,[r1]
cmp r2,#0
beq Swarp_RetFalse
cmp r2,r0
beq Swarp_RetTrue
add r1,#1
b Swarp_LoopStart

Swarp_RetFalse:
@first, can we allow the skill to work?
ldr r0,=UseSkillCheckSettingLink
ldrb r0,[r0]
cmp r0,#0
beq Swarp_GoBack @if false, return false

@otherwise, do we have the skill?
mov r0,r4
ldr r1,=SkillTester
mov r14,r1
ldr r1,=SwarpIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#1
beq Swarp_RetTrue
b Swarp_GoBack

Swarp_RetTrue:
mov r0,#1

Swarp_GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

