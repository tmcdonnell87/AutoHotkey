#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

hotstrings("now#", "%A_Now%")
hotstrings("(B|b)tw", "%$1%y the way")
hotstrings("(\d+)\/(\d+)%", "percent") ; try 4/50%
Return

percent:
p := Round($1 / $2 * 100)
Send, %p%`%
Return
