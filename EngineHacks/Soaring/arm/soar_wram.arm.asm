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
	mov	r3, #50331648	@ tmp172,
@ arm/soar_wram.arm.c:9: void NewWMLoop(SoarProc* CurrentProc){
	push	{r4, r5, r6, r7, lr}	@
@ arm/soar_wram.arm.c:56: 	u8 animClock = *(u8*)(0x3000014) & 0x3F;
	ldrb	r3, [r3, #20]	@ zero_extendqisi2	@ _11, MEM[(u8 *)50331668B]
@ arm/soar_wram.arm.c:58: 	if (animClock < 0x10) ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID, 2, 0xC)); //player frames
	tst	r3, #48	@ _11,
@ arm/soar_wram.arm.c:9: void NewWMLoop(SoarProc* CurrentProc){
	mov	r4, r0	@ CurrentProc, tmp296
	sub	sp, sp, #12	@,,
@ arm/soar_wram.arm.c:58: 	if (animClock < 0x10) ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID, 2, 0xC)); //player frames
	beq	.L39		@,
@ arm/soar_wram.arm.c:59: 	else if (animClock < 0x20)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID+0x10, 2, 0xC));
	tst	r3, #32	@ _11,
@ arm/soar_wram.arm.c:59: 	else if (animClock < 0x20)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID+0x10, 2, 0xC));
	ldreq	r3, .L45	@ tmp183,
@ arm/soar_wram.arm.c:59: 	else if (animClock < 0x20)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID+0x10, 2, 0xC));
	beq	.L37		@,
@ arm/soar_wram.arm.c:56: 	u8 animClock = *(u8*)(0x3000014) & 0x3F;
	and	r3, r3, #63	@ tmp185, _11,
@ arm/soar_wram.arm.c:60: 	else if (animClock < 0x30)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID+0x20, 2, 0xC));
	cmp	r3, #47	@ tmp185,
@ arm/soar_wram.arm.c:60: 	else if (animClock < 0x30)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID+0x20, 2, 0xC));
	ldrls	r3, .L45+4	@ tmp190,
@ arm/soar_wram.arm.c:61: 	else ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID+0x30, 2, 0xC));
	ldrhi	r3, .L45+8	@ tmp193,
.L37:
	str	r3, [sp]	@ tmp193,
	mov	r2, #88	@,
	ldr	r3, .L45+12	@,
	mov	r1, #104	@,
	mov	r0, #8	@,
	ldr	r6, .L45+16	@ tmp295,
	mov	lr, pc
	bx	r6		@ tmp295
@ arm/soar_wram.arm.c:63: 	if (CurrentProc->ShowMap) ObjInsertSafe(8, 176, 0, &gObj_64x64, OAM_ATTR2(MinimapBaseTID-1, 2, 0x2)); //draw minimap
	ldrb	r3, [r4, #69]	@ zero_extendqisi2	@ _15, *CurrentProc_6(D)
@ arm/soar_wram.arm.c:63: 	if (CurrentProc->ShowMap) ObjInsertSafe(8, 176, 0, &gObj_64x64, OAM_ATTR2(MinimapBaseTID-1, 2, 0x2)); //draw minimap
	tst	r3, #1	@ _15,
	bne	.L40		@,
.L6:
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (OAM_ATTR2(FPSBaseTID + FPS_CURRENT, 2, 0xC))); //fps counter
	tst	r3, #2	@ _15,
	bne	.L41		@,
