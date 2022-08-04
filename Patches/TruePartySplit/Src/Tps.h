
#pragma once

#include "gbafe.h"

enum { TPS_MAX_PID = 0x46 };

struct TpsMenuPartyInfo
{
    int party_num;
    u8 const* forced_pids;
};

struct TpsMenuInfo
{
    struct TpsMenuPartyInfo const* const* party_info_list;
};

int TpsGetPartyByPid(int pid);
void TpsSetPartyByPid(int pid, int party);
int TpsIsDisabledByPid(int pid);
void TpsSetDisabledByPid(int pid, int disabled);
void TpsRefreshUnitAwayBits(void);

void StartTpsMenu(struct TpsMenuInfo const* info, struct Proc* parent);

extern u8* const g_tps_party_array;
extern u8* const g_tps_current_party;
