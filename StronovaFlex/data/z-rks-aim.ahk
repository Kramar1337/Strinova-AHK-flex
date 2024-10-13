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

#include %A_ScriptDir%\Lib\AutoHotInterception.ahk
#include %A_ScriptDir%\Lib\CLR.ahk
IniRead, KeyboardVID, %A_ScriptDir%\config.ini, Settings, KeyboardVID
IniRead, KeyboardPID, %A_ScriptDir%\config.ini, Settings, KeyboardPID
IniRead, MouseVID, %A_ScriptDir%\config.ini, Settings, MouseVID
IniRead, MousePID, %A_ScriptDir%\config.ini, Settings, MousePID
IniRead, WindowFilter, %A_ScriptDir%\config.ini, Settings, WindowFilter


SetFormat, IntegerFast, hex
KeyboardVID += 0
KeyboardPID += 0
MouseVID += 0
MousePID += 0
SetFormat, IntegerFast, d
Global AHI := new AutoHotInterception()
Global mouseid := AHI.GetMouseId(MouseVID, MousePID)
Global keyboardid := AHI.GetKeyboardId(KeyboardVID, KeyboardPID)
Sensitivity := 0.1
AimOffsetPix = 0
EMCol := 0xDCE9F4
ColVn := 20
captureRange = 100
NearAimScanL := A_ScreenWidth // 2 - captureRange
NearAimScanT := A_ScreenHeight // 2 - captureRange
NearAimScanR := A_ScreenWidth // 2 + captureRange
NearAimScanB := A_ScreenHeight // 2 + captureRange
Return



*~$LButton::
Sleep 1
IfWinNotActive, %WindowFilter%
return
if FuncCursorVisible()
	Return
while (GetKeyState("LButton", "P"))
{
; msgbox 1
    PixelSearch, AimPixelX, AimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, EMCol, ColVn, Fast RGB
    if ErrorLevel=0
	{
        AimAtTarget(AimPixelX, AimPixelY + AimOffsetPix)
    }
}
Return

AimAtTarget(targetX, targetY) {
    global
    centerX := A_ScreenWidth / 2
    centerY := A_ScreenHeight / 2
    deltaX := (targetX - centerX)
    deltaY := (targetY - centerY)
    deltaX := deltaX * sensitivity
    deltaY := deltaY * sensitivity
    MoveMouseBy(deltaX, deltaY)
}
MoveMouseBy(deltaX, deltaY) {
    global
    deltaX := Round(deltaX)
    deltaY := Round(deltaY)
	AHI.SendMouseMoveRelative(mouseid, deltaX, deltaY)
}

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

*~$End::
MetkaMenu1:
ExitApp
Return
*~$Home::
MetkaMenu4:
Reload
Return
