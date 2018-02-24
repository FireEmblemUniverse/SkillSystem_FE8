The original README.txt states:
"and this README.txt file must remain unmodified."

To respect Nintenlord's wishes, I(Crazycolorz5) will put what I need to say here.

--------------
FEU Tutorials:
--------------

Disassembly: 
http://feuniverse.us/t/simple-event-editing-using-event-assembler/111

Arch's Newest, Completest Tutorial on Events:
http://feuniverse.us/t/archs-guide-to-chapter-construction/110


--------
History:
--------

V 9.11
-Crazycolorz5's Edits.
-Great AI update.
-Finally fixed the great FE7 IFAT/IFAF mixup.
-Integrated the many FE8 raws that Venno identified.
-Added many aliases for existing codes.
-Added a ton of macros. See EA standard library for full list.
-Changed name of "EA Standard library" to "EA Standard Library".
-Updated EA Standard Library to 3.0.

V 9.12
-Aliased BYTE as CODE for both backwards compatability and usage of #incbin
-Bundled Hack Installation and AI Assembly into Extensions folder.
-FE7, FE8: Added expanded templates for use in making hack buildfiles.
-Updated EA Standard Library to 3.1.

V 10.0
-FE6: Added THE_END code in raws, replacing _0x3E (credit to Onmi)
-FE8: Changed old FE8!IFET to CHECK_EVENTID
-Updated EA Standard Library to 9.2.
-Made capitalization in includes and folder structure more consistent.
-Fixed bug where resources inconsistently closed when included.
-Fixed #incbin to use BYTE instead of CODE.
-Fixed bug where ifndef didn't properly recognize automatic definitions.
-Made >> always do 32-bit logical shifts; Added >>> to do 32-bit arithmetic shifts.
-Fixed operator precedence to match that of C's.
-Loading a raw code will also load _0xXXXX where XXXX is its ID;
 If the code is <= 0xFF, it also loads _0xXX.
-Redefinitions are now only warnings, rather than errors.
-Added #incext; Searches Tools folder for the name of the tool provided,
 then calls the tool by command line with the rest of the parameters as
 commandline parameters, then inlines with BYTE any output written to stdout.
 An error is logged if the first bytes of the output are "ERROR: ".
-Added the Tools ParseFolder, Png2Dmp, and PortraitFormatter.
-Added PUSH/POP to store and load CURRENTOFFSET.
-Added #easteregg. Try to find them all!

V 10.1
-Fixed bugs with #incext
-Added #runext -- like incext but doesn't pass the --to-stdout option and discards output.
-Added ifndef guards around Tools/Tool Helpers.txt
-Allowed escaping in parsing -- \ lets the next character to be parsed plain.
 So, able to pass things like My\ File.txt or have " inside a quote, etc.
 This still needs some work when it's being lexed/displayed.
-Updated toolkit.
-Added MNTS code for FE8 (returns to title screen)
-Fixed Fe8Code assembling, which was produced by the disassembler.

V10.1.1
-Added POIN2; it's just POIN but doesn't require word-alignment.
-Fixed Hack Installation/setPointerTableEntry
-Added #inctext for programs that output event code, rather than just binary.

V 11.0
-Changed #inctext to #inctevent. I recommnend the use of this name in the future because it's more intuitive.
-Fixed bug where Core would hang if it got an invalid input file.
-Added PROTECT (start) (end) to make a region write-protected.
-Made Event assembler.exe look for .event files by default (over .txt)
-Changed lexing/parsing. 
 -String literals now work (with MESSAGE and such)
 -Labels/Definitions come into scope for parameters properly.
 -Added ability for use of definitions in preprocessor calls.
-Made disassembly work again; changed auto-adding of _0x codes to not mess up disassembly.
-Changed disassemblies to use ASSERT for stronger protection over just MESSAGE-ing the currentOffset.
-Changed scripts to take/output .event files by default.

V11.0.1
-Aliased #inctevent as #inctext for backwards compatability with V10.1.1

V 11.1 (StanH_)
-Added `-symOutput:<filename>` option, which outputs global labels to `<filename>` following the format `<name>=$<offset(hex)><newline>`
-"Added" symbol Assignment logic (`<symName> = <value>`) ("Added" because most of the logic was already present, I basically just made it parse)
-Tools invoked through directives (`#incext`, `#inctevent` & `#runext`) can now report errors via stderr (before they needed to print "ERROR: <err string>" to stdout)
-`#runext` passes Tool's stdout to EA's
-Added warning when redefining a symbol/label (within the same scope)
-Various Fixes:
 -Fixed `#inctext`/`#inctevent` not handling parameters with spaces properly
 -Fixed IsDefined macro not working
 -Fixed curly brackets crashing EA when directly after a label/statement
 -Fixed repeatable codes without parameters crashing EA
 -Fixed various crashes related to the expression/parameter parser

-------------------
Additional Credits:
-------------------

-Vennobennu/Venno, for identifying many FE8 codes, and 
 making many of the codes that deal with the world map.
-Gryz, for aiding a ton in all the AI research done on
 FE7, which was a boon in developing the new AI model.
-Circleseverywhere, for inspiring some of the design
 decisions in revamping EA. Also checking my work, and
 making several macros.
-Camdar/CT075 and Zahlman, for inspiring a UNIX-like
 design for #incext.
 
-------------
Future plans:
-------------

-http://feuniverse.us/t/ea-features-to-add/1608


------------
Legal stuff:
------------
Basically copy-pasted with a minor edit from the original README:

This program and everything it comes with, referred 
as product from now on, is delivered as is and 
has no warranty what so ever.
You can modify, add and distribute the product in its entirety
as you wish, but the origin of the product, that is, created 
by Nintenlord, must not be misinterpreted by anyone and 
the README.txt file must remain unmodified.
All money made with this product belongs to the original 
creator, Nintenlord.
