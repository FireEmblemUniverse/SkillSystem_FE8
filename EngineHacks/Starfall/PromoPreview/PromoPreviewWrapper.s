.thumb
.align

.macro blh to,reg=r3
	ldr \reg,=\to
	mov r14,\reg
	.short 0xF800
.endm

.equ GetItemUseDescTextIndex,0x8017531
.equ String_GetFromIndex,0x800a241

.global PromoPreviewWrapper
.type PromoPreviewWrapper, %function


PromoPreviewWrapper: @hook at 801E800

	@check if our item is a promo item
	mov r0,r4
	mov r1,#0xFF
	and r0,r1
	blh CheckPromoItem
	cmp r0,#0
	bne PromoPreview

	@do vanilla thing
	VanillaReturn:
	mov r0,r4
	blh GetItemUseDescTextIndex
	blh String_GetFromIndex
	mov r4,r0
	@return to 801E80D with r1
	ldr r1,=0x801E80D @return location
	bx r1

	.ltorg
	.align

	@do our thing
	PromoPreview:
	mov r0,r4 @r0 = item ID
	ldr r1,[sp,#4] @r1 = bg0 offset
	blh DrawPromoPreview
	
	ldr r0,=0x801EA1D @return location
	bx r0
	
	.ltorg
	.align
	
	