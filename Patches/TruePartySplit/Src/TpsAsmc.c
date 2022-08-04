
#include "Tps.h"

void Asmc_Tps_ResetParties(void)
{
    *g_tps_current_party = 0;

    for (int i = 0; i < TPS_MAX_PID; ++i)
    {
        TpsSetPartyByPid(i, 0);
    }

    TpsRefreshUnitAwayBits();
}

void Asmc_Tps_SetActiveParty(void)
{
    int const target_party = gEventSlot[2];

    int const old_party = *g_tps_current_party;
    *g_tps_current_party = target_party;

    TpsRefreshUnitAwayBits();

    gEventSlot[12] = old_party;
}

void Asmc_Tps_GetActiveParty(void)
{
    gEventSlot[12] = *g_tps_current_party;
}

void Asmc_Tps_MoveParty(void)
{
    int const target_party = gEventSlot[2];
    int const other_party = gEventSlot[3];

    for (int i = 0; i < TPS_MAX_PID; ++i)
    {
        if (TpsGetPartyByPid(i) == other_party)
            TpsSetPartyByPid(i, target_party);
    }

    if (*g_tps_current_party == other_party)
        *g_tps_current_party = target_party;

    TpsRefreshUnitAwayBits();
}

void Asmc_Tps_SetUnitParty(void)
{
    int const unit_pid = gEventSlot[2];
    int const target_party = gEventSlot[3];

    int const old_party = TpsGetPartyByPid(unit_pid);
    TpsSetPartyByPid(unit_pid, target_party);

    TpsRefreshUnitAwayBits();

    gEventSlot[12] = old_party;
}

void Asmc_Tps_GetUnitParty(void)
{
    int const unit_pid = gEventSlot[2];
    gEventSlot[12] = TpsGetPartyByPid(unit_pid);
}

void Asmc_Tps_HideUnit(void)
{
    int const unit_pid = gEventSlot[2];

    TpsSetDisabledByPid(unit_pid, TRUE);
    TpsRefreshUnitAwayBits();
}

void Asmc_Tps_ShowUnit(void)
{
    int const unit_pid = gEventSlot[2];

    TpsSetDisabledByPid(unit_pid, FALSE);
    TpsRefreshUnitAwayBits();
}

void Asmc_Tps_StartMenu(struct Proc* proc)
{
    struct TpsMenuInfo const* info = (struct TpsMenuInfo const*) gEventSlot[2];
    StartTpsMenu(info, proc);
}
