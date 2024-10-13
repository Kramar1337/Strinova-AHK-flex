SetWorkingDir %A_WorkingDir%
#SingleInstance force
DetectHiddenWindows On
Process, Priority,, High
SendMode Input
Setbatchlines,-1
SetKeyDelay,-1, -1
SetControlDelay, -1
SetMouseDelay, -1
SetWinDelay,-1
CoordMode, Mouse, Screen
CoordMode, ToolTip, Screen
#NoEnv


CommandLine := DllCall("GetCommandLine", "Str")
If !(A_IsAdmin || RegExMatch(CommandLine, " /restart(?!\S)")) 
{
    Try 
	{
        If (A_IsCompiled) 
		{
            Run *RunAs "%A_ScriptFullPath%" /restart
        }
		Else 
		{
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
    }
    ExitApp
}

Menu,Tray, Icon, %A_ScriptDir%\data\icon.ico
Menu,Tray, NoStandard
Menu,Tray, DeleteAll
Menu,Tray, add, RCS, MetkaMenu2
Menu,Tray, Disable, RCS
Menu,Tray, Icon, RCS, shell32.dll,264, 16
Menu,Tray, add
Menu,Tray, add, Reload, MetkaMenu2
Menu,Tray, Icon, Reload, shell32.dll, 239, 16
Menu,Tray, add, Exit, MetkaMenu1
Menu,Tray, Icon, Exit, shell32.dll,28, 16

;======разбросано 5 шт
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

#include %A_ScriptDir%\data\Lib\AutoHotInterception.ahk
#include %A_ScriptDir%\data\Lib\CLR.ahk
IniRead, KeyboardVID, %A_ScriptDir%\data\config.ini, Settings, KeyboardVID
IniRead, KeyboardPID, %A_ScriptDir%\data\config.ini, Settings, KeyboardPID
IniRead, MouseVID, %A_ScriptDir%\data\config.ini, Settings, MouseVID
IniRead, MousePID, %A_ScriptDir%\data\config.ini, Settings, MousePID
IniRead, DefaultSelectRCS, data\config.ini, Settings, DefaultSelectRCS
IniRead, RCSinclude, data\config.ini, Settings, RCSinclude

;=============================конвертируем айдишники из десятичной в хекс
SetFormat, IntegerFast, hex
KeyboardVID += 0
KeyboardPID += 0
MouseVID += 0
MousePID += 0
SetFormat, IntegerFast, d
Global AHI := new AutoHotInterception()
Global mouseid := AHI.GetMouseId(MouseVID, MousePID)
Global keyboardid := AHI.GetKeyboardId(KeyboardVID, KeyboardPID)
SetMacroValue = 43
Loop %SetMacroValue%
{
	IndexVarL := A_Index - 1
	jopa%IndexVarL% := false
}
jopa%DefaultSelectRCS%:=true
reckekgo1 = ~RButton & ~LButton
reckekgo2 = ~LButton & ~RButton
Hotkey, %reckekgo1%, ReckekgoLab, on
Hotkey, %reckekgo2%, ReckekgoLab, on

Return



ReckekgoLab:
if FuncCursorVisible() 	;Если есть курсор то возврат
	Return
if jopa1
{
if RCSinclude
{
#include %A_ScriptDir%\data\RCSinclude\Numpad1.ahk
}
Else
{
	Loop
	{
		Sleep 1
		if A_Index < 30
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		else if A_Index < 60
		AHI.SendMouseMoveRelative(mouseid, 0, 1)
		else
		AHI.SendMouseMoveRelative(mouseid, 0, 1)
		GetKeyState, SpaceState, vk1, P
		If SpaceState = U
			break
	}
}
}
if jopa2
{
if RCSinclude
{
#include %A_ScriptDir%\data\RCSinclude\Numpad2.ahk
}
Else
{
	Sleep 100
	Loop
	{
		Sleep 1
		if A_Index < 30
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		else if A_Index < 60
		AHI.SendMouseMoveRelative(mouseid, 0, 1)
		else
		AHI.SendMouseMoveRelative(mouseid, 0, 1)
		GetKeyState, SpaceState, vk1, P
		If SpaceState = U
			break
	}
}
}
if jopa3
{
; if RCSinclude
; {
; #include %A_ScriptDir%\data\RCSinclude\Numpad3.ahk
; }
; Else
; {
	Loop
	{
		if A_Index < 30
		AHI.SendMouseMoveRelative(mouseid, 0, 4)
		else if A_Index < 60
		AHI.SendMouseMoveRelative(mouseid, 0, 5)
		else
		AHI.SendMouseMoveRelative(mouseid, 0, 4)
		SendInput, {vk1 down}
		Sleep 1
		SendInput, {vk1 up}
		Sleep 1
		GetKeyState, SpaceState, vk1, P
		If SpaceState = U
			break
	}
; }
}
if jopa4
{
if RCSinclude
{
#include %A_ScriptDir%\data\RCSinclude\Numpad4.ahk
}
Else
{
	Sleep 100
	Loop
	{
		Sleep 1
		if A_Index < 30
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		else if A_Index < 60
		AHI.SendMouseMoveRelative(mouseid, 0, 1)
		else
		AHI.SendMouseMoveRelative(mouseid, 0, 1)
		GetKeyState, SpaceState, vk1, P
		If SpaceState = U
			break
	}
}
; Флавия(Соло) jopa2
}
if jopa5
{
if RCSinclude
{
#include %A_ScriptDir%\data\RCSinclude\Numpad5.ahk
}
Else
{
	Loop
	{
		Sleep 1
		if A_Index < 30
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		else if A_Index < 60
		AHI.SendMouseMoveRelative(mouseid, 0, 3)
		else
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		GetKeyState, SpaceState, vk1, P
		If SpaceState = U
			break
	}
}
}
if jopa6
{
if RCSinclude
{
#include %A_ScriptDir%\data\RCSinclude\Numpad6.ahk
}
Else
{
	Loop
	{
		Sleep 1
		if A_Index < 30
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		else if A_Index < 60
		AHI.SendMouseMoveRelative(mouseid, 0, 3)
		else
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		GetKeyState, SpaceState, vk1, P
		If SpaceState = U
			break
	}
}
; Мередит (Сокол) Ауг jopa5
}
if jopa7
{
if RCSinclude
{
#include %A_ScriptDir%\data\RCSinclude\Numpad7.ahk
}
Else
{
	Loop
	{
		Sleep 1
		if A_Index < 30
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		else if A_Index < 60
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		else
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		GetKeyState, SpaceState, vk1, P
		If SpaceState = U
			break
	}
}
}
if jopa8
{
if RCSinclude
{
#include %A_ScriptDir%\data\RCSinclude\Numpad8.ahk
}
Else
{
	Sleep 50
	Loop
	{
		Sleep 1
		if A_Index < 30
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		else if A_Index < 60
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		else
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		GetKeyState, SpaceState, vk1, P
		If SpaceState = U
			break
	}
}
}
if jopa9
{
if RCSinclude
{
#include %A_ScriptDir%\data\RCSinclude\Numpad9.ahk
}
Else
{
	Loop
	{
		Sleep 1
		if A_Index < 30
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		else if A_Index < 60
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		else
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		GetKeyState, SpaceState, vk1, P
		If SpaceState = U
			break
	}
}
}
if jopa10
{
if RCSinclude
{
#include %A_ScriptDir%\data\RCSinclude\NumpadAdd.ahk
}
Else
{
	Loop
	{
		Sleep 1
		if A_Index < 30
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		else if A_Index < 60
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		else
		AHI.SendMouseMoveRelative(mouseid, 0, 2)
		GetKeyState, SpaceState, vk1, P
		If SpaceState = U
			break
	}
}
}
Return



;Бинды================================================================
*~$Numpad0::
Gosub, PutkinoOtrisanie
jopa0:=true
ToolTip Off, round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
Sleep 800
ToolTip
Return
*~$Numpad1::
Gosub, PutkinoOtrisanie
jopa1:=true
ToolTip Мишель (Инспектор), round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
Sleep 800
ToolTip
Return
*~$Numpad2::
Gosub, PutkinoOtrisanie
jopa2:=true
ToolTip Ивет (ГОООООЛ!!!), round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
Sleep 800
ToolTip
Return
*~$Numpad3::
Gosub, PutkinoOtrisanie
jopa3:=true
ToolTip Нобунага (Судья)`nМаддалена (Хрома), round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
Sleep 800
ToolTip
Return
*~$Numpad4::
Gosub, PutkinoOtrisanie
jopa4:=true
ToolTip Флавия (Соло), round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
Sleep 800
ToolTip
Return
*~$Numpad5::
Gosub, PutkinoOtrisanie
jopa5:=true
ToolTip Мин (Мятежное пламя) АК47, round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
Sleep 800
ToolTip
Return
*~$Numpad6::
Gosub, PutkinoOtrisanie
jopa6:=true
ToolTip Мередит (Сокол) Ауг, round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
Sleep 800
ToolTip
Return
*~$Numpad7::
Gosub, PutkinoOtrisanie
jopa7:=true
ToolTip Лоуин (Тень), round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
Sleep 800
ToolTip
Return
*~$Numpad8::
Gosub, PutkinoOtrisanie
jopa8:=true
ToolTip Селестия (БиПолярная звезда), round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
Sleep 800
ToolTip
Return
*~$Numpad9::
Gosub, PutkinoOtrisanie
jopa9:=true
ToolTip Одри (Чемпион) M249, round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
Sleep 800
ToolTip
Return
*~$NumpadAdd::
Gosub, PutkinoOtrisanie
jopa10:=true
ToolTip Фуксия (Зубец), round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
Sleep 800
ToolTip
Return

PutkinoOtrisanie:
Loop %SetMacroValue%
{
	IndexVarL := A_Index - 1
	jopa%IndexVarL% := false
}
Return





;==========================================Функция: есть курсор мышки - 1, нет курсора - 0
FuncCursorVisible()
{
	StructSize1337 := A_PtrSize + 16
	VarSetCapacity(InfoStruct1337, StructSize1337)
	NumPut(StructSize1337, InfoStruct1337)
	DllCall("GetCursorInfo", UInt, &InfoStruct1337)
	Result1337 := NumGet(InfoStruct1337, 8)
	if (Result1337 <> 0)
		CursorVisible := 1
	Else
		CursorVisible := 0
	Return CursorVisible
}


*~$Home::
MetkaMenu2:
Reload
Return
*~$End::
MetkaMenu1:
Exitapp




