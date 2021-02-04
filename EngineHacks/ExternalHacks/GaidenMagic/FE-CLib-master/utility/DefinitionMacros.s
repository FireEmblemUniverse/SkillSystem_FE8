
.macro SET_FUNC name, value
	.global \name
	.type   \name, %function
	.set    \name, \value
.endm

.macro SET_DATA name, value
	.global \name
	.type   \name, %object
	.set    \name, \value
.endm
