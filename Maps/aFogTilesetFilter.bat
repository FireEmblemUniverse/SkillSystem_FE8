@echo off 

@cd "%~dp0/dmp"

@set "Fog=%~dp0FogTilesetFilter.py"

setlocal enabledelayedexpansion
set FILE_MATCH=*_pal.dmp

for /R "%~dp0/dmp" %%1 in (%FILE_MATCH%) do (
  set OUT_FILE=%%~n1_fog.dmp
  set IN_FILE=%%1
  Rem echo "!IN_FILE!"
  Rem echo "!OUT_FILE!"
  py "!Fog!" -i "!IN_FILE!" -o "!OUT_FILE!"
)

pause