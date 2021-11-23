@echo off

@cd %~dp0/Png
@dir *.png /b > png.txt
@echo //Generated - do not edit!>GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt

@for /f "tokens=*" %%m in (png.txt) do (
echo ALIGN 4 >> GeneratedInstaller.txt
echo %%~nm_Anim: >> GeneratedInstaller.txt
echo BYTE 8; ALIGN 4; POIN %%~nm_Data >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt
)
@echo. >> GeneratedInstaller.txt

@echo. >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt

@echo //Image Data >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt

@for /f "tokens=*" %%m in (png.txt) do (
echo ALIGN 4 >> GeneratedInstaller.txt
echo %%~nm_Data: >> GeneratedInstaller.txt
echo #incbin "%%~nm.dmp" >> GeneratedInstaller.txt
echo. >> GeneratedInstaller.txt
)

@del png.txt

@cd %~dp0

@copy "%~dp0Png\GeneratedInstaller.txt" "%~dp0" > nul

@del "%~dp0Png\GeneratedInstaller.txt"




echo Done!

pause