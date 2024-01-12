	.cpu arm7tdmi
	.eabi_attribute 23, 1	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 2	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"soar_wram.arm.c"
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -marm -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -Ofast -fomit-frame-pointer -ffast-math -fno-jump-tables -fno-toplevel-reorder
	.text
	.align	2
	.global	NewWMLoop
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	NewWMLoop, %function
NewWMLoop:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ arm/soar_wram.arm.c:56: 	u8 animClock = *(u8*)(0x3000014) & 0x3F;
	mov	r3, #50331648	@ tmp180,
@ arm/soar_wram.arm.c:9: void NewWMLoop(SoarProc* CurrentProc){
	push	{r4, r5, r6, r7, lr}	@
@ arm/soar_wram.arm.c:56: 	u8 animClock = *(u8*)(0x3000014) & 0x3F;
	ldrb	r3, [r3, #20]	@ zero_extendqisi2	@ _11, MEM[(u8 *)50331668B]
@ arm/soar_wram.arm.c:58: 	if (animClock < 0x10) ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID, 2, 0xC)); //player frames
	tst	r3, #48	@ _11,
@ arm/soar_wram.arm.c:9: void NewWMLoop(SoarProc* CurrentProc){
	mov	r4, r0	@ CurrentProc, tmp307
	sub	sp, sp, #12	@,,
@ arm/soar_wram.arm.c:58: 	if (animClock < 0x10) ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID, 2, 0xC)); //player frames
	beq	.L39		@,
@ arm/soar_wram.arm.c:59: 	else if (animClock < 0x20)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID+0x10, 2, 0xC));
	tst	r3, #32	@ _11,
@ arm/soar_wram.arm.c:59: 	else if (animClock < 0x20)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID+0x10, 2, 0xC));
	ldreq	r3, .L45	@ tmp191,
@ arm/soar_wram.arm.c:59: 	else if (animClock < 0x20)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID+0x10, 2, 0xC));
	beq	.L37		@,
@ arm/soar_wram.arm.c:56: 	u8 animClock = *(u8*)(0x3000014) & 0x3F;
	and	r3, r3, #63	@ tmp193, _11,
@ arm/soar_wram.arm.c:60: 	else if (animClock < 0x30)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID+0x20, 2, 0xC));
	cmp	r3, #47	@ tmp193,
@ arm/soar_wram.arm.c:60: 	else if (animClock < 0x30)	ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID+0x20, 2, 0xC));
	ldrls	r3, .L45+4	@ tmp198,
@ arm/soar_wram.arm.c:61: 	else ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID+0x30, 2, 0xC));
	ldrhi	r3, .L45+8	@ tmp201,
