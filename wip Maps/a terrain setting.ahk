#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

esc::exitapp



q::
Send, !c 
Return


e::
Send, !v 
Return

w::
MouseMove, 0, -24, 0, R //16 pixels up
sleep 50
Click
Return

a::
MouseMove, -24, 0, 0, R //16 pixels left
sleep 50
Click
Return

s::
MouseMove, 0, 24, 0, R //16 pixels down
sleep 50
Click
Return

d::
MouseMove, 24, 0, 0, R //16 pixels rig
sleep 50
Click
Return


f::
Send, !v     
sleep 10
MouseMove, 16, 0, 0, R //16 pixels right
sleep 50
Click
sleep 10
Send, !v     
sleep 50
MouseMove, 16, 0, 0, R //16 pixels right
sleep 50
Click
sleep 10
Send, !v     
sleep 50
MouseMove, 16, 0, 0, R //16 pixels right
sleep 10
Click
Return

r::
Send, !v     
sleep 10
MouseMove, -16, 0, 0, R //16 pixels left
sleep 50
Click
sleep 10
Send, !v     
sleep 50
MouseMove, -16, 0, 0, R //16 pixels left
sleep 50
Click
sleep 10
Send, !v     
sleep 50
MouseMove, -16, 0, 0, R //16 pixels left
sleep 10
Click
Return



 