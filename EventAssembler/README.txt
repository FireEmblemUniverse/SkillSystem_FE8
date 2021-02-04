Nintenlord's event code Assembler for Fire Emblem
games on GBA.

-----------
How to use:
-----------

Choose a file containing event assembly as the input 
and ROM file as output.
Press "Assemble". 
Result:
Writes event code to the ROM.

If you wish to learn about event disassembling, use my
tutorial, which is available in here:
http://www.bwdyeti.com/cafe/forum/index.php?topic=24.0
http://serenesforest.net/forums/index.php?showtopic=26206

If you wish to learn about making full custom chapters,
read this tutorial by Arch:
http://www.bwdyeti.com/cafe/forum/index.php?topic=55.0
http://serenesforest.net/forums/index.php?showtopic=21165

If you wish to use EA from command line, the format is this:
Assembly:
 Core A language [flags]
Disassembly:
 Core D language *disassembly mode* *offset to disassemble* 
      priority *length to disassemble* [flags]

language              = FE6, FE7 or FE8
disassembly mode      = Block, ToEnd or Structure
offset to disassemble = a valid number
priority              = priority of codes used in disassembly,
                        not used in Structure disassembly mode
length to disassemble = a valid number, only used in Block 
                        disassembly mode

flags:
-addEndGuards        = Adds end guards to disassembly
-raws:Folder or file = The folder or file to load raws from.
                       Default is Language raws.
-rawsExt:extension   = Extension of files that contain langauge
                       raws. Ignored when loading from a single file.
					   Default is .txt.
-output:File         = The file to write the output. Required for 
                       disassembly. Default for assembly is to write
					   to standard output.
-input:File          = The file to read the input. Required for 
                       assembly. Default for disassembly is to read 
					   form	standard output.
-error:File          = File to write errors, warnings and messages to.
                       Default is standard error.

--------
History:
--------

V 1.0:
-First public release.
-Entered the Programming contest on FEU.
V 1.1:
-Added codes: ENUT, ENUF and all condition codes.
V 2.0:
-Added stuff to make code maintaining easier. 
 Too many to list right now.
V 3.0
-Added FE8 support for some codes.
-Added support for World map codes.
V 4.0
-Made definitions and labels have a scope.
-Added support for definition files.
V 4.1
-Fixed a bug in SHLI code
V 4.2
-Fixed a bug in REPA code
V 5.0
-Added support for some FE6 codes
V 5.1
-Added support for some FE8 codes.
V 5.2
-Fixed glitch with local variables.
-Added MNC2 for FE7 and FE8 and fixed MNCH for FE8.
V 6.0
-Rewrote most of the source, added bunch of codes and abilities. 
-Removed scope for definitions.
V 6.1
-Fixed glitch with FE8 version of UNIT.
-Fixed MISC related glitches.
V 6.2
-Added FE6 CHAR support thanks to Kate/Klo/whatever.
V 6.3
-Various codes added.
-Define file support re-added.
V 6.4
-Pointer error with offsets higher than 01000000 fixed.
V 6.5
-Fixed error handling space in quotes.
V 6.6
-Added MSGE code that sends messages to message box.
-Added #ifdef, #ifndef, #else, #endif and #undef.
V 6.7
-Fixed LOCA DOOR for FE7 and FE6.
V 6.8
-Improved Exception handling to not crash on most assembly
 code mistakes.
V 6.9
-Fixed error with FE8 ENDA code.
-Added markyjoe1990s FE7 template.
V 7.0
-Added macro support.
-Included the first version of EA standard library.
-Moved most codes to language raws.
-Several code changes, removals and additions.
-Remade error and warning systems completely.
-Added support for arithmetic calculations for
 defined words.
-Added more arithmetic operations such as &, | and %.
V 7.1
-Added disassembly.
-Added some FE8 world map codes.
V 7.2
-Added option for chapter-wide disassembly.
-Some minor code changes.
-Updated EA standard library.
V 7.3
-Readded SHLI and MOMA codes.
-Readded proper coordinate support for FE8 unit data.
-Made language raws support bit-accurate codes.
-Added REDA for FE8
-Added IFET and changed IFEV to IFEF
-Added ASME code
-Updated EA standard library.
V 7.4
-Fixed a bug with MOMA and SHLI.
-Fixed a bug in LWMC and TEX8 for FE8.
-Added CMDS, CMDL, FIG1 and FIG2 code for FE8.
-Added FLDT and RMSP codes.
-Added binary support for assembly.
-Added support for preferred base for disassembly.
-Made ending guardians in disassembly an option.
-Made ending guardians appear at the end of every
 string of code.
