#include Gdip_All.ahk

global MouseMoveSleep := 10

MoveMouseRelative(dx,dy) {
  DllCall("mouse_event", "UInt", 0x0001, "Int", dx, "Int", dy, "UInt", 0, "UPtr", 0)
}

RelativeDrag(x, y, t) {
  Click, down right

  endTime := A_TickCount + t      
  While (A_TickCount < endTime) {
    ;hzd has weird mouse speed locking
    MoveMouseRelative(x,y)
    Sleep, %MouseMoveSleep%
  }

  Click, up right
}

RelativeDragColor(x, y, t, px, py, verifyColor) {
  Click, down right
        
  endTime := A_TickCount + t      
  While (A_TickCount < endTime) {
    ;hzd has weird mouse speed locking
    MoveMouseRelative(x,y)
    Sleep, %MouseMoveSleep%

    PixelGetColor, targetColor, px, py, RGB
    tr := format("{:d}","0x" . substr(targetColor,3,2))
    tg := format("{:d}","0x" . substr(targetColor,5,2))
    tb := format("{:d}","0x" . substr(targetColor,7,2))

    if (verifyColor.call(tr, tg, tb)) {
      Click, up right
      return true
    }
  }
  
  Click, up right
  return false
}

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

HasVal(arr, val) {
  if !(IsObject(arr)) || (arr.Length() = 0)
    return 0
  for index, value in arr {
    if (value = val) {
      return index
    }
  }
  return 0
}

ScreenCapture(x,y,w,h,f) {
  pToken := Gdip_Startup()
  snap := Gdip_BitmapFromScreen( x "|" y "|" w "|" h )
  Gdip_SaveBitmapToFile(snap, f)
  Gdip_DisposeImage(snap)
}

SlowKey(key, ms:=50) {
  Send {%key% down}
  Sleep, %ms%
  Send {%key% up}
  Sleep, 100
}

SlowClick(x, y, ms:=50) {
  Click, down, %x%, %y%
  Sleep, %ms%
  Click, up
  Sleep, 100
}