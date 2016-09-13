#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;
; RegEx 
;
hotstrings("i)\.(Y|T|M|W|N|H)(\+|\-)([\d]+)(\D)","ComplexDateLogic")
hotstrings("i)\.(N|T)(\s)","SimpleDateLogic")
hotstrings("i)\.(sun|mon|tues?|wed(nes)?|thu(rs)?|fri|sat(ur)?)(day)?(\W)","PieceNextDay")

#include Hotstrings.ahk
#include RegEx_Dates.ahk

;
; Code shortcuts
;


;
; Misc.
;
#include AutoCorrect.ahk
#include SmartPhrases.ahk


;
; Local-specific
;
#include Syapse.ahk


Return 

;
; Clipboard
;
^#v::                            ; Text–only paste from ClipBoard 
   Clip0 = %ClipBoardAll% 
   ClipBoard = %ClipBoard%       ; Convert to text 
   Send ^v                       ; For best compatibility: SendPlay 
   Sleep 50                      ; Don't change clipboard while it is pasted! (Sleep > 0) 
   ClipBoard = %Clip0%           ; Restore original ClipBoard 
   VarSetCapacity(Clip0, 0)      ; Free memory 
Return

^#return::
Send ^c
Run %clipboard%
