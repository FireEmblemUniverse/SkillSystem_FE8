.thumb

@ based on 6e58c. Nop at 590c6 to always play
@ this one has some extra routines in the processor. One of them plays the sound.

.equ TSAList, TimingList+4
.equ GraphicsList, TSAList+4
.equ PaletteList, GraphicsList+4
.equ SoundID, PaletteList+4

PUSH {r4-r6,lr}
MOV r6,r0 @r0 is pointer to the battle animation data??
LSL r5,r1,#0x18
LSR r5,#0x18
LDR r0, SkillAnimStruct
MOV r1,#3
LDR r2, InitializeStruct
BL goto_r2
MOV r4,r0
STR r6,[r4,#0x5c]
MOV r0,#0
STRH r0,[r4,#0x2c]
STR r0,[r4,#0x44]
LDR r0, TimingList
STR r0,[r4,#0x48]
LDR r0, TSAList
STR r0,[r4,#0x4c]
STR r0,[r4,#0x50]
LDR r0, GraphicsList
STR r0,[r4,#0x54]
LDR r0, PaletteList
STR r0,[r4,#0x58]
LDR r2, routine1
BL goto_r2
LDR r0,[r4,#0x5c]
LDR r3, LeftOrRight
BL goto_r3
MOV r1,r0
LDR r0, BattleBuffer
MOV r2,#0
LDSH r0,[r0,r2]
CMP r0,#0
BEQ JumpTarget
MOV r0,r1
LDR r2, routine2
BL goto_r2
CMP r0,#0
BNE JumpTarget2
MOV r0,#1 
MOV r1,#0x18
MOV r2,#0
LDR r3, routine3
BL goto_r3
B JumpTarget
JumpTarget2:
MOV r0,#1
MOV r1,#0xe8
MOV r2,#0
LDR r3, routine3
BL goto_r3
JumpTarget:
POP {r4-r6}
POP {r2}
goto_r2:
BX r2
goto_r3:
BX r3

.align
SkillAnimStruct:
.long 0x85d93f0
BattleBuffer:
.long 0x203e120
const1:
.long 0x2000000
InitializeStruct:
.long 0x8002c7c|1
routine1:
.long 0x80551b0|1
routine2:
.long 0x805a16c|1 @ takes halfword at [r0,#0xc] and returns if bit 0x200 is set
routine3:
.long 0x800148c|1
LeftOrRight:
.long 0x805a2b4|1
routine5:
.long 0x80729a4|1
TimingList:
@POIN to table of frames and durations: XXXX YYYY where x is frame and y is duration (in this case labeled BG only)
@POIN TSAList
@POIN GraphicsList
@POIN PaletteList
@SHORT sfx
