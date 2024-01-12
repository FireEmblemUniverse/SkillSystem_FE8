@echo off
SET Png2Dmp=../../../../../../EventAssembler/Tools/Png2Dmp.exe

call :walkTree ../
goto :eof

:walkTree
SET pathPng2Dmp=%~1%\%%Png2Dmp%

for %%f in (*.png) do (
  "%pathPng2Dmp%" %%f --lz77
  "%pathPng2Dmp%" %%f --palette-only -po %%~nfPal.dmp
)
for /D %%d in (*) do (
  cd %%d
  call :walkTree ../%~1%
  cd ..
)
exit /b