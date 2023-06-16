	.cpu arm7tdmi
	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 2	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"FreeMU_ButtonPress.c"
@ GNU C17 (devkitARM release 59) version 12.2.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -O2
	.text
	.align	1
	.p2align 2,,3
	.global	FMU_open_um
	.syntax unified
	.code	16
	.thumb_func
	.type	FMU_open_um, %function
FMU_open_um:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ FreeMU_ButtonPress.c:23: 	gLCDIOBuffer.dispControl.enableWin0 = 0;
	movs	r2, #31	@ tmp130,
	ldr	r3, .L3	@ tmp123,
	ldrb	r1, [r3, #1]	@ MEM <unsigned char> [(struct DispControl *)&gLCDIOBuffer + 1B], MEM <unsigned char> [(struct DispControl *)&gLCDIOBuffer + 1B]
	ands	r2, r1	@ tmp129, MEM <unsigned char> [(struct DispControl *)&gLCDIOBuffer + 1B]
@ FreeMU_ButtonPress.c:26: 	gLCDIOBuffer.blendControl.effect = 0;
	movs	r1, #60	@ tmp137,
@ FreeMU_ButtonPress.c:22: bool FMU_open_um(struct FMUProc* proc){
	push	{r4, lr}	@
@ FreeMU_ButtonPress.c:23: 	gLCDIOBuffer.dispControl.enableWin0 = 0;
	strb	r2, [r3, #1]	@ tmp129, MEM <unsigned char> [(struct DispControl *)&gLCDIOBuffer + 1B]
@ FreeMU_ButtonPress.c:29: }
	@ sp needed	@
@ FreeMU_ButtonPress.c:26: 	gLCDIOBuffer.blendControl.effect = 0;
	movs	r2, #63	@ tmp145,
	ldrb	r0, [r3, r1]	@ gLCDIOBuffer.blendControl.effect, gLCDIOBuffer.blendControl.effect
	ands	r2, r0	@ tmp144, gLCDIOBuffer.blendControl.effect
	strb	r2, [r3, r1]	@ tmp144, gLCDIOBuffer.blendControl.effect
@ FreeMU_ButtonPress.c:27: 	StartSemiCenteredOrphanMenu(&gUnitActionMenuDef, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x14);
	ldr	r3, .L3+4	@ tmp147,
	movs	r2, #28	@ tmp157,
	ldrsh	r1, [r3, r2]	@ tmp148, tmp147, tmp157
@ FreeMU_ButtonPress.c:27: 	StartSemiCenteredOrphanMenu(&gUnitActionMenuDef, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x14);
	movs	r2, #12	@ tmp158,
	ldrsh	r3, [r3, r2]	@ tmp150, tmp147, tmp158
@ FreeMU_ButtonPress.c:27: 	StartSemiCenteredOrphanMenu(&gUnitActionMenuDef, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x14);
	ldr	r4, .L3+8	@ tmp153,
	subs	r1, r1, r3	@ tmp151, tmp148, tmp150
	movs	r2, #1	@,
	movs	r3, #20	@,
	ldr	r0, .L3+12	@ tmp152,
	bl	.L5		@
@ FreeMU_ButtonPress.c:29: }
	movs	r0, #1	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L4:
	.align	2
.L3:
	.word	gLCDIOBuffer
	.word	gBmSt
	.word	StartSemiCenteredOrphanMenu
	.word	gUnitActionMenuDef
	.size	FMU_open_um, .-FMU_open_um
	.align	1
	.p2align 2,,3
	.global	FMU_OnButton_StartMenu
	.syntax unified
	.code	16
	.thumb_func
	.type	FMU_OnButton_StartMenu, %function
FMU_OnButton_StartMenu:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ FreeMU_ButtonPress.c:34: 	gLCDIOBuffer.dispControl.enableWin0 = 0;
	movs	r2, #31	@ tmp125,
	ldr	r3, .L7	@ tmp118,
	ldrb	r1, [r3, #1]	@ MEM <unsigned char> [(struct DispControl *)&gLCDIOBuffer + 1B], MEM <unsigned char> [(struct DispControl *)&gLCDIOBuffer + 1B]
	ands	r2, r1	@ tmp124, MEM <unsigned char> [(struct DispControl *)&gLCDIOBuffer + 1B]
@ FreeMU_ButtonPress.c:37: 	gLCDIOBuffer.blendControl.effect = 0;
	movs	r1, #60	@ tmp132,
@ FreeMU_ButtonPress.c:33: bool FMU_OnButton_StartMenu(FMUProc* proc){
	push	{r4, lr}	@
@ FreeMU_ButtonPress.c:34: 	gLCDIOBuffer.dispControl.enableWin0 = 0;
	strb	r2, [r3, #1]	@ tmp124, MEM <unsigned char> [(struct DispControl *)&gLCDIOBuffer + 1B]
@ FreeMU_ButtonPress.c:40: }
	@ sp needed	@
@ FreeMU_ButtonPress.c:37: 	gLCDIOBuffer.blendControl.effect = 0;
	movs	r2, #63	@ tmp140,
	ldrb	r0, [r3, r1]	@ gLCDIOBuffer.blendControl.effect, gLCDIOBuffer.blendControl.effect
	ands	r2, r0	@ tmp139, gLCDIOBuffer.blendControl.effect
	strb	r2, [r3, r1]	@ tmp139, gLCDIOBuffer.blendControl.effect
@ FreeMU_ButtonPress.c:38: 	StartMenuAdjusted(&FreeMovementLMenu,0,0,0);
	ldr	r4, .L7+4	@ tmp143,
	movs	r3, #0	@,
	movs	r2, #0	@,
	movs	r1, #0	@,
	ldr	r0, .L7+8	@ tmp142,
	bl	.L5		@
@ FreeMU_ButtonPress.c:40: }
	movs	r0, #1	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L8:
	.align	2
.L7:
	.word	gLCDIOBuffer
	.word	StartMenuAdjusted
	.word	FreeMovementLMenu
	.size	FMU_OnButton_StartMenu, .-FMU_OnButton_StartMenu
	.align	1
	.p2align 2,,3
	.global	FMU_OnButton_EndFreeMove
	.syntax unified
	.code	16
	.thumb_func
	.type	FMU_OnButton_EndFreeMove, %function
FMU_OnButton_EndFreeMove:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ FreeMU_ButtonPress.c:43: 	struct FMUProc* proc = (struct FMUProc*)ProcFind(FreeMovementControlProc);
	ldr	r3, .L10	@ tmp117,
@ FreeMU_ButtonPress.c:48: }
	@ sp needed	@
@ FreeMU_ButtonPress.c:43: 	struct FMUProc* proc = (struct FMUProc*)ProcFind(FreeMovementControlProc);
	ldr	r0, .L10+4	@ tmp116,
	bl	.L12		@
@ FreeMU_ButtonPress.c:44: 	FreeMoveRam->silent = false; 
	movs	r1, #16	@ tmp125,
@ FreeMU_ButtonPress.c:43: 	struct FMUProc* proc = (struct FMUProc*)ProcFind(FreeMovementControlProc);
	movs	r4, r0	@ proc, tmp130
@ FreeMU_ButtonPress.c:44: 	FreeMoveRam->silent = false; 
	ldr	r3, .L10+8	@ tmp119,
	ldr	r2, [r3]	@ FreeMoveRam, FreeMoveRam
	ldrb	r3, [r2]	@ FreeMoveRam.0_1->silent, FreeMoveRam.0_1->silent
	bics	r3, r1	@ tmp124, tmp125
	strb	r3, [r2]	@ tmp124, FreeMoveRam.0_1->silent
@ FreeMU_ButtonPress.c:45: 	ProcGoto((Proc*)proc,0xF);
	subs	r1, r1, #1	@,
	ldr	r3, .L10+12	@ tmp127,
	bl	.L12		@
@ FreeMU_ButtonPress.c:46: 	End6CInternal_FreeMU(proc);
	movs	r0, r4	@, proc
	ldr	r3, .L10+16	@ tmp128,
	bl	.L12		@
@ FreeMU_ButtonPress.c:48: }
	movs	r0, #183	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L11:
	.align	2
