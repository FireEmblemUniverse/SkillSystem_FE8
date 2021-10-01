#ifndef GBAFE_SOUND_H
#define GBAFE_SOUND_H

#include "common.h"
#include "chapterdata.h"

// TODO
int Sound_GetCurrentSong(void); //! FE8U = 0x8002259
s8 Sound_IsSongPlaying(void); //! FE8U = 0x8002265
void Sound_SetVolume_8002274(int volume); //! FE8U = 0x8002275
void Sound_SetSongVolume(int volume); //! FE8U = 0x80022ED
void Sound_FadeSongOut(int speed); //! FE8U = 0x800231D
void Sound_FadeOut_800237C(int speed); //! FE8U = 0x800237D
void Sound_FadeOut_80023E0(int speed); //! FE8U = 0x80023E1
void Sound_PlaySong(int songId, void* player); //! FE8U = 0x8002449 // TODO: struct MusicPlayerInfo
void Sound_PlaySongSmoothCommon(int songId, int speed, void* player); //! FE8U = 0x8002479
void Sound_PlaySongSmooth(int songId, void* player); //! FE8U = 0x80024D5
void Sound_PlaySongSmoothExt(int songId, int speed, void* player); //! FE8U = 0x80024E5
void StartSongVolumeTransitionB(int volume, int b, int c, struct Proc* parent); //! FE8U = 0x8002731
void PlaySongDelayed(int songId, int delay, void* player); //! FE8U = 0x8002859
void Sound_PlaySongCore(int songId, void* player); //! FE8U = 0x8002891
void SetSoundDefaultMaxChannels(void); //! FE8U = 0x80028D1
void SetSoundMaxChannels(int maxchn); //! FE8U = 0x80028E9
void Sound_SetupMaxChannelsForSong(int songId); //! FE8U = 0x80028FD
void CancelPlaySongDelayed(void); //! FE8U = 0x8002AB9

// TODO: m4a header
void m4aSongNumStart(int);

#define PlaySfx(aSongId) do { \
	if (!gChapterData.muteSfxOption) \
		m4aSongNumStart(aSongId); \
} while (0)

#endif // GBAFE_SOUND_H
