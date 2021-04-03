This hack, in its current incarnation, allows you to define weapon locks for characters or
classes by an array located anywhere you wish. It can also distinguish between 'hard' locks, which
operate the same as the vanilla GBA locks, or 'soft' locks, which let the matching character use
the weapon at Level E, no matter what its normal rank is.

This, however, requires some setup. Part of the ASM code will point to a pointer table; each
pointer in that table should lead to an array that determines which character IDs are part of the lock,
and whether the lock is a soft or hard one. Which pointer in that table is used is determined by the
Ability Byte 4 in the weapon you wish to give the lock to. 0x01 means the weapon will use the first
pointer; 0x02 the second, and so forth. 0x00 indicates that the weapon will not use a custom lock.

The proper format for each array is as follows: the first byte indicates whether or not the lock is
soft or hard, and whether it uses class or character IDs. Let's call it the 'indicator byte'.

0x0 = Soft character lock
0x1 = Hard character lock
0x2 = Soft class lock
0x3 = Hard class lock

Then follows the IDs of every character that is part of the lock. At the end of the array must be
a 0x00 byte, so the routine knows to stop looking for character/class IDs.

How to install:

-If you haven't already, download Camtech's Assembly patcher, found here: 
http://dl.dropboxusercontent.com/u/12592553/Cam%27s%20Notes/Applications/Assembly%20Patcher/folDIR.html

-Move your ROM, the 'Lock.dmp' file, and the appropriate script file for the game you're using into
the same folder as the Assembly Patcher.
	-Rename your ROM to 'fe7.gba' if using FE7, or 'fe8.gba' if using FE8. If you can't see the .gba
	extension on your ROM already, don't add it in.

-Drag the script file onto 'run.py'.
	-Now a command line will ask you twice where you want to place the hack. Input the offset of the 
	free space you're using (without adding 0x8000000) both times.
		-The offset you choose MUST be word-aligned (ie divisible by 4).
	-When it's done, enter in 'quit' or close the command line.

-Open up your ROM, and search for the hex string "EEEEEEEE". This is where your pointer to the pointer
table for the lock arrays will go.
	-Replace EEEEEEEE with a pointer to where you want the pointer table to be, MINUS FOUR BYTES.
	The actual location of your pointer table must also be word-aligned.

-So if I wanted my pointer table to be at 0xB2A610, I'd add 0x8000000, subtract 0x4, then reverse the
bytes: B2A610 --> 08 B2 A6 0C --> 0C A6 B2 08

-Now put a pointer in your pointer table to where you want the first array to go in free space. This time,
you'll use the actual offset of the start of the arrays, so for these pointers you'll just add 0x8000000
and reverse the bytes.

-At that offset, the first byte, being the indicator byte should be:
 0x00 for a soft character lock,
 0x01 for a hard character lock, (bit 1 set)
 0x02 for a soft class lock or   (bit 2 set)
 0x03 for a hard class lock.     (bits 1 and 2 set)
Next add all of the IDs of the characters who will have access to the lock, then add an 0x00 byte.

-Repeat the last two steps for as many arrays as you need! Each consecutive pointer in the pointer
table must be adjacent to one another, by the by, but the arrays can go anywhere there's room.


NEW option - Either/Or weapon ranks:
To make a weapon require ranks in multiple weapon types, set the fourth bit (0x08) in the indicator byte;
To make the weapon only require ONE out of several different weapon levels, also set the third bit (0x04).

The next eight bytes after that will be the required weapon level in each of the eight weapon types; leave
0x00 for weapon types that are not part of the weapon's levels. Following that, you may have the usual list
of Class or Character IDs (according to whether the second bit is set in the indicator byte), or an 0x00 byte
if you don't want any class/character ID locks.


To make 'PRF' display as weapon rank:

-Normally, weapons with no rank and no weapon lock will display "-" as their rank. To make weapon locks
created with this hack display "PRF" properly for weapon level 0, make the following alteration:
FE7:
0x169C0: Replace 00 3C 3D 00 with 00 3C 3D FF

FE8:
0x16DD8: Replace 00 3C 3D 00 with 00 3C 3D FF

For FE7: to make all of the default weapon locks null and void, change the values at 0x80161CC to A8E0.


Weapon Lock Array System hack created by Vennobennu.