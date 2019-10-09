.thumb
.align
.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm
.equ BiorhythmTable, BiorhythmGetter+4
.equ TextTable,BiorhythmTable+4

push {r4-r7,r14}

@get active unit's struct in r0
mov r0,r8

@call biorhythm getter
ldr r1,BiorhythmGetter
mov lr,r1
.short 0xF800

@get name ID
mov r1,#4
mul r0,r1
ldr r1,TextTable
add r0,r1
ldr r0,[r0]

GoBack:
pop {r4-r7}
pop {r1}
bx r1


.ltorg
.align 4

ActiveUnitPointer:
.word 0x3004E50
BiorhythmGetter:
@POIN BiorhythmGetter
@POIN BiorhythmTable
@WORD SS_Biorhythm1
@WORD SS_Biorhythm2
@WORD SS_Biorhythm3
@WORD SS_Biorhythm4
@WORD SS_Biorhythm5
@WORD SS_Biorhythm6
@WORD SS_Biorhythm7
