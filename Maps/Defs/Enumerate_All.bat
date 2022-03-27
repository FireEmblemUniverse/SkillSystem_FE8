@echo off
rem @set "enumerate=%~dp0\..\..\Enumerate\Enumerate.exe"
setlocal enabledelayedexpansion
set FILE_MATCH=*.txt

for /R "%~dp0" %%F in (%FILE_MATCH%) do (
  set OUT_FILE=%%~dF%%~pF%%~nF%.enu.event
  echo Assembling "%%~nxF"...
  py Enumerate.py "%%~nxF" "!OUT_FILE!"
)

pause