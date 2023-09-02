	.cpu arm7tdmi
	.arch armv4t
	.fpu softvfp
	.eabi_attribute 23, 1	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 4	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"soar_voxel.c"
@ GNU C17 (devkitARM release 58) version 12.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -march=armv4t -Os -fomit-frame-pointer -ffast-math -fno-jump-tables
	.text
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.type	getPtHeight_thumb, %function
getPtHeight_thumb:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ src/soar_voxel.c:480: 	if((ptx >= MAP_DIMENSIONS)||(pty >= MAP_DIMENSIONS)||(ptx<0)||(pty<0)) return 0;
	movs	r3, #128	@ tmp122,
@ src/soar_voxel.c:479: static inline int getPtHeight_thumb(int ptx, int pty){
	push	{r4, lr}	@
@ src/soar_voxel.c:480: 	if((ptx >= MAP_DIMENSIONS)||(pty >= MAP_DIMENSIONS)||(ptx<0)||(pty<0)) return 0;
	movs	r4, r0	@ tmp121, ptx
@ src/soar_voxel.c:479: static inline int getPtHeight_thumb(int ptx, int pty){
	movs	r2, r0	@ ptx, tmp127
@ src/soar_voxel.c:480: 	if((ptx >= MAP_DIMENSIONS)||(pty >= MAP_DIMENSIONS)||(ptx<0)||(pty<0)) return 0;
	orrs	r4, r1	@ tmp121, pty
@ src/soar_voxel.c:480: 	if((ptx >= MAP_DIMENSIONS)||(pty >= MAP_DIMENSIONS)||(ptx<0)||(pty<0)) return 0;
	movs	r0, #0	@ <retval>,
@ src/soar_voxel.c:480: 	if((ptx >= MAP_DIMENSIONS)||(pty >= MAP_DIMENSIONS)||(ptx<0)||(pty<0)) return 0;
	lsls	r3, r3, #3	@ tmp122, tmp122,
	cmp	r4, r3	@ tmp121, tmp122
	bcs	.L1		@,
@ src/soar_voxel.c:481: 	return heightMap[(pty<<MAP_DIMENSIONS_LOG2)+ptx];
	ldr	r3, .L4	@ tmp123,
@ src/soar_voxel.c:481: 	return heightMap[(pty<<MAP_DIMENSIONS_LOG2)+ptx];
	lsls	r1, r1, #10	@ tmp124, pty,
@ src/soar_voxel.c:481: 	return heightMap[(pty<<MAP_DIMENSIONS_LOG2)+ptx];
	adds	r3, r3, r2	@ tmp125, tmp123, ptx
	ldrb	r0, [r3, r1]	@ <retval>, heightMap
.L1:
@ src/soar_voxel.c:482: };
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L5:
	.align	2
.L4:
	.word	heightMap
	.size	getPtHeight_thumb, .-getPtHeight_thumb
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.type	SoaringLandRoutine, %function
SoaringLandRoutine:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ src/soar_voxel.c:120: 		u8 index = CurrentProc->location-1;
	ldr	r3, [r0, #80]	@ CurrentProc_15(D)->location, CurrentProc_15(D)->location
@ src/soar_voxel.c:119: static void SoaringLandRoutine(SoarProc* CurrentProc){
	push	{r4, lr}	@
@ src/soar_voxel.c:120: 		u8 index = CurrentProc->location-1;
	subs	r3, r3, #1	@ tmp130,
@ src/soar_voxel.c:124:     FlyLocationTable[index*4+1],
	lsls	r3, r3, #24	@ tmp131, tmp130,
@ src/soar_voxel.c:124:     FlyLocationTable[index*4+1],
	ldr	r2, .L7	@ tmp133,
@ src/soar_voxel.c:139: }
	@ sp needed	@
@ src/soar_voxel.c:124:     FlyLocationTable[index*4+1],
	lsrs	r3, r3, #24	@ tmp131, tmp131,
	lsls	r3, r3, #2	@ _4, tmp131,
@ src/soar_voxel.c:136:     memcpy((void*)0x202B670, &eventList, 48); //  RAM FEBuilder uses to store temporary event data for chapter jumping
	ldr	r0, .L7+4	@ tmp138,
@ src/soar_voxel.c:124:     FlyLocationTable[index*4+1],
	adds	r1, r2, r3	@ tmp134, tmp133, _4
@ src/soar_voxel.c:130:     FlyLocationTable[index*4],
	ldrb	r2, [r2, r3]	@ _13, FlyLocationTable
@ src/soar_voxel.c:136:     memcpy((void*)0x202B670, &eventList, 48); //  RAM FEBuilder uses to store temporary event data for chapter jumping
	ldr	r3, .L7+8	@ tmp139,
@ src/soar_voxel.c:124:     FlyLocationTable[index*4+1],
	ldrb	r4, [r1, #1]	@ _7, FlyLocationTable
@ src/soar_voxel.c:126:     FlyLocationTable[index*4+2],
	ldrb	r1, [r1, #2]	@ _10, FlyLocationTable
@ src/soar_voxel.c:136:     memcpy((void*)0x202B670, &eventList, 48); //  RAM FEBuilder uses to store temporary event data for chapter jumping
	str	r3, [r0]	@ tmp139, MEM <int> [(char * {ref-all})33732208B]
	ldr	r3, .L7+12	@ tmp141,
	str	r3, [r0, #4]	@ tmp141, MEM <int> [(char * {ref-all})33732208B + 4B]
	str	r3, [r0, #28]	@ tmp141, MEM <int> [(char * {ref-all})33732208B + 28B]
	ldr	r3, .L7+16	@ tmp154,
	str	r1, [r0, #16]	@ _10, MEM <int> [(char * {ref-all})33732208B + 16B]
	str	r3, [r0, #36]	@ tmp154, MEM <int> [(char * {ref-all})33732208B + 36B]
	movs	r1, #164	@ tmp147,
	ldr	r3, .L7+20	@ tmp156,
	str	r3, [r0, #40]	@ tmp156, MEM <int> [(char * {ref-all})33732208B + 40B]
	movs	r3, #144	@ tmp158,
	lsls	r1, r1, #4	@ tmp147, tmp147,
	str	r4, [r0, #8]	@ _7, MEM <int> [(char * {ref-all})33732208B + 8B]
	str	r1, [r0, #20]	@ tmp147, MEM <int> [(char * {ref-all})33732208B + 20B]
	ldr	r4, .L7+24	@ tmp144,
	ldr	r1, .L7+28	@ tmp149,
	lsls	r3, r3, #1	@ tmp158, tmp158,
	str	r1, [r0, #24]	@ tmp149, MEM <int> [(char * {ref-all})33732208B + 24B]
	str	r3, [r0, #44]	@ tmp158, MEM <int> [(char * {ref-all})33732208B + 44B]
@ src/soar_voxel.c:138:     CallMapEventEngine((void*) (0x202B670), 1);
	movs	r1, #1	@,
@ src/soar_voxel.c:136:     memcpy((void*)0x202B670, &eventList, 48); //  RAM FEBuilder uses to store temporary event data for chapter jumping
	str	r4, [r0, #12]	@ tmp144, MEM <int> [(char * {ref-all})33732208B + 12B]
	str	r2, [r0, #32]	@ _13, MEM <int> [(char * {ref-all})33732208B + 32B]
@ src/soar_voxel.c:138:     CallMapEventEngine((void*) (0x202B670), 1);
	ldr	r3, .L7+32	@ tmp160,
	bl	.L9		@
@ src/soar_voxel.c:139: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L8:
	.align	2
.L7:
	.word	FlyLocationTable
	.word	33732208
	.word	3938081
	.word	132416
	.word	-185822
	.word	459304
	.word	329024
	.word	FlyDestinationEvent
	.word	CallMapEventEngine
	.size	SoaringLandRoutine, .-SoaringLandRoutine
	.align	1
	.global	SoarVBlankInterrupt
	.syntax unified
	.code	16
	.thumb_func
	.type	SoarVBlankInterrupt, %function
SoarVBlankInterrupt:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ src/soar_voxel.c:89: 	*(u16*)(0x3007ff8) = 1;
	movs	r2, #1	@ tmp129,
	ldr	r3, .L27	@ tmp128,
@ src/soar_voxel.c:88: {
	push	{r4, lr}	@
@ src/soar_voxel.c:89: 	*(u16*)(0x3007ff8) = 1;
	strh	r2, [r3]	@ tmp129, MEM[(u16 *)50364408B]
@ src/soar_voxel.c:90: 	IncrementGameClock();
	bl	IncrementGameClock		@
@ src/soar_voxel.c:91: 	m4aSoundVSync();
	bl	m4aSoundVSync		@
@ src/soar_voxel.c:92: 	SyncLoOAM();
	ldr	r3, .L27+4	@ tmp131,
	bl	.L9		@
@ src/soar_voxel.c:93: 	if(gGameState.boolMainLoopEnded)
	ldr	r3, .L27+8	@ tmp132,
@ src/soar_voxel.c:93: 	if(gGameState.boolMainLoopEnded)
	ldrb	r2, [r3]	@ gGameState, gGameState
	cmp	r2, #0	@ gGameState,
	beq	.L11		@,
@ src/soar_voxel.c:95: 		gGameState.boolMainLoopEnded = 0;
	movs	r2, #0	@ tmp135,
	strb	r2, [r3]	@ tmp135, gGameState.boolMainLoopEnded
@ src/soar_voxel.c:96: 		ExecProc(*(int*)(0x2026A70));
	ldr	r3, .L27+12	@ tmp137,
@ src/soar_voxel.c:96: 		ExecProc(*(int*)(0x2026A70));
	ldr	r0, [r3]	@, MEM[(int *)33712752B]
	ldr	r3, .L27+16	@ tmp138,
	bl	.L9		@
@ src/soar_voxel.c:97: 		SyncLCDControl();
	ldr	r3, .L27+20	@ tmp139,
	bl	.L9		@
@ src/soar_voxel.c:98: 		SyncBgAndPals();
	ldr	r3, .L27+24	@ tmp140,
	bl	.L9		@
@ src/soar_voxel.c:99: 		SyncRegisteredTiles();
	ldr	r3, .L27+28	@ tmp141,
	bl	.L9		@
@ src/soar_voxel.c:100: 		SyncHiOAM();
	ldr	r3, .L27+32	@ tmp142,
	bl	.L9		@
.L11:
@ src/soar_voxel.c:102: 	m4aSoundMain();
	bl	m4aSoundMain		@
	movs	r2, #63	@ tmp147,
@ src/soar_voxel.c:104: 	int animClock = *(u8*)(0x3000014) & 0x3F;
	ldr	r3, .L27+36	@ tmp143,
	ldrb	r3, [r3]	@ MEM[(u8 *)50331668B], MEM[(u8 *)50331668B]
	ands	r3, r2	@ _1, tmp147
@ src/soar_voxel.c:105: 	if ((animClock < 0x10) | (animClock > 0x30))	g_REG_BG2X-=0x30; //the same as eirika's map sprite?
	movs	r1, r3	@ tmp149, _1
	subs	r1, r1, #16	@ tmp149,
	ldr	r2, .L27+40	@ tmp172,
@ src/soar_voxel.c:105: 	if ((animClock < 0x10) | (animClock > 0x30))	g_REG_BG2X-=0x30; //the same as eirika's map sprite?
	cmp	r1, #32	@ tmp149,
	bls	.L12		@,
@ src/soar_voxel.c:105: 	if ((animClock < 0x10) | (animClock > 0x30))	g_REG_BG2X-=0x30; //the same as eirika's map sprite?
	ldr	r1, [r2]	@ _8, MEM[(volatile vu32 *)50344144B]
@ src/soar_voxel.c:105: 	if ((animClock < 0x10) | (animClock > 0x30))	g_REG_BG2X-=0x30; //the same as eirika's map sprite?
	subs	r1, r1, #48	@ _9,
	str	r1, [r2]	@ _9, MEM[(volatile vu32 *)50344144B]
@ src/soar_voxel.c:111: 	if (animClock == 0) //resets once per 63 frames so close enough
	cmp	r3, #0	@ _1,
	beq	.L13		@,
.L10:
@ src/soar_voxel.c:117: };
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L12:
@ src/soar_voxel.c:106: 	else if (g_REG_BG2X<0x9fd0) g_REG_BG2X+=0x30;
	ldr	r0, [r2]	@ _10, MEM[(volatile vu32 *)50344144B]
@ src/soar_voxel.c:106: 	else if (g_REG_BG2X<0x9fd0) g_REG_BG2X+=0x30;
	ldr	r1, .L27+44	@ tmp153,
	cmp	r0, r1	@ _10, tmp153
	bhi	.L26		@,
@ src/soar_voxel.c:106: 	else if (g_REG_BG2X<0x9fd0) g_REG_BG2X+=0x30;
	ldr	r1, [r2]	@ _11, MEM[(volatile vu32 *)50344144B]
@ src/soar_voxel.c:106: 	else if (g_REG_BG2X<0x9fd0) g_REG_BG2X+=0x30;
	adds	r1, r1, #48	@ _12,
	str	r1, [r2]	@ _12, MEM[(volatile vu32 *)50344144B]
.L26:
@ src/soar_voxel.c:108: 	if ((animClock == 0x20) && (gChapterData.muteSfxOption == 0)) m4aSongNumStart(0xa6);
	cmp	r3, #32	@ _1,
	bne	.L10		@,
@ src/soar_voxel.c:108: 	if ((animClock == 0x20) && (gChapterData.muteSfxOption == 0)) m4aSongNumStart(0xa6);
	ldr	r3, .L27+48	@ tmp159,
	ldrb	r3, [r3]	@ gChapterData, gChapterData
@ src/soar_voxel.c:108: 	if ((animClock == 0x20) && (gChapterData.muteSfxOption == 0)) m4aSongNumStart(0xa6);
	lsls	r3, r3, #30	@ tmp173, gChapterData,
	bmi	.L10		@,
@ src/soar_voxel.c:108: 	if ((animClock == 0x20) && (gChapterData.muteSfxOption == 0)) m4aSongNumStart(0xa6);
	movs	r0, #166	@,
	ldr	r3, .L27+52	@ tmp167,
	bl	.L9		@
	b	.L10		@
.L13:
@ src/soar_voxel.c:113: 		FPS_CURRENT = FPS_COUNTER;
	ldr	r2, .L27+56	@ tmp168,
@ src/soar_voxel.c:113: 		FPS_CURRENT = FPS_COUNTER;
	ldr	r1, .L27+60	@ tmp169,
@ src/soar_voxel.c:113: 		FPS_CURRENT = FPS_COUNTER;
	ldr	r0, [r2]	@ _15, MEM[(int *)33816568B]
@ src/soar_voxel.c:113: 		FPS_CURRENT = FPS_COUNTER;
	str	r0, [r1]	@ _15, MEM[(int *)33816572B]
@ src/soar_voxel.c:114: 		FPS_COUNTER = 0;
	str	r3, [r2]	@ _1, MEM[(int *)33816568B]
@ src/soar_voxel.c:117: };
	b	.L10		@
.L28:
	.align	2
.L27:
	.word	50364408
	.word	SyncLoOAM
	.word	gGameState
	.word	33712752
	.word	ExecProc
	.word	SyncLCDControl
	.word	SyncBgAndPals
	.word	SyncRegisteredTiles
	.word	SyncHiOAM
	.word	50331668
	.word	50344144
	.word	40911
	.word	gChapterData+65
	.word	m4aSongNumStart
	.word	33816568
	.word	33816572
	.size	SoarVBlankInterrupt, .-SoarVBlankInterrupt
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.type	BumpScreen.part.0, %function
BumpScreen.part.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ src/soar_voxel.c:470: 			g_REG_BG2PA=0x00;	//rotate and stretch	
	movs	r3, #0	@ tmp114,
@ src/soar_voxel.c:477: };
	@ sp needed	@
@ src/soar_voxel.c:471: 			g_REG_BG2PB=0xFF0C; //a bit bigger than the screen (-0xF4?)
	movs	r1, #244	@ tmp117,
@ src/soar_voxel.c:470: 			g_REG_BG2PA=0x00;	//rotate and stretch	
	ldr	r2, .L30	@ tmp113,
	strh	r3, [r2]	@ tmp114, MEM[(volatile vu16 *)50344136B]
@ src/soar_voxel.c:471: 			g_REG_BG2PB=0xFF0C; //a bit bigger than the screen (-0xF4?)
	ldr	r2, .L30+4	@ tmp116,
	rsbs	r1, r1, #0	@ tmp117, tmp117
	strh	r1, [r2]	@ tmp117, MEM[(volatile vu16 *)50344138B]
@ src/soar_voxel.c:472: 			g_REG_BG2PC=0x85; //
	ldr	r2, .L30+8	@ tmp119,
	adds	r1, r1, #122	@ tmp120,
	adds	r1, r1, #255	@ tmp120,
	strh	r1, [r2]	@ tmp120, MEM[(volatile vu16 *)50344140B]
@ src/soar_voxel.c:473: 			g_REG_BG2PD=0x00;	//
	ldr	r2, .L30+12	@ tmp122,
	strh	r3, [r2]	@ tmp114, MEM[(volatile vu16 *)50344142B]
@ src/soar_voxel.c:474: 			g_REG_BG2X=0x9e40;	//offset 'horizontal' can bump 0x180 each way
	ldr	r3, .L30+16	@ tmp125,
	ldr	r2, .L30+20	@ tmp126,
	str	r2, [r3]	@ tmp126, MEM[(volatile vu32 *)50344144B]
@ src/soar_voxel.c:475: 			g_REG_BG2Y = 0x180;     //can bump it 0x180 each way
	movs	r2, #192	@ tmp128,
	ldr	r3, .L30+24	@ tmp127,
	lsls	r2, r2, #1	@ tmp128, tmp128,
	str	r2, [r3]	@ tmp128, MEM[(volatile vu32 *)50344148B]
@ src/soar_voxel.c:477: };
	bx	lr
.L31:
	.align	2
.L30:
	.word	50344136
	.word	50344138
	.word	50344140
	.word	50344142
	.word	50344144
	.word	40512
	.word	50344148
	.size	BumpScreen.part.0, .-BumpScreen.part.0
	.align	1
	.global	vid_flip
	.syntax unified
	.code	16
	.thumb_func
	.type	vid_flip, %function
vid_flip:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ src/soar_voxel.c:70: 	    vid_page= (u16*)((u32)vid_page ^ VID_FLIP);
	movs	r3, #160	@ tmp119,
@ src/soar_voxel.c:74: }
	@ sp needed	@
@ src/soar_voxel.c:70: 	    vid_page= (u16*)((u32)vid_page ^ VID_FLIP);
	lsls	r3, r3, #8	@ tmp119, tmp119,
	eors	r0, r3	@ _2, tmp119
@ src/soar_voxel.c:71: 	    g_LCDIOBuffer ^= DCNT_PAGE;            // update control register
	movs	r3, #16	@ tmp125,
@ src/soar_voxel.c:71: 	    g_LCDIOBuffer ^= DCNT_PAGE;            // update control register
	ldr	r2, .L33	@ tmp120,
	ldrh	r1, [r2]	@ MEM[(volatile vu16 *)50344064B], MEM[(volatile vu16 *)50344064B]
@ src/soar_voxel.c:71: 	    g_LCDIOBuffer ^= DCNT_PAGE;            // update control register
	eors	r3, r1	@ _4, MEM[(volatile vu16 *)50344064B]
	strh	r3, [r2]	@ _4, MEM[(volatile vu16 *)50344064B]
@ src/soar_voxel.c:74: }
	bx	lr
.L34:
	.align	2
.L33:
	.word	50344064
	.size	vid_flip, .-vid_flip
	.align	1
	.global	StartSoaring
	.syntax unified
	.code	16
	.thumb_func
	.type	StartSoaring, %function
StartSoaring:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ src/soar_voxel.c:78: 	START_PROC(Proc_Soaring, ROOT_PROC_3); //create new proc with parent
	movs	r1, #3	@,
@ src/soar_voxel.c:81: };
	@ sp needed	@
@ src/soar_voxel.c:78: 	START_PROC(Proc_Soaring, ROOT_PROC_3); //create new proc with parent
	ldr	r0, .L36	@ tmp115,
	ldr	r3, .L36+4	@ tmp116,
	bl	.L9		@
@ src/soar_voxel.c:81: };
	movs	r0, #23	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L37:
	.align	2
.L36:
	.word	Proc_Soaring
	.word	ProcStart
	.size	StartSoaring, .-StartSoaring
	.align	1
	.global	SoarUsability
	.syntax unified
	.code	16
	.thumb_func
	.type	SoarUsability, %function
SoarUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ src/soar_voxel.c:85: };
	movs	r0, #1	@,
	@ sp needed	@
	bx	lr
	.size	SoarUsability, .-SoarUsability
	.align	1
	.global	canLandHere
	.syntax unified
	.code	16
	.thumb_func
	.type	canLandHere, %function
canLandHere:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ src/soar_voxel.c:142: 	if (CurrentProc->location == 0){return FALSE;}
	ldr	r0, [r0, #80]	@ <retval>, CurrentProc_7(D)->location
@ src/soar_voxel.c:141: int canLandHere(SoarProc* CurrentProc){
	push	{r4, lr}	@
@ src/soar_voxel.c:142: 	if (CurrentProc->location == 0){return FALSE;}
	cmp	r0, #0	@ <retval>,
	beq	.L39		@,
@ src/soar_voxel.c:144: 	if (CurrentProc->location == 9){label = SaffronArrivedLabel;}
	ldr	r3, .L51	@ tmp117,
@ src/soar_voxel.c:144: 	if (CurrentProc->location == 9){label = SaffronArrivedLabel;}
	cmp	r0, #9	@ <retval>,
	beq	.L50		@,
@ src/soar_voxel.c:145: 	else if (CurrentProc->location == 10){return false; label = CinnabarArrivedLabel;}
	cmp	r0, #10	@ <retval>,
	beq	.L43		@,
@ src/soar_voxel.c:146: 	else if (CurrentProc->location == 11){label = IndigoPlateauArrivedLabel;};
	cmp	r0, #11	@ <retval>,
	bne	.L44		@,
@ src/soar_voxel.c:146: 	else if (CurrentProc->location == 11){label = IndigoPlateauArrivedLabel;};
	ldr	r3, .L51+4	@ tmp118,
.L50:
	ldrh	r3, [r3]	@ label,
@ src/soar_voxel.c:147: 	if (label == 0) {return true;};
	movs	r0, #1	@ <retval>,
@ src/soar_voxel.c:147: 	if (label == 0) {return true;};
	cmp	r3, #0	@ label,
	beq	.L39		@,
@ src/soar_voxel.c:148: 	return CheckEventId_(label);
	movs	r0, r3	@, label
	bl	CheckEventId_		@
.L39:
@ src/soar_voxel.c:149: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L43:
@ src/soar_voxel.c:142: 	if (CurrentProc->location == 0){return FALSE;}
	movs	r0, #0	@ <retval>,
	b	.L39		@
.L44:
@ src/soar_voxel.c:147: 	if (label == 0) {return true;};
	movs	r0, #1	@ <retval>,
	b	.L39		@
.L52:
	.align	2
.L51:
	.word	SaffronArrivedLabel
	.word	IndigoPlateauArrivedLabel
	.size	canLandHere, .-canLandHere
	.align	1
	.global	LoadSprite
	.syntax unified
	.code	16
	.thumb_func
	.type	LoadSprite, %function
LoadSprite:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ src/soar_voxel.c:211: 	LZ77UnCompVram(&pkSprite, &tile_mem[5][0]); //first tile of the hi block 0x6014000
	ldr	r1, .L54	@,
@ src/soar_voxel.c:223: };
	@ sp needed	@
@ src/soar_voxel.c:211: 	LZ77UnCompVram(&pkSprite, &tile_mem[5][0]); //first tile of the hi block 0x6014000
	ldr	r0, .L54+4	@ tmp114,
	bl	LZ77UnCompVram		@
@ src/soar_voxel.c:212: 	LZ77UnCompVram(&locationSprites, &tile_mem[5][64]); //yeah 
	ldr	r1, .L54+8	@,
	ldr	r0, .L54+12	@ tmp116,
	bl	LZ77UnCompVram		@
@ src/soar_voxel.c:213: 	LZ77UnCompVram(&miniCursorSprite, &tile_mem[5][192]);
	ldr	r1, .L54+16	@,
	ldr	r0, .L54+20	@ tmp118,
	bl	LZ77UnCompVram		@
@ src/soar_voxel.c:214: 	LZ77UnCompVram(&minimapSprite, &tile_mem[5][193]);
	ldr	r1, .L54+24	@,
	ldr	r0, .L54+28	@ tmp120,
	bl	LZ77UnCompVram		@
@ src/soar_voxel.c:215: 	LZ77UnCompVram(&fpsSprite, &tile_mem[5][257]); //fps numbers
	ldr	r1, .L54+32	@,
	ldr	r0, .L54+36	@ tmp122,
	bl	LZ77UnCompVram		@
@ src/soar_voxel.c:216: 	LZ77UnCompVram(&lensFlareSprite, &tile_mem[5][289]);
	ldr	r1, .L54+40	@,
	ldr	r0, .L54+44	@ tmp124,
	bl	LZ77UnCompVram		@
@ src/soar_voxel.c:218: 	ApplyPalette(&pkPal, 0x1c);
	movs	r1, #224	@ tmp140,
	ldr	r4, .L54+48	@ tmp127,
	movs	r2, #32	@,
	ldr	r0, .L54+52	@ tmp126,
	lsls	r1, r1, #2	@, tmp140,
	bl	.L56		@
@ src/soar_voxel.c:219: 	ApplyPalette(&miniCursorPal, 0x1d);
	movs	r1, #232	@ tmp141,
	movs	r2, #32	@,
	ldr	r0, .L54+56	@ tmp129,
	lsls	r1, r1, #2	@, tmp141,
	bl	.L56		@
@ src/soar_voxel.c:220: 	ApplyPalette(&locationPal, 0x1e);
	movs	r1, #240	@ tmp142,
	movs	r2, #32	@,
	ldr	r0, .L54+60	@ tmp132,
	lsls	r1, r1, #2	@, tmp142,
	bl	.L56		@
@ src/soar_voxel.c:221: 	ApplyPalette(&minimapPal, 0x12);
	movs	r1, #144	@ tmp143,
	movs	r2, #32	@,
	ldr	r0, .L54+64	@ tmp135,
	lsls	r1, r1, #2	@, tmp143,
	bl	.L56		@
@ src/soar_voxel.c:222: 	ApplyPalette(&lensFlarePal, 0x13);
	movs	r1, #152	@ tmp144,
	movs	r2, #32	@,
	ldr	r0, .L54+68	@ tmp138,
	lsls	r1, r1, #2	@, tmp144,
	bl	.L56		@
@ src/soar_voxel.c:223: };
	pop	{r4}
	pop	{r0}
	bx	r0
.L55:
	.align	2
.L54:
	.word	100745216
	.word	pkSprite
	.word	100747264
	.word	locationSprites
	.word	100751360
	.word	miniCursorSprite
	.word	100751392
	.word	minimapSprite
	.word	100753440
	.word	fpsSprite
	.word	100754464
	.word	lensFlareSprite
	.word	CopyToPaletteBuffer
	.word	pkPal
	.word	miniCursorPal
	.word	locationPal
	.word	minimapPal
	.word	lensFlarePal
	.size	LoadSprite, .-LoadSprite
	.align	1
	.global	SetUpNewWMGraphics
	.syntax unified
	.code	16
	.thumb_func
	.type	SetUpNewWMGraphics, %function
SetUpNewWMGraphics:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
@ src/soar_voxel.c:152: 	int StartX = originCoords[gChapterData.chapterIndex][0];
	ldr	r5, .L61	@ tmp128,
	ldrb	r2, [r5, #14]	@ _2,
@ src/soar_voxel.c:153: 	int StartY = originCoords[gChapterData.chapterIndex][1];
	ldr	r3, .L61+4	@ tmp129,
	lsls	r2, r2, #1	@ tmp130, _2,
	adds	r1, r3, r2	@ tmp131, tmp129, tmp130
@ src/soar_voxel.c:152: 	int StartX = originCoords[gChapterData.chapterIndex][0];
	ldrb	r3, [r2, r3]	@ StartX, originCoords
@ src/soar_voxel.c:154: 	CurrentProc->sPlayerPosX = (StartX<<6); //x coord mapped to 1024 map size
	lsls	r3, r3, #6	@ tmp136, StartX,
@ src/soar_voxel.c:154: 	CurrentProc->sPlayerPosX = (StartX<<6); //x coord mapped to 1024 map size
	str	r3, [r0, #44]	@ tmp136, CurrentProc_14(D)->sPlayerPosX
@ src/soar_voxel.c:156: 	CurrentProc->sPlayerPosZ = CAMERA_MIN_HEIGHT+(2 * CAMERA_Z_STEP);
	movs	r3, #96	@ tmp140,
@ src/soar_voxel.c:161: 	CurrentProc->location = 0;
	movs	r4, #0	@ tmp138,
@ src/soar_voxel.c:157: 	CurrentProc->sPlayerStepZ = 2;
	movs	r6, #2	@ tmp141,
@ src/soar_voxel.c:163: 	CurrentProc->sunTransition = 0;
	movs	r2, #160	@ tmp152,
@ src/soar_voxel.c:156: 	CurrentProc->sPlayerPosZ = CAMERA_MIN_HEIGHT+(2 * CAMERA_Z_STEP);
	str	r3, [r0, #52]	@ tmp140, CurrentProc_14(D)->sPlayerPosZ
@ src/soar_voxel.c:153: 	int StartY = originCoords[gChapterData.chapterIndex][1];
	ldrb	r1, [r1, #1]	@ StartY, originCoords
@ src/soar_voxel.c:158: 	CurrentProc->sPlayerYaw = a_SE;
	subs	r3, r3, #90	@ tmp142,
	str	r3, [r0, #60]	@ tmp142, CurrentProc_14(D)->sPlayerYaw
@ src/soar_voxel.c:168: 	    CurrentProc->vid_page = (u16*)(0x600A000);
	ldr	r3, .L61+8	@ tmp143,
@ src/soar_voxel.c:155: 	CurrentProc->sPlayerPosY = ((StartY<<6)+ MAP_YOFS);
	lsls	r1, r1, #6	@ tmp137, StartY,
@ src/soar_voxel.c:155: 	CurrentProc->sPlayerPosY = ((StartY<<6)+ MAP_YOFS);
	str	r1, [r0, #48]	@ tmp137, CurrentProc_14(D)->sPlayerPosY
@ src/soar_voxel.c:168: 	    CurrentProc->vid_page = (u16*)(0x600A000);
	str	r3, [r0, #64]	@ tmp143, CurrentProc_14(D)->vid_page
@ src/soar_voxel.c:161: 	CurrentProc->location = 0;
	str	r4, [r0, #80]	@ tmp138, CurrentProc_14(D)->location
@ src/soar_voxel.c:162: 	CurrentProc->sunsetVal = 0;
	str	r4, [r0, #84]	@ tmp138, CurrentProc_14(D)->sunsetVal
@ src/soar_voxel.c:157: 	CurrentProc->sPlayerStepZ = 2;
	str	r6, [r0, #56]	@ tmp141, CurrentProc_14(D)->sPlayerStepZ
@ src/soar_voxel.c:163: 	CurrentProc->sunTransition = 0;
	adds	r0, r0, #6	@ tmp144,
	ldrh	r3, [r0, #62]	@ MEM <unsigned short> [(void *)CurrentProc_14(D) + 68B], MEM <unsigned short> [(void *)CurrentProc_14(D) + 68B]
	lsrs	r3, r3, #12	@ tmp149, MEM <unsigned short> [(void *)CurrentProc_14(D) + 68B],
	lsls	r2, r2, #3	@ tmp152, tmp152,
	lsls	r3, r3, #12	@ tmp148, tmp149,
	orrs	r3, r2	@ tmp151, tmp152
@ src/soar_voxel.c:174: 	CpuFastCopy(NewWMLoop, IRAM_NewWMLoop, SIZEOF_NewWMLoop);
	movs	r2, #160	@,
@ src/soar_voxel.c:163: 	CurrentProc->sunTransition = 0;
	strh	r3, [r0, #62]	@ tmp151, MEM <unsigned short> [(void *)CurrentProc_14(D) + 68B]
@ src/soar_voxel.c:174: 	CpuFastCopy(NewWMLoop, IRAM_NewWMLoop, SIZEOF_NewWMLoop);
	ldr	r3, .L61+12	@ tmp157,
@ src/soar_voxel.c:151: void SetUpNewWMGraphics(SoarProc* CurrentProc){
	sub	sp, sp, #28	@,,
@ src/soar_voxel.c:174: 	CpuFastCopy(NewWMLoop, IRAM_NewWMLoop, SIZEOF_NewWMLoop);
	ldr	r0, .L61+16	@ tmp156,
	ldr	r1, .L61+20	@,
	lsls	r2, r2, #2	@,,
	str	r3, [sp, #12]	@ tmp157, %sfp
	bl	.L9		@
@ src/soar_voxel.c:176: 	VBlankIntrWait();
	ldr	r3, .L61+24	@ tmp158,
	bl	.L9		@
@ src/soar_voxel.c:178: 	g_LCDIOBuffer = DISPCNT_MODE_5 
	ldr	r3, .L61+28	@ tmp159,
	ldr	r2, .L61+32	@ tmp160,
@ src/soar_voxel.c:186: 	SetColorEffectsParameters(3,4,0x10,0); //do these even do anything?
	movs	r1, #4	@,
@ src/soar_voxel.c:178: 	g_LCDIOBuffer = DISPCNT_MODE_5 
	strh	r2, [r3]	@ tmp160, MEM[(volatile vu16 *)50344064B]
@ src/soar_voxel.c:186: 	SetColorEffectsParameters(3,4,0x10,0); //do these even do anything?
	movs	r0, #3	@,
	movs	r3, r4	@, tmp138
	movs	r2, #16	@,
	ldr	r7, .L61+36	@ tmp162,
	bl	.L63		@
@ src/soar_voxel.c:187: 	SetColorEffectsFirstTarget(0,0,0,0,0);
	movs	r1, r4	@, tmp138
	movs	r2, r4	@, tmp138
	movs	r3, r4	@, tmp138
	movs	r0, r4	@, tmp138
	str	r4, [sp]	@ tmp138,
	ldr	r7, .L61+40	@ tmp164,
	bl	.L63		@
@ src/soar_voxel.c:188: 	SetColorEffectBackdropFirstTarget(1);
	movs	r0, #1	@,
	ldr	r3, .L61+44	@ tmp165,
	bl	.L9		@
@ src/soar_voxel.c:194: 	g_REG_BG2PB=0xFF0C; //a bit bigger than the screen (-0xF4?)
	movs	r2, #244	@ tmp170,
@ src/soar_voxel.c:193: 	g_REG_BG2PA=0x00;	//rotate and stretch
	ldr	r3, .L61+48	@ tmp166,
	strh	r4, [r3]	@ tmp138, MEM[(volatile vu16 *)50344136B]
@ src/soar_voxel.c:194: 	g_REG_BG2PB=0xFF0C; //a bit bigger than the screen (-0xF4?)
	ldr	r3, .L61+52	@ tmp169,
	rsbs	r2, r2, #0	@ tmp170, tmp170
	strh	r2, [r3]	@ tmp170, MEM[(volatile vu16 *)50344138B]
@ src/soar_voxel.c:195: 	g_REG_BG2PC=0x85; //
	ldr	r3, .L61+56	@ tmp172,
	adds	r2, r2, #122	@ tmp173,
	adds	r2, r2, #255	@ tmp173,
	strh	r2, [r3]	@ tmp173, MEM[(volatile vu16 *)50344140B]
@ src/soar_voxel.c:196: 	g_REG_BG2PD=0x00;	//
	ldr	r3, .L61+60	@ tmp175,
@ src/soar_voxel.c:197: 	g_REG_BG2X=0x9e40;	//offset 'horizontal' can bump 0x180 each way
	ldr	r2, .L61+64	@ tmp179,
@ src/soar_voxel.c:196: 	g_REG_BG2PD=0x00;	//
	strh	r4, [r3]	@ tmp138, MEM[(volatile vu16 *)50344142B]
@ src/soar_voxel.c:197: 	g_REG_BG2X=0x9e40;	//offset 'horizontal' can bump 0x180 each way
	ldr	r3, .L61+68	@ tmp178,
	str	r2, [r3]	@ tmp179, MEM[(volatile vu32 *)50344144B]
@ src/soar_voxel.c:198: 	g_REG_BG2Y = 0x180;     //can bump it 0x180 each way
	movs	r2, #192	@ tmp181,
	ldr	r3, .L61+72	@ tmp180,
	lsls	r2, r2, #1	@ tmp181, tmp181,
@ src/soar_voxel.c:200: 	Sound_FadeSongOut(10);
	movs	r0, #10	@,
@ src/soar_voxel.c:198: 	g_REG_BG2Y = 0x180;     //can bump it 0x180 each way
	str	r2, [r3]	@ tmp181, MEM[(volatile vu32 *)50344148B]
@ src/soar_voxel.c:202: 	if (gChapterData.unk41_1 == 0) m4aSongNumStart(0x58); //unused slot //if muted option is false
	adds	r5, r5, #65	@ tmp186,
@ src/soar_voxel.c:200: 	Sound_FadeSongOut(10);
	ldr	r3, .L61+76	@ tmp182,
	bl	.L9		@
@ src/soar_voxel.c:201: 	LoadSprite();
	bl	LoadSprite		@
@ src/soar_voxel.c:202: 	if (gChapterData.unk41_1 == 0) m4aSongNumStart(0x58); //unused slot //if muted option is false
	ldrb	r3, [r5]	@ _7, gChapterData
@ src/soar_voxel.c:202: 	if (gChapterData.unk41_1 == 0) m4aSongNumStart(0x58); //unused slot //if muted option is false
	movs	r0, #88	@,
@ src/soar_voxel.c:202: 	if (gChapterData.unk41_1 == 0) m4aSongNumStart(0x58); //unused slot //if muted option is false
	lsls	r2, r3, #31	@ tmp216, _7,
	bpl	.L60		@,
@ src/soar_voxel.c:203: 	else if (gChapterData.muteSfxOption == 0) m4aSongNumStart(0x4e); //windy (play if sfx but no music)
	tst	r3, r6	@ _7, tmp141
	bne	.L59		@,
@ src/soar_voxel.c:203: 	else if (gChapterData.muteSfxOption == 0) m4aSongNumStart(0x4e); //windy (play if sfx but no music)
	movs	r0, #78	@,
.L60:
	ldr	r3, .L61+80	@ tmp198,
	bl	.L9		@
.L59:
@ src/soar_voxel.c:204: 	gCurrentMusic = 0x58;
	movs	r2, #88	@ tmp200,
	ldr	r3, .L61+84	@ tmp199,
@ src/soar_voxel.c:205: 	CpuFastFill16(0, VRAM, (MODE5_WIDTH*MODE5_HEIGHT<<1)); //make it black
	movs	r1, #192	@,
@ src/soar_voxel.c:204: 	gCurrentMusic = 0x58;
	strh	r2, [r3]	@ tmp200, MEM[(volatile u16 *)33705568B]
@ src/soar_voxel.c:205: 	CpuFastFill16(0, VRAM, (MODE5_WIDTH*MODE5_HEIGHT<<1)); //make it black
	movs	r3, #0	@ tmp202,
	ldr	r2, .L61+88	@,
	str	r3, [sp, #20]	@ tmp202, tmp
	lsls	r1, r1, #19	@,,
	ldr	r3, [sp, #12]	@ tmp157, %sfp
	add	r0, sp, #20	@,,
	bl	.L9		@
@ src/soar_voxel.c:207: 	SetInterrupt_LCDVBlank(SoarVBlankInterrupt);
	ldr	r0, .L61+92	@ tmp207,
	ldr	r3, .L61+96	@ tmp208,
	bl	.L9		@
@ src/soar_voxel.c:208: };
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L62:
	.align	2
.L61:
	.word	gChapterData
	.word	originCoords
	.word	100704256
	.word	CpuFastSet
	.word	NewWMLoop
	.word	50360320
	.word	VBlankIntrWait
	.word	50344064
	.word	5189
	.word	SetColorEffectsParameters
	.word	SetColorEffectsFirstTarget
	.word	SetColorEffectBackdropFirstTarget
	.word	50344136
	.word	50344138
	.word	50344140
	.word	50344142
	.word	40512
	.word	50344144
	.word	50344148
	.word	Sound_FadeSongOut
	.word	m4aSongNumStart
	.word	33705568
	.word	16787456
	.word	SoarVBlankInterrupt
	.word	SetInterrupt_LCDVBlank
	.size	SetUpNewWMGraphics, .-SetUpNewWMGraphics
	.align	1
	.global	MoveLord
	.syntax unified
	.code	16
	.thumb_func
	.type	MoveLord, %function
MoveLord:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ src/soar_voxel.c:394: 	VBlankIntrWait();
	ldr	r6, .L65	@ tmp127,
@ src/soar_voxel.c:421: };
	@ sp needed	@
@ src/soar_voxel.c:392: void MoveLord(SoarProc* CurrentProc){
	movs	r5, r0	@ CurrentProc, tmp141
@ src/soar_voxel.c:394: 	VBlankIntrWait();
	bl	.L67		@
@ src/soar_voxel.c:395: 	Proc* wmproc = ProcFind((ProcInstruction*)(0x8a3d748)); //worldmap
	ldr	r3, .L65+4	@ tmp129,
	ldr	r0, .L65+8	@,
	bl	.L9		@
	movs	r4, r0	@ wmproc, tmp142
@ src/soar_voxel.c:396: 	ProcGoto(wmproc, 0x17); //goto the label that fades out of black
	movs	r1, #23	@,
	ldr	r3, .L65+12	@ tmp130,
	bl	.L9		@
@ src/soar_voxel.c:397: 	VBlankIntrWait();
	bl	.L67		@
@ src/soar_voxel.c:398: 	LoadObjUIGfx();
	bl	LoadObjUIGfx		@
@ src/soar_voxel.c:399: 	RefreshWMProc(wmproc);
	movs	r0, r4	@, wmproc
	bl	RefreshWMProc		@
@ src/soar_voxel.c:407: 	GM_PutCharUnit(0, 1, -1, location); //ok so this does actually work but only for the actual location - we still need the map sprite and camera moved.
	movs	r2, #1	@ tmp143,
@ src/soar_voxel.c:406: 	int location = CurrentProc->location;
	ldr	r4, [r5, #80]	@ location, CurrentProc_18(D)->location
@ src/soar_voxel.c:407: 	GM_PutCharUnit(0, 1, -1, location); //ok so this does actually work but only for the actual location - we still need the map sprite and camera moved.
	movs	r1, #1	@,
	movs	r3, r4	@, location
	rsbs	r2, r2, #0	@, tmp143
	movs	r0, #0	@,
	bl	GM_PutCharUnit		@
@ src/soar_voxel.c:408: 	RefreshWMSprite(0); //refreshes the 0th wm entity? 
	movs	r0, #0	@,
	bl	RefreshWMSprite		@
@ src/soar_voxel.c:409: 	cursorX = *(u16*)(0x82060b0 + (32*location) + 0x18);
	ldr	r2, .L65+16	@ tmp134,
@ src/soar_voxel.c:409: 	cursorX = *(u16*)(0x82060b0 + (32*location) + 0x18);
	lsls	r4, r4, #5	@ _1, location,
@ src/soar_voxel.c:409: 	cursorX = *(u16*)(0x82060b0 + (32*location) + 0x18);
	ldrh	r2, [r4, r2]	@ cursorX, *_3
@ src/soar_voxel.c:410: 	cursorY = *(u16*)(0x82060b0 + (32*location) + 0x1a);
	ldr	r3, .L65+20	@ tmp133,
@ src/soar_voxel.c:411: 	WM_CURSOR[0] = cursorX<<8;
	ldr	r1, .L65+24	@ tmp136,
@ src/soar_voxel.c:410: 	cursorY = *(u16*)(0x82060b0 + (32*location) + 0x1a);
	ldrh	r3, [r4, r3]	@ cursorY, *_6
@ src/soar_voxel.c:411: 	WM_CURSOR[0] = cursorX<<8;
	lsls	r2, r2, #8	@ _8, cursorX,
@ src/soar_voxel.c:411: 	WM_CURSOR[0] = cursorX<<8;
	str	r2, [r1]	@ _8, MEM[(volatile int *)50352776B]
@ src/soar_voxel.c:412: 	WM_CURSOR[1] = cursorY<<8;
	ldr	r2, .L65+28	@ tmp137,
@ src/soar_voxel.c:412: 	WM_CURSOR[1] = cursorY<<8;
	lsls	r3, r3, #8	@ _9, cursorY,
@ src/soar_voxel.c:412: 	WM_CURSOR[1] = cursorY<<8;
	str	r3, [r2]	@ _9, MEM[(volatile int *)50352780B]
@ src/soar_voxel.c:414: 	g_LCDIOBuffer = DISPCNT_MODE_0
	movs	r2, #248	@ tmp139,
	ldr	r3, .L65+32	@ tmp138,
	lsls	r2, r2, #5	@ tmp139, tmp139,
	strh	r2, [r3]	@ tmp139, MEM[(volatile vu16 *)50344064B]
@ src/soar_voxel.c:421: };
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L66:
	.align	2
.L65:
	.word	VBlankIntrWait
	.word	ProcFind
	.word	144955208
	.word	ProcGoto
	.word	136339656
	.word	136339658
	.word	50352776
	.word	50352780
	.word	50344064
	.size	MoveLord, .-MoveLord
	.align	1
	.global	EndLoop
	.syntax unified
	.code	16
	.thumb_func
	.type	EndLoop, %function
EndLoop:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r4, r5, r6, lr}	@
@ src/soar_voxel.c:423: void EndLoop(SoarProc* CurrentProc){
	movs	r4, r0	@ CurrentProc, tmp129
@ src/soar_voxel.c:443: };
	@ sp needed	@
@ src/soar_voxel.c:424: 	SetInterrupt_LCDVBlank(OnVBlankMain);
	ldr	r0, .L69	@ tmp116,
	ldr	r3, .L69+4	@ tmp117,
	bl	.L9		@
@ src/soar_voxel.c:426: 	VBlankIntrWait();
	ldr	r5, .L69+8	@ tmp118,
@ src/soar_voxel.c:425: 	int vid_page = CurrentProc->vid_page;
	ldr	r6, [r4, #64]	@ _1, CurrentProc_5(D)->vid_page
@ src/soar_voxel.c:426: 	VBlankIntrWait();
	bl	.L71		@
@ src/soar_voxel.c:427:   	CpuFastFill(0, vid_page, (MODE5_WIDTH*MODE5_HEIGHT)<<1); //make it black
	movs	r3, #0	@ tmp119,
	movs	r1, r6	@, _1
	ldr	r2, .L69+12	@,
	str	r3, [sp, #4]	@ tmp119, tmp
	add	r0, sp, #4	@,,
	ldr	r3, .L69+16	@ tmp122,
	bl	.L9		@
@ src/soar_voxel.c:428:   	CurrentProc->vid_page = vid_flip(vid_page);
	movs	r0, r6	@, _1
	bl	vid_flip		@
@ src/soar_voxel.c:428:   	CurrentProc->vid_page = vid_flip(vid_page);
	str	r0, [r4, #64]	@ tmp130, CurrentProc_5(D)->vid_page
@ src/soar_voxel.c:430:   	VBlankIntrWait();
	bl	.L71		@
@ src/soar_voxel.c:431: 	g_LCDIOBuffer = DISPCNT_MODE_5; //disable all layers
	movs	r2, #5	@ tmp125,
	ldr	r3, .L69+20	@ tmp124,
@ src/soar_voxel.c:440: 	BreakProcLoop(CurrentProc);
	movs	r0, r4	@, CurrentProc
@ src/soar_voxel.c:431: 	g_LCDIOBuffer = DISPCNT_MODE_5; //disable all layers
	strh	r2, [r3]	@ tmp125, MEM[(volatile vu16 *)50344064B]
@ src/soar_voxel.c:440: 	BreakProcLoop(CurrentProc);
	ldr	r3, .L69+24	@ tmp127,
	bl	.L9		@
@ src/soar_voxel.c:442: 	Sound_FadeSongOut(10);
	movs	r0, #10	@,
	ldr	r3, .L69+28	@ tmp128,
	bl	.L9		@
@ src/soar_voxel.c:443: };
	pop	{r0, r1, r4, r5, r6}
	pop	{r0}
	bx	r0
.L70:
	.align	2
.L69:
	.word	OnVBlankMain
	.word	SetInterrupt_LCDVBlank
	.word	VBlankIntrWait
	.word	16787456
	.word	CpuFastSet
	.word	50344064
	.word	BreakProcLoop
	.word	Sound_FadeSongOut
	.size	EndLoop, .-EndLoop
	.align	1
	.global	BumpScreen
	.syntax unified
	.code	16
	.thumb_func
	.type	BumpScreen, %function
BumpScreen:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ src/soar_voxel.c:446: 	switch (direction){
	cmp	r0, #2	@ direction,
	beq	.L73		@,
	bgt	.L74		@,
	cmp	r0, #1	@ direction,
	bls	.L72		@,
.L75:
	bl	BumpScreen.part.0		@
@ src/soar_voxel.c:477: };
	b	.L72		@
.L74:
@ src/soar_voxel.c:446: 	switch (direction){
	cmp	r0, #3	@ direction,
	bne	.L75		@,
@ src/soar_voxel.c:462: 			g_REG_BG2Y=0x0500;	//offset horizontal
	movs	r2, #160	@ tmp132,
	ldr	r3, .L79	@ tmp131,
	lsls	r2, r2, #3	@ tmp132, tmp132,
	str	r2, [r3]	@ tmp132, MEM[(volatile vu32 *)50344148B]
@ src/soar_voxel.c:463: 			g_REG_BG2X=0x9c40;
	ldr	r3, .L79+4	@ tmp133,
	ldr	r2, .L79+8	@ tmp134,
	str	r2, [r3]	@ tmp134, MEM[(volatile vu32 *)50344144B]
@ src/soar_voxel.c:464: 			g_REG_BG2PA=0xFFF2; 
	movs	r2, #14	@ tmp136,
	ldr	r3, .L79+12	@ tmp135,
	rsbs	r2, r2, #0	@ tmp136, tmp136
	strh	r2, [r3]	@ tmp136, MEM[(volatile vu16 *)50344136B]
@ src/soar_voxel.c:465: 			g_REG_BG2PB=0xFF1C;
	ldr	r3, .L79+16	@ tmp138,
	subs	r2, r2, #214	@ tmp139,
	strh	r2, [r3]	@ tmp139, MEM[(volatile vu16 *)50344138B]
@ src/soar_voxel.c:466: 			g_REG_BG2PC=0x0080;
	ldr	r3, .L79+20	@ tmp141,
	adds	r2, r2, #101	@ tmp142,
	adds	r2, r2, #255	@ tmp142,
	strh	r2, [r3]	@ tmp142, MEM[(volatile vu16 *)50344140B]
@ src/soar_voxel.c:467: 			g_REG_BG2PD=0xFFF8;
	ldr	r3, .L79+24	@ tmp144,
	subs	r2, r2, #136	@ tmp145,
	b	.L78		@
.L73:
@ src/soar_voxel.c:454: 			g_REG_BG2Y=0x180;	//offset horizontal
	movs	r2, #192	@ tmp116,
	ldr	r3, .L79	@ tmp115,
	lsls	r2, r2, #1	@ tmp116, tmp116,
	str	r2, [r3]	@ tmp116, MEM[(volatile vu32 *)50344148B]
@ src/soar_voxel.c:455: 			g_REG_BG2X=0x9280;
	ldr	r3, .L79+4	@ tmp117,
	ldr	r2, .L79+28	@ tmp118,
	str	r2, [r3]	@ tmp118, MEM[(volatile vu32 *)50344144B]
@ src/soar_voxel.c:456: 			g_REG_BG2PA=0x000E; 
	movs	r2, #14	@ tmp120,
	ldr	r3, .L79+12	@ tmp119,
	strh	r2, [r3]	@ tmp120, MEM[(volatile vu16 *)50344136B]
@ src/soar_voxel.c:457: 			g_REG_BG2PB=0xFF1C;
	ldr	r3, .L79+16	@ tmp122,
	subs	r2, r2, #242	@ tmp123,
	strh	r2, [r3]	@ tmp123, MEM[(volatile vu16 *)50344138B]
@ src/soar_voxel.c:458: 			g_REG_BG2PC=0x0080;
	ldr	r3, .L79+20	@ tmp125,
	adds	r2, r2, #101	@ tmp126,
	adds	r2, r2, #255	@ tmp126,
	strh	r2, [r3]	@ tmp126, MEM[(volatile vu16 *)50344140B]
@ src/soar_voxel.c:459: 			g_REG_BG2PD=0x0008;
	ldr	r3, .L79+24	@ tmp128,
	subs	r2, r2, #120	@ tmp129,
.L78:
@ src/soar_voxel.c:467: 			g_REG_BG2PD=0xFFF8;
	strh	r2, [r3]	@ tmp145,
.L72:
@ src/soar_voxel.c:477: };
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L80:
	.align	2
.L79:
	.word	50344148
	.word	50344144
	.word	40000
	.word	50344136
	.word	50344138
	.word	50344140
	.word	50344142
	.word	37504
	.size	BumpScreen, .-BumpScreen
	.align	1
	.global	thumb_loop
	.syntax unified
	.code	16
	.thumb_func
	.type	thumb_loop, %function
thumb_loop:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
@ src/soar_voxel.c:487: 	CurrentProc->oceanOffset += (cam_dx_Angles[(CurrentProc->oceanClock>>2)]|1); //was oceanDelta but it's just a sin table so can use this lol
	movs	r1, r0	@ tmp278, CurrentProc
@ src/soar_voxel.c:485: {
	push	{r4, r5, r6, r7, lr}	@
@ src/soar_voxel.c:487: 	CurrentProc->oceanOffset += (cam_dx_Angles[(CurrentProc->oceanClock>>2)]|1); //was oceanDelta but it's just a sin table so can use this lol
	adds	r1, r1, #71	@ tmp278,
	ldrb	r3, [r1]	@ _3,
@ src/soar_voxel.c:487: 	CurrentProc->oceanOffset += (cam_dx_Angles[(CurrentProc->oceanClock>>2)]|1); //was oceanDelta but it's just a sin table so can use this lol
	ldr	r5, .L148	@ tmp279,
@ src/soar_voxel.c:487: 	CurrentProc->oceanOffset += (cam_dx_Angles[(CurrentProc->oceanClock>>2)]|1); //was oceanDelta but it's just a sin table so can use this lol
	lsrs	r2, r3, #2	@ tmp281, _3,
@ src/soar_voxel.c:487: 	CurrentProc->oceanOffset += (cam_dx_Angles[(CurrentProc->oceanClock>>2)]|1); //was oceanDelta but it's just a sin table so can use this lol
	lsls	r2, r2, #1	@ tmp283, tmp281,
@ src/soar_voxel.c:485: {
	movs	r4, r0	@ CurrentProc, tmp696
@ src/soar_voxel.c:487: 	CurrentProc->oceanOffset += (cam_dx_Angles[(CurrentProc->oceanClock>>2)]|1); //was oceanDelta but it's just a sin table so can use this lol
	ldrh	r0, [r2, r5]	@ tmp286, cam_dx_Angles
	movs	r2, #1	@ tmp288,
	orrs	r2, r0	@ tmp287, tmp286
@ src/soar_voxel.c:487: 	CurrentProc->oceanOffset += (cam_dx_Angles[(CurrentProc->oceanClock>>2)]|1); //was oceanDelta but it's just a sin table so can use this lol
	movs	r0, r4	@ tmp291, CurrentProc
	adds	r0, r0, #70	@ tmp291,
@ src/soar_voxel.c:487: 	CurrentProc->oceanOffset += (cam_dx_Angles[(CurrentProc->oceanClock>>2)]|1); //was oceanDelta but it's just a sin table so can use this lol
	ldrb	r6, [r0]	@ tmp294,
	adds	r2, r2, r6	@ tmp295, tmp287, tmp294
	strb	r2, [r0]	@ tmp295, CurrentProc_154(D)->oceanOffset
@ src/soar_voxel.c:488: 	CurrentProc->oceanClock = (CurrentProc->oceanClock + 1) & 0x3F;
	movs	r2, #63	@ tmp303,
@ src/soar_voxel.c:488: 	CurrentProc->oceanClock = (CurrentProc->oceanClock + 1) & 0x3F;
	adds	r3, r3, #1	@ tmp300,
@ src/soar_voxel.c:488: 	CurrentProc->oceanClock = (CurrentProc->oceanClock + 1) & 0x3F;
	ands	r3, r2	@ tmp302, tmp303
@ src/soar_voxel.c:488: 	CurrentProc->oceanClock = (CurrentProc->oceanClock + 1) & 0x3F;
	strb	r3, [r1]	@ tmp302, CurrentProc_154(D)->oceanClock
@ src/soar_voxel.c:490: 	if ((CurrentProc->takeOffTransition) & (CurrentProc->sPlayerStepZ < (CAMERA_NUM_STEPS-3)))
	movs	r0, #0	@ tmp323,
	movs	r1, #6	@ tmp771,
@ src/soar_voxel.c:490: 	if ((CurrentProc->takeOffTransition) & (CurrentProc->sPlayerStepZ < (CAMERA_NUM_STEPS-3)))
	movs	r6, r4	@ tmp314, CurrentProc
@ src/soar_voxel.c:490: 	if ((CurrentProc->takeOffTransition) & (CurrentProc->sPlayerStepZ < (CAMERA_NUM_STEPS-3)))
	ldr	r7, [r4, #56]	@ _16, CurrentProc_154(D)->sPlayerStepZ
@ src/soar_voxel.c:490: 	if ((CurrentProc->takeOffTransition) & (CurrentProc->sPlayerStepZ < (CAMERA_NUM_STEPS-3)))
	lsrs	r2, r7, #31	@ tmp322, _16,
	cmp	r1, r7	@ tmp771, _16
	adcs	r2, r2, r0	@ tmp320, tmp322, tmp323
@ src/soar_voxel.c:490: 	if ((CurrentProc->takeOffTransition) & (CurrentProc->sPlayerStepZ < (CAMERA_NUM_STEPS-3)))
	adds	r6, r6, #69	@ tmp314,
	ldrb	r3, [r6]	@ *CurrentProc_154(D), *CurrentProc_154(D)
@ src/soar_voxel.c:490: 	if ((CurrentProc->takeOffTransition) & (CurrentProc->sPlayerStepZ < (CAMERA_NUM_STEPS-3)))
	lsls	r1, r3, #29	@ tmp318, *CurrentProc_154(D),
	lsrs	r1, r1, #31	@ tmp328, tmp318,
@ src/soar_voxel.c:485: {
	sub	sp, sp, #20	@,,
@ src/soar_voxel.c:490: 	if ((CurrentProc->takeOffTransition) & (CurrentProc->sPlayerStepZ < (CAMERA_NUM_STEPS-3)))
	tst	r1, r2	@ tmp328, tmp320
	beq	.L82		@,
@ src/soar_voxel.c:492: 		if (getPtHeight_thumb(CurrentProc->sFocusPtX, CurrentProc->sFocusPtY) > (CurrentProc->sPlayerPosZ - (CAMERA_Z_STEP)))
	ldr	r5, [r4, #52]	@ _18, CurrentProc_154(D)->sPlayerPosZ
@ src/soar_voxel.c:492: 		if (getPtHeight_thumb(CurrentProc->sFocusPtX, CurrentProc->sFocusPtY) > (CurrentProc->sPlayerPosZ - (CAMERA_Z_STEP)))
	ldr	r1, [r4, #76]	@, CurrentProc_154(D)->sFocusPtY
	ldr	r0, [r4, #72]	@, CurrentProc_154(D)->sFocusPtX
	bl	getPtHeight_thumb		@
@ src/soar_voxel.c:492: 		if (getPtHeight_thumb(CurrentProc->sFocusPtX, CurrentProc->sFocusPtY) > (CurrentProc->sPlayerPosZ - (CAMERA_Z_STEP)))
	movs	r3, r5	@ tmp329, _18
	subs	r3, r3, #31	@ tmp329,
@ src/soar_voxel.c:492: 		if (getPtHeight_thumb(CurrentProc->sFocusPtX, CurrentProc->sFocusPtY) > (CurrentProc->sPlayerPosZ - (CAMERA_Z_STEP)))
	cmp	r3, r0	@ tmp329, tmp697
	bgt	.L83		@,
@ src/soar_voxel.c:494: 			CurrentProc->sPlayerPosZ += CAMERA_Z_STEP;
	adds	r5, r5, #32	@ tmp330,
@ src/soar_voxel.c:495: 			CurrentProc->sPlayerStepZ += 1;
	adds	r7, r7, #1	@ tmp331,
@ src/soar_voxel.c:494: 			CurrentProc->sPlayerPosZ += CAMERA_Z_STEP;
	str	r5, [r4, #52]	@ tmp330, CurrentProc_154(D)->sPlayerPosZ
@ src/soar_voxel.c:495: 			CurrentProc->sPlayerStepZ += 1;
	str	r7, [r4, #56]	@ tmp331, CurrentProc_154(D)->sPlayerStepZ
.L83:
@ src/soar_voxel.c:497: 		CurrentProc->sPlayerPosZ += CAMERA_Z_STEP;
	ldr	r3, [r4, #52]	@ CurrentProc_154(D)->sPlayerPosZ, CurrentProc_154(D)->sPlayerPosZ
	adds	r3, r3, #32	@ tmp332,
	str	r3, [r4, #52]	@ tmp332, CurrentProc_154(D)->sPlayerPosZ
@ src/soar_voxel.c:498: 		CurrentProc->sPlayerStepZ += 1;
	ldr	r3, [r4, #56]	@ CurrentProc_154(D)->sPlayerStepZ, CurrentProc_154(D)->sPlayerStepZ
	adds	r3, r3, #1	@ tmp334,
	str	r3, [r4, #56]	@ tmp334, CurrentProc_154(D)->sPlayerStepZ
.L84:
@ src/soar_voxel.c:499: 		return 1;
	movs	r0, #1	@ <retval>,
	b	.L81		@
.L82:
@ src/soar_voxel.c:501: 	else CurrentProc->takeOffTransition = 0;
	movs	r2, #4	@ tmp344,
	bics	r3, r2	@ tmp343, tmp344
	strb	r3, [r6]	@ tmp343, CurrentProc_154(D)->takeOffTransition
@ src/soar_voxel.c:503: 	if (CurrentProc->landingTransition)
	lsls	r3, r3, #28	@ tmp720, tmp343,
	bpl	.L85		@,
@ src/soar_voxel.c:505: 		if (getPtHeight_thumb(CurrentProc->sFocusPtX, CurrentProc->sFocusPtY) > (CurrentProc->sPlayerPosZ - (2*CAMERA_Z_STEP)))
	ldr	r5, [r4, #52]	@ _31, CurrentProc_154(D)->sPlayerPosZ
@ src/soar_voxel.c:505: 		if (getPtHeight_thumb(CurrentProc->sFocusPtX, CurrentProc->sFocusPtY) > (CurrentProc->sPlayerPosZ - (2*CAMERA_Z_STEP)))
	ldr	r1, [r4, #76]	@, CurrentProc_154(D)->sFocusPtY
	ldr	r0, [r4, #72]	@, CurrentProc_154(D)->sFocusPtX
	bl	getPtHeight_thumb		@
@ src/soar_voxel.c:505: 		if (getPtHeight_thumb(CurrentProc->sFocusPtX, CurrentProc->sFocusPtY) > (CurrentProc->sPlayerPosZ - (2*CAMERA_Z_STEP)))
	movs	r3, r5	@ tmp356, _31
	subs	r3, r3, #63	@ tmp356,
@ src/soar_voxel.c:505: 		if (getPtHeight_thumb(CurrentProc->sFocusPtX, CurrentProc->sFocusPtY) > (CurrentProc->sPlayerPosZ - (2*CAMERA_Z_STEP)))
	cmp	r3, r0	@ tmp356, tmp698
	bgt	.L86		@,
@ src/soar_voxel.c:507: 			if (gChapterData.muteSfxOption == 0) m4aSongNumStart(0x73); //phase transition
	ldr	r3, .L148+4	@ tmp360,
	ldrb	r3, [r3]	@ gChapterData, gChapterData
@ src/soar_voxel.c:507: 			if (gChapterData.muteSfxOption == 0) m4aSongNumStart(0x73); //phase transition
	lsls	r3, r3, #30	@ tmp721, gChapterData,
	bmi	.L87		@,
@ src/soar_voxel.c:507: 			if (gChapterData.muteSfxOption == 0) m4aSongNumStart(0x73); //phase transition
	movs	r0, #115	@,
	ldr	r3, .L148+8	@ tmp368,
	bl	.L9		@
.L87:
@ src/soar_voxel.c:508: 			EndLoop(CurrentProc);
	movs	r0, r4	@, CurrentProc
	bl	EndLoop		@
@ src/soar_voxel.c:509: 			return 0;
	movs	r0, #0	@ <retval>,
.L81:
@ src/soar_voxel.c:630: };
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L86:
@ src/soar_voxel.c:513: 			CurrentProc->sPlayerPosZ -= CAMERA_Z_STEP;
	subs	r5, r5, #32	@ tmp369,
@ src/soar_voxel.c:514: 			CurrentProc->sPlayerStepZ -= 1;
	subs	r7, r7, #1	@ tmp370,
@ src/soar_voxel.c:513: 			CurrentProc->sPlayerPosZ -= CAMERA_Z_STEP;
	str	r5, [r4, #52]	@ tmp369, CurrentProc_154(D)->sPlayerPosZ
@ src/soar_voxel.c:514: 			CurrentProc->sPlayerStepZ -= 1;
	str	r7, [r4, #56]	@ tmp370, CurrentProc_154(D)->sPlayerStepZ
@ src/soar_voxel.c:515: 			return 1;
	b	.L84		@
.L85:
@ src/soar_voxel.c:521: 	if (gKeyState.heldKeys & DPAD_LEFT){
	ldr	r2, .L148+12	@ tmp371,
	ldrh	r3, [r2, #4]	@ _40,
@ src/soar_voxel.c:521: 	if (gKeyState.heldKeys & DPAD_LEFT){
	lsls	r1, r3, #26	@ tmp722, _40,
	bmi	.LCB951	@
	b	.L89	@long jump	@
.LCB951:
@ src/soar_voxel.c:522: 		newx = CurrentProc->sPlayerPosX + cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]; // step forward to focal point
	ldr	r3, [r4, #60]	@ _42, CurrentProc_154(D)->sPlayerYaw
@ src/soar_voxel.c:522: 		newx = CurrentProc->sPlayerPosX + cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]; // step forward to focal point
	lsls	r0, r3, #1	@ tmp378, _42,
	adds	r2, r5, r0	@ tmp379, tmp279, tmp378
	movs	r1, #32	@ tmp381,
	ldrsh	r1, [r2, r1]	@ tmp381, tmp379, tmp381
@ src/soar_voxel.c:522: 		newx = CurrentProc->sPlayerPosX + cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]; // step forward to focal point
	ldr	r2, [r4, #44]	@ CurrentProc_154(D)->sPlayerPosX, CurrentProc_154(D)->sPlayerPosX
	adds	r1, r1, r2	@ newx, tmp381, CurrentProc_154(D)->sPlayerPosX
@ src/soar_voxel.c:523: 		newy = CurrentProc->sPlayerPosY + cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]; // step forward to focal point
	adds	r2, r5, #2	@ tmp384, tmp279,
	adds	r0, r2, r0	@ tmp386, tmp384, tmp378
	movs	r7, #62	@ tmp733,
	ldrsh	r0, [r0, r7]	@ tmp388, tmp386, tmp733
@ src/soar_voxel.c:523: 		newy = CurrentProc->sPlayerPosY + cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]; // step forward to focal point
	ldr	r7, [r4, #48]	@ CurrentProc_154(D)->sPlayerPosY, CurrentProc_154(D)->sPlayerPosY
	adds	r0, r0, r7	@ newy, tmp388, CurrentProc_154(D)->sPlayerPosY
@ src/soar_voxel.c:524: 		CurrentProc->sPlayerYaw = (CurrentProc->sPlayerYaw - 1)&0xF; //16 angles so skip the conditional
	movs	r7, #15	@ tmp391,
@ src/soar_voxel.c:524: 		CurrentProc->sPlayerYaw = (CurrentProc->sPlayerYaw - 1)&0xF; //16 angles so skip the conditional
	subs	r3, r3, #1	@ tmp390,
@ src/soar_voxel.c:524: 		CurrentProc->sPlayerYaw = (CurrentProc->sPlayerYaw - 1)&0xF; //16 angles so skip the conditional
	ands	r3, r7	@ _49, tmp391
@ src/soar_voxel.c:524: 		CurrentProc->sPlayerYaw = (CurrentProc->sPlayerYaw - 1)&0xF; //16 angles so skip the conditional
	str	r3, [r4, #60]	@ _49, CurrentProc_154(D)->sPlayerYaw
@ src/soar_voxel.c:526: 		newy -= (cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	lsls	r3, r3, #1	@ tmp394, _49,
	adds	r2, r2, r3	@ tmp395, tmp384, tmp394
@ src/soar_voxel.c:526: 		newy -= (cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	movs	r7, #62	@ tmp734,
	ldrsh	r2, [r2, r7]	@ tmp397, tmp395, tmp734
	asrs	r2, r2, #2	@ tmp399, tmp397,
@ src/soar_voxel.c:526: 		newy -= (cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	lsls	r7, r2, #2	@ tmp401, tmp399,
	subs	r2, r2, r7	@ tmp402, tmp399, tmp401
@ src/soar_voxel.c:525: 		newx -= (cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	adds	r3, r5, r3	@ tmp405, tmp279, tmp394
@ src/soar_voxel.c:526: 		newy -= (cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	adds	r2, r2, r0	@ newy, tmp402, newy
@ src/soar_voxel.c:525: 		newx -= (cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	movs	r0, #32	@ tmp735,
	ldrsh	r3, [r3, r0]	@ tmp407, tmp405, tmp735
	asrs	r3, r3, #2	@ tmp409, tmp407,
@ src/soar_voxel.c:525: 		newx -= (cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	lsls	r0, r3, #2	@ tmp411, tmp409,
	subs	r3, r3, r0	@ tmp412, tmp409, tmp411
@ src/soar_voxel.c:529: 		BumpScreen(bump_left);
	movs	r0, #2	@,
@ src/soar_voxel.c:525: 		newx -= (cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	adds	r3, r3, r1	@ newx, tmp412, newx
@ src/soar_voxel.c:527: 		CurrentProc->sPlayerPosX = newx;
	str	r3, [r4, #44]	@ newx, CurrentProc_154(D)->sPlayerPosX
@ src/soar_voxel.c:528: 		CurrentProc->sPlayerPosY = newy;
	str	r2, [r4, #48]	@ newy, CurrentProc_154(D)->sPlayerPosY
.L146:
@ src/soar_voxel.c:539: 		BumpScreen(bump_right);
	bl	BumpScreen		@
.L90:
@ src/soar_voxel.c:550: 	CurrentProc->sPlayerPosX += cam_dx_Angles[CurrentProc->sPlayerYaw]; 
	ldr	r3, [r4, #60]	@ _77, CurrentProc_154(D)->sPlayerYaw
@ src/soar_voxel.c:550: 	CurrentProc->sPlayerPosX += cam_dx_Angles[CurrentProc->sPlayerYaw]; 
	lsls	r3, r3, #1	@ tmp465, _77,
	ldrsh	r1, [r5, r3]	@ tmp466, cam_dx_Angles
@ src/soar_voxel.c:550: 	CurrentProc->sPlayerPosX += cam_dx_Angles[CurrentProc->sPlayerYaw]; 
	ldr	r2, [r4, #44]	@ CurrentProc_154(D)->sPlayerPosX, CurrentProc_154(D)->sPlayerPosX
	adds	r1, r1, r2	@ _80, tmp466, CurrentProc_154(D)->sPlayerPosX
@ src/soar_voxel.c:551: 	CurrentProc->sPlayerPosY += cam_dy_Angles[CurrentProc->sPlayerYaw];
	movs	r2, r5	@ tmp471, tmp279
	adds	r2, r2, #96	@ tmp471,
	ldrsh	r2, [r3, r2]	@ tmp473, cam_dy_Angles
@ src/soar_voxel.c:551: 	CurrentProc->sPlayerPosY += cam_dy_Angles[CurrentProc->sPlayerYaw];
	ldr	r0, [r4, #48]	@ CurrentProc_154(D)->sPlayerPosY, CurrentProc_154(D)->sPlayerPosY
	adds	r2, r2, r0	@ _84, tmp473, CurrentProc_154(D)->sPlayerPosY
@ src/soar_voxel.c:552: 	CurrentProc->sFocusPtX = CurrentProc->sPlayerPosX + cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]; // set focal point
	adds	r0, r5, r3	@ tmp477, tmp279, tmp465
	movs	r7, #32	@ tmp742,
	ldrsh	r0, [r0, r7]	@ tmp479, tmp477, tmp742
@ src/soar_voxel.c:556: 	if (gKeyState.pressedKeys & START_BUTTON){
	movs	r7, #8	@ tmp492,
@ src/soar_voxel.c:550: 	CurrentProc->sPlayerPosX += cam_dx_Angles[CurrentProc->sPlayerYaw]; 
	str	r1, [r4, #44]	@ _80, CurrentProc_154(D)->sPlayerPosX
@ src/soar_voxel.c:552: 	CurrentProc->sFocusPtX = CurrentProc->sPlayerPosX + cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]; // set focal point
	adds	r1, r0, r1	@ tmp480, tmp479, _80
@ src/soar_voxel.c:552: 	CurrentProc->sFocusPtX = CurrentProc->sPlayerPosX + cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]; // set focal point
	str	r1, [r4, #72]	@ tmp480, CurrentProc_154(D)->sFocusPtX
@ src/soar_voxel.c:553: 	CurrentProc->sFocusPtY = CurrentProc->sPlayerPosY + cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]; // set focal point
	adds	r1, r5, #2	@ tmp482, tmp279,
	adds	r3, r1, r3	@ tmp484, tmp482, tmp465
	movs	r1, #62	@ tmp743,
	ldrsh	r3, [r3, r1]	@ tmp486, tmp484, tmp743
@ src/soar_voxel.c:553: 	CurrentProc->sFocusPtY = CurrentProc->sPlayerPosY + cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]; // set focal point
	adds	r3, r3, r2	@ tmp487, tmp486, _84
@ src/soar_voxel.c:553: 	CurrentProc->sFocusPtY = CurrentProc->sPlayerPosY + cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]; // set focal point
	str	r3, [r4, #76]	@ tmp487, CurrentProc_154(D)->sFocusPtY
@ src/soar_voxel.c:556: 	if (gKeyState.pressedKeys & START_BUTTON){
	ldr	r3, .L148+12	@ tmp488,
@ src/soar_voxel.c:551: 	CurrentProc->sPlayerPosY += cam_dy_Angles[CurrentProc->sPlayerYaw];
	str	r2, [r4, #48]	@ _84, CurrentProc_154(D)->sPlayerPosY
@ src/soar_voxel.c:556: 	if (gKeyState.pressedKeys & START_BUTTON){
	str	r3, [sp, #4]	@ tmp488, %sfp
@ src/soar_voxel.c:556: 	if (gKeyState.pressedKeys & START_BUTTON){
	ldrh	r3, [r3, #8]	@ tmp490,
	tst	r3, r7	@ tmp490, tmp492
	beq	.L93		@,
@ src/soar_voxel.c:557: 		if (canLandHere(CurrentProc))
	movs	r0, r4	@, CurrentProc
	bl	canLandHere		@
@ src/soar_voxel.c:557: 		if (canLandHere(CurrentProc))
	cmp	r0, #0	@ tmp699,
	bne	.LCB1024	@
	b	.L94	@long jump	@
.LCB1024:
@ src/soar_voxel.c:559: 			CurrentProc->landingTransition = TRUE;
	ldrb	r3, [r6]	@ CurrentProc_154(D)->landingTransition, CurrentProc_154(D)->landingTransition
	orrs	r7, r3	@ tmp503, CurrentProc_154(D)->landingTransition
	strb	r7, [r6]	@ tmp503, CurrentProc_154(D)->landingTransition
.L93:
@ src/soar_voxel.c:564: 	if (gKeyState.pressedKeys & SELECT_BUTTON) CurrentProc->ShowFPS ^= 1;
	ldr	r3, [sp, #4]	@ tmp488, %sfp
	ldrh	r1, [r3, #8]	@ _95,
@ src/soar_voxel.c:564: 	if (gKeyState.pressedKeys & SELECT_BUTTON) CurrentProc->ShowFPS ^= 1;
	lsls	r3, r1, #29	@ tmp725, _95,
	bpl	.L96		@,
@ src/soar_voxel.c:564: 	if (gKeyState.pressedKeys & SELECT_BUTTON) CurrentProc->ShowFPS ^= 1;
	movs	r2, #1	@ tmp536,
@ src/soar_voxel.c:564: 	if (gKeyState.pressedKeys & SELECT_BUTTON) CurrentProc->ShowFPS ^= 1;
	ldrb	r3, [r6]	@ *CurrentProc_154(D), *CurrentProc_154(D)
	lsls	r0, r3, #30	@ tmp534, *CurrentProc_154(D),
	lsrs	r0, r0, #31	@ tmp533, tmp534,
@ src/soar_voxel.c:564: 	if (gKeyState.pressedKeys & SELECT_BUTTON) CurrentProc->ShowFPS ^= 1;
	bics	r2, r0	@ tmp543, tmp533
	movs	r0, #2	@ tmp550,
	lsls	r2, r2, #1	@ tmp546, tmp543,
	bics	r3, r0	@ tmp549, tmp550
	orrs	r3, r2	@ tmp553, tmp546
	strb	r3, [r6]	@ tmp553, CurrentProc_154(D)->ShowFPS
.L96:
@ src/soar_voxel.c:584: 	if (gKeyState.pressedKeys & R_BUTTON){
	lsls	r1, r1, #23	@ tmp726, _95,
	bpl	.L97		@,
@ src/soar_voxel.c:585: 		CurrentProc->ShowMap ^= 1;
	movs	r1, #1	@ tmp572,
	movs	r0, r1	@ tmp579, tmp572
@ src/soar_voxel.c:585: 		CurrentProc->ShowMap ^= 1;
	ldrb	r3, [r6]	@ *CurrentProc_154(D), *CurrentProc_154(D)
	lsls	r2, r3, #31	@ tmp570, *CurrentProc_154(D),
	lsrs	r2, r2, #31	@ tmp569, tmp570,
@ src/soar_voxel.c:585: 		CurrentProc->ShowMap ^= 1;
	bics	r0, r2	@ tmp579, tmp569
	bics	r3, r1	@ tmp583, tmp572
	orrs	r3, r0	@ tmp587, tmp579
	strb	r3, [r6]	@ tmp587, CurrentProc_154(D)->ShowMap
.L97:
@ src/soar_voxel.c:588: 	if (gKeyState.heldKeys & DPAD_UP){ //turbo
	ldr	r3, [sp, #4]	@ tmp488, %sfp
	ldrh	r6, [r3, #4]	@ _100,
@ src/soar_voxel.c:588: 	if (gKeyState.heldKeys & DPAD_UP){ //turbo
	lsls	r3, r6, #25	@ tmp727, _100,
	bpl	.L98		@,
@ src/soar_voxel.c:589: 		CurrentProc->sPlayerPosX += cam_dx_Angles[CurrentProc->sPlayerYaw];
	ldr	r3, [r4, #60]	@ _102, CurrentProc_154(D)->sPlayerYaw
@ src/soar_voxel.c:589: 		CurrentProc->sPlayerPosX += cam_dx_Angles[CurrentProc->sPlayerYaw];
	lsls	r3, r3, #1	@ tmp596, _102,
	ldrsh	r0, [r5, r3]	@ tmp597, cam_dx_Angles
@ src/soar_voxel.c:589: 		CurrentProc->sPlayerPosX += cam_dx_Angles[CurrentProc->sPlayerYaw];
	ldr	r2, [r4, #44]	@ CurrentProc_154(D)->sPlayerPosX, CurrentProc_154(D)->sPlayerPosX
	adds	r2, r2, r0	@ tmp598, CurrentProc_154(D)->sPlayerPosX, tmp597
	str	r2, [r4, #44]	@ tmp598, CurrentProc_154(D)->sPlayerPosX
@ src/soar_voxel.c:590: 		CurrentProc->sPlayerPosY += cam_dy_Angles[CurrentProc->sPlayerYaw];
	movs	r2, r5	@ tmp603, tmp279
	adds	r2, r2, #96	@ tmp603,
@ src/soar_voxel.c:601: 	int camera_terrain_ht = getPtHeight_thumb(CurrentProc->sPlayerPosX, CurrentProc->sPlayerPosY);
	ldr	r1, [r4, #48]	@ pretmp_277, CurrentProc_154(D)->sPlayerPosY
@ src/soar_voxel.c:590: 		CurrentProc->sPlayerPosY += cam_dy_Angles[CurrentProc->sPlayerYaw];
	ldrsh	r3, [r3, r2]	@ tmp605, cam_dy_Angles
@ src/soar_voxel.c:590: 		CurrentProc->sPlayerPosY += cam_dy_Angles[CurrentProc->sPlayerYaw];
	adds	r3, r3, r1	@ tmp606, tmp605, pretmp_277
	str	r3, [r4, #48]	@ tmp606, CurrentProc_154(D)->sPlayerPosY
.L98:
@ src/soar_voxel.c:592: 	if (gKeyState.heldKeys & DPAD_DOWN){ //hover
	lsls	r3, r6, #24	@ tmp728, _100,
	bpl	.L99		@,
@ src/soar_voxel.c:593: 		CurrentProc->sPlayerPosX -= cam_dx_Angles[CurrentProc->sPlayerYaw];
	ldr	r3, [r4, #60]	@ _111, CurrentProc_154(D)->sPlayerYaw
@ src/soar_voxel.c:593: 		CurrentProc->sPlayerPosX -= cam_dx_Angles[CurrentProc->sPlayerYaw];
	lsls	r3, r3, #1	@ tmp613, _111,
	ldrsh	r0, [r5, r3]	@ tmp614, cam_dx_Angles
@ src/soar_voxel.c:593: 		CurrentProc->sPlayerPosX -= cam_dx_Angles[CurrentProc->sPlayerYaw];
	ldr	r1, [r4, #44]	@ CurrentProc_154(D)->sPlayerPosX, CurrentProc_154(D)->sPlayerPosX
@ src/soar_voxel.c:594: 		CurrentProc->sPlayerPosY -= cam_dy_Angles[CurrentProc->sPlayerYaw];
	adds	r5, r5, #96	@ tmp620,
@ src/soar_voxel.c:593: 		CurrentProc->sPlayerPosX -= cam_dx_Angles[CurrentProc->sPlayerYaw];
	subs	r1, r1, r0	@ tmp615, CurrentProc_154(D)->sPlayerPosX, tmp614
@ src/soar_voxel.c:601: 	int camera_terrain_ht = getPtHeight_thumb(CurrentProc->sPlayerPosX, CurrentProc->sPlayerPosY);
	ldr	r2, [r4, #48]	@ pretmp_275, CurrentProc_154(D)->sPlayerPosY
@ src/soar_voxel.c:593: 		CurrentProc->sPlayerPosX -= cam_dx_Angles[CurrentProc->sPlayerYaw];
	str	r1, [r4, #44]	@ tmp615, CurrentProc_154(D)->sPlayerPosX
@ src/soar_voxel.c:594: 		CurrentProc->sPlayerPosY -= cam_dy_Angles[CurrentProc->sPlayerYaw];
	ldrsh	r3, [r3, r5]	@ tmp622, cam_dy_Angles
@ src/soar_voxel.c:594: 		CurrentProc->sPlayerPosY -= cam_dy_Angles[CurrentProc->sPlayerYaw];
	subs	r3, r2, r3	@ tmp623, pretmp_275, tmp622
	str	r3, [r4, #48]	@ tmp623, CurrentProc_154(D)->sPlayerPosY
.L99:
@ src/soar_voxel.c:600: 	int player_terrain_ht = getPtHeight_thumb(CurrentProc->sFocusPtX, CurrentProc->sFocusPtY);
	ldr	r1, [r4, #76]	@, CurrentProc_154(D)->sFocusPtY
	ldr	r0, [r4, #72]	@, CurrentProc_154(D)->sFocusPtX
	bl	getPtHeight_thumb		@
@ src/soar_voxel.c:602: 	int camera_ht = CurrentProc->sPlayerPosZ - (CAMERA_Z_STEP) - 10;
	ldr	r5, [r4, #52]	@ _123, CurrentProc_154(D)->sPlayerPosZ
@ src/soar_voxel.c:602: 	int camera_ht = CurrentProc->sPlayerPosZ - (CAMERA_Z_STEP) - 10;
	movs	r7, r5	@ camera_ht, _123
@ src/soar_voxel.c:601: 	int camera_terrain_ht = getPtHeight_thumb(CurrentProc->sPlayerPosX, CurrentProc->sPlayerPosY);
	ldr	r3, [r4, #44]	@ _121, CurrentProc_154(D)->sPlayerPosX
	str	r3, [sp, #4]	@ _121, %sfp
	ldr	r3, [r4, #48]	@ _122, CurrentProc_154(D)->sPlayerPosY
@ src/soar_voxel.c:602: 	int camera_ht = CurrentProc->sPlayerPosZ - (CAMERA_Z_STEP) - 10;
	subs	r7, r7, #42	@ camera_ht,
@ src/soar_voxel.c:600: 	int player_terrain_ht = getPtHeight_thumb(CurrentProc->sFocusPtX, CurrentProc->sFocusPtY);
	str	r0, [sp, #12]	@ tmp700, %sfp
@ src/soar_voxel.c:601: 	int camera_terrain_ht = getPtHeight_thumb(CurrentProc->sPlayerPosX, CurrentProc->sPlayerPosY);
	str	r3, [sp, #8]	@ _122, %sfp
@ src/soar_voxel.c:603: 	if ((player_terrain_ht > (camera_ht)) || (camera_terrain_ht > camera_ht)){
	cmp	r0, r7	@ player_terrain_ht, camera_ht
	bgt	.L100		@,
@ src/soar_voxel.c:601: 	int camera_terrain_ht = getPtHeight_thumb(CurrentProc->sPlayerPosX, CurrentProc->sPlayerPosY);
	ldr	r1, [sp, #8]	@, %sfp
	ldr	r0, [sp, #4]	@, %sfp
	bl	getPtHeight_thumb		@
@ src/soar_voxel.c:603: 	if ((player_terrain_ht > (camera_ht)) || (camera_terrain_ht > camera_ht)){
	cmp	r0, r7	@ camera_terrain_ht, camera_ht
	ble	.L101		@,
.L100:
@ src/soar_voxel.c:605: 		CurrentProc->sPlayerStepZ += 1;
	ldr	r3, [r4, #56]	@ CurrentProc_154(D)->sPlayerStepZ, CurrentProc_154(D)->sPlayerStepZ
@ src/soar_voxel.c:604: 		CurrentProc->sPlayerPosZ += CAMERA_Z_STEP;
	adds	r5, r5, #32	@ tmp624,
	str	r5, [r4, #52]	@ tmp624, CurrentProc_154(D)->sPlayerPosZ
@ src/soar_voxel.c:605: 		CurrentProc->sPlayerStepZ += 1;
	adds	r3, r3, #1	@ tmp625,
.L147:
@ src/soar_voxel.c:610: 			CurrentProc->sPlayerStepZ -= 1;
	str	r3, [r4, #56]	@ tmp654, CurrentProc_154(D)->sPlayerStepZ
.L102:
@ src/soar_voxel.c:614: 	if (gKeyState.heldKeys & A_BUTTON){
	lsls	r6, r6, #31	@ tmp730, _100,
	bpl	.L106		@,
@ src/soar_voxel.c:615: 		if (CurrentProc->sPlayerPosZ<CAMERA_MAX_HEIGHT){
	movs	r2, #160	@ tmp661,
@ src/soar_voxel.c:615: 		if (CurrentProc->sPlayerPosZ<CAMERA_MAX_HEIGHT){
	ldr	r3, [r4, #52]	@ _136, CurrentProc_154(D)->sPlayerPosZ
@ src/soar_voxel.c:615: 		if (CurrentProc->sPlayerPosZ<CAMERA_MAX_HEIGHT){
	lsls	r2, r2, #1	@ tmp661, tmp661,
	cmp	r3, r2	@ _136, tmp661
	bge	.L106		@,
@ src/soar_voxel.c:616: 			CurrentProc->sPlayerPosZ += CAMERA_Z_STEP;
	adds	r3, r3, #32	@ tmp662,
	str	r3, [r4, #52]	@ tmp662, CurrentProc_154(D)->sPlayerPosZ
@ src/soar_voxel.c:617: 			CurrentProc->sPlayerStepZ += 1;
	ldr	r3, [r4, #56]	@ CurrentProc_154(D)->sPlayerStepZ, CurrentProc_154(D)->sPlayerStepZ
	adds	r3, r3, #1	@ tmp663,
	str	r3, [r4, #56]	@ tmp663, CurrentProc_154(D)->sPlayerStepZ
.L106:
@ src/soar_voxel.c:623: 	if (CurrentProc->sPlayerPosX > (MAP_DIMENSIONS-10)) CurrentProc->sPlayerPosX = MAP_DIMENSIONS-10;
	ldr	r3, .L148+16	@ tmp675,
	ldr	r2, [sp, #4]	@ _121, %sfp
	cmp	r2, r3	@ _121, tmp675
	ble	.L107		@,
@ src/soar_voxel.c:623: 	if (CurrentProc->sPlayerPosX > (MAP_DIMENSIONS-10)) CurrentProc->sPlayerPosX = MAP_DIMENSIONS-10;
	str	r3, [r4, #44]	@ tmp675, CurrentProc_154(D)->sPlayerPosX
.L108:
@ src/soar_voxel.c:626: 	if (CurrentProc->sPlayerPosY > (MAP_DIMENSIONS-10)) CurrentProc->sPlayerPosY = MAP_DIMENSIONS-10;
	ldr	r2, [sp, #8]	@ _122, %sfp
	cmp	r2, r3	@ _122, tmp675
	ble	.L109		@,
.L145:
@ src/soar_voxel.c:627: 	else if (CurrentProc->sPlayerPosY < 10) CurrentProc->sPlayerPosY = 10;
	str	r3, [r4, #48]	@ tmp670, CurrentProc_154(D)->sPlayerPosY
	b	.L84		@
.L89:
@ src/soar_voxel.c:531: 	else if (gKeyState.heldKeys & DPAD_RIGHT){
	lsls	r3, r3, #27	@ tmp723, _40,
	bpl	.L91		@,
@ src/soar_voxel.c:532: 		newx = CurrentProc->sPlayerPosX + cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]; // step forward to focal point
	ldr	r3, [r4, #60]	@ _59, CurrentProc_154(D)->sPlayerYaw
@ src/soar_voxel.c:532: 		newx = CurrentProc->sPlayerPosX + cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]; // step forward to focal point
	lsls	r0, r3, #1	@ tmp420, _59,
	adds	r2, r5, r0	@ tmp421, tmp279, tmp420
	movs	r1, #32	@ tmp423,
	ldrsh	r1, [r2, r1]	@ tmp423, tmp421, tmp423
@ src/soar_voxel.c:532: 		newx = CurrentProc->sPlayerPosX + cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]; // step forward to focal point
	ldr	r2, [r4, #44]	@ CurrentProc_154(D)->sPlayerPosX, CurrentProc_154(D)->sPlayerPosX
	adds	r1, r1, r2	@ newx, tmp423, CurrentProc_154(D)->sPlayerPosX
@ src/soar_voxel.c:533: 		newy = CurrentProc->sPlayerPosY + cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]; // step forward to focal point
	adds	r2, r5, #2	@ tmp426, tmp279,
	adds	r0, r2, r0	@ tmp428, tmp426, tmp420
	movs	r7, #62	@ tmp737,
	ldrsh	r0, [r0, r7]	@ tmp430, tmp428, tmp737
@ src/soar_voxel.c:533: 		newy = CurrentProc->sPlayerPosY + cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]; // step forward to focal point
	ldr	r7, [r4, #48]	@ CurrentProc_154(D)->sPlayerPosY, CurrentProc_154(D)->sPlayerPosY
	adds	r0, r0, r7	@ newy, tmp430, CurrentProc_154(D)->sPlayerPosY
@ src/soar_voxel.c:534: 		CurrentProc->sPlayerYaw = (CurrentProc->sPlayerYaw + 1)&0xF; //16 angles so skip the conditional
	movs	r7, #15	@ tmp433,
@ src/soar_voxel.c:534: 		CurrentProc->sPlayerYaw = (CurrentProc->sPlayerYaw + 1)&0xF; //16 angles so skip the conditional
	adds	r3, r3, #1	@ tmp432,
@ src/soar_voxel.c:534: 		CurrentProc->sPlayerYaw = (CurrentProc->sPlayerYaw + 1)&0xF; //16 angles so skip the conditional
	ands	r3, r7	@ _66, tmp433
@ src/soar_voxel.c:534: 		CurrentProc->sPlayerYaw = (CurrentProc->sPlayerYaw + 1)&0xF; //16 angles so skip the conditional
	str	r3, [r4, #60]	@ _66, CurrentProc_154(D)->sPlayerYaw
@ src/soar_voxel.c:536: 		newy -= (cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	lsls	r3, r3, #1	@ tmp436, _66,
	adds	r2, r2, r3	@ tmp437, tmp426, tmp436
@ src/soar_voxel.c:536: 		newy -= (cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	movs	r7, #62	@ tmp738,
	ldrsh	r2, [r2, r7]	@ tmp439, tmp437, tmp738
	asrs	r2, r2, #2	@ tmp441, tmp439,
@ src/soar_voxel.c:536: 		newy -= (cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	lsls	r7, r2, #2	@ tmp443, tmp441,
	subs	r2, r2, r7	@ tmp444, tmp441, tmp443
@ src/soar_voxel.c:535: 		newx -= (cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	adds	r3, r5, r3	@ tmp447, tmp279, tmp436
@ src/soar_voxel.c:536: 		newy -= (cam_pivot_dy_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	adds	r2, r2, r0	@ newy, tmp444, newy
@ src/soar_voxel.c:535: 		newx -= (cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	movs	r0, #32	@ tmp739,
	ldrsh	r3, [r3, r0]	@ tmp449, tmp447, tmp739
	asrs	r3, r3, #2	@ tmp451, tmp449,
@ src/soar_voxel.c:535: 		newx -= (cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	lsls	r0, r3, #2	@ tmp453, tmp451,
	subs	r3, r3, r0	@ tmp454, tmp451, tmp453
@ src/soar_voxel.c:535: 		newx -= (cam_pivot_dx_Angles[CurrentProc->sPlayerYaw]>>2)*3; // step back partway from focal point
	adds	r3, r3, r1	@ newx, tmp454, newx
@ src/soar_voxel.c:539: 		BumpScreen(bump_right);
	movs	r0, #3	@,
@ src/soar_voxel.c:537: 		CurrentProc->sPlayerPosX = newx;
	str	r3, [r4, #44]	@ newx, CurrentProc_154(D)->sPlayerPosX
@ src/soar_voxel.c:538: 		CurrentProc->sPlayerPosY = newy;
	str	r2, [r4, #48]	@ newy, CurrentProc_154(D)->sPlayerPosY
	b	.L146		@
.L91:
@ src/soar_voxel.c:541: 	else if (gKeyState.prevKeys & (DPAD_LEFT|DPAD_RIGHT)) {
	movs	r3, #48	@ tmp460,
	ldrh	r2, [r2, #10]	@ tmp458,
	tst	r2, r3	@ tmp458, tmp460
	bne	.LCB1221	@
	b	.L90	@long jump	@
.LCB1221:
	bl	BumpScreen.part.0		@
@ src/soar_voxel.c:477: };
	b	.L90		@
.L94:
@ src/soar_voxel.c:561: 		else if (gChapterData.muteSfxOption == 0) m4aSongNumStart(0x6c); //invalid sfx
	ldr	r3, .L148+4	@ tmp509,
	ldrb	r3, [r3]	@ gChapterData, gChapterData
@ src/soar_voxel.c:561: 		else if (gChapterData.muteSfxOption == 0) m4aSongNumStart(0x6c); //invalid sfx
	lsls	r3, r3, #30	@ tmp724, gChapterData,
	bpl	.LCB1235	@
	b	.L93	@long jump	@
.LCB1235:
@ src/soar_voxel.c:561: 		else if (gChapterData.muteSfxOption == 0) m4aSongNumStart(0x6c); //invalid sfx
	movs	r0, #108	@,
	ldr	r3, .L148+8	@ tmp517,
	bl	.L9		@
	b	.L93		@
.L101:
@ src/soar_voxel.c:607: 	else if (gKeyState.heldKeys & B_BUTTON){ //prevent clipping through ground
	lsls	r3, r6, #30	@ tmp729, _100,
	bpl	.L102		@,
@ src/soar_voxel.c:608: 		if ((CurrentProc->sPlayerPosZ>CAMERA_MIN_HEIGHT) & (camera_ht > (player_terrain_ht+CAMERA_Z_STEP)) & (camera_ht > (camera_terrain_ht+CAMERA_Z_STEP))){
	ldr	r3, [sp, #12]	@ player_terrain_ht, %sfp
	adds	r3, r3, #32	@ player_terrain_ht,
@ src/soar_voxel.c:608: 		if ((CurrentProc->sPlayerPosZ>CAMERA_MIN_HEIGHT) & (camera_ht > (player_terrain_ht+CAMERA_Z_STEP)) & (camera_ht > (camera_terrain_ht+CAMERA_Z_STEP))){
	movs	r2, #1	@ tmp633,
	cmp	r3, r7	@ tmp632, camera_ht
	blt	.L103		@,
	movs	r2, #0	@ tmp633,
.L103:
	movs	r3, #1	@ tmp637,
	cmp	r5, #32	@ _123,
	bgt	.L104		@,
	movs	r3, #0	@ tmp637,
.L104:
	ands	r3, r2	@ tmp641, tmp633
@ src/soar_voxel.c:608: 		if ((CurrentProc->sPlayerPosZ>CAMERA_MIN_HEIGHT) & (camera_ht > (player_terrain_ht+CAMERA_Z_STEP)) & (camera_ht > (camera_terrain_ht+CAMERA_Z_STEP))){
	lsls	r3, r3, #24	@ tmp645, tmp641,
	beq	.L102		@,
@ src/soar_voxel.c:608: 		if ((CurrentProc->sPlayerPosZ>CAMERA_MIN_HEIGHT) & (camera_ht > (player_terrain_ht+CAMERA_Z_STEP)) & (camera_ht > (camera_terrain_ht+CAMERA_Z_STEP))){
	adds	r0, r0, #32	@ tmp646,
@ src/soar_voxel.c:608: 		if ((CurrentProc->sPlayerPosZ>CAMERA_MIN_HEIGHT) & (camera_ht > (player_terrain_ht+CAMERA_Z_STEP)) & (camera_ht > (camera_terrain_ht+CAMERA_Z_STEP))){
	movs	r3, #1	@ tmp647,
	cmp	r0, r7	@ tmp646, camera_ht
	blt	.L105		@,
	movs	r3, #0	@ tmp647,
.L105:
@ src/soar_voxel.c:608: 		if ((CurrentProc->sPlayerPosZ>CAMERA_MIN_HEIGHT) & (camera_ht > (player_terrain_ht+CAMERA_Z_STEP)) & (camera_ht > (camera_terrain_ht+CAMERA_Z_STEP))){
	lsls	r3, r3, #24	@ tmp652, tmp647,
	beq	.L102		@,
@ src/soar_voxel.c:610: 			CurrentProc->sPlayerStepZ -= 1;
	ldr	r3, [r4, #56]	@ CurrentProc_154(D)->sPlayerStepZ, CurrentProc_154(D)->sPlayerStepZ
@ src/soar_voxel.c:609: 			CurrentProc->sPlayerPosZ -= CAMERA_Z_STEP;
	subs	r5, r5, #32	@ tmp653,
	str	r5, [r4, #52]	@ tmp653, CurrentProc_154(D)->sPlayerPosZ
@ src/soar_voxel.c:610: 			CurrentProc->sPlayerStepZ -= 1;
	subs	r3, r3, #1	@ tmp654,
	b	.L147		@
.L107:
@ src/soar_voxel.c:624: 	else if (CurrentProc->sPlayerPosX < 10) CurrentProc->sPlayerPosX = 10;
	ldr	r2, [sp, #4]	@ _121, %sfp
	cmp	r2, #9	@ _121,
	bgt	.L108		@,
@ src/soar_voxel.c:624: 	else if (CurrentProc->sPlayerPosX < 10) CurrentProc->sPlayerPosX = 10;
	movs	r2, #10	@ tmp667,
	str	r2, [r4, #44]	@ tmp667, CurrentProc_154(D)->sPlayerPosX
	b	.L108		@
.L109:
@ src/soar_voxel.c:627: 	else if (CurrentProc->sPlayerPosY < 10) CurrentProc->sPlayerPosY = 10;
	ldr	r3, [sp, #8]	@ _122, %sfp
	cmp	r3, #9	@ _122,
	ble	.LCB1299	@
	b	.L84	@long jump	@
.LCB1299:
@ src/soar_voxel.c:627: 	else if (CurrentProc->sPlayerPosY < 10) CurrentProc->sPlayerPosY = 10;
	movs	r3, #10	@ tmp670,
	b	.L145		@
.L149:
	.align	2
.L148:
	.word	.LANCHOR0
	.word	gChapterData+65
	.word	m4aSongNumStart
	.word	gKeyState
	.word	1014
	.size	thumb_loop, .-thumb_loop
	.global	translatedLocations
	.global	WorldMapNodes
	.global	gObj_aff32x32
	.global	gObj_64x64
	.global	gObj_32x8
	.global	PkOamData
	.global	cam_pivot_dy_Angles
	.global	cam_pivot_dx_Angles
	.global	cam_dy_Angles
	.global	cam_dx_Angles
	.global	fogClrs
	.global	skies
	.global	Proc_Soaring
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC59:
	.ascii	"NewWorldMap\000"
	.global	originCoords
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	cam_dx_Angles, %object
	.size	cam_dx_Angles, 32
cam_dx_Angles:
	.short	0
	.short	1
	.short	2
	.short	3
	.short	4
	.short	3
	.short	2
	.short	1
	.short	0
	.short	-1
	.short	-2
	.short	-3
	.short	-4
	.short	-3
	.short	-2
	.short	-1
	.type	cam_pivot_dx_Angles, %object
	.size	cam_pivot_dx_Angles, 32
cam_pivot_dx_Angles:
	.short	0
	.short	24
	.short	45
	.short	58
	.short	64
	.short	58
	.short	45
	.short	24
	.short	0
	.short	-24
	.short	-45
	.short	-58
	.short	-64
	.short	-58
	.short	-45
	.short	-24
	.type	cam_pivot_dy_Angles, %object
	.size	cam_pivot_dy_Angles, 32
cam_pivot_dy_Angles:
	.short	-64
	.short	-58
	.short	-45
	.short	-24
	.short	0
	.short	24
	.short	45
	.short	58
	.short	64
	.short	58
	.short	45
	.short	24
	.short	0
	.short	-24
	.short	-45
	.short	-58
	.type	cam_dy_Angles, %object
	.size	cam_dy_Angles, 32
cam_dy_Angles:
	.short	-4
	.short	-3
	.short	-2
	.short	-1
	.short	0
	.short	1
	.short	2
	.short	3
	.short	4
	.short	3
	.short	2
	.short	1
	.short	0
	.short	-1
	.short	-2
	.short	-3
	.type	translatedLocations, %object
	.size	translatedLocations, 12
translatedLocations:
	.ascii	"\000\001\002\003\004\005\006\007\010\011\012\013"
	.type	WorldMapNodes, %object
	.size	WorldMapNodes, 256
WorldMapNodes:
	.ascii	"\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.ascii	"\000\000\000"
	.ascii	"\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.ascii	"\000\000\000"
	.ascii	"\000\000\000\000\000\000\000\000\000\000\000\000\000"
	.ascii	"\000\000\000"
	.ascii	"\013\013\000\000\000\000\000\000\000\000\000\004\000"
	.ascii	"\000\000\000"
	.ascii	"\013\013\003\000\000\000\000\000\000\000\004\004\004"
	.ascii	"\000\000\000"
	.ascii	"\013\003\003\003\000\000\000\000\000\000\000\004\000"
	.ascii	"\000\000\000"
	.ascii	"\000\000\003\000\000\000\000\000\010\000\011\011\000"
	.ascii	"\000\006\000"
	.ascii	"\000\000\000\000\000\000\000\010\010\010\011\011\000"
	.ascii	"\006\006\006"
	.ascii	"\000\000\002\000\000\000\000\000\010\000\011\011\000"
	.ascii	"\000\006\000"
	.ascii	"\000\002\002\002\000\000\000\000\000\000\005\005\000"
	.ascii	"\000\000\000"
	.ascii	"\000\000\001\000\000\000\000\000\000\000\005\005\005"
	.ascii	"\000\000\000"
	.ascii	"\000\001\001\001\000\000\000\000\000\007\000\005\000"
	.ascii	"\000\000\000"
	.ascii	"\000\000\001\000\000\000\000\000\007\007\007\000\000"
	.ascii	"\000\000\000"
	.ascii	"\000\000\012\000\000\000\000\000\000\007\000\000\000"
	.ascii	"\000\000\000"
	.ascii	"\000\012\012\012\000\000\000\000\000\000\000\000\000"
	.ascii	"\000\000\000"
	.ascii	"\000\000\012\000\000\000\000\000\000\000\000\000\000"
	.ascii	"\000\000\000"
	.type	gObj_aff32x32, %object
	.size	gObj_aff32x32, 6
gObj_aff32x32:
	.short	1
	.short	1024
	.short	-32768
	.type	gObj_64x64, %object
	.size	gObj_64x64, 6
gObj_64x64:
	.short	1
	.short	0
	.short	-16384
	.type	gObj_32x8, %object
	.size	gObj_32x8, 6
gObj_32x8:
	.short	1
	.short	16384
	.short	16384
	.space	2
	.type	PkOamData, %object
	.size	PkOamData, 4
PkOamData:
	.space	4
	.type	fogClrs, %object
	.size	fogClrs, 10
fogClrs:
	.short	32628
	.short	32628
	.short	27277
	.short	20935
	.short	13536
	.space	2
	.type	skies, %object
	.size	skies, 20
skies:
	.word	SkyBG
	.word	SkyBG
	.word	SkyBG
	.word	SkyBG
	.word	SkyBG
	.type	Proc_Soaring, %object
	.size	Proc_Soaring, 152
Proc_Soaring:
@ type:
	.short	1
@ sArg:
	.short	0
@ lArg:
	.word	.LC59
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	LockGameLogic
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	LockGameGraphicsLogic
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	MU_AllDisable
@ type:
	.short	24
@ sArg:
	.short	8
@ lArg:
	.word	NewFadeIn
@ type:
	.short	20
@ sArg:
	.short	0
@ lArg:
	.word	FadeInExists
@ type:
	.short	14
@ sArg:
	.short	1
@ lArg:
	.word	0
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	SetUpNewWMGraphics
@ type:
	.short	14
@ sArg:
	.short	8
@ lArg:
	.word	0
@ type:
	.short	3
@ sArg:
	.short	0
@ lArg:
	.word	50360320
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	SoaringLandRoutine
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	134848105
@ type:
	.short	24
@ sArg:
	.short	8
@ lArg:
	.word	NewFadeIn
@ type:
	.short	20
@ sArg:
	.short	0
@ lArg:
	.word	FadeInExists
@ type:
	.short	14
@ sArg:
	.short	1
@ lArg:
	.word	0
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	UnlockGameLogic
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	UnlockGameGraphicsLogic
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	MU_AllEnable
@ type:
	.short	0
@ sArg:
	.short	0
@ lArg:
	.word	0
	.type	originCoords, %object
	.size	originCoords, 212
originCoords:
	.ascii	"\002\013"
	.ascii	"\002\013"
	.ascii	"\002\012"
	.ascii	"\002\011"
	.ascii	"\002\010"
	.ascii	"\002\007"
	.ascii	"\002\007"
	.ascii	"\002\006"
	.ascii	"\002\005"
	.ascii	"\002\005"
	.ascii	"\004\005"
	.ascii	"\007\004"
	.ascii	"\010\004"
	.ascii	"\010\004"
	.ascii	"\010\004"
	.ascii	"\011\004"
	.ascii	"\013\004"
	.ascii	"\013\004"
	.ascii	"\013\003"
	.ascii	"\014\003"
	.ascii	"\013\005"
	.ascii	"\013\010"
	.ascii	"\013\012"
	.ascii	"\013\012"
	.ascii	"\013\012"
	.ascii	"\014\012"
	.ascii	"\014\012"
	.ascii	"\014\004"
	.ascii	"\015\004"
	.ascii	"\016\004"
	.ascii	"\016\005"
	.ascii	"\016\006"
	.ascii	"\016\007"
	.ascii	"\011\007"
	.ascii	"\016\007"
	.ascii	"\016\007"
	.ascii	"\016\007"
	.ascii	"\016\007"
	.ascii	"\016\007"
	.ascii	"\016\010"
	.ascii	"\016\011"
	.ascii	"\015\013"
	.ascii	"\014\014"
	.ascii	"\012\014"
	.ascii	"\011\014"
	.ascii	"\011\014"
	.ascii	"\011\014"
	.ascii	"\011\014"
	.ascii	"\011\014"
	.ascii	"\011\014"
	.ascii	"\007\014"
	.ascii	"\004\013"
	.ascii	"\004\011"
	.ascii	"\007\007"
	.ascii	"\010\007"
	.ascii	"\010\007"
	.ascii	"\014\007"
	.ascii	"\013\007"
	.ascii	"\013\007"
	.ascii	"\013\007"
	.ascii	"\011\016"
	.ascii	"\006\016"
	.ascii	"\003\016"
	.ascii	"\002\016"
	.ascii	"\002\016"
	.ascii	"\002\015"
	.ascii	"\002\011"
	.ascii	"\001\011"
	.ascii	"\001\010"
	.ascii	"\001\007"
	.ascii	"\001\005"
	.ascii	"\000\000"
	.ascii	"\000\000"
	.ascii	"\013\007"
	.ascii	"\013\007"
	.ascii	"\013\007"
	.ascii	"\013\007"
	.ascii	"\013\007"
	.ascii	"\006\016"
	.ascii	"\006\016"
	.ascii	"\006\016"
	.ascii	"\006\016"
	.ascii	"\006\016"
	.ascii	"\002\016"
	.ascii	"\002\016"
	.ascii	"\002\016"
	.ascii	"\002\016"
	.ascii	"\016\005"
	.ascii	"\012\004"
	.ascii	"\012\004"
	.ascii	"\012\004"
	.ascii	"\001\005"
	.ascii	"\001\005"
	.ascii	"\001\005"
	.ascii	"\001\004"
	.ascii	"\001\004"
	.ascii	"\001\004"
	.ascii	"\001\004"
	.ascii	"\001\004"
	.ascii	"\001\004"
	.ascii	"\000\000"
	.ascii	"\001\004"
	.ascii	"\000\000"
	.ascii	"\000\000"
	.ascii	"\002\016"
	.ascii	"\000\000"
	.ident	"GCC: (devkitARM release 58) 12.1.0"
	.text
	.code 16
	.align	1
.L9:
	bx	r3
.L56:
	bx	r4
.L71:
	bx	r5
.L67:
	bx	r6
.L63:
	bx	r7
