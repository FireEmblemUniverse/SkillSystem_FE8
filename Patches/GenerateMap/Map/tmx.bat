

@echo off

tmx2ea.py -s

@dir *.dmp /b > dmp.txt
@echo //Generated - do not edit!>GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt


@echo ALIGN 4 >> GeneratedInstaller.txt
@echo MapPiecesTable: >> GeneratedInstaller.txt
setlocal enableextensions enabledelayedexpansion
@for /f "tokens=*" %%m in (dmp.txt) do (
echo POIN %%~nm >> GeneratedInstaller.txt
) 
@echo WORD 0 >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt
@echo. >> GeneratedInstaller.txt
setlocal enableextensions enabledelayedexpansion
@for /f "tokens=*" %%m in (dmp.txt) do (
echo ALIGN 4 >> GeneratedInstaller.txt
echo %%~nm: >> GeneratedInstaller.txt
echo #incbin "%%~nm.dmp" >> GeneratedInstaller.txt
) 
endlocal 

@del dmp.txt

type %~dp0GeneratedInstaller.txt > %~dp0GeneratedInstaller.event
@del %~dp0GeneratedInstaller.txt

pause 