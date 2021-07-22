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

ColorPanRight(r,g,b) {
  return r < 40 and g < 40 and b < 40
}
ColorPanDown(r,g,b) {
  ;FileAppend, % r . "," . g . "," . b . "`n", c.txt
  return g < 30 and b < 30
}

PanToTarget() {
  Loop, 5 {
    ;pan camera
    RelativeDrag(1000, 0, 1210)
    Sleep, 50
    panRight := func("ColorPanRight")
    if (!RelativeDragColor(2, 0, 8000, 2497, 473, panRight)) {
      ResetPhotoMode()
      continue
    }

    RelativeDrag(0, -2, 1100)
    Sleep, 50
    panDown := func("ColorPanDown")
    if (!RelativeDragColor(0, -1, 20000, 2461, 671, panDown)) {
      ResetPhotoMode()
      continue
    }

    return true
  }

  return false
}

PanToTarget()

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

if (HasVal(A_Args, "-dof")) {  
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
}

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