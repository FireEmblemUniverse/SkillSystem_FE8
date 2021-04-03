echo off
cd %~dp0
cd ..
echo on

Core D FE7 Structure 0xCA0720 -input:%1 "-output:%~dp1Prologue.event" -addEndGuards
Core D FE7 Structure 0xCA0974 -input:%1 "-output:%~dp1Ch1.event" -addEndGuards
Core D FE7 Structure 0xCA0B08 -input:%1 "-output:%~dp1Ch2.event" -addEndGuards
Core D FE7 Structure 0xCA0CA4 -input:%1 "-output:%~dp1Ch3.event" -addEndGuards
Core D FE7 Structure 0xCA0EA8 -input:%1 "-output:%~dp1Ch4.event" -addEndGuards
Core D FE7 Structure 0xCA1030 -input:%1 "-output:%~dp1Ch5.event" -addEndGuards
Core D FE7 Structure 0xCA1270 -input:%1 "-output:%~dp1Ch6.event" -addEndGuards
Core D FE7 Structure 0xCA13A0 -input:%1 "-output:%~dp1Ch7.event" -addEndGuards
Core D FE7 Structure 0xCA146C -input:%1 "-output:%~dp1Ch7x.event" -addEndGuards
Core D FE7 Structure 0xCA1538 -input:%1 "-output:%~dp1Ch8.event" -addEndGuards
Core D FE7 Structure 0xCA1654 -input:%1 "-output:%~dp1Ch9.event" -addEndGuards
Core D FE7 Structure 0xCA18B0 -input:%1 "-output:%~dp1Ch10.event" -addEndGuards

Core D FE7 Structure 0xCA1974 -input:%1 "-output:%~dp1Ch11E.event" -addEndGuards
Core D FE7 Structure 0xCA1A34 -input:%1 "-output:%~dp1Ch11H.event" -addEndGuards
Core D FE7 Structure 0xCA1B84 -input:%1 "-output:%~dp1Ch12.event" -addEndGuards
Core D FE7 Structure 0xCA1D58 -input:%1 "-output:%~dp1Ch13.event" -addEndGuards
Core D FE7 Structure 0xCA1ECC -input:%1 "-output:%~dp1Ch13x.event" -addEndGuards
Core D FE7 Structure 0xCA21C0 -input:%1 "-output:%~dp1Ch14.event" -addEndGuards
Core D FE7 Structure 0xCA2304 -input:%1 "-output:%~dp1Ch15.event" -addEndGuards

Core D FE7 Structure 0xCA2604 -input:%1 "-output:%~dp1Ch16.event" -addEndGuards
Core D FE7 Structure 0xCA2908 -input:%1 "-output:%~dp1Ch17.event" -addEndGuards
Core D FE7 Structure 0xCA2A58 -input:%1 "-output:%~dp1Ch17x.event" -addEndGuards
Core D FE7 Structure 0xCA2C98 -input:%1 "-output:%~dp1Ch18.event" -addEndGuards
Core D FE7 Structure 0xCA2DB0 -input:%1 "-output:%~dp1Ch19.event" -addEndGuards
Core D FE7 Structure 0xCA2EF8 -input:%1 "-output:%~dp1Ch19x.event" -addEndGuards
Core D FE7 Structure 0xCA2FD0 -input:%1 "-output:%~dp1Ch19xx.event" -addEndGuards
Core D FE7 Structure 0xCA34EC -input:%1 "-output:%~dp1Ch20.event" -addEndGuards
Core D FE7 Structure 0xCA3798 -input:%1 "-output:%~dp1Ch21.event" -addEndGuards

Core D FE7 Structure 0xCA3B20 -input:%1 "-output:%~dp1Ch22.event" -addEndGuards
Core D FE7 Structure 0xCA3D7C -input:%1 "-output:%~dp1Ch23.event" -addEndGuards
Core D FE7 Structure 0xCA3E98 -input:%1 "-output:%~dp1Ch23x.event" -addEndGuards
Core D FE7 Structure 0xCA4260 -input:%1 "-output:%~dp1Ch24Lloyd.event" -addEndGuards
Core D FE7 Structure 0xCA4570 -input:%1 "-output:%~dp1Ch24Linus.event" -addEndGuards
Core D FE7 Structure 0xCA478C -input:%1 "-output:%~dp1Ch25.event" -addEndGuards
Core D FE7 Structure 0xCA4950 -input:%1 "-output:%~dp1Ch26.event" -addEndGuards
Core D FE7 Structure 0xCA4D2C -input:%1 "-output:%~dp1Ch27Kenneth.event" -addEndGuards
Core D FE7 Structure 0xCA50E0 -input:%1 "-output:%~dp1Ch27Jerme.event" -addEndGuards

Core D FE7 Structure 0xCA54A4 -input:%1 "-output:%~dp1Ch28.event" -addEndGuards
Core D FE7 Structure 0xCA5B28 -input:%1 "-output:%~dp1Ch28E.event" -addEndGuards
Core D FE7 Structure 0xCA593C -input:%1 "-output:%~dp1Ch28x.event" -addEndGuards
Core D FE7 Structure 0xCA5AB0 -input:%1 "-output:%~dp1Ch29.event" -addEndGuards
Core D FE7 Structure 0xCA5BD4 -input:%1 "-output:%~dp1Ch30H.event" -addEndGuards

Core D FE7 Structure 0xCA5F10 -input:%1 "-output:%~dp1Ch31.event" -addEndGuards
Core D FE7 Structure 0xCA605C -input:%1 "-output:%~dp1Ch31x.event" -addEndGuards
Core D FE7 Structure 0xCA6404 -input:%1 "-output:%~dp1Ch32.event" -addEndGuards
Core D FE7 Structure 0xCA6574 -input:%1 "-output:%~dp1Ch32x.event" -addEndGuards
Core D FE7 Structure 0xCA6720 -input:%1 "-output:%~dp1Final1.event" -addEndGuards
Core D FE7 Structure 0xCA67D0 -input:%1 "-output:%~dp1Final2.event" -addEndGuards

pause