.L7:
@ arm/soar_wram.arm.c:67: 	if (CurrentProc->sunsetVal < 3)
	ldr	r3, [r4, #84]	@ CurrentProc_6(D)->sunsetVal, CurrentProc_6(D)->sunsetVal
	cmp	r3, #2	@ CurrentProc_6(D)->sunsetVal,
	bgt	.L8		@,
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	ldr	r3, .L45+20	@ tmp217,
	ldr	r3, [r3, #208]	@ _27, MEM[(volatile vu32 *)50344144B]
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	sub	r3, r3, #40448	@ tmp218, _27,
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	ldr	r2, [r4, #60]	@ _32, CurrentProc_6(D)->sPlayerYaw
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	sub	r3, r3, #64	@ tmp218, tmp218,
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	ldr	r1, [r4, #56]	@ CurrentProc_6(D)->sPlayerStepZ, CurrentProc_6(D)->sPlayerStepZ
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	lsr	r3, r3, #10	@ tmp220, tmp218,
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	rsb	r3, r3, #80	@ tmp221, tmp220,
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	cmp	r2, #11	@ _32,
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	sub	r3, r3, r1, lsl #2	@ _31, tmp221, CurrentProc_6(D)->sPlayerStepZ,
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	beq	.L18		@,
	bgt	.L10		@,
	cmp	r2, #9	@ _32,
	beq	.L19		@,
	cmp	r2, #10	@ _32,
	moveq	r1, #96	@ prephitmp_133,
	bne	.L8		@,
.L11:
@ arm/soar_wram.arm.c:82: 			ObjInsertSafe(9, flarex, flarey, &gObj_aff32x32, OAM_ATTR2(LensFlareBaseTID-1, 2, 0x3));
	ldr	r0, .L45+24	@ tmp227,
	lsl	r2, r3, #16	@, _31,
	str	r0, [sp]	@ tmp227,
	ldr	r3, .L45+28	@,
	mov	r0, #9	@,
	lsr	r2, r2, #16	@,,
	mov	lr, pc
	bx	r6		@ tmp295
.L8:
@ arm/soar_wram.arm.c:88: 	int posY = CurrentProc->sFocusPtY;
	ldr	r5, [r4, #76]	@ posY, CurrentProc_6(D)->sFocusPtY
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	ldr	r3, .L45+32	@ tmp230,
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	sub	r2, r5, #1	@ tmp229, posY,
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	cmp	r2, r3	@ tmp229, tmp230
@ arm/soar_wram.arm.c:87: 	int posX = CurrentProc->sFocusPtX;
	ldr	r7, [r4, #72]	@ posX, CurrentProc_6(D)->sFocusPtX
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	bhi	.L15		@,
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	sub	r2, r7, #1	@ tmp233, posX,
	cmp	r2, r3	@ tmp233, tmp230
	bls	.L42		@,
.L15:
@ arm/soar_wram.arm.c:98: 	CurrentProc->location = translatedLocations[loc];
	ldr	r3, .L45+36	@ tmp231,
	ldrb	r3, [r3]	@ zero_extendqisi2	@ translatedLocations[0], translatedLocations[0]
	str	r3, [r4, #80]	@ translatedLocations[0], CurrentProc_6(D)->location
.L14:
@ arm/soar_wram.arm.c:12: 	if (thumb_loop(CurrentProc)){
	mov	r0, r4	@, CurrentProc
	ldr	r3, .L45+40	@ tmp289,
	mov	lr, pc
	bx	r3		@ tmp289
@ arm/soar_wram.arm.c:12: 	if (thumb_loop(CurrentProc)){
	cmp	r0, #0	@ tmp297,
	bne	.L43		@,
@ arm/soar_wram.arm.c:17: };
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7, lr}	@
	bx	lr	@
.L10:
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	cmp	r2, #12	@ _32,
	moveq	r1, #160	@ prephitmp_133,
	beq	.L11		@,
	b	.L8		@
.L42:
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, OAM_ATTR2(CursorBaseTID+CurrentProc->sPlayerYaw, 2, 0xD)); //draw cursor on minimap
	ldrb	r3, [r4, #69]	@ zero_extendqisi2	@ *CurrentProc_6(D), *CurrentProc_6(D)
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, OAM_ATTR2(CursorBaseTID+CurrentProc->sPlayerYaw, 2, 0xD)); //draw cursor on minimap
	tst	r3, #1	@ *CurrentProc_6(D),
	bne	.L44		@,
.L16:
@ arm/soar_wram.arm.c:96: 		loc = WorldMapNodes[posY][posX];
	ldr	r3, .L45+44	@ tmp259,
@ arm/soar_wram.arm.c:95: 		posY = (posY-MAP_YOFS)>>6;
	asr	r5, r5, #6	@ posY, posY,
@ arm/soar_wram.arm.c:96: 		loc = WorldMapNodes[posY][posX];
	add	r3, r3, r5, lsl #4	@ tmp263, tmp259, posY,
	ldrb	r3, [r3, r7, asr #6]	@ zero_extendqisi2	@ loc, WorldMapNodes[posY_58][posX_57]
@ arm/soar_wram.arm.c:98: 	CurrentProc->location = translatedLocations[loc];
	ldr	r2, .L45+36	@ tmp265,
	ldrb	r2, [r2, r3]	@ zero_extendqisi2	@ translatedLocations[_61], translatedLocations[_61]
@ arm/soar_wram.arm.c:99: 	if (loc>0) {
	cmp	r3, #0	@ loc,
@ arm/soar_wram.arm.c:98: 	CurrentProc->location = translatedLocations[loc];
	str	r2, [r4, #80]	@ translatedLocations[_61], CurrentProc_6(D)->location
@ arm/soar_wram.arm.c:99: 	if (loc>0) {
	beq	.L14		@,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3), 2, 0xe))); //draw in the top corner if we're there
	mov	r2, #16	@,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3), 2, 0xe))); //draw in the top corner if we're there
	sub	r5, r3, #1	@ tmp267, loc,
	lsl	r5, r5, #19	@ tmp270, tmp267,
	lsr	r5, r5, r2	@ _66, tmp270,
	add	r3, r5, #576	@ tmp272, _66,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3), 2, 0xe))); //draw in the top corner if we're there
	orr	r3, r3, #59392	@ tmp276, tmp272,
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3)+4, 2, 0xe))); //draw in the top corner if we're there
	add	r5, r5, #580	@ tmp281, _66,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3), 2, 0xe))); //draw in the top corner if we're there
	lsl	r3, r3, r2	@ tmp278, tmp276,
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3)+4, 2, 0xe))); //draw in the top corner if we're there
	orr	r5, r5, #59392	@ tmp285, tmp281,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3), 2, 0xe))); //draw in the top corner if we're there
	lsr	r3, r3, r2	@ tmp277, tmp278,
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3)+4, 2, 0xe))); //draw in the top corner if we're there
	lsl	r5, r5, #16	@ tmp287, tmp285,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3), 2, 0xe))); //draw in the top corner if we're there
	mov	r1, r2	@,
	str	r3, [sp]	@ tmp277,
	mov	r0, #8	@,
	ldr	r3, .L45+48	@,
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3)+4, 2, 0xe))); //draw in the top corner if we're there
	lsr	r5, r5, #16	@ tmp286, tmp287,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3), 2, 0xe))); //draw in the top corner if we're there
	mov	lr, pc
	bx	r6		@ tmp295
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3)+4, 2, 0xe))); //draw in the top corner if we're there
	mov	r2, #16	@,
	mov	r1, #48	@,
	mov	r0, #8	@,
	str	r5, [sp]	@ tmp286,
	ldr	r3, .L45+48	@,
	mov	lr, pc
	bx	r6		@ tmp295
	b	.L14		@
