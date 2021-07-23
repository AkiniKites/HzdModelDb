#SingleInstance, Force
#include lib\common.ahk

hzdPath := "E:\Games\SteamLibrary\steamapps\common\Horizon Zero Dawn\HorizonZeroDawn.exe"
SplitPath, hzdPath ,, hzdDir

if (A_Args.Length() > 0) {
  hzdPath := A_Args[1]
}
if (A_Args.Length() > 1) {
  hzdDir := A_Args[2]
}

;Start hzd
Run, %hzdPath%, %hzdDir%

;Wait for menu
WinWait, ahk_exe HorizonZeroDawn.exe
Sleep, 2000
if (!WaitForImage("..\img\menu.png", 5000, foundX, foundY)) {
  Exit, 1
}

SlowKey("Enter") ;enter game

;wait for load
if (!WaitForImage("..\img\ingame.png", 60000, foundX, foundY)) {
  Exit, 2
}
;wait for fade
Sleep, 2000


if (A_Args.Length() < 2) {
  msgbox, Finished run-hzd
  Exit, 0
}

SlowKey("Esc") ;game menu

;enter photo mode
Loop, 3 {
  SlowKey("Down")
}
SlowKey("Enter")

Sleep, 500
RunWait, arrange-photo.ahk -nowait
Sleep, 500

SlowKey("f", 2500) ;screenshot

;exit
Send !{f4}
Sleep, 500
SlowKey("Enter")

