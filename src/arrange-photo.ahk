#SingleInstance, Force

MoveMouseRelative(dx,dy) {
	DllCall("mouse_event", "UInt", 0x0001, "Int", dx, "Int", dy, "UInt", 0, "UPtr", 0)
}
RelativeDrag(x, y, t) {
	Click, down right	
	RelativeMove(x, y, t)	
	Click, up right
}

RelativeMove(x, y, t) {
	endTime := A_TickCount + t			
	While (A_TickCount < endTime) {
	
		;hzd limits mouse move speed (1000, will max it)
		MoveMouseRelative(x,y)
        Sleep, 1
    }

    MouseMove, x1, y1, 0
}

if (A_Args.Length() < 1 or A_Args[1] != "-nowait") {
	;Wait for menu
	WinWait, ahk_exe HorizonZeroDawn.exe
	Sleep, 1000
}

;pan camera
RelativeDrag(1000, 0, 1250)
RelativeDrag(0, -50, 50)
Sleep, 50

;lower camera
send {LCtrl down}
Sleep, 200
send {LCtrl up}
Sleep, 100

;goto dof
	Send {e down}
	Sleep, 50
	Send {e up}
	Sleep, 100
	
;dof on
Click, down, 2301, 915
sleep, 50
Click, up
Sleep, 100

;4.1m focus
Click, down, 1864, 981
sleep, 50
Click, up
Sleep, 100

;f2
Click, down, 1960, 1046
sleep, 50
Click, up
Sleep, 100

;goto time of day
Loop, 2 {
	Send {e down}
	Sleep, 50
	Send {e up}
	Sleep, 100
}

;click time of day 8:43
Click, down, 2016, 914
sleep, 50
Click, up
Sleep, 100

;look at camera
Send {c down}
Sleep, 50
Send {c up}
Sleep, 100

;hide ui
Send {r down}
Sleep, 50
Send {r up}
Sleep, 100