@echo off
SET compress="../../../../../../../EventAssembler/Tools/compress.exe"
SET tmx2tsa="../../../../../../../Tools/tmx2tsa/tmx2tsa.py"

FOR %%A IN (*.tmx) DO (
  python3 %tmx2tsa% -p 1 -c %compress% %%A %%~nA.dmp )