; Ссылка на сканкоды для драйвера
; https://www.rsdn.org/article/asm/keyboard.xml
/*
F4 - OFF - PixelGetColor - PixelSearch

Up - Увеличить радиус захвата
Down - Уменьшить радиус захвата
End - Завершить работу скрипта

*/


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
Menu,Tray, add, Trigger, MetkaMenu2
Menu,Tray, Disable, Trigger
Menu,Tray, Icon, Trigger, shell32.dll,264, 16
Menu,Tray, add
Menu,Tray, add, Reload, MetkaMenu2
Menu,Tray, Icon, Reload, shell32.dll, 239, 16
Menu,Tray, add, Exit, MetkaMenu1
Menu,Tray, Icon, Exit, shell32.dll,28, 16

;======разбросано 5 шт
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"



; =====================================================Main
IniRead, CrosOffsetY, data\config.ini, Settings, CrosOffsetY
IniRead, CrosOffsetX, data\config.ini, Settings, CrosOffsetX
IniRead, key_tr, data\config.ini, Settings, key_tr
IniRead, TrMode, data\config.ini, Settings, TrMode
IniRead, Threshold, data\config.ini, Settings, Threshold
IniRead, ColVn, data\config.ini, Settings, ColVn
IniRead, UseRadius, data\config.ini, Settings, UseRadius
IniRead, MouseXYHandMode, data\config.ini, Settings, MouseXYHandMode
IniRead, MouseXorigin, data\config.ini, Settings, MouseXorigin
IniRead, MouseYorigin, data\config.ini, Settings, MouseYorigin
IniRead, RashodVar, data\config.ini, Settings, RashodVar
IniRead, Color1, data\config.ini, Settings, Color1
IniRead, RashodVarPixelSearch, data\config.ini, Settings, RashodVarPixelSearch
IniRead, HoldFF, data\config.ini, Settings, HoldFF
; =====================================================Сrosshair
IniRead, СrosshairEnable, data\config.ini, Settings, СrosshairEnable
IniRead, CrosSet, data\config.ini, Settings, CrosSet
IniRead, ICrosHandMode, data\config.ini, Settings, ICrosHandMode
IniRead, xCentreGUI, data\config.ini, Settings, xCentreGUI
IniRead, yCentreGUI, data\config.ini, Settings, yCentreGUI
; =====================================================Other
IniRead, WindowFilterUse, data\config.ini, Settings, WindowFilterUse
IniRead, WindowFilter, data\config.ini, Settings, WindowFilter
; =====================================================Security
IniRead, RandomGUIwindowNameEn, data\config.ini, Settings, RandomGUIwindowNameEn
IniRead, ScHachCh, data\config.ini, Settings, ScHachCh
IniRead, ScRenamer, data\config.ini, Settings, ScRenamer
IniRead, InterDriverUse, data\config.ini, Settings, InterDriverUse
IniRead, KeyboardVID, data\config.ini, Settings, KeyboardVID
IniRead, KeyboardPID, data\config.ini, Settings, KeyboardPID
IniRead, MouseVID, data\config.ini, Settings, MouseVID
IniRead, MousePID, data\config.ini, Settings, MousePID

IniRead, key_TrSelect, data\config.ini, Settings, key_TrSelect, F4

Hotkey, *~$%key_tr%, Metkakey_start, on
Hotkey, *~$%key_TrSelect%, MetkakeyTrSelect, on


If ScHachCh
{
	FileRead, FileReadOutputVar1, %A_ScriptFullPath%
	Random, rand1488, 20, 30
	password := gen_password(rand1488)
	1RepFile1 = AntiVACHashChanger:="\w*"
	2RepFile2 = AntiVACHashChanger:="%password%%password%%password%%password%"
	RegExRepFile1 := RegExReplace(FileReadOutputVar1, 1RepFile1, 2RepFile2)
	FileEncoding UTF-8
	FileDelete, %A_ScriptFullPath%
	FileAppend, %RegExRepFile1%, %A_ScriptFullPath%
}
If ScRenamer
{
	Random, rand1488, 10, 14
	password := gen_password(rand1488)										;вызов функции в переменную (длина)
	SplitPath, A_ScriptFullPath,,, 2z2ext,, 	;извлечь из строки расширение
	FileMove, %A_ScriptFullPath%, %A_ScriptDir%\%password%.%2z2ext%
}

