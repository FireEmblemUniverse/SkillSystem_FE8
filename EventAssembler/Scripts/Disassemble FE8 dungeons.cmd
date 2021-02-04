echo off
cd %~dp0
cd ..
echo on

Core D FE8 Structure 0x9eb574 -input:%1 "-output:%~dp1T1.event" -addEndGuards
Core D FE8 Structure 0x9eb614 -input:%1 "-output:%~dp1T2.event" -addEndGuards
Core D FE8 Structure 0x9eb6a8 -input:%1 "-output:%~dp1T3.event" -addEndGuards
Core D FE8 Structure 0x9eb730 -input:%1 "-output:%~dp1T4.event" -addEndGuards
Core D FE8 Structure 0x9eb7dc -input:%1 "-output:%~dp1T5.event" -addEndGuards
Core D FE8 Structure 0x9eb894 -input:%1 "-output:%~dp1T6.event" -addEndGuards
Core D FE8 Structure 0x9eb97c -input:%1 "-output:%~dp1T7.event" -addEndGuards
Core D FE8 Structure 0x9eba10 -input:%1 "-output:%~dp1T8.event" -addEndGuards

Core D FE8 Structure 0x9ebae0 -input:%1 "-output:%~dp1R1.event" -addEndGuards
Core D FE8 Structure 0x9ebb80 -input:%1 "-output:%~dp1R2.event" -addEndGuards
Core D FE8 Structure 0x9ebca4 -input:%1 "-output:%~dp1R3.event" -addEndGuards
Core D FE8 Structure 0x9ebd5c -input:%1 "-output:%~dp1R4.event" -addEndGuards
Core D FE8 Structure 0x9ebe2c -input:%1 "-output:%~dp1R5.event" -addEndGuards
Core D FE8 Structure 0x9ebf14 -input:%1 "-output:%~dp1R6.event" -addEndGuards
Core D FE8 Structure 0x9ec038 -input:%1 "-output:%~dp1R7.event" -addEndGuards
Core D FE8 Structure 0x9ec1e0 -input:%1 "-output:%~dp1R8.event" -addEndGuards
Core D FE8 Structure 0x9ec298 -input:%1 "-output:%~dp1R9.event" -addEndGuards
Core D FE8 Structure 0x9ec32c -input:%1 "-output:%~dp1R10.event" -addEndGuards

pause