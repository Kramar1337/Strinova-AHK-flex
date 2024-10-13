﻿SetWorkingDir %A_WorkingDir%
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
Menu,Tray, add, Macros, MetkaMenu2
Menu,Tray, Disable, Macros
Menu,Tray, Icon, Macros, shell32.dll,264, 16
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
IniRead, WindowFilter, data\config.ini, Settings, WindowFilter
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
return

*~$R::
Sleep 1
IfWinNotActive, %WindowFilter%
return
if FuncCursorVisible()
return
AHI.SendKeyEvent(keyboardId, 0x1D, 1) 	;0x1D код нажатия "P" Make (HEX)
sleep 1
AHI.SendKeyEvent(keyboardId, 0x1D, 0) 	;0x1D код отпускания "P" Break (HEX)
return



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