.L37:
	str	r3, [sp]	@ tmp201,
	mov	r2, #88	@,
	ldr	r3, .L45+12	@,
	mov	r1, #104	@,
	mov	r0, #8	@,
	ldr	r6, .L45+16	@ tmp306,
	mov	lr, pc
	bx	r6		@ tmp306
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
@ arm/soar_wram.arm.c:67: 	if (CurrentProc->disableFlare == 0)
	tst	r3, #16	@ _15,
	bne	.L8		@,
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	ldr	r3, .L45+20	@ tmp227,
	ldr	r3, [r3, #208]	@ _30, MEM[(volatile vu32 *)50344144B]
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	sub	r3, r3, #40448	@ tmp228, _30,
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	ldr	r2, [r4, #60]	@ _35, CurrentProc_6(D)->sPlayerYaw
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	sub	r3, r3, #64	@ tmp228, tmp228,
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	ldr	r1, [r4, #56]	@ CurrentProc_6(D)->sPlayerStepZ, CurrentProc_6(D)->sPlayerStepZ
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	lsr	r3, r3, #10	@ tmp230, tmp228,
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	rsb	r3, r3, #80	@ tmp231, tmp230,
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	cmp	r2, #11	@ _35,
@ arm/soar_wram.arm.c:71: 		int flarey = 80 - (CurrentProc->sPlayerStepZ<<2) - ((g_REG_BG2X - 0x9e40)>>10);
	sub	r3, r3, r1, lsl #2	@ _34, tmp231, CurrentProc_6(D)->sPlayerStepZ,
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	beq	.L18		@,
	bgt	.L10		@,
	cmp	r2, #9	@ _35,
	beq	.L19		@,
	cmp	r2, #10	@ _35,
	moveq	r1, #96	@ prephitmp_154,
	bne	.L8		@,
.L11:
@ arm/soar_wram.arm.c:82: 			ObjInsertSafe(9, flarex, flarey, &gObj_aff32x32, OAM_ATTR2(LensFlareBaseTID-1, 2, 0x3));
	ldr	r0, .L45+24	@ tmp237,
	lsl	r2, r3, #16	@, _34,
	str	r0, [sp]	@ tmp237,
	ldr	r3, .L45+28	@,
	mov	r0, #9	@,
	lsr	r2, r2, #16	@,,
	mov	lr, pc
	bx	r6		@ tmp306
.L8:
@ arm/soar_wram.arm.c:88: 	int posY = CurrentProc->sFocusPtY;
	ldr	r5, [r4, #76]	@ posY, CurrentProc_6(D)->sFocusPtY
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	ldr	r3, .L45+32	@ tmp240,
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	sub	r2, r5, #1	@ tmp239, posY,
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	cmp	r2, r3	@ tmp239, tmp240
@ arm/soar_wram.arm.c:87: 	int posX = CurrentProc->sFocusPtX;
	ldr	r7, [r4, #72]	@ posX, CurrentProc_6(D)->sFocusPtX
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	bhi	.L15		@,
@ arm/soar_wram.arm.c:92: 	if ((posY > MAP_YOFS) && (posY < (MAP_DIMENSIONS - MAP_YOFS)) && (posX > 0) && (posX < MAP_DIMENSIONS)) {
	sub	r2, r7, #1	@ tmp243, posX,
	cmp	r2, r3	@ tmp243, tmp240
	bls	.L42		@,
.L15:
@ arm/soar_wram.arm.c:98: 	CurrentProc->location = translatedLocations[loc];
	ldr	r3, .L45+36	@ tmp241,
	ldrb	r3, [r3]	@ zero_extendqisi2	@ translatedLocations[0], translatedLocations[0]
	str	r3, [r4, #80]	@ translatedLocations[0], CurrentProc_6(D)->location
.L14:
@ arm/soar_wram.arm.c:12: 	if (thumb_loop(CurrentProc)){
	mov	r0, r4	@, CurrentProc
	ldr	r3, .L45+40	@ tmp300,
	mov	lr, pc
	bx	r3		@ tmp300
@ arm/soar_wram.arm.c:12: 	if (thumb_loop(CurrentProc)){
	cmp	r0, #0	@ tmp308,
	bne	.L43		@,
@ arm/soar_wram.arm.c:17: };
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7, lr}	@
	bx	lr	@
.L10:
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	cmp	r2, #12	@ _35,
	moveq	r1, #160	@ prephitmp_154,
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
	ldr	r3, .L45+44	@ tmp269,
@ arm/soar_wram.arm.c:95: 		posY = (posY-MAP_YOFS)>>6;
	asr	r5, r5, #6	@ posY, posY,
@ arm/soar_wram.arm.c:96: 		loc = WorldMapNodes[posY][posX];
	add	r3, r3, r5, lsl #4	@ tmp273, tmp269, posY,
	ldrb	r3, [r3, r7, asr #6]	@ zero_extendqisi2	@ loc, WorldMapNodes[posY_63][posX_62]
@ arm/soar_wram.arm.c:98: 	CurrentProc->location = translatedLocations[loc];
	ldr	r2, .L45+36	@ tmp275,
	ldrb	r2, [r2, r3]	@ zero_extendqisi2	@ translatedLocations[_66], translatedLocations[_66]
@ arm/soar_wram.arm.c:99: 	if (loc>0) {
	cmp	r3, #0	@ loc,
@ arm/soar_wram.arm.c:98: 	CurrentProc->location = translatedLocations[loc];
	str	r2, [r4, #80]	@ translatedLocations[_66], CurrentProc_6(D)->location
@ arm/soar_wram.arm.c:99: 	if (loc>0) {
	beq	.L14		@,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3), 2, 0xe))); //draw in the top corner if we're there
	mov	r2, #16	@,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3), 2, 0xe))); //draw in the top corner if we're there
	sub	r5, r3, #1	@ tmp278, loc,
	lsl	r5, r5, #19	@ tmp281, tmp278,
	lsr	r5, r5, r2	@ _71, tmp281,
	add	r3, r5, #576	@ tmp283, _71,
	orr	r3, r3, #59392	@ tmp287, tmp283,
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3)+4, 2, 0xe))); //draw in the top corner if we're there
	add	r5, r5, #580	@ tmp292, _71,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3), 2, 0xe))); //draw in the top corner if we're there
	lsl	r3, r3, r2	@ tmp289, tmp287,
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3)+4, 2, 0xe))); //draw in the top corner if we're there
	orr	r5, r5, #59392	@ tmp296, tmp292,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3), 2, 0xe))); //draw in the top corner if we're there
	lsr	r3, r3, r2	@ tmp288, tmp289,
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3)+4, 2, 0xe))); //draw in the top corner if we're there
	lsl	r5, r5, #16	@ tmp298, tmp296,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3), 2, 0xe))); //draw in the top corner if we're there
	mov	r1, r2	@,
	str	r3, [sp]	@ tmp288,
	mov	r0, #8	@,
	ldr	r3, .L45+48	@,
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3)+4, 2, 0xe))); //draw in the top corner if we're there
	lsr	r5, r5, #16	@ tmp297, tmp298,
