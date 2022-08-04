
#include "Tps.h"

void TpsSave(void* target, unsigned size)
{
    WriteSramFast(g_tps_current_party, target, 1);
    WriteSramFast(g_tps_party_array, target+1, size-1);
}

void TpsLoad(void* source, unsigned size)
{
    ReadSramFast(source, g_tps_current_party, 1);
    ReadSramFast(source+1, g_tps_party_array, size-1);
}
