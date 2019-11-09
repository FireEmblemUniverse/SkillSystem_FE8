
	.thumb

	.include "Definitions.inc"

	@ gLCDIOBuffer = 0x03003080

PromotionPrepScreenSetup:
	push {r4, lr}

	mov r0, #0
	_blh 0x08001B58 @ SetBgConfig

	_blh 0x080156F4 @ ReloadGameCoreGfx

	_blh 0x0804E884 @ ClearBG0BG1

	pop {r4}

	pop {r1}
	bx r1
