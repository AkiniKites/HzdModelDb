SetWorkingDir %A_ScriptDir%
#SingleInstance, Force

global modelsFile := "..\data\models.txt"
global imagesDir := "..\db\"
hzdScreens := % A_MyDocuments . "\Horizon Zero Dawn\Screenshots"
hzdPath := "E:\Games\SteamLibrary\steamapps\common\Horizon Zero Dawn\HorizonZeroDawn.exe"
aaPath := "E:\Projects\AloysAdjustments\src\AloysAdjustments\bin\Debug\AloysAdjustments.exe"
aaOutput := "E:\Projects\AloysAdjustments\src\AloysAdjustments\bin\Debug\output.txt"

totalOutfits := 138

SplitPath, hzdPath ,, hzdDir
SplitPath, aaPath ,, aaDir

ReadModels() {
  models := Array()
  Loop, read, % modelsFile
  {
    if (!instr(A_LoopReadLine, "#") and Trim(A_LoopReadLine)) {
      models.Push(A_LoopReadLine)
    }
  }
  return %models%
}

GetCompleted() {
  complete := Object()
  Loop, files, % imagesDir . "*.png" 
  {
    SplitPath, A_LoopFileName,,,,name
    complete[name] := 1
  }
  return %complete%
}

;Delete existing screens
FileDelete, %hzdScreens%\*

complete := GetCompleted()
models := ReadModels()

Loop, % models.Length()
{
  name := models[A_Index]
  if complete[name] != 1 {
    ;apply patch
    RunWait, %aaPath% --patch --cmd "Misc" i "Outfits" %name%, %aaDir%

    Sleep, 500

    ;take screen
    RunWait, run-hzd.ahk "%hzdPath%" "%hzdDir%"

    ;copy screen
    Loop, %hzdScreens%\* {
      FileCreateDir, ..\db
      FileMove, %A_LoopFilePath%, % "..\db\" . name . ".png", 1
    }

    FileDelete, %hzdScreens%\*
    complete[name] := 1

    Process, WaitClose, HorizonZeroDawn.exe
    Sleep, 1000
  }
}
