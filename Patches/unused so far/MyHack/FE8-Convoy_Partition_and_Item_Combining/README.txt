This hack allows you to split the convoy into partitions as you see fit, as well as combine items when depositing them into the convoy. However, some assembly may be required.


########### CONVOY PARTITIONING ############

First off, let me note THIS DOES NOT SAVE MORE CONVOY SPACE. If you want to expand it, you'll need something like EMS (Expanded Modular Save). If you increase the number of items, they will be written to save RAM and most likely be immediately overwritten. You have been warned.

If you expand the number of items, you might need to repoint the convoy buffer as well. Both of these can be changed on lines 18 and 19, respectively.

If you don't want to partition the convoy at all and are only interested in the item combining, then you don't have to do anything.

You can split the convoy into partitions by utilizing the ConvoyPartitionTable, beginning on line 25. There are two different setups.

### SETUP 1 ###
The first case is fairly simple. The partition ID is written in the Chapter Data Table (FEBuilder: Chapter Editor) at byte +0x3D, which is currently unused. (In FEBuilder, the entry is called ?? and is the last row of the Tactics Evaluation column.)
Your entries then will simply be ConvoyPartition(start_slot, length, 0).
Start_slot is where in the convoy buffer the first item of the partition appears. If partition 2 has start slot 50, then the 50th item in the entire convoy will be the first item in partition 2.
Length is pretty obvious: how many items this partition can hold.
Function isn't used in this instance and can be set to 0.
NOTE: Make sure the entry id in the chapter table corresponds to actual data in ConvoyParitionTable. This byte is 0-aligned, so the first entry in the table is 00, the second entry is 01, etc.
This setup is fairly intuitive and easy to apply, and I think most people will use it. If you have a route split and want Group A to use partition 0 and Group B to use partition 1, both with 50 slots, then your table would look like:

ConvoyPartitionTable:
ConvoyPartition(0, 50, 0) // partition 0
ConvoyPartition(50, 50, 0) // partition 1
WORD 0 //terminator

and you'd write 00 to the aforementioned byte in the chapter data table for chapters with Group A and 01 to chapters with Group B.

If your parties meet up and you want another partition that combines them, then you'd add another entry to the table:

ConvoyPartitionTable:
ConvoyPartition(0, 50, 0) // partition 0
ConvoyPartition(50, 50, 0) // partition 1
ConvoyPartition(0, 100, 0) // partition 2
WORD 0 //terminator

For the actual combining, see the Partition Combining section further below.

### SETUP 2 (Advanced) ###
This setup is a bit more involved. Instead of a table indexed by a byte in the Chapter Data Table, the game will iterate through each entry in the ConvoyPartitionTable and execute the function. If the function returns True (1) (or there is no function), then that partition will be used.
Some examples of when you might want to use this:
- Different convoy used on the prep screen vs during the chapter
- Having a playable green army with its own convoy
- Having two convoy units (eg Merlinus) on opposite sides of the map, with different stock

To switch to setup 2, you'll need to:
- open Convoy_Stuff.asm and set Get_Partition_From_Chapter_Data_Table to 0, then reassemble the file.
- uncomment line 21, which defines _CONVOY_PARTITION_SETUP_2_, which includes Partition_Functions.lyn.event
- write your functions in Partition_Functions.asm and assemble them

I've provided a few examples of potential functions, which can be found in Partition_Functions.asm. IsEirika will return true if the current character is Eirika (character id 0x1), and false otherwise, meaning Eirika could get an entire section of the convoy to herself. GetChapterMode returns the chapter mode byte-1; this is 1 for prologue-chapter 8, 2 for Eirika route, and 3 for Ephraim route. 
I can't guess what kind of the separation the user wants to implement, so that's why you'll have to get your hands dirty if the choices available aren't what you want. Alternatively, you can ask someone to write and compile the asm for you. You'll need both DevKitARM and lyn, Stan_H's linker; search on the FEU forums for this or ask a wizard.

Example partition table for using a different convoy on the prep screen and during the chapter:

ConvoyPartitionTable:
ConvoyPartition(0, 50, IsOnPrepScreen|1) // partition 0
ConvoyPartition(50, 50, IsInChapter|1) // partition 1
WORD 0 //terminator

### NOTES ABOUT PARTITIONING ###

Things to watch out for:
- Make sure your partitions don't overlap! If partition 0 begins at 0 and has 50 spaces, and partition 1 begins at 40, then the first 10 items in partition 1 will also be part of partition 0 (although they will only be accessible if partition 0 has 40 items since the game stops reading items if it encounters a 00 00 in the list). 
- start_slot is 0-aligned (begins counting at 0), while length is 1-aligned (begins counting at 1). In the default entry, we have 100 items beginning at slot 0, and ending at slot 99. Failure to account for this can result in off-by-one errors.
- If using setup 2, the *first* partition with a function that returns True (or doesn't have one at all) will be used. Put entries with more specific conditions first. For instance, if you have a partition for lance users only, and a partition for other physical weapon users that only checks if the item's magic bit isn't set, the lance user partition should come first, since it fits both conditions. (I don't know why you'd do this, I'm just trying to come up with a clear example. Please don't sue me.)
- There are no checks to ensure all items are saved. You are responsible for ensuring you don't go over capacity. I just want to make this absolutely clear.

### COMBINING CONVOY PARTITIONS ###

There is an ASMC to combine partitions (for instance, after your route split ends and your parties join up, you can combine their convoys into one big convoy). It's called CombineConvoyPartitionsASMC and can be used as follows:

SETVAL 1 0xCCBBAA
ASMC CombineConvoyPartitionsASMC|1

AA and BB are partition ids that are being combined, and CC is the destination partition id. So if your hack has a route split where Group A uses partition 0, Group B uses partition 1, and the post-meetup group uses partition 2, you'd do SETVAL 1 0x020100.

NOTE: Make sure your target partition has enough space for the two combined partitions! If partition 0 has 50 items and partition 1 has 50 items, but partition 2 has a length of 75, then 50 items will be copied from 0 and only 25 items will be copied from 1.

########### ITEM COMBINING ############

This is pretty straightforward. If it's enabled, hold L when depositing an item or using Give All to combine an item's uses with other items of the same item id in the convoy.

Example: Depositing an iron lance (max uses: 45) with 20 uses to the convoy while holding L. There are 2 iron lances already in there; 1 with 30 uses, 1 with 44. The end result will be 2 iron lances with 45 uses and 1 iron lance with 20 - (45 - 30) - (45 - 44) = 20 - 15 - 1 = 4 uses.

If you do not want this functionality, comment out line 20 (#define _COMBINE_ITEMS_HACK_).