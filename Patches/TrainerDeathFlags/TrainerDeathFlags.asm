
.thumb
.align 4

.equ MemorySlot,0x30004B8


.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


	.equ NewFlagsRam, 0x203F548
	.equ GetUnit, 0x8019430
	.equ EventEngine, 0x800D07C
	.equ CurrentUnit, 0x3004E50

@.global TrainerDeathFlags
@.type TrainerDeathFlags, %function
@TrainerDeathFlags:
push {lr}

ldr r1, [r2] @ Char pointer 
ldrb r1, [r1, #4] @ Unit ID 
cmp r1, #0xD0 
blt End 
sub r1, #0xD0 


ldr r3, =0x202BCF0 @ Chapter Data 
ldrb r0, [r3, #0x0E] @ +0x0E	Byte	Chapter ID
lsl r0, #4 @ 16 trainers per area allowed 

add r0, r1 @ which trainer exactly 


ldrb r3, =TrainerDefeatedFlagOffset @0xA0 
lsl r1, r3, #3 @ 8 flags per byte so +0x500 
add r0, r1 @ Full offset 
@ some ram address + 0x500 + ChapterID*8 + unit id over 0xD0 
blh SetNewFlag 

End:

pop {r0}
bx r0 

.ltorg
.align

.global ShouldTrainerSummonTeam
.type ShouldTrainerSummonTeam, %function 
ShouldTrainerSummonTeam: 
push {r4-r7, lr}
@ save their # of pokemon to wexp +0x2D ? 
@ save each one that dies to trainer/commander's wexp + 0x2E? 
@ 8 bits - 1, 2, 4, 8, 0x10, 0x20, 0x40, 0x80 

blh ModularSummonUsability 
cmp r0, #0 
beq ReturnFalse 
mov r5, r2 @ Unit group to summon 
ldr r0, [r2] 
cmp r0, #0 
beq ReturnFalse @ Unit group is empty 
ldr r4, =CurrentUnit
ldr r4, [r4] @ Active unit trying to summon 

@ they can summon at least 1 unit 
ldr r2, =MemorySlot 
ldr r3, [r2, #4*1] @ Mem Slot 1 has total summonable 
lsr r0, r3, #8 @ # we can summon 
lsl r1, r3, #24 
lsr r1, #24 @ # pokemon they have
cmp r0, r1 
blt ReturnFalse @ 1 or more of the units have already been summoned 
mov r6, r1 @ Total party size 





mov r1, #0x2D 
ldrb r0, [r4, r1] 
cmp r0, #0 
bne ReturnFalse 


strb r6, [r4,r1] @ Wexp1 as # of team members 
mov r0, #0 
mov r1, #0x2E 
strb r0, [r4, r1] @ Wexp2 as which ones that have fainted (none so far) 

ldr r3, =0x202BCF0 @ gChapterData
mov r2, #0x2F @ Dark WEXP as additional level bonus 
mov r1, #0x14 
ldrb r0, [r3, r1] 
mov r1, #0x40 @+0x40	Set for hard mode
and r1, r0 
cmp r1, #0 
beq NotHard
@ Hard mode 
mov r0, #0x8 
strb r0, [r4, r2] 
b ReturnTrue 

NotHard:
mov r1, #0x42
ldrb r0, [r3, r1] 
mov r1, #0x20 @ 0x20	Set if not easy mode
and r1, r0 
cmp r1, #0 
beq NotEasy @ Easy mode we do not 
mov r0, #0 
strb r0, [r4, r2] @ Easy mode gets no extra level bonus 
b ReturnTrue 

NotEasy: 
@ Must be normal 
mov r0, #4 
strb r0, [r4, r2] @ 4 levels bonus 



ReturnTrue:
mov r0, #1 
b Exit 

ReturnFalse:
mov r0, #0 

Exit:
pop {r4-r7}
pop {r1}
bx r1 
.ltorg
.align
.global IsTrainersTeamDefeated
.type IsTrainersTeamDefeated, %function 
IsTrainersTeamDefeated: 
push {r4-r7, lr}
@ checks if the whole team was defeated whenever a unit dies 
ldr r4, =0x203A4EC  @ Atkr 
ldr r5, =0x203A56C @ Dfdr


ldrb r0, [r4, #0x0B] @ Deployment id 
ldr r3, =CurrentUnit 
ldr r3, [r3] 
cmp r3, #0 
beq False_IsTrainersTeamDefeated

ldrb r1, [r3, #0x0B] @ deployment ID 
cmp r0, r1 
bne False_IsTrainersTeamDefeated

CheckAtkrFirst:
ldrb r0, [r4, #0x13] @ CurrentHP 
cmp r0, #0 
bne CheckDfdrSecond

mov r1, #0x38 @ Commander 
ldrb r0, [r4, r1] @ Commander 
cmp r0, #0 
beq CheckDfdrSecond 
blh GetUnitByEventParameter
cmp r0, #0 
beq CheckDfdrSecond 
mov r6, r0 @ Commander 
@ newly loaded trainer unit could be same deployment id 
@ as a wild one you just defeated, so we check this 
@ only after checking support 7 for commander 

ldrb r0, [r4, #0x0B] @ Deployment id 
blh GetUnit 
mov r4, r0 
cmp r0, #0 
beq CheckDfdrSecond 

@ Commander should be the same for atkr / unit 
ldr r3, =0x203A4EC  @ Atkr
mov r2, #0x38 @ Commander 
ldrb r0, [r4, r2] 
ldrb r1, [r3, r2] @ Commander 
cmp r0, r1 
bne CheckDfdrSecond 


mov r1, #0x2D 
ldrb r0, [r6,r1] @ Wexp1 as # of team members 
cmp r0, #50 
beq CheckDfdrSecond 

mov r1, #0x38 @ Commander 
mov r2, #0 
strb r2, [r5, r1] @ Make dfdr have no commander so this doesn't trigger again 

mov r2, #0x2E 
ldrb r1, [r6, r2] @ Wexp2 as how many that have fainted 
add r1, #1 @ 1 more has died 
strb r1, [r6, r2] 
cmp r0, r1 
bne False_IsTrainersTeamDefeated


mov r0, r6 @ Defeated trainer 
bl DefeatedTrainerRoutine



b True_IsTrainersTeamDefeated


CheckDfdrSecond:
@ 202d1b4 
ldrb r0, [r5, #0x13] @ CurrentHP 
cmp r0, #0 
bne False_IsTrainersTeamDefeated


mov r1, #0x38 @ Commander 
ldrb r0, [r5, r1] @ Commander 

cmp r0, #0 
beq False_IsTrainersTeamDefeated
blh GetUnitByEventParameter
cmp r0, #0 
beq False_IsTrainersTeamDefeated
mov r6, r0 @ Commander 

ldrb r0, [r5, #0x0B] @ Deployment id 
blh GetUnit 
cmp r0, #0 
beq False_IsTrainersTeamDefeated
mov r5, r0 
ldrb r0, [r5, #0x13] @ CurrentHP 
cmp r0, #0 
bne False_IsTrainersTeamDefeated @ so loading the dmg preview and then waiting doesn't count the unit as defeated 

@ Commander should be the same for Dfdr / unit 
@ this is done because battle struct doesn't get cleared after battle 
ldr r3, =0x203A56C @ Dfdr
mov r2, #0x38 @ Commander 
ldrb r0, [r5, r2] 
ldrb r1, [r3, r2] @ Commander 
cmp r0, r1 
bne False_IsTrainersTeamDefeated


mov r1, #0x2D 
ldrb r0, [r6,r1] @ Wexp1 as # of team members 
cmp r0, #50 
beq False_IsTrainersTeamDefeated @ just now, anyway (they were previously defeated) 

mov r1, #0x38 @ Commander 
mov r2, #0 
strb r2, [r5, r1] @ Make dfdr have no commander so this doesn't trigger again 


mov r2, #0x2E 
ldrb r1, [r6, r2] @ Wexp2 as which ones that have fainted (none so far) 
add r1, #1 @ 1 more has died 
strb r1, [r6, r2] 
cmp r0, r1 
bne False_IsTrainersTeamDefeated  




mov r0, r6 @ Defeated trainer 
bl DefeatedTrainerRoutine
b True_IsTrainersTeamDefeated

True_IsTrainersTeamDefeated: 
mov r0, #1 
b Exit_IsTrainersTeamDefeated 

False_IsTrainersTeamDefeated:
mov r0, #0 

Exit_IsTrainersTeamDefeated:

pop {r4-r7}
pop {r1}
bx r1 
.ltorg
.align
.global AreAnyTrainerBattlesActive
.type AreAnyTrainerBattlesActive, %function 
AreAnyTrainerBattlesActive:

push {r4-r7, lr}



mov r4, #0xDF 
mov r5, #0x2D @ number of summoned units 

AreAnyTrainerBattlesActive_Loop:
add r4, #1 
cmp r4, #0xF0 
bge BreakLoop
mov r0, r4 
blh GetUnitByEventParameter 
cmp r0, #0 
beq AreAnyTrainerBattlesActive_Loop
ldrb r1, [r0, r5]
cmp r1, #0 
beq AreAnyTrainerBattlesActive_Loop 
cmp r1, #50 
beq AreAnyTrainerBattlesActive_Loop

@ if we got here, at least one battle is active, so ret true 
mov r0, #1 
b AreAnyTrainerBattlesActive_Exit

BreakLoop:



mov r0, #0 @ False 

AreAnyTrainerBattlesActive_Exit:

pop {r4-r7}
pop {r1}
bx r1 


.ltorg
.align




.global DefeatedTrainerRoutine
.type DefeatedTrainerRoutine, %function 

DefeatedTrainerRoutine:
push {r4-r7, lr}

mov r6, r0 @ Defeated trainer 

mov r1, #0x2D 
ldrb r0, [r6, r1] 
cmp r0, #50
beq ExitDefeatedTrainer 

ldr r3, =PostTrainerBattleRamLocatLink
ldr r3, [r3] @ @ my ram 
ldrb r0, [r6, #0x0B] 
strb r0, [r3] @ my ram 2
@ 903cfe6

ldr r0, =TrainerDefeatedEvent 
mov r1, #1 
blh EventEngine 

ExitDefeatedTrainer:



pop {r4-r7}
pop {r1}
bx r1 
.ltorg
.align

.global ASMC_CheckTrainerFlag
.type ASMC_CheckTrainerFlag, %function 
ASMC_CheckTrainerFlag: 
push {lr} 
ldr r3, =MemorySlot 
ldr r0, [r3, #4] @ Slot 1 as unit ID to check 
bl CheckTrainerFlagByID @ result in r0 
Exit_ASMC_CheckTrainerFlag:
ldr r3, =MemorySlot 
mov r1, #0x0C*4 
str r0, [r3, r1] @ Store result to sC 
pop {r1} 
bx r1 
.ltorg
.align


.global CallCheckTrainerFlag 
.type CallCheckTrainerFlag, %function 
CallCheckTrainerFlag: 
push {lr} 
ldr r0, =CurrentUnit
ldr r0, [r0] 
bl CheckTrainerFlag 
ldr r3, =MemorySlot 
mov r1, #0x0C*4 
str r0, [r3, r1] @ Store result to sC 

pop {r1} 
bx r1 
.ltorg
.align
.global CheckTrainerFlagByID
.type CheckTrainerFlagByID, %function 
CheckTrainerFlagByID:
push {r4-r5, lr}
mov r5, #0 
mov r1, r0 
mov r4, r0 @ unit ?? 

b StartCheckTrainerFlag 

@ Trainers use IDs 0xE0 - 0xEF 
.global CheckTrainerFlag
.type CheckTrainerFlag, %function 
CheckTrainerFlag:
push {r4-r5, lr}

@ given unit struct r0, check if their flag is set or not 
mov r4, r0 
mov r5, #0 



ldr r1, [r4] 
ldrb r1, [r1, #4] @ Unit ID we're interested in 
StartCheckTrainerFlag:
@ r4 below here is variable and dangerous 
cmp r1, #0xE0 
blt TrainerFlagTrue 
cmp r1, #0xF0 
bge TrainerFlagTrue 

ldr r3, =0x202BCF0 @ Chapter Data 
ldrb r0, [r3, #0x0E] @ +0x0E	Byte	Chapter ID
lsl r0, #4 @ 16 trainers per area allowed 
add r0, r1 @ which trainer exactly 
ldr r3, =TrainerDefeatedFlagOffset @0xA0 
lsl r3, #24 
lsr r3, #24 
lsl r1, r3, #3 @ 8 flags per byte so +0x500 
add r0, r1 @ Full offset 
mov r5, r0 
blh CheckNewFlag_No_sC @ icon display needs to not write to sC constantly lol 
b ExitCheckTrainerFlag 


TrainerFlagTrue:
mov r0, #1 
b ExitCheckTrainerFlag 

TrainerFlagFalse:
mov r0, #0 

ExitCheckTrainerFlag: 
mov r1, r5 @ Offset of flag 
pop {r4-r5} 
pop {r2}
bx r2 
.ltorg
.align

.global GetTargetAndStoreToRam
.type GetTargetAndStoreToRam, %function 
GetTargetAndStoreToRam:
push {lr} 

ldr r3, =0x203A958
ldrb r0, [r3, #0x0D] @ Target's deployment byte 
ldr r3, =PostTrainerBattleRamLocatLink
ldr r3, [r3] @ @ my ram 
strb r0, [r3]


pop {r1}
bx r1 

.ltorg
.align


.global MarkTrainerAsDefeated_ASMC
.type MarkTrainerAsDefeated_ASMC, %function 
MarkTrainerAsDefeated_ASMC: 
push {r4, lr} 

ldr r3, =MemorySlot 
ldr r0, [r3, #4] @ s1 as unit ID 
blh GetUnitByEventParameter
cmp r0, #0 
beq ExitMarkTrainerAsDefeated
mov r4, r0 @ unit to mark as defeated 
bl CheckTrainerFlag 
mov r0, r1 @ returned address offset to set 
blh SetNewFlag 

mov r0, #50 
mov r1, #0x2D 
strb r0, [r4, r1] @ to not trigger the battle again 

ExitMarkTrainerAsDefeated: 

pop {r4} 
pop {r0} 
bx r0 




.global UnmarkTrainerAsDefeated_ASMC
.type UnmarkTrainerAsDefeated_ASMC, %function 
UnmarkTrainerAsDefeated_ASMC: 
push {r4, lr} 

ldr r3, =MemorySlot 
ldr r0, [r3, #4] @ s1 as unit ID 
blh GetUnitByEventParameter
cmp r0, #0 
beq ExitUnmarkTrainerAsDefeated
mov r4, r0 @ unit to mark as defeated 
bl CheckTrainerFlag 
mov r0, r1 @ returned address offset to set 
blh UnsetNewFlag 
mov r0, #0 
mov r1, #0x2D 
strb r0, [r4, r1] @ to trigger the battle again 


ExitUnmarkTrainerAsDefeated: 

pop {r4} 
pop {r0} 
bx r0 

.ltorg
.align
.global PostTrainerBattleActions
.type PostTrainerBattleActions, %function 

PostTrainerBattleActions:
push {r4, lr} 
ldr r3, =PostTrainerBattleRamLocatLink
ldr r3, [r3] @ @ my ram 
ldrb r0, [r3] @ deployment ID 
cmp r0, #0 
beq DontTurnOffFlag
blh GetUnit 
cmp r0, #0
beq DontTurnOffFlag
mov r4, r0 


ldr r1, [r4] 
ldrb r1, [r1, #4] @ Leader's unit ID 

ldr r3, =MemorySlot
str r1, [r3, #0x9*4]



sub r1, #0xE0 @ we only have trainers from unit IDs 0xE0 - 0xEF 
lsl r1, #2 @ 4 bytes per entry 


ldr r3, =0x202BCF0 @ gChapterData 
ldrb r0, [r3, #0xE] @ what chapter is it 
ldr r3, =TrainerDefeatPoinTable
lsl r0, #2 @ 4 bytes per poin 
add r3, r0 
ldr r3, [r3] @ Specific chapter's table of quotes 
ldrh r0, [r3, r1] @ TextID we want 
add r1, #2 @ Gold amount 
ldrh r1, [r3, r1] @ Gold amount we want 

ldr r3, =MemorySlot 

str r1, [r3, #4*0x03] @ Gold to give in s3 


str r0, [r3, #4*0x02] @ Store to mem slot 2 


ldrb r0, [r4, #0x10] @ X 
ldrb r1, [r4, #0x11] @ Y 

lsl r1, #16 
add r1, r0 
str r1, [r3, #4*0x0B] @ Coords 

mov r0, r4 
bl CheckTrainerFlag 
ldr r3, =MemorySlot 
mov r2, #0x0C*4 
str r0, [r3, r2] @ store result to sC 
mov r0, r1 @ returned address offset to set 
blh SetNewFlag 

mov r0, #50 
mov r1, #0x2D 
strb r0, [r4, r1] @ to not trigger the battle again 

bl AreAnyTrainerBattlesActive 
cmp r0, #1
beq DontTurnOffFlag



ldr r0, =TrainerBattleActiveFlag 
lsl r0, #24 
lsr r0, #24 
blh 0x8083cd8 @UnsetGlobalEventId

ldr r0, =CallCountdownFlag_2
lsl r0, #24 
lsr r0, #24 
blh 0x8083cd8 @UnsetGlobalEventId

DontTurnOffFlag: 


pop {r4}
pop {r0}
bx r0 
.ltorg
.align


	.equ GetUnitByEventParameter, 0x0800BC51
	

.type BreakPointASMC, %function 
.global BreakPointASMC
BreakPointASMC:
push {lr}
mov r11, r11 
mov r8, r8
mov r5, r5 
pop {r0}
bx r0 
.ltorg 
.align 


.type WildAuraMonDefeatQuoteFunc, %function 
.global WildAuraMonDefeatQuoteFunc
WildAuraMonDefeatQuoteFunc:
push {lr}

ldr r3, =MemorySlot
mov r0, #0 
str r0, [r3, #4*0x02] @ store 0 to s2 

ldr r3, =0x203A4EC @ atkr 
ldrb r0, [r3, #0x0B] @ deployment id 
blh GetUnit 
cmp r0, #0 
beq TryAtkr 
ldr r1, [r0] 
ldrb r1, [r1, #4] @ unit ID 
cmp r1, #0xD0 
blt TryAtkr
cmp r1, #0xF0
bge TryAtkr 
b FoundUnit

TryAtkr:
ldr r3, =0x203A56C @ dfdr
ldrb r0, [r3, #0x0B] @ deployment id 
blh GetUnit 
cmp r0, #0 
beq Exit_Aura
ldr r1, [r0] 
ldrb r1, [r1, #4] @ unit ID 
cmp r1, #0xD0 
blt Exit_Aura
cmp r1, #0xF0
bge Exit_Aura
b FoundUnit

FoundUnit:
ldr r3, =MemorySlot
str r1, [r3, #4*6] @ unit ID that is dying in s6 
cmp r1, #0xE0 
bge NoAdd
add r1, #0x10 
NoAdd:

str r1, [r3, #4*1] @ unit ID to mark as defeated 

sub r1, #0xE0 @ we only have x from unit IDs 0xD0 - 0xDF 


lsl r1, #2 @ 4 bytes per entry 

ldrb r2, [r0, #0x10] @ XX coord 
ldrb r3, [r0, #0x11] @ YY coord 
ldr r0, =MemorySlot
add r0, #4*0x0B 
strh r2, [r0] 
strh r3, [r0, #2] @ coords 

ldr r3, =0x202BCF0 @ gChapterData 
ldrb r0, [r3, #0xE] @ what chapter is it 
ldr r3, =TrainerDefeatPoinTable
lsl r0, #2 @ 4 bytes per poin 
add r3, r0 
ldr r3, [r3] @ Specific chapter's table of quotes 
ldrh r0, [r3, r1] @ TextID we want 
ldr r3, =MemorySlot 
str r0, [r3, #4*0x02] @ Store to mem slot 2 

Exit_Aura:

pop {r0}
bx r0 

.ltorg 
.align 
