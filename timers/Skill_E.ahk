#SingleInstance, Force

IniRead, Start, %A_ScriptDir%\Hotkeys.ini, Hotkeys, Start
IniRead, Stop, %A_ScriptDir%\Hotkeys.ini, Hotkeys, Stop

Hotkey,~%Start%,StartHK
Hotkey,~%Stop%,StopHK

Gui, -MaximizeBox -MinimizeBox

global toggle = false
global timer
global randomizer

Gui, Add, Edit, x0 y0 w70 h20 -VScroll -WantReturn Number Limit5 +Center vskillTimerE,
Gui, Add, Button, x69 y-1 w32 h22 gOK, OK
Gui, Show, w100 h20, Skill E
return

GuiClose:
ExitApp

OK:
	GuiControlGet, skillTimerE
	timer := skillTimerE
	if (timer < 1000) {
		MsgBox Timer must be between 1000 and 30000
		return
	}
	if (timer > 30000) {
		MsgBox Timer must be between 1000 and 30000
		return
	}
	WinHide, Skill E

StartHK:
	toggle := true
	runTimerE()
	return

StopHK:
	toggle := false
	return
	
runTimerE() {
	if (WinActive("ahk_class POEWindowClass")) {
		while (toggle) {
			Send, E
			Random, rand, %timer% - 1500, %timer% + 1500
			Sleep, %rand%
		}
	}
}