.L39:
@ arm/soar_wram.arm.c:58: 	if (animClock < 0x10) ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID, 2, 0xC)); //player frames
	mov	ip, #51712	@ tmp177,
	ldr	r3, .L45+12	@,
	mov	r2, #88	@,
	mov	r1, #104	@,
	mov	r0, #8	@,
	ldr	r6, .L45+16	@ tmp295,
	str	ip, [sp]	@ tmp177,
	mov	lr, pc
	bx	r6		@ tmp295
@ arm/soar_wram.arm.c:63: 	if (CurrentProc->ShowMap) ObjInsertSafe(8, 176, 0, &gObj_64x64, OAM_ATTR2(MinimapBaseTID-1, 2, 0x2)); //draw minimap
	ldrb	r3, [r4, #69]	@ zero_extendqisi2	@ _15, *CurrentProc_6(D)
@ arm/soar_wram.arm.c:63: 	if (CurrentProc->ShowMap) ObjInsertSafe(8, 176, 0, &gObj_64x64, OAM_ATTR2(MinimapBaseTID-1, 2, 0x2)); //draw minimap
	tst	r3, #1	@ _15,
	beq	.L6		@,
.L40:
@ arm/soar_wram.arm.c:63: 	if (CurrentProc->ShowMap) ObjInsertSafe(8, 176, 0, &gObj_64x64, OAM_ATTR2(MinimapBaseTID-1, 2, 0x2)); //draw minimap
	ldr	r3, .L45+52	@ tmp199,
	mov	r2, #0	@,
	str	r3, [sp]	@ tmp199,
	mov	r1, #176	@,
	ldr	r3, .L45+56	@,
	mov	r0, #8	@,
	mov	lr, pc
	bx	r6		@ tmp295
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (OAM_ATTR2(FPSBaseTID + FPS_CURRENT, 2, 0xC))); //fps counter
	ldrb	r3, [r4, #69]	@ zero_extendqisi2	@ _15, *CurrentProc_6(D)
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (OAM_ATTR2(FPSBaseTID + FPS_CURRENT, 2, 0xC))); //fps counter
	tst	r3, #2	@ _15,
	beq	.L7		@,
