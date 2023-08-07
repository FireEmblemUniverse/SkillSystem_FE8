
@echo off

set "textprocess=%~dp0..\Tools\TextProcess\text-process-classic.exe"
set "parsefile=%~dp0..\EventAssembler\Tools\ParseFileUTF8.exe"

  echo: | ("%textprocess%" text_buildfile.txt --parser-exe "%parsefile%" --installer "InstallTextData.event" --definitions "TextDefinitions.event")

pause
