cFreeMovement by Mokha：
<Tutorial Basic>
1. Include "FreeMovement.event" in your buildfile.
2. Use the macro "EnableFreeMovement" in beginning event of the chapter, then you can enter the FreeMovement proc.
3. Press Button A, you can interact with chest, Visit, Armory, Vendor, Scecret, Talk events. Traps can also get effect but need you work on it (I will cover it in "Tutorial Advanced").
4. Press Button B will end the FreeMovement and goto Enimy Phase.
5. Press Button L will call for menu.
6. Press Button "Select" will change unit to move.

<Tutorial Advanced>
1. You can now modify the program modularly!
2. Functions called at each Button pressed now can be modified modularly in the file "HookList.event" (FMU_FunctionList_OnPressXs). These On-Button-Pressed functions are defined in file "/src/FreeMU_ButtonPress.c" , both of which are defined as "Bool Fuction(Proc*)": if they successfully trigered, then they will return TRUE, otherwase FALSE. Following this format, you can define your own On-Button-Pressed functions. These functions have Prioritization: (For example) Once you press Button "A" and successfully RunMapEvents, then you will not trigger TalkEvents and TrapEvents this time.
3. Traps: now FreeMU has been adapted to TrapRework... but not not fully adapted. You  can use macro "AddTrap(trapID,x,y)" (which is defined in TrapRework) in your chapter, but to make them work properly, you need to do more:

<Toturial on Traps>
1. To determine a trap effect. You should select a trapID (Same as TrapRework), and write the effect function for your trap. For now, the effect can only defined in ASMC, not in Event Code. I make an example in "/Examples/_TrapExample.event", you can refer on it.
2. Once you end up working on effect routine, you should insert it in "HookList/HookListFMU_TrapList_OnPressA" or "HookListFMU_TrapList_Auto" by  using the macro FMU_SetTrap(ID,ASMC). Currently there are two types of traps defined: Triggered by pressing button A, or triggered automaticlly.
3. Now use macro "AddTrap(ID,x,y)" to set traps on map. You should set this macro in BeginningScene of your chapter.

<Problems on original version:>
1. The introduction of automaticly save operation will  cause lag in the interaction between the game and the player.
2.  Bugs exist in the interaction between FreeMU proc with EventEngine, including but not limited to: (1) "Armory、Vendor、Scecret" cannot be triggered effectively. (2) Chests and the dialogue between villages and characters can be triggered repeatedly.
3. In the process of long-distance movement, Map sprite cannot display the running anime correctly;
4. Problems exist on controling the moving speed.


<The optimization scheme of the new version:>
1. Reorganize the program logic based on the C language to ensure the readability and scalability of the program at the PROC level;
2. Save automaticly;
3. The 6C-MoveUnit has been fixed to avoid the operation jam and ensure the smooth interaction.
4. Reorganize the interaction process with EventEngine to ensure that single trigger events such as chests and character dialogues do not run repeatedly;

<how to use:>
See Tutorials ！



<Other considerations:>
1. It can interact with EventEngine correctly: chest, Visit, Armory, Vendor, Scecret, Talk events. Currently problems still exixt with the Size event (I don't know why, but it has been not triggered yet). MiscEvents has not been verified, but I think it should be effective, because MiscEvents is directly used the original assembly code ( well my poor programming ability really does not allow this complex assembly code to be transcribed into C :(
2. The free movement flag is at 0x2028924 (Defined at FreeMovement.event), which is not saved in the SaveData. Please use ExpandedModularSave to save this flag bit;

<Credits:>
FreeMovement prototype made by Sme;
ASM tutorial shared by Tequilla;
Proc tutorial, C language compilation tutorial and library functions shared by StanH;
Suggestions, tutorials and tools provided by Vesly and all FEU friends.


<!>
<Update>







Readme-cn：
优化的FreeMovement（FE8U Only）：

原版存在的问题：
1. 引入自动存档会造成操作卡顿；
2. 与EventEngine的交互过程存在bug，包括但不限于：(1)无法有效触发商店. (2)宝箱、村庄与角色对话可以反复触发；
3. 长距离移动的过程，Map Sprite moving animation 无法正确显示出跑步动作；
4. 角色移速的控制过程存在bug。

新版本的优化方案：
1. 基于c语言重新梳理程序逻辑，确保程序在proc层面的可读性与可扩展性；
2. 可自动存档；
3. 额外对6C-MoveUnit进行修补，避免了操作卡顿，并确保了移动过程丝滑流畅；
4. 重新梳理与EventEngine的交互过程，确保宝箱、角色对话等单次触发事件不再重复运行；

如何使用：
1. 只需在章节事件内使用macro，“EnableFreeMovement”即可在章节开启事件结束后进入自由移动过程。对应的，调用“DisableFreeMovement”则可以将其关闭。这与SME的版本是一致的。
2. Press button “Select”，即可在我方出场的角色之间自由切换移动单位。

其他注意事项：
1. 可与EventEngine之间正确交互：chest、Visit、Armory、Vendor、Scecret、Talk事件。Size事件目前存在问题（不知道为什么，没有正确触发）。MiscEvents未做验证，但是我觉着应该能够生效，因为MiscEvents是直接用的原本的汇编代码（我那可怜的编程能力实在不允许把这段复杂的汇编代码转写成C了）；
2. 自由移动的标志位在0x2028924，这一标志位并没有保存在存档中。请自行使用存档扩展将这一标志位进行保存；


Credits：
Sme所做的FreeMovement原型；
Tequilla分享的ASM教程；
StanH分享的Proc教程、C语言编译教程与库函数；
Vesly等所有FEU的朋友们提供的建议、教程与工具。


<!>更新！
1. 现在已经可以与Sme的TrapRework进行互动
