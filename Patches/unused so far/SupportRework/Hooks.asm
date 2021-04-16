
.macro SET_FUNC name, value
    .global \name
    .type   \name, %function
    .set    \name, \value
.endm

SET_FUNC MasterSupportCalculation, (0x080285B0+1)

SET_FUNC DisplaySupportStatScreen1, (0x080876A4+1)

SET_FUNC DisplaySupportStatScreen2, (0x080876D8+1)

SET_FUNC SupportConvoUsability, (0x08023D14+1)

SET_FUNC BuildSupportTargetList, (0x08025644+1)

SET_FUNC SupportSelected, (0x080323D4+1)

SET_FUNC FixCUSA, (0x08018480+1)