V 7.5
-Fixed a bug in FE8 unit data.
-Added preferred bases to most raw codes.
-Updated EA standard library.
V 7.6
-Fixed a bug that caused binary numbers to not be recognized.
-Changed bases in raw codes to correct.
V 7.7
-Fixed a bug related to uneven bit writing to the end of code.
-Added language raws specification. See file Language.raws in
 folder Language raws for details about the raws.
-Updated EA standard library.
V 7.8
-Added support for FE6 AFEV code.
-Updated template.
-Added MESSAGEIF code.
-Fixed FE7 CHAI coordinate version code.
-More error messages.
-Some other fixes.
-Updated EA standard library.
V 7.9
-Fixed errors in Event assembler language file.
-Added WARP code for FE7.
-Added TEXTSTART, TEXTSHOW, TEXTCONT and TEXTEND codes
 for FE8. 
-Added an extra parameter to REDA code.
-Fixed coordinate related problems in REDA and FE8 UNIT.
-Added ALIGN code.
-Updated template.
-Updated EA standard library.
V 8.0
-Fixed crash on loading language raw files with different
 line ending modes.
-Fixed a code in language raws randomly getting ignored. 
-Added support for negative numbers.
-Some UI changes.
-Fixed MOVE code for FE6.
-Fixed FE8 FADI/FADU confusion.
-Fixed TEX3 code.
-Added new parameter for MUS3.
-Added new parameter for RMSP.
-Added parameter to MACC.
-Split SHOWMAP and HIDEMAP codes from FADU, FADI, FAWI and FAWU.
-Renamed TEX3 as TEXTIFEM, TEX4 as MORETEXT, TEX7 as TEXTWM.
-Removed UNIT Empty code, though EAstdlib has backwards 
 compability code.
-Removed data from GOTO and MNCH.
-Added lot's of FE6 and FE7 codes. Every code used in those games
 is covered somehow.
-Updated EA standard library.
V 8.1
-Rewrote macro handling to be faster and more predictable.
-Added and changed some codes, including FE7 & 8 World map codes.
-Added some built-in macros.
-Added pool ability.
-Made Event Assembler Language.txt generate automatically from raws
 and updated it considerably.
-Updated EA standard library.
V 8.2
-Separated core functions to separate assembly, called Core.
 Core can only be run from command line.
-Included scripts to disassemble all chapters and world maps for all 
 3 GBA games.
-Added few FE6 and FE7 codes that I overlooked in previous release.
-Added description of doc codes to Language.raws file.
-Fixed last bits getting written wrong in FE8 UNIT code.
-Fixed a bug in ITGM for FE8.
-Fixed MUSI and MUNO FE8 confusion.
-Fixed FE7 TEXTBOXTOBOTTOM and TEXTBOXTOTOP mixup.
-Removed CAM1 for FE8 for not working.
-Added some experimental FE8 codes.
-Added EAstdlib Macro and Command List.txt.
-Updated EA standard library.
V 8.3
-Added Assembly scripts.
-Added script for generating Event assembler language.txt.
-Made EA accept non-caps codes.
-Added FIRE and GAST for FE7.
-Fixed some FE7 codes.
-Fixed a problem with pool dumping.
-Fixed a problem with codes not incrementing offset properly.
-Updated EA standard library.
V 8.4
-Fixed FE7 ENUT and ENUF screw-up.
-Updated EA standard library.
V 8.5
-Made FE7 IFET and IFEF codes match ENUT and ENUF
-Added THE_END and LYN_END codes for FE7.
-Added NCONVOS and NEVENTS for the control freaks out there.
-Updated EA standard library.
V 9.0
-The great FE8 update.
-Improved disassembly performance, especially for FE8.
-Disabled REDA disassembling for causing problems.
-Removed bunch of faulty codes for FE8.
-Added large bunch of codes FE8.
-Added CGSTAL code for FE7.
-Renamed TEX5 to TEXTCG for FE7.
-Added MORETEXTCG for FE7.
-Added FROMCGTOBG, FROMBGTOCG, FROMCGTOMAP for FE7.
-Added new built-in macro, String.
-Fixed error reporting error when file isn't found 
 with #include and #incbin
