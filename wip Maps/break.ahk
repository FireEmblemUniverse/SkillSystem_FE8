#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
esc::exitapp

q::
MyVar = 0x19181742
MyVar = 0x19181741
MyVar = 0x1514133d
;MyVar = 0x19181740
;MyVar = 0x1514133f
;MyVar = 0x19181743
;MyVar = 0x19181744
MyVar = 0x8019411

counter = 0
Loop 8 
{
Send {Ctrl down}
Sleep 5
Send {b down}
Send {Ctrl up}
Send {b up}
Sleep 50
Send r%counter%=%MyVar%
Sleep 50
Send {Enter}
Sleep 5
counter++
}
Return


