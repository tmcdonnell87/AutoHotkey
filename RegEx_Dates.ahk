#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;
; AutoHotkey updating to be used with relative dates ("T", "T+7", etc.)
;
; ***Requires Hotstrings.ahk #included in same launch***
;
;

;include the following in your launch file:
;handle calculation logic
;hotstrings("i)\.(Y|T|M|W|N|H)(\+|\-)([\d]+)(\s)","complexDateLogic")

;handle simple logic: only trigger off certain end chars
; without changing Hotstring Endchars for everyone else (don't want to trigger off of '.t-')
;hotstrings("i)\.(N|T)(\s)","simpleDateLogic")

ComplexDateLogic:
	;unpack variables into locals
	time := A_Now
	type := ""
	char := $1
	sign := $2
	offset := $3
	LASTCHAR := $4  ;override last-char logic, re-send it here
	StringUpper, char, char
	;quit if we're here without the correct assumed variables
	if (char="")
	{
		Return
	}
	if (sign="-") 
	{
		offset*=-1
	}
	if (char="T")
	{
		time += offset, D
		type := "ShortDate"
	}
	else if (char="W")
	{
		time += offset*7, D
		type := "ShortDate"
	}
	else if (char="M")
	{
		years:=Ceil((offset+A_MM)/12)-1
		months := offset-12*years
		time+=(months*100000000)+(years*10000000000)
		type := "ShortDate"
	}
	else if (char="Y")
	{
		time+=(offset*10000000000)
		type := "ShortDate"
	}
	else if (char="N")
	{
		time += offset, M
		type := "Time"
	}
	else if (char="H")
	{
		time += offset, H
		type := "Time"
	}
	;catch any parsing errors
	if (type="")
	{
		MsgBox ERROR: char>%char% | sign>%sign% | offset>%offset% | type>%type%
	}
	if (time < 0)
	{
		MsgBox Cannot display B.C.E. date
		Return
	}
	else
	{
		FormatTime, timeString, %time%, %type%
		SendInput %timeString%%LASTCHAR%
	}
Return

SimpleDateLogic:
	type := ""
	char := $1
	LASTCHAR := $2  ;override last-char logic, re-send it here
	StringUpper, char, char
	if (char="N")
	{
		type := "Time"
	}
	if (char="T")
	{
		type := "ShortDate"
	}
	FormatTime, timeString, %A_Now%, %type%
	SendInput %timeString%%LASTCHAR%
Return

PieceNextDay:
	piece:=SubStr($1,1,3)
	StringUpper, piece, piece
	LASTCHAR:=$6
	if (piece="SUN")
	{
		date:=NextDay(1)
	}
	else if (piece="MON")
	{
		date:=NextDay(2)
	}
	else if (piece="TUE")
	{
		date:=NextDay(3)
	}
	else if (piece="WED")
	{
		date:=NextDay(4)
	}
	else if (piece="THU")
	{
		date:=NextDay(5)
	}
	else if (piece="FRI")
	{
		date:=NextDay(6)
	}
	else if (piece="SAT")
	{
		date:=NextDay(7)
	}
	else
	{
		MsgBox % "Error parsing date:" . $1
		Return
	}
	SendInput %date%%LASTCHAR%
Return

NextDay(day)
{
	if (day<1 OR day>7)
	{
		Return
	}
	offset:=(day-A_WDay)
	time:=A_Now
		If (offset<1)
	{
		offset+=7
	}
	time += offset, D
	FormatTime, timeString, %time%, ShortDate
	Return %timeString%
}


