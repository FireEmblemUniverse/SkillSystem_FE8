.equ gMapMovement, 0x202E4E0
.equ ClearMapWith, 0x80197E4
.equ NewTargetSelectionStruct, 0x859D2F8
.equ WarpTargetSelectionOnSelect, 0x8029854 + 1
.equ NewTargetSelectionSpecialized, 0x804FAA4
.equ GetStringFromIndex, 0x800A240
.equ NewBottomHelpText, 0x8035708
.equ ChapterData, 0x202BCF0
.equ m4aSongNumStart, 0x80D01FC

.macro blh to, reg=r3
ldr \reg, =\to
mov lr, \reg
.short 0xF800
.endm

.thumb

push {r4, lr}

// mov r2, r4

// blh AbortStaff_RangeSetup
ldr r3, AbortStaff_RangeSetup
mov lr, r3
.short 0xF800

ldr r0, =gMapMovement
ldr r0, [r0]
mov r1, #0x1
neg r1, r1
blh ClearMapWith
ldr r0, =NewTargetSelectionStruct
ldr r1, =WarpTargetSelectionOnSelect
blh NewTargetSelectionSpecialized
mov r4, r0
ldr r0, =#0x00000875 // Scroll text
blh GetStringFromIndex
mov r1, r0
mov r0, r4
blh NewBottomHelpText
ldr r0, =ChapterData
add r0, #0x41
ldrb r0, [r0]
lsl r0, #0x1E
cmp r0, #0x0
blt End
mov r0, #0x6A
blh m4aSongNumStart

End:
pop {r4}
pop {r0}
bx r0

.ltorg
.align

AbortStaff_RangeSetup:
@POIN AbortStaff_RangeSetup
