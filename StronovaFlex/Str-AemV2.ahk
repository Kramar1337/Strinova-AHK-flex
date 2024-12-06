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
toggle := false ; Переменная для переключения состояния
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
IniRead, key_mode, data\config.ini, Settings, key_mode, F3

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
IniRead, captureRangeDMR, data\config.ini, Settings, AimcaptureRangeDMR, 200
IniRead, circleColor, data\config.ini, Settings, AimcircleColor, 0x5FFF0000
IniRead, thickness, data\config.ini, Settings, Aimthickness, 1
IniRead, Sensitivity, data\config.ini, Settings, AimSensitivity, 0.1
IniRead, EMCol, data\config.ini, Settings, AimEMCol, 0x8D0092
IniRead, ColVn, data\config.ini, Settings, AimColVn, 50
IniRead, EMCol2, data\config.ini, Settings, AimEMCol2, 0xFFB16E
IniRead, ColVn2, data\config.ini, Settings, AimColVn2, 5
IniRead, EMCol3, data\config.ini, Settings, AimEMCol3, 0xDA2D32
IniRead, ColVn3, data\config.ini, Settings, AimColVn3, 5
IniRead, AimOffsetPix, data\config.ini, Settings, AimAimOffsetPix, 5
IniRead, DeadZoneSize, data\config.ini, Settings, DeadZoneSize, 0
IniRead, Fucksiay, data\config.ini, Settings, Fucksiay, 0

NearAimScanL := A_ScreenWidth // 2 - captureRange
NearAimScanT := A_ScreenHeight // 2 - captureRange
NearAimScanR := A_ScreenWidth // 2 + captureRange
NearAimScanB := A_ScreenHeight // 2 + captureRange
Hotkey, *~$%key_aimStart%, Metkakey_start, on
Hotkey, *~$%key_mode%, Metkakey_mode, on

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
			if Toggler1
				game.DrawEllipse(centerX, centerY, captureRangeDMR, captureRangeDMR, circleColor, thickness)
			else
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

Metkakey_mode:
Toggler1 := !Toggler1
if (Toggler1)
{
	NearAimScanL := A_ScreenWidth // 2 - captureRangeDMR
	NearAimScanT := A_ScreenHeight // 2 - captureRangeDMR
	NearAimScanR := A_ScreenWidth // 2 + captureRangeDMR
	NearAimScanB := A_ScreenHeight // 2 + captureRangeDMR
	Tooltip DMR mode (Марксманская винтовка), round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
}
else
{
	NearAimScanL := A_ScreenWidth // 2 - captureRange
	NearAimScanT := A_ScreenHeight // 2 - captureRange
	NearAimScanR := A_ScreenWidth // 2 + captureRange
	NearAimScanB := A_ScreenHeight // 2 + captureRange
	Tooltip AR mode (Автоматическая винтовка), round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
}
sleep 500
Tooltip
Return


Metkakey_start: 
while (GetKeyState(key_aimStart, "P"))
{
	TogglerPixel=0
	PixelSearch, GetAimPixelX, GetAimPixelY, NearAimScanL+1, NearAimScanT+1, NearAimScanR-1, NearAimScanB-1, EMCol3, ColVn3, Fast RGB
	if ErrorLevel = 0
	{
		TogglerPixel=1
	}
    PixelSearch, AimPixelX, AimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, EMCol, ColVn, Fast RGB
    if (ErrorLevel = 0 add TogglerPixel=1)
    {
		if !Toggler1
		{
			if (Abs(AimPixelX - (A_ScreenWidth / 2)) > DeadZoneSize || Abs(AimPixelY - (A_ScreenHeight / 2 + AimOffsetPix)) > DeadZoneSize)
			{
				AimAtTarget(AimPixelX, AimPixelY)
			}
		}
		else
		{
			AimAtTarget(AimPixelX, AimPixelY)
		}
    }
	if Fucksiay
	{
		PixelSearch, AimPixelX, AimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, EMCol2, ColVn2, Fast RGB
		if ErrorLevel = 0
		{
			if !Toggler1
			{
				if (Abs(AimPixelX - (A_ScreenWidth / 2)) > DeadZoneSize || Abs(AimPixelY - (A_ScreenHeight / 2 + AimOffsetPix)) > DeadZoneSize)
				{
					AimAtTarget(AimPixelX, AimPixelY)
				}
			}
			else
			{
				AimAtTarget(AimPixelX, AimPixelY)
			}
		}
	}
}
Return

AimAtTarget(targetX, targetY) {
    global
    centerX := A_ScreenWidth / 2
    centerY := A_ScreenHeight / 2
	
    deltaX := (targetX - centerX)
	if !Toggler1
    deltaY := (targetY - centerY + AimOffsetPix)
	else
	deltaY := (targetY - centerY + 1)
	
    deltaX := Round(deltaX * sensitivity)
    deltaY := Round(deltaY * sensitivity)
    AHI.SendMouseMoveRelative(mouseid, deltaX, deltaY)
}
	; tooltip %deltaX%`n%deltaY%, round(A_ScreenWidth * .5) - 100, round(A_ScreenHeight * .5)

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


