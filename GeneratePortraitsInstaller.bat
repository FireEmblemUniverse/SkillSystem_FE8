@echo off

@cd %~dp0/Png
@dir *.png /b > png.txt
@echo //Generated - do not edit!>GeneratedInstaller.txt
@echo //Copy paste /* */ section into your installer to change the position of eyes/mouth.>>GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt

@echo ^/^* >> GeneratedInstaller.txt

setlocal enableextensions enabledelayedexpansion
set /a count = 1
@for /f "tokens=*" %%m in (png.txt) do (
set /a count += 1
echo #define %%~nmMug !count! >> GeneratedInstaller.txt
) 
endlocal 

@echo. >> GeneratedInstaller.txt
@for /f "tokens=*" %%m in (png.txt) do (
echo setMugEntry^(%%~nmMug, %%~nm_MugData, 2,2,2,2^) >> GeneratedInstaller.txt
) 



@echo ^*^/ >> GeneratedInstaller.txt

@echo. >> GeneratedInstaller.txt

@echo. >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt


@echo //Image Data >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt

@for /f "tokens=*" %%m in (png.txt) do (
echo ALIGN 4 >> GeneratedInstaller.txt
echo %%~nm_MugData: >> GeneratedInstaller.txt
echo #incbin "dmp/%%~nm_mug.dmp" >> GeneratedInstaller.txt
echo #incbin "dmp/%%~nm_frames.dmp" >> GeneratedInstaller.txt
echo #incbin "dmp/%%~nm_palette.dmp" >> GeneratedInstaller.txt
echo #incbin "dmp/%%~nm_minimug.dmp" >> GeneratedInstaller.txt


echo. >> GeneratedInstaller.txt
)

@del png.txt

@cd %~dp0

type %~dp0Png\GeneratedInstaller.txt > %~dp0Png\GeneratedInstaller.event

@copy "%~dp0Png\GeneratedInstaller.event" "%~dp0" > nul

@del "%~dp0Png\GeneratedInstaller.txt"
@del "%~dp0Png\GeneratedInstaller.event"



echo Done!

pause