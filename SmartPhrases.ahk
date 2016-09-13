#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


::.tt::
Send Thanks,{enter}Terry
Return

::.ts::
FormatTime, TimeString, , M/dd/yyyy h:mm tt
Send *TM %TimeString%
Return


::.eom::
	time:=A_Now+100000000
	back:=-A_DD
	EnvAdd, time, %back%, D
	FormatTime, timeString, %time%, ShortDate
	Send %timeString%
Return

:R:.pquestions::Please let me know if you have any questions
:R:.questions::Let me know if you have any questions