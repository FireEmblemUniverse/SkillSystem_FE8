@echo off

@cd %~dp0/Png

echo //Generated - do not edit!>GeneratedInstaller.event
echo. >> GeneratedInstaller.event


@dir /b /a:d > subfolders.txt
@for /f "tokens=*" %%G in (subfolders.txt) do (
@cd %~dp0png\%%G
echo %~dp0png\%%G

@echo.> GeneratedInstaller.txt
@echo.>> GeneratedInstaller.txt
@echo.>> GeneratedInstaller.txt
@echo.>> GeneratedInstaller.txt
echo ALIGN 4 >> GeneratedInstaller.txt
echo %%~nG_Anim: >> GeneratedInstaller.txt
@dir *.png /b > png.txt
@for /f "tokens=*" %%m in (png.txt) do (
echo BYTE 3 0; SHORT 0; POIN %%~nm_Data %%~nm_pal >> GeneratedInstaller.txt)
echo WORD 0 0 0 >> GeneratedInstaller.txt
@echo.>> GeneratedInstaller.txt
@echo.>> GeneratedInstaller.txt
@echo //Image Data >> GeneratedInstaller.txt
@echo.>> GeneratedInstaller.txt
@for /f "tokens=*" %%m in (png.txt) do (
@echo ALIGN 4 >> GeneratedInstaller.txt
@echo %%~nm_Data: >> GeneratedInstaller.txt
@echo #incbin "dmp\%%~nm.dmp" >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt
@echo ALIGN 4 >> GeneratedInstaller.txt
@echo %%~nm_pal: >> GeneratedInstaller.txt
@echo #incbin "dmp\%%~nm_pal.dmp" >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt)
@del png.txt
@cd %~dp0/Png
type %~dp0Png\%%G\GeneratedInstaller.txt >> %~dp0Png\GeneratedInstaller.event

@del "%~dp0Png\%%G\GeneratedInstaller.txt"
)
@cd %~dp0
@copy "%~dp0Png\GeneratedInstaller.event" "%~dp0" > nul
@del "%~dp0Png\GeneratedInstaller.event"

echo Done!

pause