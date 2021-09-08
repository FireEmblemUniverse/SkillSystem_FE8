#ifndef	HEARDEREXT_MAGCHA
#define	HEARDEREXT_MAGCHA

struct MagCharData{
	/* 00 */ u8 basMag;
	/* 01 */ u8 growthMag;
};
struct ChaCharData{
	/* 00 */ u8 basCha;
	/* 01 */ u8 growthCha;
};

struct MagClassData{
	/* 00 */ u8 basMag;
	/* 01 */ u8 growthMag;
	/* 02 */ u8 maxMag;
	/* 03 */ u8 promotionMag;
};
struct ChaClassData{
	/* 00 */ u8 basCha;
	/* 01 */ u8 growthCha;
	/* 02 */ u8 maxCha;
	/* 03 */ u8 promotionCha;
};

extern const struct MagCharData MagCharTable[];
extern const struct ChaCharData CharmCharTable[];
extern const struct MagClassData MagClassTable[];
extern const struct ChaClassData CharmClassTable[];
	
#endif	// HEARDEREXT_MAGCHA