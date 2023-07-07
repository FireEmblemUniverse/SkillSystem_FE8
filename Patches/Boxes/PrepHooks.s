@ Starts the proc related to the extra entry.
@ Replaces stat screen proc start in 0x96350 switch.
.thumb

.equ ProcStartBlocking, 0x08002CE0
.equ gChapterData, 0x202BCF0
.equ m4aSongNumStart, 0x80D01FC
.equ ProcGoto, 0x8002F24
.equ AddPrepMenuEntry, 0x8097024
.equ EnableBgSyncByMask, 0x8001FAC
.equ FillBgMap, 0x8001220
.equ gpBG0MapBuffer, 0x2022CA8

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global PREEXT_StartExtraEntry
.type PREEXT_StartExtraEntry, %function 
PREEXT_StartExtraEntry:


mov r0, r4 
bl StartPCBoxUnitSelect

ldr   r0, =0x8096384
mov   r15, r0
GOTO_R2:
bx    r2
.ltorg 


@ Executed when selecting the new entry.
@ Sets +0x33 to 5, go to label 0xA, play select sound.
.thumb
.type PREEXT_SelectExtraEntry, %function 
.global PREEXT_SelectExtraEntry
PREEXT_SelectExtraEntry:
push  {r4-r7, r14}
mov   r5, r0


@ Play Sfx
ldr   r0, =gChapterData
add   r0, #0x41
ldrb  r0, [r0]
lsl   r0, #0x1E
cmp   r0, #0x0
blt   L1
  mov   r0, #0x6A
  ldr   r4, =m4aSongNumStart|1
  bl    GOTO_R4
L1:

@ Set +0x33 to 5.
mov   r0, r5
add   r0, #0x33
mov   r1, #0x5
strb  r1, [r0]

@ Go to label 0xA
mov   r0, r5
mov   r1, #0xA
ldr   r4, =ProcGoto|1
bl    GOTO_R4


pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4

.ltorg 

@ Clears BG0 through BG3
.type ClearBGs, %function 
.global ClearBGs
ClearBGs:
push  {r4-r7, r14}


ldr   r4, =FillBgMap|1
ldr   r5, =0x800
ldr   r6, =gpBG0MapBuffer
mov   r7, #0x0
Loop:
  mov   r0, r6
  mov   r1, #0x0
  bl    GOTO_R4
  add   r6, r5
  add   r7, #0x1
  cmp   r7, #0x3
  ble   Loop

mov   r0, #0xF
ldr   r4, =EnableBgSyncByMask|1
bl    GOTO_R4


pop   {r4-r7}
pop   {r0}
bx    r0
.ltorg 

.global HookCopyGameSave
.type HookCopyGameSave, %function 
HookCopyGameSave: 
push {r4-r5, lr} 
mov r2, r4 
add r2, #0x2C 
ldrb r5, [r2] 
ldrb r4, [r1] 
mov r0, r4 
mov r1, r5 
blh CopyGameSave 
mov r0, r4 
mov r1, r5 
bl CopyPCBox
pop {r4-r5} 
pop {r3} 
bx r3 
.ltorg 

.global HookSaveGame
.type HookSaveGame, %function 
HookSaveGame:
push {lr} 

mov r0, r4 
add r0, #0x2c 
ldrb r0, [r0] 
bl SavePCBox

mov r0, r4 
add r0, #0x2c 
ldrb r0, [r0] 
blh SaveGame 

mov r0, r4 
pop {r3} 
bx r3 
.ltorg 

.equ CopyGameSave, 0x80A4E08 
.equ SaveGame, 0x80A5010 
.equ SetGameClock, 0x8000D34 
.global HookInitSave
.type HookInitSave, %function 
HookInitSave:
push {lr} 
mov r0, #0 
blh SetGameClock 

mov r0, r10 @ slot 
bl ClearAllBoxUnits @ Added 

lsl r1, r4, #0x18 
asr r1, #0x18 
mov r0, r5 
pop {r3} 
bx r3 
.ltorg 





