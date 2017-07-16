echo off
cd %~dp0
cd ..
echo on

Core A FE8 -output:%1 "-input:%~dp1Prologue.event"
Core A FE8 -output:%1 "-input:%~dp1Ch1.event"
Core A FE8 -output:%1 "-input:%~dp1Ch2.event"
Core A FE8 -output:%1 "-input:%~dp1Ch3.event"
Core A FE8 -output:%1 "-input:%~dp1Ch4.event"
Core A FE8 -output:%1 "-input:%~dp1Ch5.event"
Core A FE8 -output:%1 "-input:%~dp1Ch6.event"
Core A FE8 -output:%1 "-input:%~dp1Ch7.event"
Core A FE8 -output:%1 "-input:%~dp1Ch8.event"

Core A FE8 -output:%1 "-input:%~dp1Ch9Eir.event"
Core A FE8 -output:%1 "-input:%~dp1Ch10Eir.event"
Core A FE8 -output:%1 "-input:%~dp1Ch12Eir.event"
Core A FE8 -output:%1 "-input:%~dp1Ch13Eir.event"
Core A FE8 -output:%1 "-input:%~dp1Ch14Eir.event"

Core A FE8 -output:%1 "-input:%~dp1Ch9Eph.event"
Core A FE8 -output:%1 "-input:%~dp1Ch10Eph.event"
Core A FE8 -output:%1 "-input:%~dp1Ch12Eph.event"
Core A FE8 -output:%1 "-input:%~dp1Ch13Eph.event"
Core A FE8 -output:%1 "-input:%~dp1Ch14Eph.event"

Core A FE8 -output:%1 "-input:%~dp1Ch15Eir.event"
Core A FE8 -output:%1 "-input:%~dp1Ch16Eir.event"
Core A FE8 -output:%1 "-input:%~dp1Ch17Eir.event"
Core A FE8 -output:%1 "-input:%~dp1Ch18Eir.event"
Core A FE8 -output:%1 "-input:%~dp1Ch19Eir.event"
Core A FE8 -output:%1 "-input:%~dp1Ch20Eir.event"
Core A FE8 -output:%1 "-input:%~dp1Final1Eir.event"

Core A FE8 -output:%1 "-input:%~dp1Ch15Eph.event"
Core A FE8 -output:%1 "-input:%~dp1Ch16Eph.event"
Core A FE8 -output:%1 "-input:%~dp1Ch17Eph.event"
Core A FE8 -output:%1 "-input:%~dp1Ch18Eph.event"
Core A FE8 -output:%1 "-input:%~dp1Ch19Eph.event"
Core A FE8 -output:%1 "-input:%~dp1Ch20Eph.event"
Core A FE8 -output:%1 "-input:%~dp1Final1Eph.event"

Core A FE8 -output:%1 "-input:%~dp1LordsSplit.event"
Core A FE8 -output:%1 "-input:%~dp1Ch5x.event"
Core A FE8 -output:%1 "-input:%~dp1Final2Eir.event"
Core A FE8 -output:%1 "-input:%~dp1Final2Eph.event"
Core A FE8 -output:%1 "-input:%~dp1Ch11Eir.event"
Core A FE8 -output:%1 "-input:%~dp1Ch11Eph.event"

pause