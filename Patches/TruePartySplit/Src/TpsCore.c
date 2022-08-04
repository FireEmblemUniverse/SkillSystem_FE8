
#include "Tps.h"

enum { BITS_PER_PARTY_ID = 4 };

#define PARTY_ID(party) (party & ((1 << (BITS_PER_PARTY_ID-1))-1))
#define PARTY_RM(party) (party & ((1 << (BITS_PER_PARTY_ID-1))))

int TpsGetPartyRawByPid(int pid)
{
    static int const mask = (1 << BITS_PER_PARTY_ID) - 1;

    int const slot = pid / (8 / BITS_PER_PARTY_ID);
    int const shift = (pid % (8 / BITS_PER_PARTY_ID)) * BITS_PER_PARTY_ID;

    return (g_tps_party_array[slot] >> shift) & mask;
}

void TpsSetPartyRawForPid(int pid, int party)
{
    static int const mask = (1 << BITS_PER_PARTY_ID) - 1;

    int const slot = pid / (8 / BITS_PER_PARTY_ID);
    int const shift = (pid % (8 / BITS_PER_PARTY_ID)) * BITS_PER_PARTY_ID;

/*

x and 0xF | y and ~mask (0xFFFFFFF0) 



*/ 


    //g_tps_party_array[slot] = (g_tps_party_array[slot] & mask << shift) | (g_tps_party_array[slot] & ~(mask << shift));
	//int test = g_tps_party_array[slot];
	//asm("mov r11, r11");
	// party & 0xF << (4*unit id remainder of 4) 
// 1 << 4  | 1
// F << 4 = 0xF0 
// neg 0xF0 
	
  
	if (shift) { 
		g_tps_party_array[slot] = (g_tps_party_array[slot] & 0xF) | 0x10; //(party & mask) << 4;
	} 
	else { 
		g_tps_party_array[slot] = (g_tps_party_array[slot] & 0xF0) | 1; //(party & mask);
	}
    //g_tps_party_array[slot] = (g_tps_party_array[slot] & mask << shift) | (party & mask) << shift;
    
	
	//g_tps_party_array[slot] |= (party & mask) << shift;

//	g_tps_party_array[slot] = ((party & mask) << shift) | (g_tps_party_array[slot] & (-1 - (mask << shift))); // << shift;
	int test = g_tps_party_array[slot]; 
	if (pid > 0x44) {
		asm("mov r11, r11");
	}
	TpsGetPartyByPid(test); 
	//g_tps_party_array[slot] = (g_tps_party_array[slot] & mask << shift) | (party & mask) << shift; // originally |= which would never work for setting party to 0 
}

int TpsGetPartyByPid(int pid)
{
    return PARTY_ID(TpsGetPartyRawByPid(pid));
}

void TpsSetPartyByPid(int pid, int party)
{
    static int const mask = (1 << (BITS_PER_PARTY_ID-1)) - 1;

    int val = TpsGetPartyRawByPid(pid);

    val &= ~mask;
    val |= party & mask;

    TpsSetPartyRawForPid(pid, val);
}

int TpsIsDisabledByPid(int pid)
{
    return !!(TpsGetPartyRawByPid(pid) & (1 << (BITS_PER_PARTY_ID-1)));
}

void TpsSetDisabledByPid(int pid, int disabled)
{
    int val = TpsGetPartyRawByPid(pid);

    val &= ~(1 << (BITS_PER_PARTY_ID-1));
    val |= (!!disabled) << (BITS_PER_PARTY_ID-1); 

    TpsSetPartyRawForPid(pid, val);
}

void TpsRefreshUnitAwayBits(void)
{
    for (int i = 1; i < 0x40; ++i)
    {
        struct Unit* const unit = GetUnit(i);

        if (!unit || !unit->pCharacterData)
            continue;

        if (unit->state & US_DEAD)
            continue;

        if (unit->pCharacterData->number >= TPS_MAX_PID)
            continue;

        int const party = TpsGetPartyRawByPid(unit->pCharacterData->number);

        if (PARTY_RM(party) || PARTY_ID(party) != *g_tps_current_party)
        {
            // Unit is disabled
            unit->state |= US_NOT_DEPLOYED | US_HIDDEN | US_BIT16 | US_BIT26;
        }
        else
        {
            // Unit is enabled
            unit->state &= ~(US_NOT_DEPLOYED | US_HIDDEN | US_BIT16 | US_BIT26);
        }
    }
}