@ arm/soar_wram.arm.c:100: 		ObjInsertSafe(8, 0x10, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3), 2, 0xe))); //draw in the top corner if we're there
	mov	lr, pc
	bx	r6		@ tmp306
@ arm/soar_wram.arm.c:101: 		ObjInsertSafe(8, 0x30, 0x10, &gObj_32x8, (OAM_ATTR2(LocationBaseTID+((loc-1)<<3)+4, 2, 0xe))); //draw in the top corner if we're there
	mov	r2, #16	@,
	mov	r1, #48	@,
	mov	r0, #8	@,
	str	r5, [sp]	@ tmp297,
	ldr	r3, .L45+48	@,
	mov	lr, pc
	bx	r6		@ tmp306
	b	.L14		@
.L39:
@ arm/soar_wram.arm.c:58: 	if (animClock < 0x10) ObjInsertSafe(8, 0x68, 0x58, &gObj_32x32, OAM_ATTR2(PKBaseTID, 2, 0xC)); //player frames
	mov	ip, #51712	@ tmp185,
	ldr	r3, .L45+12	@,
	mov	r2, #88	@,
	mov	r1, #104	@,
	mov	r0, #8	@,
	ldr	r6, .L45+16	@ tmp306,
	str	ip, [sp]	@ tmp185,
	mov	lr, pc
	bx	r6		@ tmp306
@ arm/soar_wram.arm.c:63: 	if (CurrentProc->ShowMap) ObjInsertSafe(8, 176, 0, &gObj_64x64, OAM_ATTR2(MinimapBaseTID-1, 2, 0x2)); //draw minimap
	ldrb	r3, [r4, #69]	@ zero_extendqisi2	@ _15, *CurrentProc_6(D)
@ arm/soar_wram.arm.c:63: 	if (CurrentProc->ShowMap) ObjInsertSafe(8, 176, 0, &gObj_64x64, OAM_ATTR2(MinimapBaseTID-1, 2, 0x2)); //draw minimap
	tst	r3, #1	@ _15,
	beq	.L6		@,
.L40:
@ arm/soar_wram.arm.c:63: 	if (CurrentProc->ShowMap) ObjInsertSafe(8, 176, 0, &gObj_64x64, OAM_ATTR2(MinimapBaseTID-1, 2, 0x2)); //draw minimap
	ldr	r3, .L45+52	@ tmp207,
	mov	r2, #0	@,
	str	r3, [sp]	@ tmp207,
	mov	r1, #176	@,
	ldr	r3, .L45+56	@,
	mov	r0, #8	@,
	mov	lr, pc
	bx	r6		@ tmp306
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (OAM_ATTR2(FPSBaseTID + FPS_CURRENT, 2, 0xC))); //fps counter
	ldrb	r3, [r4, #69]	@ zero_extendqisi2	@ _15, *CurrentProc_6(D)
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (OAM_ATTR2(FPSBaseTID + FPS_CURRENT, 2, 0xC))); //fps counter
	tst	r3, #2	@ _15,
	beq	.L7		@,
