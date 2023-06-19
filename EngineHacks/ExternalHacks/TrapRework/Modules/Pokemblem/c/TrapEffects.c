#include "gbafe.h"


extern int ObtainCoinsEffect(void); 
int NewObtainCoinsEffect(void) { 
	int result = ObtainCoinsEffect(); 
	SMS_UpdateFromGameData();
	return result; 
} 



