@echo off
SET compress=../../../../../../EventAssembler/Tools/compress.exe
SET tmx2tsa=../../../../../../Tools/tmx2tsa/tmx2tsa.py

call :walkTree ../
goto :eof

:runTmx2tsa
SET tmxFile=%~1%.tmx
SET dmpFile=%~1%.dmp
:: Equipment box is a special case.
if %~1%==EquipmentBox (SET pal=0)
if not %~1%==EquipmentBox (SET pal=1)
python3 "%pathTmx2tsa%" -p %pal% -c "%pathCompress%" %tmxFile% %dmpFile%
exit /b

:walkTree
SET pathCompress=%~1%\%%compress%
SET pathTmx2tsa=%~1%\%%tmx2tsa%

for %%f in (*.tmx) do (
  call :runTmx2tsa %%~nf
)
for /D %%d in (*) do (
  cd %%d
  call :walkTree ../%~1%
  cd ..
)
exit /b