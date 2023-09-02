	.cpu arm7tdmi
	.arch armv4t
	.fpu softvfp
	.eabi_attribute 23, 1	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 2	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"soar_wram.arm.c"
@ GNU C17 (devkitARM release 58) version 12.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -marm -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -Ofast -fomit-frame-pointer -ffast-math -fno-jump-tables -fno-toplevel-reorder
	.text
	.align	2
	.global	NewWMLoop
	.syntax unified
	.arm
	.type	NewWMLoop, %function
NewWMLoop:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ arm/soar_wram.arm.c:56: 	u8 animClock = *(u8*)(0x3000014) & 0x3F;
	mov	r3, #50331648	@ tmp164,
@ arm/soar_wram.arm.c:9: void NewWMLoop(SoarProc* CurrentProc){
	push	{r4, r5, r6, r7, lr}	@
@ arm/soar_wram.arm.c:56: 	u8 animClock = *(u8*)(0x3000014) & 0x3F;
	ldrb	r3, [r3, #20]	@ zero_extendqisi2	@ _11, MEM[(u8 *)50331668B]
@ arm/soar_wram.arm.c:58: 	if (animClock < 0x10) ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, 0xca00); //player frames
	tst	r3, #48	@ _11,
@ arm/soar_wram.arm.c:9: void NewWMLoop(SoarProc* CurrentProc){
	mov	r4, r0	@ CurrentProc, tmp269
	sub	sp, sp, #12	@,,
@ arm/soar_wram.arm.c:58: 	if (animClock < 0x10) ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, 0xca00); //player frames
	beq	.L39		@,
@ arm/soar_wram.arm.c:59: 	else if (animClock < 0x20)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, 0xca10);
	tst	r3, #32	@ _11,
@ arm/soar_wram.arm.c:59: 	else if (animClock < 0x20)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, 0xca10);
	ldreq	r3, .L45	@ tmp175,
@ arm/soar_wram.arm.c:59: 	else if (animClock < 0x20)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, 0xca10);
	beq	.L37		@,
@ arm/soar_wram.arm.c:56: 	u8 animClock = *(u8*)(0x3000014) & 0x3F;
	and	r3, r3, #63	@ tmp177, _11,
@ arm/soar_wram.arm.c:60: 	else if (animClock < 0x30)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, 0xca20);
	cmp	r3, #47	@ tmp177,
@ arm/soar_wram.arm.c:60: 	else if (animClock < 0x30)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, 0xca20);
	ldrls	r3, .L45+4	@ tmp182,
@ arm/soar_wram.arm.c:61: 	else ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, 0xca30);
	ldrhi	r3, .L45+8	@ tmp185,
.L37:
	str	r3, [sp]	@ tmp185,
	mov	r2, #88	@,
	ldr	r3, .L45+12	@,
	mov	r1, #104	@,
	mov	r0, #8	@,
	ldr	r5, .L45+16	@ tmp268,
	mov	lr, pc
	bx	r5		@ tmp268
@ arm/soar_wram.arm.c:63: 	if (CurrentProc->ShowMap) ObjInsertSafe(8, 176, 0, &gObj_64x64, 0x2a60+96); //draw minimap
	ldrb	r3, [r4, #69]	@ zero_extendqisi2	@ _15, *CurrentProc_6(D)
@ arm/soar_wram.arm.c:63: 	if (CurrentProc->ShowMap) ObjInsertSafe(8, 176, 0, &gObj_64x64, 0x2a60+96); //draw minimap
	tst	r3, #1	@ _15,
	bne	.L40		@,
.L6:
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (0xcaa1 +96 + (FPS_CURRENT))); //fps counter
	tst	r3, #2	@ _15,
	bne	.L41		@,
