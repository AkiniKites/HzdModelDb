WaitForImage(img, timeout, byref foundX, byref foundY)
{	
	WinGetActiveStats, tmp0, winW, winH, _, _
	
	loop % timeout / 200
	{
		ImageSearch, foundX, foundY, 0, 0, winW, winH, *50 %img%
		if (ErrorLevel = 0) {
			return true
		}
		Sleep, 200
	}
	return false
}

;Start hzd
Run, %1%, %2%

;Wait for menu
WinWait, ahk_exe HorizonZeroDawn.exe
Sleep, 2000
if (!WaitForImage("..\img\menu.png", 5000, foundX, foundY)) {
	Exit, 1
}

;enter game
Send {Enter down}
Sleep, 50
Send {Enter up}

;wait for load
if (!WaitForImage("..\img\ingame.png", 60000, foundX, foundY)) {
	Exit, 2
}
;wait for fade
Sleep, 2000

;jump to reset pos
Send {Space down}
Sleep, 50
Send {Space up}
Sleep, 2000

;game menu
Send {Esc down}
Sleep, 50
Send {Esc up}
Sleep, 100

;enter photo mode
Loop, 3 {
	Send {Down down}
	Sleep, 50
	Send {Down up}
	Sleep, 100
}

Send {Enter down}
Sleep, 50
Send {Enter up}
Sleep, 100

Sleep, 500
RunWait, setup-photo.ahk

Sleep, 500
Send {f down}
Sleep, 50
Send {f up}
Sleep, 2500

;exit
Send !{f4}
Sleep, 500
Send {Enter down}
Sleep, 50
Send {Enter up}
Sleep, 100