;==============================================================Драйвер низкоуровнего ввода
if InterDriverUse
{
	#include %A_ScriptDir%\data\Lib\AutoHotInterception.ahk
	#include %A_ScriptDir%\data\Lib\CLR.ahk

	IniRead, KeyboardVID, %A_ScriptDir%\data\config.ini, Settings, KeyboardVID
	IniRead, KeyboardPID, %A_ScriptDir%\data\config.ini, Settings, KeyboardPID
	IniRead, MouseVID, %A_ScriptDir%\data\config.ini, Settings, MouseVID
	IniRead, MousePID, %A_ScriptDir%\data\config.ini, Settings, MousePID
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
}


if RandomGUIwindowNameEn
{
	Random, rand1488, 30, 35
	RandomGUIwindowName := gen_password(rand1488)
}

If MouseXYHandMode
{
	MouseX := MouseXorigin
	MouseY := MouseYorigin
	1MouseX:=MouseXorigin - RashodVarPixelSearch
	1MouseY:=MouseYorigin - RashodVarPixelSearch
	1MouseX2:=MouseXorigin + RashodVarPixelSearch
	1MouseY2:=MouseYorigin + RashodVarPixelSearch
}
Else
{
	MouseX := round(A_ScreenWidth / 2 - CrosOffsetX)
	MouseY := round(A_ScreenHeight / 2 - CrosOffsetY)
	1MouseX:=MouseX - RashodVarPixelSearch
	1MouseY:=MouseY - RashodVarPixelSearch
	1MouseX2:=MouseX + RashodVarPixelSearch
	1MouseY2:=MouseY + RashodVarPixelSearch
}


;======разбросано 5 шт
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"


; Определить центр и размер изображения
	Gui, 89: -DPIScale
	gui, 89:add, picture, vmypic w%CrosSet% h%CrosSet%, data\Green.png
	GuiControlGet, mypic, 89:Pos
	gui, 89:destroy
	mypicW1:=round(mypicW / 2)
	mypicH1:=round(mypicH / 2)
	xCentre:=round(A_ScreenWidth / 2)
	yCentre:=round(A_ScreenHeight / 2)
	xCentreEX:=xCentre - mypicW1
	yCentreEX:=yCentre - mypicH1
if !(ICrosHandMode)
	{
	;рисовашка гуи
	Gui,1: +AlwaysOnTop +ToolWindow -Caption +LastFound +E0x20 -DPIScale
	WinSet, TransColor, ABC
	Gui,1: Color, ABC
	Gui,1: Add, Picture, x0 y0 w%CrosSet% h%CrosSet% +BackgroundTrans, data\Green.png
	
	if СrosshairEnable
	Gui,1: Show, x%xCentreEX% y%yCentreEX%, %RandomGUIwindowName%
	Else
	Gui,1: Show, Hide x%xCentreEX% y%yCentreEX%, %RandomGUIwindowName%
	
	}
Else
	{
	;рисовашка гуи
	Gui,1: +AlwaysOnTop +ToolWindow -Caption +LastFound +E0x20 -DPIScale
	WinSet, TransColor, ABC
	Gui,1: Color, ABC
	Gui,1: Add, Picture, x0 y0 w%CrosSet% h%CrosSet% +BackgroundTrans, data\Green.png
	
	if СrosshairEnable
	Gui,1: Show, NoActivate x%xCentreGUI% y%yCentreGUI%, %RandomGUIwindowName%
	Else
	Gui,1: Show, Hide NoActivate x%xCentreGUI% y%yCentreGUI%, %RandomGUIwindowName%
	
	}

if WindowFilterUse
SetTimer, ExitOnGameClose, 1000



Return
;=============================================конец основного потока





;======разбросано 5 шт
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

;==============================если окно игры не активно, то скрыть прицел
ExitOnGameClose() {
    global WindowFilter
    IfWinExist, %WindowFilter%
	{
	Gui, 1: Show, NoActivate
	}
    IfWinNotActive, %WindowFilter%
	{
	Gui, 1: Cancel
	}
}