.L10:
	.word	ProcFind
	.word	FreeMovementControlProc
	.word	FreeMoveRam
	.word	ProcGoto
	.word	End6CInternal_FreeMU
	.size	FMU_OnButton_EndFreeMove, .-FMU_OnButton_EndFreeMove
	.align	1
	.p2align 2,,3
	.global	FMU_EndFreeMoveSilent
	.syntax unified
	.code	16
	.thumb_func
	.type	FMU_EndFreeMoveSilent, %function
FMU_EndFreeMoveSilent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ FreeMU_ButtonPress.c:51: 	FreeMoveRam->silent = true; 
	movs	r1, #16	@ tmp122,
	ldr	r3, .L14	@ tmp117,
	ldr	r2, [r3]	@ FreeMoveRam, FreeMoveRam
	ldrb	r3, [r2]	@ FreeMoveRam.1_1->silent, FreeMoveRam.1_1->silent
	orrs	r3, r1	@ tmp124, tmp122
@ FreeMU_ButtonPress.c:50: int FMU_EndFreeMoveSilent(void){
	push	{r4, lr}	@
@ FreeMU_ButtonPress.c:52: 	struct FMUProc* proc = (struct FMUProc*)ProcFind(FreeMovementControlProc);
	ldr	r0, .L14+4	@ tmp126,
@ FreeMU_ButtonPress.c:56: }
	@ sp needed	@
@ FreeMU_ButtonPress.c:51: 	FreeMoveRam->silent = true; 
	strb	r3, [r2]	@ tmp124, FreeMoveRam.1_1->silent
