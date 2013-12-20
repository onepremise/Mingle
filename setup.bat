@ECHO off

set ORIGINAL_PATH=%CD%

@setlocal enableextensions enabledelayedexpansion
@cd /d "%~dp0"

REM http://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights

set DRIVE=
set PERSIST=1
set ERRORVALUE=0

NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
   ECHO.
   ECHO "Administrator PRIVILEGES Detected!"
   ECHO.
) ELSE (
   ECHO.
   ECHO ##########################################################
   ECHO.
   ECHO.
   ECHO ######## ########  ########   #######  ########  
   ECHO ##       ##     ## ##     ## ##     ## ##     ## 
   ECHO ##       ##     ## ##     ## ##     ## ##     ## 
   ECHO ######   ########  ########  ##     ## ########  
   ECHO ##       ##   ##   ##   ##   ##     ## ##   ##   
   ECHO ##       ##    ##  ##    ##  ##     ## ##    ##  
   ECHO ######## ##     ## ##     ##  #######  ##     ## 
   ECHO.
   ECHO.
   ECHO ####### ERROR: ADMINISTRATOR PRIVILEGES REQUIRED #########
   ECHO This script must be run as administrator to work properly!  
   ECHO If you're seeing this after clicking on a start menu icon, 
   ECHO then right click on the shortcut and select 
   ECHO "Run As Administrator".
   ECHO ##########################################################
   ECHO.
   PAUSE
   EXIT /B 1
)

REM ===========================================================================
REM SET Environment Variables and create the package cache directory
REM ===========================================================================
for /f "delims=" %%i in (mingle\mingle.cfg) do @echo set %%i>>%CD%\mingle_config.bat

if exist mingle_config.bat (
    call mingle_config.bat
    del mingle_config.bat
) else (
    ECHO "Failed to set configuration!"
    ECHO.
    EXIT /B 1
)

if not exist "%MINGLE_CACHE%" (
    mkdir "%MINGLE_CACHE%"
)

REM ===========================================================================
REM SET EXECUTION POLICY
REM ===========================================================================

ECHO "Set Execution Policy..."
ECHO.

powershell -command "Set-ExecutionPolicy Unrestricted"

REM ===========================================================================
REM DOWNLOAD TOOLS
REM ===========================================================================

set MSYSTOOLS="MSYS-20111123.zip"

if not exist "%MINGLE_CACHE%\%MSYSTOOLS%" (
     ECHO "Downloading msys..."
     powershell -command ". .\mingle\Get-WebFile.ps1; Get-WebFile -url 'http://sourceforge.net/projects/mingw-w64/files/External binary packages (Win64 hosted)/MSYS (32-bit)/%MSYSTOOLS%/download' -fileName '%MINGLE_CACHE%\\%MSYSTOOLS%'"
)

if not exist "%MINGLE_CACHE%\%MSYSTOOLS%" (
    ECHO "Failed to download MSYS!"
    ECHO.
    EXIT /B 1
)

REM Best so far.
set GCCCOMPILER=x86_64-w64-mingw32-gcc-4.7.2-release-win64_rubenvb.7z
set GCCURL="'http://sourceforge.net/projects/mingw-w64/files/Toolchains targetting Win64/Personal Builds/rubenvb/gcc-4.7-release/%GCCCOMPILER%/download'"

REM set GCCCOMPILERUPDATE=x86_64-w64-mingw32-mingw-w64-update-trunk-20130115_rubenvb.7z
REM set GCCUPDATEURL="'http://sourceforge.net/projects/mingw-w64/files/Toolchains targetting Win64/Personal Builds/rubenvb/update/%GCCCOMPILERUPDATE%/download'"

REM set GCCCOMPILER=mingw-w64-bin-x86_64-20130104.7z
REM set GCCURL="'http://www.drangon.org/mingw/mirror.php?num=2&fname=mingw-w64-bin-x86_64-20130104.7z'"
                    
REM set GCCCOMPILER=x64-4.7.2-release-posix-sjlj-rev9.7z
REM set GCCURL="'http://sourceforge.net/projects/mingwbuilds/files/host-windows/releases/4.7.2/64-bit/threads-posix/sjlj/%GCCCOMPILER%/download'"

