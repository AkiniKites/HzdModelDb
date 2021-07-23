#SingleInstance, Force
#include common.ahk

if (A_Args.Length() < 1 or !HasVal(A_Args, "-nowait")) {
  ;Wait for menu
  WinWait, ahk_exe HorizonZeroDawn.exe
  Sleep, 1000
}

ResetPhotoMode() {
  ;exit photo mode
  Send {Esc down}
  Sleep, 50
  Send {Esc up}
  Sleep, 500

  ;enter photo mode
  Send {Enter down}
  Sleep, 50
  Send {Enter up}
  Sleep, 500
  
  ;enter photo mode
  Send {Enter down}
  Sleep, 50
  Send {Enter up}
  Sleep, 500
}

global ii := 0
ColorPanRight(r,g,b) {
  ;ii++
  ;FileAppend, % ii "-" r "," g "," b "`n", c.txt
  ;ScreenCapture(1575-5,440-5,11,11, "debug\" ii ".png")
  return r < 130 and g < 100 and b < 100
}
ColorPanDown(r,g,b) {
  ;ii++
  ;FileAppend, % ii "-" r "," g "," b "`n", c.txt
  ;ScreenCapture(1575-5,440-5,11,11, "debug\" ii ".png")
  return r < 160 and g < 100 and b < 100
}

PanToTarget() {
  Loop, 5 {
    ;pan camera
    RelativeDrag(-1000, 0, 1150)
    Sleep, 50
    panRight := func("ColorPanRight")
    if (!RelativeDragColor(1, 0, 15000, 1575, 440, panRight)) {
      ResetPhotoMode()
      continue
    }

    RelativeDrag(0, -2, 2000)
    Sleep, 50
    panDown := func("ColorPanDown")
    if (!RelativeDragColor(0, -1, 5000, 1575, 682, panDown)) {
      ResetPhotoMode()
      continue
    }

    return true
  }

  return false
}

;goto pose
Loop, 2 {
  Click, down, 2301, 1232
  sleep, 50
  Click, up
  Sleep, 200
}

;goto dof
Send {e down}
Sleep, 50
Send {e up}
Sleep, 100

;dof off
Click, down, 1872, 908
sleep, 50
Click, up
Sleep, 100

PanToTarget()

;look at camera
Send {c down}
Sleep, 50
Send {c up}
Sleep, 100

;look at camera off
Send {c down}
Sleep, 50
Send {c up}
Sleep, 100

;lower camera
send {LCtrl down}
Sleep, 200
send {LCtrl up}
Sleep, 100

;dof on
Click, down, 2301, 915
sleep, 50
Click, up
Sleep, 100

if (HasVal(A_Args, "-dof")) {  
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
}

;goto time of day
Loop, 2 {
  Send {e down}
  Sleep, 50
  Send {e up}
  Sleep, 100
}

;click time of day 8:43
Click, down, 1986, 920
sleep, 50
Click, up
Sleep, 100

;hide ui
Send {r down}
Sleep, 50
Send {r up}
Sleep, 100

Sleep, 100