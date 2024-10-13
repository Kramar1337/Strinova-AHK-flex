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
Menu,Tray, add, AIM, MetkaMenu2
Menu,Tray, Disable, AIM
Menu,Tray, Icon, AIM, shell32.dll,264, 16
Menu,Tray, add
Menu,Tray, add, Reload, MetkaMenu2
Menu,Tray, Icon, Reload, shell32.dll, 239, 16
Menu,Tray, add, Exit, MetkaMenu1
Menu,Tray, Icon, Exit, shell32.dll,28, 16

;======разбросано 5 шт
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

#include %A_ScriptDir%\data\ShinsOverlayClass.ahk
#include %A_ScriptDir%\data\Lib\AutoHotInterception.ahk
#include %A_ScriptDir%\data\Lib\CLR.ahk
IniRead, KeyboardVID, %A_ScriptDir%\data\config.ini, Settings, KeyboardVID
IniRead, KeyboardPID, %A_ScriptDir%\data\config.ini, Settings, KeyboardPID
IniRead, MouseVID, %A_ScriptDir%\data\config.ini, Settings, MouseVID
IniRead, MousePID, %A_ScriptDir%\data\config.ini, Settings, MousePID
IniRead, WindowFilter, data\config.ini, Settings, WindowFilter
IniRead, key_aimStart, data\config.ini, Settings, key_aimStart, V


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

IniRead, AimuseEllipse, data\config.ini, Settings, AimuseEllipse, 1
if AimuseEllipse
{
	Gui, 1: new, +hwndNewGuiID2
	game := new ShinsOverlayClass(0,0,A_ScreenWidth,A_ScreenHeight, "1", "1", "1",, NewGuiID2)
}

centerX := A_ScreenWidth / 2
centerY := A_ScreenHeight / 2


IniRead, captureRange, data\config.ini, Settings, AimcaptureRange, 100
IniRead, circleColor, data\config.ini, Settings, AimcircleColor, 0x5FFF0000
IniRead, thickness, data\config.ini, Settings, Aimthickness, 1
IniRead, Sensitivity, data\config.ini, Settings, AimSensitivity, 0.1
IniRead, AimOffsetPix, data\config.ini, Settings, AimAimOffsetPix, 30
IniRead, EMCol, data\config.ini, Settings, AimEMCol, 0x8D0092
IniRead, ColVn, data\config.ini, Settings, AimColVn, 50
IniRead, SdeltaS, data\config.ini, Settings, SdeltaS, 0


; captureRange := 100
; circleColor := 0x5FFF0000
; thickness := 1

; Sensitivity := 0.1
; AimOffsetPix = 30
; EMCol := 0x8D0092
; ColVn := 50
NearAimScanL := A_ScreenWidth // 2 - captureRange
NearAimScanT := A_ScreenHeight // 2 - captureRange
NearAimScanR := A_ScreenWidth // 2 + captureRange
NearAimScanB := A_ScreenHeight // 2 + captureRange
Hotkey, *~$%key_aimStart%, Metkakey_start, on

if AimuseEllipse
SetTimer, OnGameClose, 1000
Return


;==============================если окно игры не активно, то скрыть прицел
OnGameClose()
{
    global
    IfWinActive, %WindowFilter%
	{
		if !FuncCursorVisible()
		{
			game.BeginDraw()
			game.DrawEllipse(centerX, centerY, captureRange, captureRange, circleColor, thickness)
			game.EndDraw()
		}
		else
		{
			game.BeginDraw()
			game.EndDraw()
		}
	}
	else
	{
		game.BeginDraw()
		game.EndDraw()
	}
}



Metkakey_start:
while (GetKeyState(key_aimStart, "P"))
{
	; Sleep 1
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
	if (deltaX < 0)
	deltaX -= SdeltaS
	if (deltaX > 0)
	deltaX += SdeltaS
	; ToolTip %deltaX%`n%deltaY%, round(A_ScreenWidth * .5 - 50), round(A_ScreenHeight * .5)
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

*~$Home::
MetkaMenu2:
Reload
Return
*~$End::
MetkaMenu1:
Exitapp


