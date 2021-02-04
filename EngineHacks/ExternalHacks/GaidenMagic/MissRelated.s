
.global MakeHPEffectsWorkOnMiss
.type MakeHPEffectsWorkOnMiss, %function
MakeHPEffectsWorkOnMiss: @ jumpToHacked at 0x080552D2 (with a preceding nop).
push {r2, r3}
cmp r4, #0x0
beq BattleTime
cmp r4, #0x1
bne FailsafeExit //failsafe
b DodgeTime

//If normal battle, exit to proper area
BattleTime:
pop {r2, r3}
ldr r6, =0x080552E5
bx r6

//If something fucked up, just exit
FailsafeExit:
pop {r2, r3}
ldr r6, =0x08055415
bx r6

//round2 - AIS says 2, E152 says 1

DodgeTime:
MOV r0 ,r7
blh 0x0805A16C, r3   //GetAISSubjectId r0=@AnimationInterpreter //get attacker's ais
MOV r1, r0
LDRH r0, [r7, #0xE] //round number
SUB r0, #0x1
LSL r0, r0 ,#0x1
ADD r0, r0, R1
blh 0x08058A34, r3   //GetBattleAnimRoundTypeFlags
LSL r0, r0 ,#0x10
LSR r6, r0 ,#0x10 //flags are stored in r6.
MOV r0, r5
blh 0x0805A16C, r3   //GetAISSubjectId r0=@AnimationInterpreter //get defender's ais
MOV r1, r0
LDRH r0, [r5, #0xE]
SUB r0, #0x1
LSL r0, r0 ,#0x1
ADD r0, r0, R1
blh 0x08058A34, r3   //GetBattleAnimRoundTypeFlags
LSL r0, r0, #0x10
LSR r4, r0, #0x10
LSL r0, r6, #0x10
ASR r0, r0, #0x10

//We want to check if the attacker's HP is set to change on this round, and if so, apply Devil Effect
LDR r4, =0x0203E152
MOV r0, r5
blh 0x0805A16C, r3   //GetAISSubjectId r0=@AnimationInterpreter (still has defender)
LSL r0, r0, #0x1
ADD r0, r0, R4
MOV r1, #0x0
LDSH r6, [r0, r1] //pointer:0203E152 (global roundID - 0)
MOV r0, r5
blh 0x0805A16C, r3   //GetAISSubjectId r0=@AnimationInterpreter
LSL r0, r0, #0x1
ADD r0, r0, R4
MOV r1, #0x0
LDSH r4, [r0, r1] //pointer:0203E152
ADD r4, #0x1 //This lets us check the HP from the next round
MOV r0, r5

blh 0x0805A16C, r3   //GetAISSubjectId r0=@AnimationInterpreter
cmp r0, #0x0	//IsRightToLeft
bne IsLeftToRight
mov r0, #0x1
b GetHP

IsLeftToRight:
mov r0, #0x0

GetHP:
MOV r1, r0
LSL r0, r6, #0x1 
ADD r0, r0, R1
blh 0x08058A60, r3   //GetSomeBattleAnimHpValue
//This was getting the defender's HP, now it gets attacker's

LSL r0, r0, #0x10
ASR r6, r0, #0x10 //this compares old hp to new

mov r0, r5
blh 0x0805A16C, r3   //GetAISSubjectId r0=@AnimationInterpreter
cmp r0, #0x0	//IsRightToLeft
bne IsLeftToRight2
mov r0, #0x1
b GetHP2

IsLeftToRight2:
mov r0, #0x0

GetHP2:
mov r1, r0
lsl r0, r4, #0x1
add r0, r0, r1
blh 0x08058A60, r3   //GetSomeBattleAnimHpValue
lsl r0, r0, #0x10
asr r4, r0, #0x10
cmp r6, r4
bne HpChanged

//If HP did not change, just advance the round numbers.
	ldr r4,	=0x0203E152     
	MOV r0, r5    
	blh 0x0805A16C, r3   //GetAISSubjectId
	lsl     r0,r0,#0x1
	add     r0,r0,r4
	ldrh    r1,[r0]    
	add     r1,#0x1  
	strh    r1,[r0] 
	ldr r4,	=0x0203E152     
	MOV r0, r7    
	blh 0x0805A16C, r3   //GetAISSubjectId
	lsl     r0,r0,#0x1
	add     r0,r0,r4
	ldrh    r1,[r0]    
	add     r1,#0x1  
	strh    r1,[r0] 

b DoneUpdatingHp

HpChanged:
	MOV r0, r5
	MOV r5, r7
	MOV r7, r0
	MOV r8, r9

label4: //Running this again with our new values in place
LDR r4, =0x0203E152
MOV r0, r5 //attacker AIS
blh 0x0805A16C, r3   //GetAISSubjectId r0=@AnimationInterpreter
LSL r0, r0, #0x1
ADD r0, r0, R4
MOV r1, #0x0
LDSH r6, [r0, r1] //pointer:0203E152
MOV r0, r5
blh 0x0805A16C, r3   //GetAISSubjectId r0=@AnimationInterpreter
LSL r0, r0, #0x1
ADD r0, r0, R4
MOV r1, #0x0
LDSH r4, [r0, r1] //pointer:0203E152
ADD r4, #0x1

//MOV r0, r5 @this unit in r5
MOV r0, r7 @opponent in r7
BL StartEfxHpBarForMiss   //StartEfxHpBar, but only update the attacker.
//blh 0x08052304 //goto real EfxHpBar
b DoneUpdatingChangedHp
	
//Now we exit to 5540E to start the dodge animation

DoneUpdatingHp:
pop {r2, r3}
ldr r4, =0x0805540F
bx r4

//We need to put r7 back where r5 was if we flipped it earlier

DoneUpdatingChangedHp:
mov r0, r7 //defender ais
pop {r2, r3}
ldr r4, =0x08055411
bx r4


.ltorg
.align

//New efxHpBar for updating only the attacker (when magic misses)
StartEfxHpBarForMiss:
PUSH {r4,r5,r6,lr}   //StartEfxHpBar
MOV r4 ,r0
blh 0x0805A16C, r3   //GetAISSubjectId r0=@AnimationInterpreter
MOV r1 ,r0
LDRH r0, [r4, #0xE] //round number
SUB r0, #0x1
LSL r0 ,r0 ,#0x1
ADD r0 ,r0, R1
blh 0x08058A34, r3   //GetBattleAnimRoundTypeFlags
MOV r1, #0x80
LSL r1, r1, #0x3 //great shield?
AND r1, r0
CMP r1, #0x0
BNE label5
    LDR r1, =0x02017728 //(gBattleAnimeCounter )
    LDR r0, [r1, #0x0] //pointer:02017728 (gBattleAnimeCounter )
    CMP r0, #0x0
    BNE label5
        MOV r0, #0x1
        STR r0, [r1, #0x0]   //gBattleAnimeCounter
		label5:
        LDR r0, =NewEfxHPBar
        MOV r1, #0x3
        blh 0x08002C7C, r3   //New6C
        MOV r6 ,r0
		
		
		//We need the opponent in here instead.
        STR r4, [r6, #0x64]
		
		
        MOV r0, r4
        blh 0x0805A16C, r3   //GetAISSubjectId r0=@AnimationInterpreter
        CMP r0, #0x0
        BNE label6 //Flipped these values from original.
			LDR r0, =0x02000000 //(WRAM )
			LDR r1, [r0] 
			STR r1, [r6, #0x5C] 
			LDR r0, [r0, #0x8] 
            B label7
		label6:
        LDR r0, =0x02000000 //(WRAM )
        LDR r1, [r0, #0x8] //pointer:02000008 (gAISFrontRight )
        STR r1, [r6, #0x5C]
        LDR r0, [r0] //pointer:02000000 (WRAM ) //flipped from orig
		
		label7:
        ldr r3, =efxHPBarParent
		mov r2, #0x01
		orr r3, r2, r3
		bx r3

.ltorg

.global MakeHPEffectsWorkOnMiss_Nos
.type MakeHPEffectsWorkOnMiss_Nos, %function
MakeHPEffectsWorkOnMiss_Nos: @ jumpToHacked at 0x08055496 (with a preceding nop).
mov r0, r9
cmp r0, #0x0
beq BattleTimeNos //554AC
cmp r0, #0x1
bne FailsafeExitNos //failsafe
b DodgeTimeNos

//If normal battle, exit to proper area
BattleTimeNos:
ldr r3, =0x080554AD
bx r3

//If something fucked up, just exit
FailsafeExitNos:
ldr r3, =0x0805550B
bx r3

DodgeTimeNos:

//If HP did not change, just advance the round numbers.
	ldr r4,	=0x0203E152     
	MOV r0, r5    
	blh 0x0805A16C, r3   //GetAISSubjectId
	lsl     r0,r0,#0x1
	add     r0,r0,r4
	ldrh    r1,[r0]    
	add     r1,#0x1  
	strh    r1,[r0] 
	ldr r4,	=0x0203E152     
	MOV r0, r7    
	blh 0x0805A16C, r3   //GetAISSubjectId
	lsl     r0,r0,#0x1
	add     r0,r0,r4
	ldrh    r1,[r0]    
	add     r1,#0x1  
	strh    r1,[r0] 
	
	//Now we exit to 55505 to start the dodge animation

DoneUpdatingHpNos:
ldr r4, =0x08055505
bx r4

.ltorg