if not exist "%MINGLE_CACHE%\%GCCCOMPILER%" (
    ECHO "Downloading %GCCCOMPILER%..."
    powershell -command ". .\mingle\Get-WebFile.ps1; Get-WebFile -url %GCCURL% -fileName '%MINGLE_CACHE%\\%GCCCOMPILER%'"
)

REM if not exist "packages\%GCCCOMPILERUPDATE%" (
REM     ECHO "Downloading %GCCCOMPILERUPDATE%..."
REM     powershell -command ". .\mingle\Get-WebFile.ps1; Get-WebFile -url %GCCUPDATEURL% -fileName '%MINGLE_CACHE%\\%GCCCOMPILERUPDATE%'"
REM )

if not exist "%MINGLE_CACHE%\%GCCCOMPILER%" (
    ECHO "Failed to download compiler!"
    ECHO.
    EXIT /B 1
)

REM Command tool updates from MSYS2


REM ===========================================================================
REM EXTRACTING TOOLS
REM ===========================================================================

if not exist "msys" (
    ECHO "Extracting MSYS..."
    ECHO.
    mingle\unzip %MINGLE_CACHE%\MSYS-20111123.zip
)

if not exist "mingw64" (
    ECHO "Extracting GCC..."
    ECHO.
    mingle\7za x %MINGLE_CACHE%\%GCCCOMPILER%
REM     mingle\7za x -y %MINGLE_CACHE%\%GCCCOMPILERUPDATE% -ir!*mingw64\x86_64-w64-mingw32*
)

IF EXIST "mingw" (
    MOVE mingw mingw64
)

IF NOT EXIST "mingw64\bin\gcc.exe" (
    ECHO "Failed to install GCC!"
    ECHO.
    EXIT /B 1
)

IF EXIST "mingw64\bin\lib" (
    ECHO Not sure why these python libraries exist in bin. We will remove and reinstall later after we build Python. Otherwise, this will interfere with the msvc lib command.
    DEL /s /Q mingw64\bin\lib
    RMDIR /S /Q mingw64\bin\lib
)

IF EXIST "msys.lnk" (
    DEL msys.lnk
)

ECHO "Creating shortcut..."
ECHO.
powershell -command ". .\mingle\createShortcut.ps1; createShortcut -TargetPath '%CD%\msys\msys.bat' -LinkPath '.\msys.lnk'" 

REM ===========================================================================
REM RESET EXECUTION POLICY
REM ===========================================================================

ECHO "Reset Execution Policy..."
ECHO.

powershell -command "Set-ExecutionPolicy Restricted"

REM ===========================================================================
REM GET BUILD SCRIPTS IN ORDER
REM ===========================================================================
ECHO.
ECHO "Copy build scripts and configs..."
ECHO.

IF NOT EXIST "mingw64\etc" (
    mkdir mingw64\etc
)

IF NOT EXIST "mingw64\lib\mingle" (
    mkdir mingw64\lib\mingle
)

XCOPY /Y /Q /D mingle\mingle.sh mingw64\bin
XCOPY /Y /Q /D /S mingle\mingle\mingle-* mingw64\lib\mingle
XCOPY /Y /Q /D mingle\mingle.cfg mingw64\etc

IF EXIST "mingw64\bin\mingle.sh" (
MOVE /Y mingw64\bin\mingle.sh mingw64\bin\mingle
)

REM ===========================================================================
REM PROCESS ARGUMENTS
REM ===========================================================================
SET "MINGLE_SUITE=0"

:Loop

IF "%1"=="" (
  GOTO Continue
)

IF "%1"=="-p" (
  SET "MINGLE_ALT_PATH=%2"
  ECHO.
  ECHO MINGLE_ALT_PATH=!MINGLE_ALT_PATH!
  ::Shift value
  SHIFT
) ELSE (
  IF "%1"=="-b" GOTO SUBSTDRV
  IF "%1"=="-c" GOTO CONSOLE
  IF "%1"=="-s" GOTO SUITE
  IF "%1"=="-u" GOTO UPDATE
  IF "%1"=="/?" (
    GOTO HELP
  ) ELSE (
    IF "%1"=="" ( 
      GOTO Continue
    ) ELSE (
      GOTO INVALID
    )
  )
)