.L41:
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (OAM_ATTR2(FPSBaseTID + FPS_CURRENT, 2, 0xC))); //fps counter
	mov	r2, #0	@,
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (OAM_ATTR2(FPSBaseTID + FPS_CURRENT, 2, 0xC))); //fps counter
	ldr	r1, .L45+60	@ tmp213,
	ldr	r1, [r1, #4092]	@ MEM[(int *)33816572B], MEM[(int *)33816572B]
	add	r1, r1, #784	@ tmp216, MEM[(int *)33816572B],
	orr	r1, r1, #51200	@ tmp220, tmp216,
@ arm/soar_wram.arm.c:65: 	if (CurrentProc->ShowFPS) ObjInsertSafe(8, 0, 0, &gObj_8x8, (OAM_ATTR2(FPSBaseTID + FPS_CURRENT, 2, 0xC))); //fps counter
	lsl	r1, r1, #16	@ tmp221, tmp220,
	lsr	r1, r1, #16	@ tmp221, tmp221,
	ldr	r3, .L45+64	@,
	str	r1, [sp]	@ tmp221,
	mov	r0, #8	@,
	mov	r1, r2	@,
	mov	lr, pc
	bx	r6		@ tmp306
@ arm/soar_wram.arm.c:67: 	if (CurrentProc->disableFlare == 0)
	ldrb	r3, [r4, #69]	@ zero_extendqisi2	@ _15, *CurrentProc_6(D)
	b	.L7		@
.L43:
@ arm/soar_wram.arm.c:13: 		iwram_Render_arm(CurrentProc);
	mov	r0, r4	@, CurrentProc
	ldr	r3, .L45+68	@ tmp301,
	mov	lr, pc
	bx	r3		@ tmp301
@ arm/soar_wram.arm.c:15: 		FPS_COUNTER += 1;
	ldr	r2, .L45+60	@ tmp302,
	ldr	r3, [r2, #4088]	@ MEM[(int *)33816568B], MEM[(int *)33816568B]
	add	r3, r3, #1	@ tmp304, MEM[(int *)33816568B],
	str	r3, [r2, #4088]	@ tmp304, MEM[(int *)33816568B]
@ arm/soar_wram.arm.c:17: };
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7, lr}	@
	bx	lr	@
.L19:
@ arm/soar_wram.arm.c:72: 		switch(CurrentProc->sPlayerYaw){
	mov	r1, #64	@ prephitmp_154,
	b	.L11		@
.L18:
	mov	r1, #128	@ prephitmp_154,
	b	.L11		@
.L44:
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, OAM_ATTR2(CursorBaseTID+CurrentProc->sPlayerYaw, 2, 0xD)); //draw cursor on minimap
	ldr	r3, [r4, #60]	@ CurrentProc_6(D)->sPlayerYaw, CurrentProc_6(D)->sPlayerYaw
	add	r3, r3, #704	@ tmp261, CurrentProc_6(D)->sPlayerYaw,
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, OAM_ATTR2(CursorBaseTID+CurrentProc->sPlayerYaw, 2, 0xD)); //draw cursor on minimap
	asr	r1, r7, #4	@ tmp254, posX,
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, OAM_ATTR2(CursorBaseTID+CurrentProc->sPlayerYaw, 2, 0xD)); //draw cursor on minimap
	orr	r3, r3, #55296	@ tmp265, tmp261,
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, OAM_ATTR2(CursorBaseTID+CurrentProc->sPlayerYaw, 2, 0xD)); //draw cursor on minimap
	asr	r2, r5, #4	@ tmp251, posY,
@ arm/soar_wram.arm.c:93: 		if (CurrentProc->ShowMap) ObjInsertSafe(8, (176 + (posX>>4)), (posY-MAP_YOFS)>>4, &gObj_8x8, OAM_ATTR2(CursorBaseTID+CurrentProc->sPlayerYaw, 2, 0xD)); //draw cursor on minimap
	lsl	r3, r3, #16	@ tmp266, tmp265,
	add	r1, r1, #176	@ tmp256, tmp254,
	lsr	r3, r3, #16	@ tmp266, tmp266,
	lsl	r2, r2, #16	@, tmp251,
	lsl	r1, r1, #16	@, tmp256,
	str	r3, [sp]	@ tmp266,
	mov	r0, #8	@,
	ldr	r3, .L45+64	@,
	lsr	r2, r2, #16	@,,
	lsr	r1, r1, #16	@,,
	mov	lr, pc
	bx	r6		@ tmp306
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
	.ident	"GCC: (devkitARM release 56) 11.1.0"