-Updated EA standard library.
V 9.1
-Rewrote parsing.
-Added << and >> operators.
-Removed CODE and FILL codes.
-Added WORD, SHORT, BYTE.
-Improved error reporting.
-Updated EA standard library.
V 9.2
-Fixed ; handling repeating the first code.
-Added proper errors to some symbol related parameters 
 being undefined.
-Added proper errors to built-in codes getting a parameter
 of wrong type.
-Fixed Terminating string templates misreporting length 
 during disassembly.
-Updated FE7 Template.
V 9.3
-Fixed EA not giving the error on mis-aligned codes.
-Fixed crashing upon certain parsing errors.
-Fixed crash with 0x integer literals.
-Added FE6 and FE8 templates and updated FE7 one.
V 9.4
-Fixed line comments not getting ignored in block comments.
-Fixed error with custom error file when calling Core
 from command line.
-Fixed disassembly not handling mergeable codes lengths 
 properly.
-Added offset of bad pointer to error message when
 handling the pointerlist of a chapter.
-Some performance improvements to both assembly and
 disassembly.
-Fixed crash when using read-only file as output
 file in assembly from command line.
-Updated EA standard library.
V 9.5
-Removed output showing window from taskbar.
-Made column numbering start from 1 instead of 0.
-Improved error when using vector of vectors as parameter.
-More minor performance improvements.
V 9.6
-Renamed GOTO to CALL and _GOTO_HELL to _CALL_HELL
-Fixed a bug causing CURRENTOFFSET to not print properly.
-Fixed length disassembly adding end guards in wrong places
 with wrong offsets.
-Added Programmers Notepad syntax highlighting scheme.
 Only works with version 2.0.8.718 of PN.
-Added shaky backwards compatibility for CODE.
 Define USING_CODE to use it.
-Updated EA standard library.
V 9.7
-Fixed errors in FE6 disassembly script, thanks to Omni.
-Fixed a raw file not being included with releases, causing
 NCONVOS and NEVENTS codes not to work.
-Added backwards compatibility for experimental codes
 moved to full codes.
-Made GUI not freeze when completing a task.
-Renamed some language raws files.
-Fixed crash on having wrong amount of parameters with ORG or ALIGN.
-Updated EA standard library.
V 9.8
-Made EA not write any data to output
 if any errors are encountered.
-Updated EA standard library.
V 9.9
-Fixed SHORT and BYTE giving alignment errors on 
 2 and 1 aligned codes.
-Updated Templates to match changes.
-Added END_MAIN code.
-Updated EA standard library to 2.13.
V 9.10
-Fixed disassembly always crashing.
-Stopped MESSAGE, ERROR and WARNING codes from printing
 the name of the code.
-Updated EA standard library to 2.14.

-------------
Future plans:
-------------

-More functions to EA standard library.
-More documentation about codes and EAstdlib.
-Integrated development environment.

--------
Credits:
--------

-Nintenlord for making this.
-Kate/Klo/whatever for writing FE6 CHAR support
-Everyone who submitted event codes for this, especially
 Fire Blazer and flyingace24.
-markyjoe1990 for FE7 event template.
-Mariobro3828 for FE7 world map definition values and
 for making the EAstdlib Macro and Command List.txt.
-Arch for making code I can use to debug this app, 
 for his tutorials and his FE6 template.
-Ryrumeli for telling me the ASM routine that handles
 the events in FE8.
-Omni for reporting errors with FE6 disassembly script.
-Camtech075/Cam/Kam for making FE8 template.
-Everyone who uses this and/or reports bugs and/or gives
 feedback.

------------
Legal stuff:
------------

This program and everything it comes with, referred 
as product from now on, is delivered as is and 
has no warranty what so ever.
You can modify, add and distribute the product as
you wish, but the origin of the product must not be 
misinterpretted by anyone and this README.txt file must
remain unmodified.
All money made with this product belongs to the original 
creator, Nintenlord.