:NEXTPARAM
SHIFT

GOTO Loop

:HELP
ECHO.
ECHO ===========================================================================
ECHO Mingle - HELP
ECHO ===========================================================================
ECHO.
ECHO This is the Windoes command shell wrapper which deploys the MinGW 64bit 
ECHO development environment. Please select from one of the following options:
ECHO.
ECHO Usage: setup.bat [-s NUM]
ECHO.
ECHO   -p PATH Use alternate path for build.
ECHO   -b Use a substitue drive to reduce path length. Msys has a max path length 
ECHO      of 256, any further and bash configure scripts may crash, causing 
ECHO      stackdumps which are difficult to determine origin.
ECHO   -c Open a console with a subst drive for dev purposes.
ECHO   -u Update configuration.
ECHO   -s NUM Specify a reference number from one of the suites listed below.
ECHO.

msys\bin\bash -l -c "/mingw/bin/mingle -l"

GOTO EXIT

:INVALID

ECHO.
ECHO Invalid Option: %1
ECHO.

SET ERRORVALUE=5

GOTO HELP

:CONSOLE
SET LAUNCH=1

GOTO NEXTPARAM

:SUBSTDRV

call mingle\available-drive.bat> drive.txt

IF ERRORLEVEL 1 (
  ECHO.
  ECHO No drives available!
  ECHO.
  SET ERRORVALUE=6
  GOTO EXIT
)

set /p DRIVE=<drive.txt

echo.
echo Mapping current directory to=%DRIVE%

subst %DRIVE% %CD%

IF ERRORLEVEL 1 (
  ECHO.
  ECHO Failed to subst drive letter, %DRIVE%, for path. Must be in use."
  ECHO.
  SET ERRORVALUE=6
  GOTO EXIT
)

%DRIVE%

echo CD=%CD%

DEL drive.txt

GOTO NEXTPARAM

:SUITE

set MINGLE_SUITE=%2

::Shift value
SHIFT

GOTO NEXTPARAM

:UPDATE

ECHO Updating configuration

GOTO EXIT

REM ===========================================================================
REM CONTINUE
REM ===========================================================================
:Continue

REM ===========================================================================
REM UPDATE PROFILE
REM ===========================================================================
call mingle\update-etc.bat


REM ===========================================================================
REM LAUNCH CONSOLE
REM ===========================================================================
IF DEFINED LAUNCH (
msys\bin\mintty msys/bin/bash -l
REM START "MINGLE" /D "%CD%" msys\bin\bash -l
GOTO EXIT
)

REM ===========================================================================
REM USE SUITE IF PROVIDED
REM ===========================================================================
IF %MINGLE_SUITE% NEQ 0 (
  ECHO.
  ECHO.
  ECHO "Deploying selected development environment (%MINGLE_SUITE%):"
  ECHO.

  msys\bin\bash -l -c "/mingw/bin/mingle -m"

  IF %MINGLE_SUITE% GTR !ERRORLEVEL! (
    ECHO.
    ECHO "Invalid selection^! You can only choose from one of the following:"
    ECHO.
    msys\bin\bash -l -c "cd /mingw/bin;./mingle -l"
    SET ERRORVALUE=7
    GOTO EXIT
  )

  msys\bin\bash -l -c "/mingw/bin/mingle -k %MINGLE_SUITE%"
  ECHO.
)

REM ===========================================================================
REM CHECK FOR VISUAL STUDIO
REM ===========================================================================
ECHO "Checking for Visual Studio 2012 Express for Windows Desktop..."
ECHO.
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VisualStudio\11.0"
ECHO.

