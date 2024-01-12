typedef struct {
	u8 firstTickDelay;
	u8 nextTickDelay;
	u8 tickDownCounter;
	u8 pad1;
	u16 currentPress;
	u16 tickPress;
	u16 newPress;
	u16 previousPress;
	u16 lastPressState;
	u16 releasedPress;
	u16 newPress2;
	u16 timeSinceLastStartSelect;
} InputBuffer;

#define sInput ((InputBuffer*)0x2024CC0)

#define InputA 0x1
#define InputB 0x2
#define InputSelect 0x4
#define InputStart 0x8
#define InputRight 0x10
#define InputLeft 0x20
#define InputUp 0x40
#define InputDown 0x80
#define InputR 0x100
#define InputL 0x200

