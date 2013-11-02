@ECHO off
setlocal enabledelayedexpansion

set string=M:O:P:S:T:W:X:Y:Z
set substdrives=
set netwkdrives=

FOR /F "tokens=1 delims==> " %%A IN ('SUBST') DO (
    set "value=%%A"
    set "substdrives=!substdrives! !value:~0,2!"
)

for /f "tokens=2" %%G IN ('net use ^| FINDSTR /R /C:"OK.*[A-Z]: "') do (
    set "netwkdrives=!netwkdrives! %%G"
)

IF not "%substdrives%"=="" (
  set substdrives=!substdrives:~1!
)

IF not "%netwkdrives%" == "" (
  set netwkdrives=!netwkdrives:~1!
)

set "alldrives=%substdrives% %netwkdrives%"

for %%x in (%string::= %) do (
  set "test=%%x:"

  echo !alldrives! | findstr "!test!" 1>nul

  if ERRORLEVEL 1 (
    echo !test!
    exit /B 0
  )
  
)

exit /B 0