Metkakey_start:
Sleep 1
If WindowFilterUse
{
IfWinNotActive, %WindowFilter%
Return
}
If TrMode = 1
{
	StringSplit, Colorz, Color1
	Color1B = 0x%Colorz3%%Colorz4%
	Color1G = 0x%Colorz5%%Colorz6%
	Color1R = 0x%Colorz7%%Colorz8%
	Color1B += 0
	Color1G += 0
	Color1R += 0
	while (GetKeyState(key_tr, "P"))
		{
			if UseRadius
			{
				RashodVarMin:=0 - RashodVar
				Random, RandomVar1, %RashodVarMin%, %RashodVar%
				Random, RandomVar2, %RashodVarMin%, %RashodVar%
				Random, RandomVar3, 0, 1
				if RandomVar3
				{
				MouseXorigin:=MouseX + RandomVar1
				MouseYorigin:=MouseY + RandomVar2
				}
				Else
				{
				MouseXorigin:=MouseX - RandomVar1
				MouseYorigin:=MouseY - RandomVar2
				}
			}
			Else
			{
				MouseXorigin:=MouseX
				MouseYorigin:=MouseY
			}
			PixelGetColor, Color2, MouseXorigin, MouseYorigin
			StringSplit, Colorz, Color2
			Color2B = 0x%Colorz3%%Colorz4%
			Color2G = 0x%Colorz5%%Colorz6%
			Color2R = 0x%Colorz7%%Colorz8%
			Color2B += 0
			Color2G += 0
			Color2R += 0
			if (Color1R > (Color2R + Threshold)) or (Color1R < (Color2R - Threshold)) or (Color1G > (Color2G + Threshold)) or (Color1G < (Color2G - Threshold)) or (Color1B > (Color2B + Threshold)) or (Color1B < (Color2B - Threshold))
				{
				; MsgBox 0
				}
			Else
				{
					SendInput {Blind}{vk1}
					sleep %HoldFF%
					sleep %HoldFF%
				}
		}
}
If TrMode = 2
{
	while (GetKeyState(key_tr, "P"))
    {
	    PixelSearch,,, 1MouseX, 1MouseY, 1MouseX2, 1MouseY2, Color1, ColVn, Fast RGB
		if ErrorLevel = 0
        {
			SendInput {Blind}{vk1}
			sleep %HoldFF%
        }
	}
}
Return


;======разбросано 5 шт
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"


MetkakeyTrSelect:
    TrMode++
    if (TrMode > 2)  ; Если значение больше 2, сбрасываем на 0
        TrMode := 0
    if TrMode = 0
	{
	ToolTip Off, round(A_ScreenWidth * .5 - 50), round(A_ScreenHeight * .5)
    Sleep, 500
    Tooltip
	}
	if TrMode = 1
	{
	ToolTip 1 - PixlGetColor,round(A_ScreenWidth * .5 - 50), round(A_ScreenHeight * .5)
    Sleep, 500
    Tooltip
	}
	if TrMode = 2
	{
	ToolTip 2 - PixlSearch,round(A_ScreenWidth * .5 - 50), round(A_ScreenHeight * .5)
    Sleep, 500
    Tooltip
	}
return


*~$^Up::
RashodVar+=1
RashodVarPixelSearch+=1
Tooltip RashodVar - %RashodVar%`nRashodVarPixelSearch - %RashodVarPixelSearch%,round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
sleep 350
Tooltip
Return



*~$^Down::
RashodVar-=1
RashodVarPixelSearch-=1
Tooltip RashodVar - %RashodVar%`nRashodVarPixelSearch - %RashodVarPixelSearch%,round(A_ScreenWidth * .5), round(A_ScreenHeight * .5)
sleep 350
Tooltip
Return


;======================================================функция рандома
gen_password(length = 8)																;начало фукции длина пароля по дефолту 8
{																						
	possible = abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890			;переменная с символами
	StringLen, max, possible															;сколько символов в переменной
	if length > %max%																	;если длина пароля больше переменной то выйти
	{																					
		MsgBox, Длина должна быть меньше количества возможных символов.				
		Exit, 40																		
	}																					
	Loop																				;начало петли
	{																					
		Random, rand, 1, max															;зарандомить от 1 до %число символов в переменной %possible%%
		StringMid, char, possible, rand, 1												;извлеч из %possible%(наши символы), номер символа %rand%, кол-во 1, в %char%
		IfNotInString, password, %char%													;повторился ли символ %password% и %char%
		{																				
			password = %password%%char%													;склеить то что было и новый символ
			if StrLen(password) >= length												;если длина строки %password% больше или равна длине %length%
				break																	;выйти из петли
		}																				
	}																					
	return password																		;вернуть сгенерированое значение в переменную
}


;======разбросано 5 шт
AntiVACHashChanger:="fghfh3534gjdgdfgfj6867jhmbdsq4123asddfgdfgaszxxcasdf423dfght7657ghnbnghrtwer32esdfgr65475dgdgdf6867ghjkhji7456wsdfsf34sdfsdf324sdfgdfg453453453456345gdgdgdfsf"

*~$Home::
MetkaMenu2:
Reload
Return
*~$End::
MetkaMenu1:
Exitapp