if ERRORLEVEL 1 (
ECHO "Please Install Visual Studio 2012 Express for Windows Desktop before proceeding"
ECHO "VS includes MASM, ml64.exe, which is used to build boost libraries."
ECHO.
ECHO "If this is a full prebuilt deployment, and you're not building boost,"
ECHO "you may continue compiling and building projects via gnu gcc and"
ECHO "the included dependencies in this package."
ECHO.
ECHO Visit: http://www.microsoft.com/visualstudio/eng/downloads
ECHO New Link: http://www.microsoft.com/en-us/download/details.aspx?id=34673
ECHO Download the full package. I've had issues with the web install.
ECHO.

pause
)

if not exist "mingw64\bin\ml64.exe" (
    set MLINSTALLED=false
    ECHO "Retrieve MASM..."
  
    IF exist "%VS110COMNTOOLS%..\..\VC\bin\x86_amd64" (
        copy "%VS110COMNTOOLS%..\IDE\mspdb110.dll" mingw64\bin\
        copy "%VS110COMNTOOLS%..\..\VC\bin\x86_amd64\*.*" mingw64\bin\
        set MLINSTALLED=true
    ) ELSE (
        IF exist "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\x86_amd64" (
            copy "C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\mspdb110.dll" mingw64\bin\
            copy "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\x86_amd64\*.*" mingw64\bin\
            set MLINSTALLED=true
        )
    )
    
    if "%MLINSTALLED%" == "false" (
       ECHO.
       ECHO ##########################################################
       ECHO.
       ECHO.
       ECHO ######## ########  ########   #######  ########  
       ECHO ##       ##     ## ##     ## ##     ## ##     ## 
       ECHO ##       ##     ## ##     ## ##     ## ##     ## 
       ECHO ######   ########  ########  ##     ## ########  
       ECHO ##       ##   ##   ##   ##   ##     ## ##   ##   
       ECHO ##       ##    ##  ##    ##  ##     ## ##    ##  
       ECHO ######## ##     ## ##     ##  #######  ##     ## 
       ECHO.
       ECHO.
       ECHO ###### ERROR: VISUAL STUDIO 2012 EXPRESS REQUIRED ########
       ECHO Something is quirky on your machine. Did you not install
       ECHO to the typicl path? You will have to manually copy MASM
       ECHO to your install. Look for the files in your VS2012 install:
       ECHO "Microsoft Visual Studio 11.0\VC\bin\x86_amd64".
       ECHO ##########################################################
       ECHO.
       PAUSE
       EXIT /B 1
    )
)

ECHO.
ECHO "Create windows 64bit library directory..."
ECHO.

IF NOT EXIST mingw64\win64bitlibs (
    mkdir mingw64\win64bitlibs
)

ECHO.
ECHO "Copy 64 bit system libraries..."
ECHO.

COPY %WINDIR%\System32\gdi32.dll mingw64\win64bitlibs /y
COPY %WINDIR%\System32\msimg32.dll mingw64\win64bitlibs /y
COPY %WINDIR%\System32\ws2_32.dll mingw64\win64bitlibs /y
COPY %WINDIR%\System32\crypt32.dll mingw64\win64bitlibs /y
COPY %WINDIR%\System32\Wldap32.dll mingw64\win64bitlibs /y

move mingw64\win64bitlibs\gdi32.dll mingw64\win64bitlibs\libgdi32.dll
move mingw64\win64bitlibs\msimg32.dll mingw64\win64bitlibs\libmsimg32.dll
move mingw64\win64bitlibs\ws2_32.dll mingw64\win64bitlibs\libws2_32.dll
move mingw64\win64bitlibs\crypt32.dll mingw64\win64bitlibs\libcrypt32.dll
move mingw64\win64bitlibs\Wldap32.dll mingw64\win64bitlibs\libwldap32.dll


ECHO.
ECHO "Copy 32 bit system libraries..."
ECHO.

IF NOT EXIST mingw64\win32bitlibs (
    mkdir mingw64\win32bitlibs
)

