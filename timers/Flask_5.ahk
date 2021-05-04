#SingleInstance, Force

IniRead, Start, %A_ScriptDir%\Hotkeys.ini, Hotkeys, Start
IniRead, Stop, %A_ScriptDir%\Hotkeys.ini, Hotkeys, Stop

Hotkey,~%Start%,StartHK
Hotkey,~%Stop%,StopHK

Gui, -MaximizeBox -MinimizeBox

global toggle = false
global timer
global randomizer

Gui, Add, Edit, x0 y0 w70 h20 -VScroll -WantReturn Number Limit5 +Center vflaskTimer5,
Gui, Add, Button, x69 y-1 w32 h22 gOK, OK
Gui, Show, w100 h20, Flask 5
return

GuiClose:
ExitApp

OK:
	GuiControlGet, flaskTimer5
	timer := flaskTimer5
	if (timer < 1000) {
		MsgBox Timer must be between 1000 and 12000
		return
	}
	if (timer > 12000) {
		MsgBox Timer must be between 1000 and 12000
		return
	}
	WinHide, Flask 5

StartHK:
	toggle := true
	runTimer5()
	return

StopHK:
	toggle := false
	return
	
runTimer5() {
	if (WinActive("ahk_class POEWindowClass")) {
		while (toggle) {
			Send, 5
			Random, rand, %timer% - 1500, %timer% + 1500
			Sleep, %rand%
		}
	}
}