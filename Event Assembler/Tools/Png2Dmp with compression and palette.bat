@echo off

@rem call with palette output and compression
"%~dp0Png2Dmp" "%~1" --lz77 -po "%~n1_pal.dmp"

pause
