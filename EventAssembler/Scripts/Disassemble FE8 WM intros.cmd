echo off
cd %~dp0
cd ..
echo on

Core D FE8 ToEnd 0xA39D00 none -input:%1 "-output:%~dp1Prologue.event" -addEndGuards
Core D FE8 ToEnd 0xA39D18 none -input:%1 "-output:%~dp1Ch1.event" -addEndGuards
Core D FE8 ToEnd 0xA39DB4 none -input:%1 "-output:%~dp1Ch2.event" -addEndGuards
Core D FE8 ToEnd 0xA39F90 none -input:%1 "-output:%~dp1Ch3.event" -addEndGuards
Core D FE8 ToEnd 0xA3A118 none -input:%1 "-output:%~dp1Ch4.event" -addEndGuards
Core D FE8 ToEnd 0xA3A2D8 none -input:%1 "-output:%~dp1Ch5.event" -addEndGuards
Core D FE8 ToEnd 0xA3A534 none -input:%1 "-output:%~dp1Ch6.event" -addEndGuards
Core D FE8 ToEnd 0xA3A620 none -input:%1 "-output:%~dp1Ch7.event" -addEndGuards
Core D FE8 ToEnd 0xA3A700 none -input:%1 "-output:%~dp1Ch8.event" -addEndGuards

Core D FE8 ToEnd 0xA3A7EC none -input:%1 "-output:%~dp1Ch9Eir.event" -addEndGuards
Core D FE8 ToEnd 0xA3A9EC none -input:%1 "-output:%~dp1Ch10Eir.event" -addEndGuards
Core D FE8 ToEnd 0xA3AB68 none -input:%1 "-output:%~dp1Ch12Eir.event" -addEndGuards
Core D FE8 ToEnd 0xA3ABC8 none -input:%1 "-output:%~dp1Ch13Eir.event" -addEndGuards
Core D FE8 ToEnd 0xA3AD40 none -input:%1 "-output:%~dp1Ch14Eir.event" -addEndGuards

Core D FE8 ToEnd 0xA3AF30 none -input:%1 "-output:%~dp1Ch9Eph.event" -addEndGuards
Core D FE8 ToEnd 0xA3B10C none -input:%1 "-output:%~dp1Ch10Eph.event" -addEndGuards
Core D FE8 ToEnd 0xA3B1F0 none -input:%1 "-output:%~dp1Ch12Eph.event" -addEndGuards
Core D FE8 ToEnd 0xA3B250 none -input:%1 "-output:%~dp1Ch13Eph.event" -addEndGuards
Core D FE8 ToEnd 0xA3B338 none -input:%1 "-output:%~dp1Ch14Eph.event" -addEndGuards

Core D FE8 ToEnd 0xA3B58C none -input:%1 "-output:%~dp1Ch15Eir.event" -addEndGuards
Core D FE8 ToEnd 0xA3B678 none -input:%1 "-output:%~dp1Ch16Eir.event" -addEndGuards
Core D FE8 ToEnd 0xA3B808 none -input:%1 "-output:%~dp1Ch17Eir.event" -addEndGuards
Core D FE8 ToEnd 0xA3B944 none -input:%1 "-output:%~dp1Ch18Eir.event" -addEndGuards
Core D FE8 ToEnd 0xA3BAC0 none -input:%1 "-output:%~dp1Ch19Eir.event" -addEndGuards
Core D FE8 ToEnd 0xA3BC8C none -input:%1 "-output:%~dp1Ch20Eir.event" -addEndGuards
Core D FE8 ToEnd 0xA3BD70 none -input:%1 "-output:%~dp1Final1Eir.event" -addEndGuards

Core D FE8 ToEnd 0xA3BE14 none -input:%1 "-output:%~dp1Ch15Eph.event" -addEndGuards
Core D FE8 ToEnd 0xA3BFF4 none -input:%1 "-output:%~dp1Ch16Eph.event" -addEndGuards
Core D FE8 ToEnd 0xA3C184 none -input:%1 "-output:%~dp1Ch17Eph.event" -addEndGuards
Core D FE8 ToEnd 0xA3C2BC none -input:%1 "-output:%~dp1Ch18Eph.event" -addEndGuards
Core D FE8 ToEnd 0xA3C438 none -input:%1 "-output:%~dp1Ch19Eph.event" -addEndGuards
Core D FE8 ToEnd 0xA3C604 none -input:%1 "-output:%~dp1Ch20Eph.event" -addEndGuards
Core D FE8 ToEnd 0xA3C6E8 none -input:%1 "-output:%~dp1Final1Eph.event" -addEndGuards

Core D FE8 ToEnd 0xA3C888 none -input:%1 "-output:%~dp1LordsSplit.event" -addEndGuards
Core D FE8 ToEnd 0xA3C894 none -input:%1 "-output:%~dp1Ch5x.event" -addEndGuards
Core D FE8 ToEnd 0xA3C89C none -input:%1 "-output:%~dp1Final2Eir.event" -addEndGuards
Core D FE8 ToEnd 0xA3C8A4 none -input:%1 "-output:%~dp1Final2Eph.event" -addEndGuards
Core D FE8 ToEnd 0xA3C904 none -input:%1 "-output:%~dp1Ch11Eir.event" -addEndGuards
Core D FE8 ToEnd 0xA3CA2C none -input:%1 "-output:%~dp1Ch11Eph.event" -addEndGuards

Core D FE8 ToEnd 0xA3B460 none -input:%1 "-output:%~dp1MelkaenCoast.event" -addEndGuards
Core D FE8 ToEnd 0xA3B46C none -input:%1 "-output:%~dp1Valni1.event" -addEndGuards
Core D FE8 ToEnd 0xA3B4C4 none -input:%1 "-output:%~dp1Lagdou1.event" -addEndGuards

Core D FE8 ToEnd 0xA3974C none -input:%1 "-output:%~dp1A3974C.event" -addEndGuards
Core D FE8 ToEnd 0xA3A4D0 none -input:%1 "-output:%~dp1A3A4D0.event" -addEndGuards

pause