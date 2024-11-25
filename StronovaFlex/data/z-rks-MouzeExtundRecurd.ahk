#include %A_ScriptDir%\MouseDelta.ahk
#SingleInstance,Force
SetBatchLines -1
CoordMode, Mouse, Screen
CoordMode, ToolTip, Screen
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
global lastActionTime := 0  ; Глобальная переменная для отслеживания времени
LogFile := A_WorkingDir "\TempRecord.txt"
; Rec := "SetBatchLines -1`nSleep 100`nToolTip ""Playback recording Playback recording %A_ScriptName%"", 0, 0"
Keys := ["d", "a", "w", "s", "space", "RButton", "LButton", "LAlt", "e", "c", "f", "q", "Esc", "Enter"]
States := []
for i, element in Keys
{
    States.Push(0)
}

ToolTip RButton & LButton to start record, round(A_ScreenWidth * .5-50), 0
reckekgo1 = ~RButton & ~LButton
reckekgo2 = ~LButton & ~RButton
Hotkey, %reckekgo1%, ReckekgoLab, on
Hotkey, %reckekgo2%, ReckekgoLab, on
return

ReckekgoLab:
    LastState := 0
    LastTime := A_TickCount
    SetTimer WaitForKey, 1
    Md := new MouseDelta("MouseEvent")
    Md.SetState(1)
	ToolTip "Re. F12 stop", round(A_ScreenWidth * .5), 0
return

EndLabel:
    ToolTip ""
    FileDelete %LogFile%
    ; Rec := Rec "`nFileAppend %A_ScriptName%, %A_WorkingDir%\neednewrun.txt"
    FileAppend %Rec%, %LogFile%
    Run %LogFile%
    Md.Delete()
    Md := ""
ExitApp
return

MouseEvent(MouseID, x := 0, y := 0)
{
    global Rec, LastTime
    t := A_TickCount
    Delay := t - LastTime
    LastTime := t
    if (Delay > 0)
        Rec := Rec "`nSleep " Delay
    Rec := Rec "`nAHI.SendMouseMoveRelative(mouseid, " x " , " y ")"
}

WaitForKey()
{
    global LastState,LastTime,Rec,Keys,States,lastActionTime,currentTime

    if (!GetKeyState("LButton", "P"))  ; Если LButton отпущена
    {
        SetTimer, WaitForKey, Off
        Gosub EndLabel  ; Переход к EndLabel
        return
    }
	
    currentTime := A_TickCount - lastActionTime
    if (currentTime > 100)
    {
        Rec := Rec "`nGetKeyState, SpaceState, vk1, P`nIf SpaceState = U`nreturn"
		; soundbeep
        lastActionTime := A_TickCount  ; Обновляем время последнего действия
    }
	
    wasStateChange := false
    for i, element in Keys
    {
        state := GetKeystate(element)
        if(States[i] != state)
        {
            wasStateChange := true
        }
    }
    if(wasStateChange)
    {
        t := A_TickCount
        Delay := t - LastTime
        LastTime := t
        Rec := Rec "`nSleep " Delay
    }
    for i, element in Keys
    {
        state := GetKeystate(element)
        if(States[i] != state)
        {
            if(state = 1)
            {
                Rec := Rec "`nSend {" element " down}"
            }
            else
            {
                Rec := Rec "`nSend {" element " up}"
            }
            States[i] := state
        }
    }
}

*~$End::
MetkaMenu1:
ExitApp
Return
*~$Home::
MetkaMenu4:
Reload
Return
