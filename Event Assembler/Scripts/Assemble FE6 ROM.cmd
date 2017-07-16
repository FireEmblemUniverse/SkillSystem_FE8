echo off
cd %~dp0
cd ..
echo on

Core A FE6 -output:%1 "-input:%~dp1ROM Buildfile.event"

pause