.L41:
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (OAM_ATTR2(FPSBaseTID + FPS_CURRENT, 2, 0xC))); //fps counter
	mov	r2, #0	@,
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (OAM_ATTR2(FPSBaseTID + FPS_CURRENT, 2, 0xC))); //fps counter
	ldr	r1, .L45+60	@ tmp205,
	ldr	r1, [r1, #4092]	@ MEM[(int *)33816572B], MEM[(int *)33816572B]
	add	r1, r1, #784	@ tmp208, MEM[(int *)33816572B],
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (OAM_ATTR2(FPSBaseTID + FPS_CURRENT, 2, 0xC))); //fps counter
	orr	r1, r1, #51200	@ tmp212, tmp208,
	lsl	r1, r1, #16	@ tmp213, tmp212,
	lsr	r1, r1, #16	@ tmp213, tmp213,
	str	r1, [sp]	@ tmp213,
	mov	r0, #8	@,
	mov	r1, r2	@,
	ldr	r3, .L45+64	@,
	mov	lr, pc
	bx	r6		@ tmp295
	b	.L7		@
.L43:
@ arm/soar_wram.arm.c:13: 		iwram_Render_arm(CurrentProc);
	mov	r0, r4	@, CurrentProc
	ldr	r3, .L45+68	@ tmp290,
	mov	lr, pc
	bx	r3		@ tmp290
@ arm/soar_wram.arm.c:15: 		FPS_COUNTER += 1;
	ldr	r2, .L45+60	@ tmp291,
	ldr	r3, [r2, #4088]	@ MEM[(int *)33816568B], MEM[(int *)33816568B]
	add	r3, r3, #1	@ tmp293, MEM[(int *)33816568B],
	str	r3, [r2, #4088]	@ tmp293, MEM[(int *)33816568B]
@ arm/soar_wram.arm.c:17: };
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7, lr}	@
	bx	lr	@
.L19:
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	mov	r1, #64	@ prephitmp_133,
	b	.L11		@
.L18:
	mov	r1, #128	@ prephitmp_133,
	b	.L11		@
.L44:
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, OAM_ATTR2(CursorBaseTID+CurrentProc->sPlayerYaw, 2, 0xD)); //draw cursor on minimap
	ldr	r3, [r4, #60]	@ CurrentProc_6(D)->sPlayerYaw, CurrentProc_6(D)->sPlayerYaw
	add	r3, r3, #704	@ tmp251, CurrentProc_6(D)->sPlayerYaw,
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, OAM_ATTR2(CursorBaseTID+CurrentProc->sPlayerYaw, 2, 0xD)); //draw cursor on minimap
	asr	r1, r7, #4	@ tmp244, posX,
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, OAM_ATTR2(CursorBaseTID+CurrentProc->sPlayerYaw, 2, 0xD)); //draw cursor on minimap
	orr	r3, r3, #55296	@ tmp255, tmp251,
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, OAM_ATTR2(CursorBaseTID+CurrentProc->sPlayerYaw, 2, 0xD)); //draw cursor on minimap
	asr	r2, r5, #4	@ tmp241, posY,
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, OAM_ATTR2(CursorBaseTID+CurrentProc->sPlayerYaw, 2, 0xD)); //draw cursor on minimap
	lsl	r3, r3, #16	@ tmp256, tmp255,
	add	r1, r1, #176	@ tmp246, tmp244,
	lsr	r3, r3, #16	@ tmp256, tmp256,
	lsl	r2, r2, #16	@, tmp241,
	lsl	r1, r1, #16	@, tmp246,
	str	r3, [sp]	@ tmp256,
	mov	r0, #8	@,
	ldr	r3, .L45+64	@,
	lsr	r2, r2, #16	@,,
	lsr	r1, r1, #16	@,,
	mov	lr, pc
	bx	r6		@ tmp295
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
	.word	15151
	.word	gObj_aff32x32
	.word	1022
	.word	translatedLocations
	.word	thumb_loop
	.word	WorldMapNodes
	.word	gObj_32x8
	.word	10959
	.word	gObj_64x64
	.word	33812480
	.word	gObj_8x8
	.word	iwram_Render_arm
	.size	NewWMLoop, .-NewWMLoop
	.ident	"GCC: (devkitARM release 58) 12.1.0"
