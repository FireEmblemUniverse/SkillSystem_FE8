@ Hook at MapAddinRange.
@ Calculates DR.
.thumb

.equ DRindicator,		0x0801B91B @ DR-caller.
.equ gMapSize,			0x0202E4D4
.equ gpSubjectMap,		0x030049A0
.equ Fog,				0x0202E4E8

.equ ChapterData,		0x0202BCF0

@ Mimic 0801AACC, MapAddInRange.
mov		r8, r2
mov		r10, r3
mov		r5, r8
mov		r4, r9
add		r0, r4, r5

@ Check for FOW.
ldr		r1, =ChapterData
ldrb	r1, [r1,#0xD]
cmp		r1,	#0x0
bne		NoDR

@ Check if DR called us.
ldr		r1, =DRindicator
ldr		r2, [sp, #0x5C] @ r2's value won't be reused in MapAddInRange (IDK about its caller, but non-r0 scratch register).
cmp		r1, r2
beq		initfog @ Branch if DR call.

@ Return to regular MapAddInRange.
NoDR:
cmp		r4, r0
bx		r14

initfog:
cmp		r4 ,r0
bgt		L1ab3c
    ldr		r1, =gMapSize
    mov		r2, #0x2
    ldsh	r0, [r1, r2]
    cmp		r4 ,r0
    bge		L1ab3c
		L1aae4:
        ldr		r6,[sp, #0x0]
        sub		r1 ,r6, r5
        lsl		r0 ,r5 ,#0x1
        add		r0, #0x1
        cmp		r1, #0x0
        bge		L1aaf4
            add		r0 ,r0, r1
            mov		r1, #0x0
		L1aaf4:
        add		r3 ,r1, r0
        ldr		r2, =gMapSize
        mov		r6, #0x0
        ldsh	r0, [r2, r6]
        cmp		r3 ,r0
        ble		L1ab02
            mov		r3 ,r0
		L1ab02:
        mov		r2 ,r1
        sub		r5, #0x1
        add		r7 ,r4, #0x1
        mov		r6, r9
        add		r6, r8
        cmp		r2 ,r3
        bge		L1ab2c
            ldr		r0, =Fog
            str		r0, [r13, #0x4]
            lsl		r4 ,r4 ,#0x2
			L1ab16:
            ldr		r1, [r13, #0x4]
            ldr		r0, [r1, #0x0]
            add		r0 ,r4, r0
            ldr		r1, [r0, #0x0]
            add		r1 ,r1, r2
			mov		r0,#0x1
            strb	r0, [r1, #0x0]
            add		r2, #0x1
            cmp		r2 ,r3
            blt		L1ab16
		L1ab2c:
        mov		r4 ,r7
        cmp		r4 ,r6
        bgt		L1ab3c
            ldr		r2, =gMapSize
            mov		r6, #0x2
            ldsh	r0, [r2, r6]
            cmp		r4 ,r0
            blt		L1aae4
L1ab3c:
mov		r5, r8
sub		r5, #0x1
mov		r4, r9
sub		r4, #0x1
mov		r0, r9
mov		r1, r8
sub		r0 ,r0, r1
mov		r8, r0
cmp		r4, r8
blt		L1aba6
    cmp		r4, #0x0
    blt		L1aba6
        ldr		r2, =gMapSize
        str		r2, [r13, #0x4]
        ldr		r6, =gpSubjectMap
        mov		r9, r6
		L1ab5c:
        ldr		r0,[sp, #0x0]
        sub		r1 ,r0, r5
        lsl		r0 ,r5 ,#0x1
        add		r0, #0x1
        cmp		r1, #0x0
        bge		L1ab6c
            add		r0 ,r0, r1
            mov		r1, #0x0
		L1ab6c:
        add		r3 ,r1, r0
        ldr		r2, [r13, #0x4]
        mov		r6, #0x0
        ldsh	r0, [r2, r6]
        cmp		r3 ,r0
        ble		L1ab7a
            mov		r3 ,r0
		L1ab7a:
        mov		r2 ,r1
        sub		r5, #0x1
        sub		r6 ,r4, #0x1
        cmp		r2 ,r3
        bge		L1ab9c
            mov		r7, r9
            lsl		r4 ,r4 ,#0x2
			L1ab88:
            ldr		r0, =Fog
			ldr		r0, [r0, #0x0]
            add		r0 ,r4, r0
            ldr		r1, [r0, #0x0]
            add		r1 ,r1, r2
			mov		r0,#0x1
            strb	r0, [r1, #0x0]
            add		r2, #0x1
            cmp		r2 ,r3
            blt		L1ab88
		L1ab9c:
        mov		r4 ,r6
        cmp		r6, r8
        blt		L1aba6
            cmp		r6, #0x0
            bge		L1ab5c
L1aba6:
add		sp, #0x8
pop		{r3, r4, r5}
mov		r8, r3
mov		r9, r4
mov		r10, r5
pop		{r4, r5, r6, r7}
pop		{r0} @ Return from MapAddInRange, instead of to MapAddInRange.
bx		r0
