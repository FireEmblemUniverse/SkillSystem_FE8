
.thumb 
//Event0E_STAL
@ exported via FEBuilder 
.global StalVariableSleep
.type StalVariableSleep, %function 
StalVariableSleep: @ https://github.com/FireEmblemUniverse/fireemblem8u/blob/b9ad9bcafd9d4ecb7fc13cc77a464e2a82ac8338/src/evtscr.c#L473
PUSH {r4,r5,r6,r7,lr}   
	mov r4, r8 
	push {r4} 
	ldr  r1, [r0, #0x38] 
	ldrh r1, [r1, #2] @ stal time 
	mov r8, r1 @ stal time 
	MOV r2 ,r0 @ proc 
LDR r7, [r2, #0x38]
	mov r0, #0x20 @ regular STAL (no skipping or speeding up with A / B) 
MOV r1, #0xF
AND r1 ,r0
MOV r4 ,r1
LDRH r6, [r2, #0x3C]
LSL r3 ,r6 ,#0x10
LSR r0 ,r3 ,#0x12
MOV r5, #0x1
AND r0 ,r5
CMP r0, #0x0
BNE Label_1
    MOV r0, #0x1
    AND r1 ,r0
    CMP r1, #0x0
    BEQ Label_2
        LSR r0 ,r3 ,#0x13
        AND r0 ,r5
        CMP r0, #0x0
        BNE Label_1
            LDR r0, =0x858791C @# pointer:0800DB84 -> 0858791C (KeyStatusBuffer Pointer )
            LDR r0, [r0, #0x0] @# pointer:0858791C -> 02024CC0 (KeyStatusBuffer@KeyStatusBuffer.FirstTickDelay )
            LDRH r1, [r0, #0x8] @# pointer:02024CC8 (KeyStatusBuffer@KeyStatusBuffer.NewPresses:  1 For Press, 0 Otherwise )
            MOV r0, #0x2
            AND r0 ,r1
            CMP r0, #0x0
            BNE Label_1
            Label_2:
			LDRH r3, [r2, #0x3E]
            MOV r1, #0x3E
            LDSH r0, [r2, r1]
            CMP r0, #0x0
            BGT Label_3
					mov r0, r8 @ Stal time 
					push {r2} 
					bl AdjustSleepTime_AB_Press
					pop {r2} 
            STRH r0, [r2, #0x3E]
            B Label_4

            Label_3:
			MOV r5, #0x1
            MOV r0, #0x40
            AND r0 ,r6
            CMP r0, #0x0
            BNE Label_5
				MOV r0, #0x2
				AND r4 ,r0
				CMP r4, #0x0
				BEQ Label_5
					LDR r0, =0x202BCF0 @# pointer:0800DBCC -> 0202BCF0 (ChapterData@gChapterData.TurnStartClock )
					ADD r0, #0x40
					LDRB r0, [r0, #0x0] @# pointer:0202BD30 (ChapterData@gChapterData.Option1  &01=Controller(unused) &02=Terrain window (set=off, not set=on)  &04=Unit window (set=burst, not set=panel) &08=Unit window (set=off, not set=panel)  &10=Autocursor (set=off, not set=on))
					LSR r0 ,r0 ,#0x7
					CMP r0, #0x0
					BNE Label_6
						LDR r0, =0x858791C @ pointer:0800DBD0 -> 0858791C (KeyStatusBuffer Pointer )
						LDR r0, [r0, #0x0] @# pointer:0858791C -> 02024CC0 (KeyStatusBuffer@KeyStatusBuffer.FirstTickDelay )
						LDRH r1, [r0, #0x4] @# pointer:02024CC4 (KeyStatusBuffer@KeyStatusBuffer.Current )
						MOV r0 ,r5
						AND r0 ,r1
						CMP r0, #0x0
						BEQ Label_5
                        Label_6: 
						MOV r5, #0x4
				Label_5: 
				LSL r0 ,r3 ,#0x10
				ASR r0 ,r0 ,#0x10
				SUB r0 ,r0, R5
				LSL r0 ,r0 ,#0x10
				LSR r3 ,r0 ,#0x10
				CMP r0, #0x0
				BGT Label_7
    Label_1:
	MOV r0, #0x0
    STRH r0, [r2, #0x3E]
    B Label_8
Label_7: 
STRH r3, [r2, #0x3E]
Label_4:
MOV r0, #0x3
Label_8: 
pop {r4} 
mov r8, r4 
POP {r4,r5,r6,r7}
POP {r1}
BX r1
.ltorg 
