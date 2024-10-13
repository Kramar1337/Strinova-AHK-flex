#NoTrayIcon
#NoEnv
#SingleInstance, Ignore
#KeyHistory 0
ListLines Off
SetBatchLines, -1
SetControlDelay, -1
SendMode Input
DetectHiddenWindows, On

Menu, Tray, Icon, imageres.dll, 230
Menu, Tray, NoStandard
Menu, Tray, Add, Exit, Exiting
Menu, Tray, Default, Exit
Menu, Tray, Icon


Gui, 1: Submit, NoHide
Gui, 1: -Theme +AlwaysOnTop +ToolWindow -Caption +LastFound
Gui, 1: Color, 0xFF0000
Gui, 1: Add, Edit, x24 y50 w98 h21 vEditDir
Gui, 1: Font, Bold
Gui, 1: Font,, FixedSys
Gui, 1: Add, Text, x56 y74 w35 h23 +0x200 -Background, Text
Gui, 1: Show, x950 y550 w142 h100, Coilor-Cooird-v2



; taskbar collision fix
; diğer her yerde fareden doğru kurtulan tooltip, görev çubuğu alttayken kurtulmayıp çakışmadan üste fırlıyor
WinGetPos, x, y, , taskbarheight, ahk_class Shell_TrayWnd
if (x == 0 and y != 0) {
    screenycheck := A_ScreenHeight-taskbarheight-66-16      ; tooltip uzunluğu + tooltip fareden uzaklık
    taskbarbot = 1
}

rgbcolor:=p:=s:=win:=x:=y:=lastwin:=lastx:=lasty:=screenx:=screeny:=0
csave := ClipboardAll        ; script boyunca kullanamayacağımız önceki panoyu kaydedelim


SetTimer, Guncelle, 10        ; 10ms = 100hz - bilmem, iyi gibi
OnExit, Exiting



Guncelle:
    win := WinExist("A")
   ; x ve y screen coordinate değil
    MouseGetPos, x, y
    if (win == lastwin and x == lastx and y == lasty) {
       ; fare değişmedi ve aynı pencere, bir şey yapma
    }
    else {
        if (win != lastwin) {
            WinGet, p, ProcessName
            lastwin := win
        }

        PixelGetColor, rgbcolor , x, y, RGB
        rgbcolor := SubStr(rgbcolor, 3)
        s = %x%, %y% 0x%rgbcolor%

        if (taskbarbot == 1) {
            CoordMode, Mouse, Screen
            MouseGetPos, screenx, screeny
            CoordMode, Mouse, Window
           ; screen.y'yi screen.y.check'te durdur, görev çubuğu'na binmesin
            if (screeny > screenycheck) {
                CoordMode, ToolTip, Screen
                ToolTip, ahk_exe %p%`n%x% %y%`n%rgbcolor%`nF5 to copy 1, screenx+16, screenycheck+16
				Gui, 1: Submit, NoHide
				Gui, 1: Color, 0x%rgbcolor%
				GuiControl,1:, EditDir, 0x%rgbcolor%
                CoordMode, ToolTip, Window
            }
            else
                ToolTip, ahk_exe %p%`n%x% %y%`n%rgbcolor%`nF5 to copy 2
				Gui, 1: Submit, NoHide
				Gui, 1: Color, 0x%rgbcolor%
				GuiControl,1:, EditDir, 0x%rgbcolor%
        }
        else
            ToolTip, ahk_exe %p%`n%x% %y%`n%rgbcolor%`nF5 to copy 3
			Gui, 1: Submit, NoHide
			Gui, 1: Color, 0x%rgbcolor%
			GuiControl,1:, EditDir, 0x%rgbcolor%

        lastx := x
        lasty := y
    }
Return

F5::
clipboard = 0x%rgbcolor%
Return

Exiting:
ExitApp
Return
