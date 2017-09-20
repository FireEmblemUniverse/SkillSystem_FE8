cd %~dp0

copy FE8_clean.gba SkillsTest.gba

cd "%~dp0Event Assembler"

Core A FE8 "-output:%~dp0SkillsTest.gba" "-input:%~dp0ROM Buildfile.event"

pause
