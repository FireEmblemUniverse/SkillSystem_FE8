@echo off 

@cd "%~dp0/dmp"

setlocal enabledelayedexpansion
set FILE_MATCH=*_pal.dmp

for /R "%~dp0/dmp" %%F in (%FILE_MATCH%) do (
  set OUT_FILE=%%~dF%%~pF%%~nF%_fog.dmp
  echo Assembling "dmp/%%~nxF"...
  py FogTilesetFilter.py -i "%%~nxF" -o "!OUT_FILE!"
)

pause