.L7:
@ arm/soar_wram.arm.c:67: 	if (CurrentProc->sunsetVal < 3)
	ldr	r3, [r4, #84]	@ CurrentProc_6(D)->sunsetVal, CurrentProc_6(D)->sunsetVal
	cmp	r3, #2	@ CurrentProc_6(D)->sunsetVal,
	bgt	.L8		@,
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	ldr	r3, .L45+20	@ tmp206,
	ldr	r3, [r3, #208]	@ _26, MEM[(volatile vu32 *)50344144B]
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	sub	r3, r3, #40448	@ tmp207, _26,
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	ldr	r2, [r4, #60]	@ _31, CurrentProc_6(D)->sPlayerYaw
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	sub	r3, r3, #64	@ tmp207, tmp207,
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	ldr	r1, [r4, #56]	@ CurrentProc_6(D)->sPlayerStepZ, CurrentProc_6(D)->sPlayerStepZ
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	lsr	r3, r3, #10	@ tmp209, tmp207,
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	rsb	r3, r3, #80	@ tmp210, tmp209,
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	cmp	r2, #11	@ _31,
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	sub	r3, r3, r1, lsl #2	@ _30, tmp210, CurrentProc_6(D)->sPlayerStepZ,
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	beq	.L18		@,
	bgt	.L10		@,
	cmp	r2, #9	@ _31,
	beq	.L19		@,
	cmp	r2, #10	@ _31,
	moveq	r1, #96	@ prephitmp_119,
	bne	.L8		@,
.L11:
@ arm/soar_wram.arm.c:82: 			ObjInsertSafe(9, flarex, flarey, &gObj_aff32x32, 0x3aa1+96+31);
	ldr	r0, .L45+24	@ tmp216,
	lsl	r2, r3, #16	@, _30,
	str	r0, [sp]	@ tmp216,
	ldr	r3, .L45+28	@,
	mov	r0, #9	@,
	lsr	r2, r2, #16	@,,
	mov	lr, pc
	bx	r5		@ tmp268
.L8:
@ arm/soar_wram.arm.c:88: 	int posY = CurrentProc->sFocusPtY;
	ldr	r6, [r4, #76]	@ posY, CurrentProc_6(D)->sFocusPtY
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	ldr	r3, .L45+32	@ tmp219,
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	sub	r2, r6, #1	@ tmp218, posY,
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	cmp	r2, r3	@ tmp218, tmp219
@ arm/soar_wram.arm.c:87: 	int posX = CurrentProc->sFocusPtX;
	ldr	r7, [r4, #72]	@ posX, CurrentProc_6(D)->sFocusPtX
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	bhi	.L15		@,
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	sub	r2, r7, #1	@ tmp222, posX,
	cmp	r2, r3	@ tmp222, tmp219
	bls	.L42		@,
.L15:
@ arm/soar_wram.arm.c:98: 	CurrentProc->location = translatedLocations[loc];
	ldr	r3, .L45+36	@ tmp220,
	ldrb	r3, [r3]	@ zero_extendqisi2	@ translatedLocations[0], translatedLocations[0]
	str	r3, [r4, #80]	@ translatedLocations[0], CurrentProc_6(D)->location
.L14:
@ arm/soar_wram.arm.c:12: 	if (thumb_loop(CurrentProc)){
	mov	r0, r4	@, CurrentProc
	ldr	r3, .L45+40	@ tmp262,
	mov	lr, pc
	bx	r3		@ tmp262
@ arm/soar_wram.arm.c:12: 	if (thumb_loop(CurrentProc)){
	cmp	r0, #0	@ tmp270,
	bne	.L43		@,
@ arm/soar_wram.arm.c:17: };
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7, lr}	@
	bx	lr	@
.L10:
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	cmp	r2, #12	@ _31,
	moveq	r1, #160	@ prephitmp_119,
	beq	.L11		@,
	b	.L8		@
.L42:
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, 0xda60+96); //draw cursor on minimap
	ldrb	r3, [r4, #69]	@ zero_extendqisi2	@ *CurrentProc_6(D), *CurrentProc_6(D)
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, 0xda60+96); //draw cursor on minimap
	tst	r3, #1	@ *CurrentProc_6(D),
	bne	.L44		@,
.L16:
@ arm/soar_wram.arm.c:96: 		loc = WorldMapNodes[posY][posX];
	ldr	r3, .L45+44	@ tmp240,
@ arm/soar_wram.arm.c:95: 		posY = (posY-MAP_YOFS)>>6;
	asr	r6, r6, #6	@ posY, posY,
@ arm/soar_wram.arm.c:96: 		loc = WorldMapNodes[posY][posX];
	add	r3, r3, r6, lsl #4	@ tmp244, tmp240, posY,
	ldrb	r3, [r3, r7, asr #6]	@ zero_extendqisi2	@ loc, WorldMapNodes[posY_53][posX_52]
@ arm/soar_wram.arm.c:98: 	CurrentProc->location = translatedLocations[loc];
	ldr	r2, .L45+36	@ tmp246,
	ldrb	r2, [r2, r3]	@ zero_extendqisi2	@ translatedLocations[_56], translatedLocations[_56]
@ arm/soar_wram.arm.c:99: 	if (loc>0) {
	cmp	r3, #0	@ loc,
@ arm/soar_wram.arm.c:98: 	CurrentProc->location = translatedLocations[loc];
	str	r2, [r4, #80]	@ translatedLocations[_56], CurrentProc_6(D)->location
@ arm/soar_wram.arm.c:99: 	if (loc>0) {
	beq	.L14		@,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (0xea38+(loc<<3))); //draw in the top corner if we're there
	mov	r2, #16	@,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (0xea38+(loc<<3))); //draw in the top corner if we're there
	lsl	r3, r3, #3	@ _60, loc,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (0xea38+(loc<<3))); //draw in the top corner if we're there
	sub	r6, r3, #5568	@ tmp252, _60,
	sub	r3, r6, #8	@ tmp251, tmp252,
	lsl	r3, r3, r2	@ tmp254, tmp251,
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (0xea38+(loc<<3)+4)); //draw in the top corner if we're there
	sub	r6, r6, #4	@ tmp257, tmp252,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (0xea38+(loc<<3))); //draw in the top corner if we're there
	lsr	r3, r3, r2	@ tmp253, tmp254,
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (0xea38+(loc<<3)+4)); //draw in the top corner if we're there
	lsl	r6, r6, #16	@ tmp260, tmp257,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (0xea38+(loc<<3))); //draw in the top corner if we're there
	mov	r1, r2	@,
	str	r3, [sp]	@ tmp253,
	mov	r0, #8	@,
	ldr	r3, .L45+48	@,
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (0xea38+(loc<<3)+4)); //draw in the top corner if we're there
	lsr	r6, r6, #16	@ tmp259, tmp260,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (0xea38+(loc<<3))); //draw in the top corner if we're there
	mov	lr, pc
	bx	r5		@ tmp268
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (0xea38+(loc<<3)+4)); //draw in the top corner if we're there
	mov	r2, #16	@,
	mov	r1, #48	@,
	mov	r0, #8	@,
	str	r6, [sp]	@ tmp259,
	ldr	r3, .L45+48	@,
	mov	lr, pc
	bx	r5		@ tmp268
	b	.L14		@
.L39:
@ arm/soar_wram.arm.c:58: 	if (animClock < 0x10) ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, 0xca00); //player frames
	mov	ip, #51712	@ tmp169,
	ldr	r3, .L45+12	@,
	mov	r2, #88	@,
	mov	r1, #104	@,
	mov	r0, #8	@,
	ldr	r5, .L45+16	@ tmp268,
	str	ip, [sp]	@ tmp169,
	mov	lr, pc
	bx	r5		@ tmp268
@ arm/soar_wram.arm.c:63: 	if (CurrentProc->ShowMap) ObjInsertSafe(8, 176, 0, &gObj_64x64, 0x2a60+96); //draw minimap
	ldrb	r3, [r4, #69]	@ zero_extendqisi2	@ _15, *CurrentProc_6(D)
@ arm/soar_wram.arm.c:63: 	if (CurrentProc->ShowMap) ObjInsertSafe(8, 176, 0, &gObj_64x64, 0x2a60+96); //draw minimap
	tst	r3, #1	@ _15,
	beq	.L6		@,
.L40:
@ arm/soar_wram.arm.c:63: 	if (CurrentProc->ShowMap) ObjInsertSafe(8, 176, 0, &gObj_64x64, 0x2a60+96); //draw minimap
	mov	ip, #10944	@ tmp191,
	ldr	r3, .L45+52	@,
	mov	r2, #0	@,
	mov	r1, #176	@,
	mov	r0, #8	@,
	str	ip, [sp]	@ tmp191,
	mov	lr, pc
	bx	r5		@ tmp268
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (0xcaa1 +96 + (FPS_CURRENT))); //fps counter
	ldrb	r3, [r4, #69]	@ zero_extendqisi2	@ _15, *CurrentProc_6(D)
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (0xcaa1 +96 + (FPS_CURRENT))); //fps counter
	tst	r3, #2	@ _15,
	beq	.L7		@,
.L41:
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (0xcaa1 +96 + (FPS_CURRENT))); //fps counter
	mov	r2, #0	@,
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (0xcaa1 +96 + (FPS_CURRENT))); //fps counter
	ldr	r1, .L45+56	@ tmp197,
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (0xcaa1 +96 + (FPS_CURRENT))); //fps counter
	ldr	r1, [r1, #4092]	@ MEM[(int *)33816572B], MEM[(int *)33816572B]
	sub	r1, r1, #13504	@ tmp200, MEM[(int *)33816572B],
	sub	r1, r1, #63	@ tmp200, tmp200,
	lsl	r1, r1, #16	@ tmp202, tmp200,
	lsr	r1, r1, #16	@ tmp202, tmp202,
	str	r1, [sp]	@ tmp202,
	mov	r0, #8	@,
	mov	r1, r2	@,
	ldr	r3, .L45+60	@,
	mov	lr, pc
	bx	r5		@ tmp268
	b	.L7		@
.L43:
@ arm/soar_wram.arm.c:13: 		iwram_Render_arm(CurrentProc);
	mov	r0, r4	@, CurrentProc
	ldr	r3, .L45+64	@ tmp263,
	mov	lr, pc
	bx	r3		@ tmp263
@ arm/soar_wram.arm.c:15: 		FPS_COUNTER += 1;
	ldr	r2, .L45+56	@ tmp264,
	ldr	r3, [r2, #4088]	@ MEM[(int *)33816568B], MEM[(int *)33816568B]
	add	r3, r3, #1	@ tmp266, MEM[(int *)33816568B],
	str	r3, [r2, #4088]	@ tmp266, MEM[(int *)33816568B]
@ arm/soar_wram.arm.c:17: };
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7, lr}	@
	bx	lr	@
.L19:
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	mov	r1, #64	@ prephitmp_119,
	b	.L11		@
.L18:
	mov	r1, #128	@ prephitmp_119,
	b	.L11		@
.L44:
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, 0xda60+96); //draw cursor on minimap
	asr	r1, r7, #4	@ tmp233, posX,
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, 0xda60+96); //draw cursor on minimap
	ldr	r3, .L45+68	@ tmp238,
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, 0xda60+96); //draw cursor on minimap
	asr	r2, r6, #4	@ tmp230, posY,
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, 0xda60+96); //draw cursor on minimap
	add	r1, r1, #176	@ tmp235, tmp233,
	lsl	r2, r2, #16	@, tmp230,
	lsl	r1, r1, #16	@, tmp235,
	str	r3, [sp]	@ tmp238,
	mov	r0, #8	@,
	ldr	r3, .L45+60	@,
	lsr	r2, r2, #16	@,,
	lsr	r1, r1, #16	@,,
	mov	lr, pc
	bx	r5		@ tmp268
	b	.L16		@
.L46:
	.align	2
.L45:
	.word	51728
	.word	51744
	.word	51760
	.word	gObj_32x32
	.word	ObjInsertSafe
	.word	50343936
	.word	15136
	.word	gObj_aff32x32
	.word	1022
	.word	translatedLocations
	.word	thumb_loop
	.word	WorldMapNodes
	.word	gObj_32x8
	.word	gObj_64x64
	.word	33812480
	.word	gObj_8x8
	.word	iwram_Render_arm
	.word	56000
	.size	NewWMLoop, .-NewWMLoop
	.ident	"GCC: (devkitARM release 58) 12.1.0"
