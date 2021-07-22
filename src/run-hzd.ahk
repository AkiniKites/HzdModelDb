#SingleInstance, Force
#include common.ahk

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

if (%0% < 2) {
  msgbox, Finished run-hzd
  Exit, 0
}

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
RunWait, arrange-photo.ahk -nowait

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