COPY %WINDIR%\SysWOW64\gdi32.dll mingw64\win32bitlibs /y
COPY %WINDIR%\SysWOW64\msimg32.dll mingw64\win32bitlibs /y
COPY %WINDIR%\SysWOW64\ws2_32.dll mingw64\win32bitlibs /y
COPY %WINDIR%\SysWOW64\crypt32.dll mingw64\win32bitlibs /y
COPY %WINDIR%\SysWOW64\Wldap32.dll mingw64\win32bitlibs /y

move mingw64\win32bitlibs\gdi32.dll mingw64\win32bitlibs\libgdi32.dll
move mingw64\win32bitlibs\msimg32.dll mingw64\win32bitlibs\libmsimg32.dll
move mingw64\win32bitlibs\ws2_32.dll mingw64\win32bitlibs\libws2_32.dll
move mingw64\win32bitlibs\crypt32.dll mingw64\win32bitlibs\libcrypt32.dll
move mingw64\win32bitlibs\Wldap32.dll mingw64\win32bitlibs\libwldap32.dll

REM ===========================================================================
REM STARTBUILD
REM ===========================================================================
ECHO.
ECHO "Getting Started..."
ECHO.

SET ERRL=0
SET ERROR_CHECK=0
SET "MINGLE_PATH_OPTION="

IF DEFINED MINGLE_ALT_PATH (
    set "MINGLE_BUILD_DIR=%MINGLE_BUILD_DIR%"
    set "MINGLE_PATH_OPTION=--path=%MINGLE_ALT_PATH:\=/%"
    ECHO MINGLE_PATH_OPTION=!MINGLE_PATH_OPTION!
)

if not exist "msys%MINGLE_BUILD_DIR%" (
    ECHO Creating build directory: "msys%MINGLE_BUILD_DIR%"...
    mkdir "msys%MINGLE_BUILD_DIR%"
)

IF %MINGLE_SUITE% EQU 0 (
    msys\bin\mintty -e msys/bin/bash -l -c "/mingw/bin/mingle %MINGLE_PATH_OPTION% 2>&1 | tee %MINGLE_BUILD_DIR%/build.log"
) ELSE (
    msys\bin\bash -l -c "/mingw/bin/mingle %MINGLE_PATH_OPTION% --suite=%MINGLE_SUITE% 2>&1 | tee %MINGLE_BUILD_DIR%/build.log"
)

REM ===========================================================================
REM ERROR HANDLER
REM ===========================================================================
set ERRL=!ERRORLEVEL!
set ERR_MSG="Error: %ERRL%, Failed to execute mingle!"

IF %ERRL% NEQ 0 set ERROR_CHECK=1

IF DEFINED MINGLE_ALT_PATH (
    IF EXIST "%MINGLE_ALT_PATH%\mingle_error.log" (
        set ERROR_CHECK=1
    )
) ELSE (
    SET MINGLE_ALT_PATH="msys\%MINGLE_BUILD_DIR%"
    IF EXIST "msys%MINGLE_BUILD_DIR%\mingle_error.log" (
        set ERROR_CHECK=1
    )
)

IF %ERROR_CHECK% EQU 1 (
    CD /D %MINGLE_ALT_PATH:/=\%"
    
    FOR /F "eol=; tokens=1,2,3* delims=," %%i in (mingle_error.log) do (
        set ERRD=%%i
        set ERRL=%%j
        set ERR_MSG=%%k
    )
    
    CD /D "%ORIGINAL_PATH%"
    
    SET ERRORVALUE=!ERRL:"=!
    
    ECHO.
    ECHO DATE = !ERRD!
    ECHO ERROR = !ERRORVALUE!
    ECHO MESSAGE = !ERR_MSG!
    
    GOTO EXIT
)

IF EXIST msys%MINGLE_BUILD_DIR:/=\%\build.log (
    COPY /Y msys%MINGLE_BUILD_DIR:/=\%\build.log .
)

ECHO.
ECHO "Setup Complete."
ECHO.

REM ===========================================================================
REM EXIT AND RETURN STATUS
REM ===========================================================================
:EXIT

cd /D "%ORIGINAL_PATH%"

subst %DRIVE% /D > nul

call mingle\update-etc.bat

EXIT /B %ERRORVALUE%

endlocal
