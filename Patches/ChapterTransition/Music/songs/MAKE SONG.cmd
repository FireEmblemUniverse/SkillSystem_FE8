cd %~dp0
ECHO %~1
set "variable=%~1"
midi2agb.exe "%~1"
s2ea.exe "%variable:~0,-4%.s"

ECHO off

setlocal enableextensions disabledelayedexpansion

set "search=.align  2"
set "replace=ALIGN  4"
set "textFile=%variable:~0,-4%.event"

for /f "delims=" %%i in ('type "%textFile%" ^& break ^> "%textFile%" ') do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    >>"%textFile%" echo(!line:%search%=%replace%!
    endlocal
)