@ FreeMU_ButtonPress.c:52: 	struct FMUProc* proc = (struct FMUProc*)ProcFind(FreeMovementControlProc);
	ldr	r3, .L14+8	@ tmp127,
	bl	.L12		@
	movs	r4, r0	@ proc, tmp131
@ FreeMU_ButtonPress.c:53: 	ProcGoto((Proc*)proc,0xF);
	movs	r1, #15	@,
	ldr	r3, .L14+12	@ tmp128,
	bl	.L12		@
@ FreeMU_ButtonPress.c:54: 	End6CInternal_FreeMU(proc);
	movs	r0, r4	@, proc
	ldr	r3, .L14+16	@ tmp129,
	bl	.L12		@
@ FreeMU_ButtonPress.c:56: }
	movs	r0, #183	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L15:
	.align	2
.L14:
	.word	FreeMoveRam
	.word	FreeMovementControlProc
	.word	ProcFind
	.word	ProcGoto
	.word	End6CInternal_FreeMU
	.size	FMU_EndFreeMoveSilent, .-FMU_EndFreeMoveSilent
	.align	1
	.p2align 2,,3
	.global	FMU_OnButton_ChangeUnit
	.syntax unified
	.code	16
	.thumb_func
	.type	FMU_OnButton_ChangeUnit, %function
FMU_OnButton_ChangeUnit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ FreeMU_ButtonPress.c:59: 	Unit* UnitNext = GetUnit(proc->FMUnit->index+1);
	ldr	r3, [r0, #48]	@ proc_14(D)->FMUnit, proc_14(D)->FMUnit
@ FreeMU_ButtonPress.c:58: bool FMU_OnButton_ChangeUnit(FMUProc* proc){
	movs	r4, r0	@ proc, tmp146
@ FreeMU_ButtonPress.c:59: 	Unit* UnitNext = GetUnit(proc->FMUnit->index+1);
	ldrb	r0, [r3, #11]	@ tmp128,
	adds	r0, r0, #1	@ tmp129,
	lsls	r0, r0, #24	@ tmp131, tmp129,
	ldr	r5, .L29	@ tmp145,
	lsrs	r0, r0, #24	@ tmp130, tmp131,
	bl	.L31		@
.L17:
@ FreeMU_ButtonPress.c:7: 	if(-1==unit->xPos)
	movs	r3, #16	@ tmp135,
	ldrsb	r3, [r0, r3]	@ tmp135,
	adds	r3, r3, #1	@ tmp151, tmp135,
	beq	.L19		@,
@ FreeMU_ButtonPress.c:15: 	if(0==unit->pCharacterData)
	ldr	r3, [r0]	@ UnitNext_8->pCharacterData, UnitNext_8->pCharacterData
	cmp	r3, #0	@ UnitNext_8->pCharacterData,
	beq	.L20		@,
.L18:
@ FreeMU_ButtonPress.c:77: }
	@ sp needed	@
@ FreeMU_ButtonPress.c:67: 			gActiveUnit = UnitNext;
	ldr	r3, .L29+4	@ tmp143,
@ FreeMU_ButtonPress.c:66: 			proc->FMUnit = UnitNext;
	str	r0, [r4, #48]	@ UnitNext, proc_14(D)->FMUnit
@ FreeMU_ButtonPress.c:67: 			gActiveUnit = UnitNext;
	str	r0, [r3]	@ UnitNext, gActiveUnit
@ FreeMU_ButtonPress.c:77: }
	movs	r0, #1	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L19:
@ FreeMU_ButtonPress.c:62: 		UnitNext = GetUnit(UnitNext->index+1);
	ldrb	r0, [r0, #11]	@ tmp138,
	adds	r0, r0, #1	@ tmp139,
	lsls	r0, r0, #24	@ tmp140, tmp139,
	lsrs	r0, r0, #24	@ _7, tmp140,
	bl	.L31		@
@ FreeMU_ButtonPress.c:13: 	if(0==unit)
	cmp	r0, #0	@ UnitNext,
	beq	.L20		@,
@ FreeMU_ButtonPress.c:15: 	if(0==unit->pCharacterData)
	ldr	r3, [r0]	@ UnitNext_24->pCharacterData, UnitNext_24->pCharacterData
	cmp	r3, #0	@ UnitNext_24->pCharacterData,
	bne	.L17		@,
.L20:
@ FreeMU_ButtonPress.c:73: 		UnitNext = GetUnit(1);
	movs	r0, #1	@,
	bl	.L31		@
@ FreeMU_ButtonPress.c:76: 	return 1;
	b	.L18		@
.L30:
	.align	2
.L29:
	.word	GetUnit
	.word	gActiveUnit
	.size	FMU_OnButton_ChangeUnit, .-FMU_OnButton_ChangeUnit
	.ident	"GCC: (devkitARM release 59) 12.2.0"
	.code 16
	.align	1
.L12:
	bx	r3
.L5:
	bx	r4
.L31:
	bx	r5
