#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#j::
InputBox, UserInput, Jira Issue
if ErrorLevel
    Return
else
	if(not InStr(UserInput, "-")){
		UserInput = AP-%UserInput%
	}
	else {
		StringUpper, UserInput, UserInput
	}
    SendInput https://syapse.atlassian.net/browse/%UserInput%
Return

::.webex::https://syapse.webex.com/join/terry

::.conf::650 479 3208,,802259762#

