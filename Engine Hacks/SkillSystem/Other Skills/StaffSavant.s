@Staff Savant by StanH
@adds 1 to mag/2 range
.thumb

.equ GetItemMaxRange, 0x8017684
.equ GetUnitPower, 0x80191B0

.equ SkillChecker, EALiterals
.equ SkillId, EALiterals+0x04

.equ unitFormortiis, 0xBE
.equ itemNightmare, 0xA6

.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

@ jumpToHack at 0x18A1C
GetStatusStaffRange:
    push {r4, lr}
    
    mov r4, r0
    
    ldr r1, [r4]
    ldrb r1, [r1, #4] @ loading char id
    
    cmp r1, #unitFormortiis
    bne NotFormortiis
    
    mov r0, #itemNightmare
    blh GetItemMaxRange, r1
    
    b End

NotFormortiis:
    mov r0, r4
    blh GetUnitPower, r1
    
    asr r2, r0, #1 @ range = pow/2
    
    cmp r2, #5
    bgt SkipMinRange
    
    mov r2, #5

SkipMinRange:
    mov r0, r4
    ldr r1, SkillId
    blh SkillChecker
    
    cmp r0, #0
    beq End
    
    @ Adding 1 to Staff Range
    add r2, #1
    
End:
    mov r0, r2
    pop {r4, pc}

.ltorg
.align

EALiterals:
@ POIN SkillChecker
@ WORD SkillId