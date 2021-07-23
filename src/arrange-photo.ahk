#SingleInstance, Force
#include lib\common.ahk

if (A_Args.Length() < 1 or !HasVal(A_Args, "-nowait")) {
  ;Wait for menu
  WinWait, ahk_exe HorizonZeroDawn.exe
  Sleep, 1000
}

ResetPhotoMode() {  
  SlowKey("Esc", 500) ;exit photo mode  
  SlowKey("Enter", 500) ;confirm
  SlowKey("Enter", 500) ;enter photo mode
}

ColorPanLeft(r,g,b) {
  return r > 200 and g > 150 and b > 130
}
ColorPanRight(r,g,b) {
  return r < 130 and g < 100 and b < 100
}
ColorPanDown(r,g,b) {
  return r < 160 and g < 100 and b < 100
}

PanToTarget() {
  Loop, 5 {
    ;pan camera
    RelativeDrag(-1000, 0, 1150)
    Sleep, 50
    
    panLeft := func("ColorPanLeft")
    if (!RelativeDragColor(-1, 0, 10000, 1575, 440, panLeft)) {
      ResetPhotoMode()
      continue
    }
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
  SlowClick(2301, 1232, 200)
}

SlowKey("e") ;goto dof
SlowClick(1872, 908) ;dof off

PanToTarget()

SlowKey("c") ;look at camera
SlowKey("c") ;look at camera off

SlowKey("LCtrl", 100, 200) ;lower camera

SlowClick(2301, 915) ;dof on

if (HasVal(A_Args, "-dof")) {  
  SlowClick(1864, 981) ;4.1m focus
  SlowClick(1960, 1046) ;f2
}

;goto time of day
SlowKey("e")
SlowKey("e")
SlowClick(1986, 920) ;click time of day 8:43

SlowKey("r") ;hide ui

;wait for sun effects
Sleep, 500