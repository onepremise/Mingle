@ECHO off

@setlocal enableextensions enabledelayedexpansion
@cd /d "%~dp0"

REM http://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights

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
for /f "delims=" %%i in (mingle\mingle.cfg) do @echo set %%i>>mingle_config.bat

if exist mingle_config.bat (
    call mingle_config.bat
    del mingle_config.bat
) else (
    ECHO "Failed to set configuration!"
    ECHO.
    EXIT /B 1
)

if not exist "%MINGLE_CACHE%" (
    mkdir %MINGLE_CACHE%
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

IF NOT EXIST "msys.lnk" (
ECHO "Creating shortcut..."
ECHO.
powershell -command ". .\mingle\createShortcut.ps1; createShortcut -TargetPath '%CD%\msys\msys.bat' -LinkPath '.\msys.lnk'" 
)

REM ===========================================================================
REM RESET EXECUTION POLICY
REM ===========================================================================

ECHO "Reset Execution Policy..."
ECHO.

powershell -command "Set-ExecutionPolicy Restricted"

REM ===========================================================================
REM SETUP FSTAB
REM ===========================================================================
IF NOT EXIST "msys/etc/fstab" (
    ECHO "Setup MSYS fstab..."
    
    msys\bin\bash -l -c "ECHO '%CD%\mingw64' /mingw>/etc/fstab"
    if not exist "msys\home\developer" mkdir "%CD%\msys\home\developer"  
) ELSE (
    ECHO "Updating MSYS fstab..."
    msys\bin\bash -l -c "newpath=%CD:\=/%/mingw64; sed 's|.*\mingw|'$newpath' \/mingw|' /etc/fstab>/etc/fstab2"
    msys\bin\bash -l -c "mv /etc/fstab2 /etc/fstab"
)

ECHO.
ECHO "Make Sure Previous PYTHONPATH is cleared..."
ECHO.

COPY mingle\profile msys\etc 

msys\bin\bash -l -c "echo \"export MINGLE_BASE=%CD%\"|sed -e 's/\([a-xA-X]\):\\\/\/\1\//' -e 's/\\\/\//g'>>/etc/profile"

REM ===========================================================================
REM GET BUILD SCRIPTS IN ORDER
REM ===========================================================================
ECHO.
ECHO "Copy build scripts and configs..."
ECHO.

IF NOT EXIST "mingw64\etc" (
    mkdir mingw64\etc
)

XCOPY /Y /Q /D mingle\mingle.sh mingw64\bin
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
  SHIFT
) ELSE (
  IF "%1"=="-s" GOTO SUITE
  IF "%1"=="/?" (
    GOTO HELP
  ) ELSE (
    GOTO INVALID
  )
)

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
ECHO   -s NUM Specify a reference number from one of the suites listed below.
ECHO.

msys\bin\bash -l -c "/mingw/bin/mingle -l"

GOTO EXIT

:INVALID

ECHO.
ECHO Invalid Option: %1
ECHO.

GOTO HELP

:SUITE

set MINGLE_SUITE=%2

ECHO.
ECHO.
ECHO Deploying selected development environment (%MINGLE_SUITE%):
ECHO.

msys\bin\bash -l -c "/mingw/bin/mingle -m %MINGLE_SUITE%"

IF %MINGLE_SUITE% GTR %ERRORLEVEL% (
ECHO.
ECHO Invalid selection! You can only choose from one of the following:
ECHO.
msys\bin\bash -l -c "cd /mingw/bin;./mingle -l"
GOTO EXIT
)

msys\bin\bash -l -c "/mingw/bin/mingle -k %MINGLE_SUITE%"
ECHO.

GOTO Continue

REM ===========================================================================
REM CONTINUE
REM ===========================================================================
:Continue

ECHO "Checking for Visual Studio 2012 Express for Windows Desktop..."
ECHO.
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VisualStudio\11.0"
ECHO.

if ERRORLEVEL 1 (
ECHO "Please Install Visual Studio 2012 Express for Windows Desktop before proceeding"
ECHO "VS includes MASM, ml64.exe, which is used to build boost libraries."

ECHO Visit: http://www.microsoft.com/visualstudio/eng/downloads
ECHO Direct Link: http://go.microsoft.com/?linkid=9816758
ECHO.

pause
EXIT /B 1
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
    set "MINGLE_PATH_OPTION=--path=%MINGLE_ALT_PATH:\=/%"
    ECHO MINGLE_PATH_OPTION=!MINGLE_PATH_OPTION!
)

IF %MINGLE_SUITE% EQU 0 (
    msys\bin\mintty msys/bin/bash -l -c "/mingw/bin/mingle %MINGLE_PATH_OPTION% | tee %MINGLE_BUILD_DIR%/build.log"
) ELSE (
    msys\bin\bash -l -c "/mingw/bin/mingle %MINGLE_PATH_OPTION% --suite=%MINGLE_SUITE% 2>&1 | tee %MINGLE_BUILD_DIR%/build.log"
)

set ERRL=%ERRORLEVEL%
set ERR_MSG="Error: %ERRL%, Failed to execute mingle!"

IF %ERRL% NEQ 0 set ERROR_CHECK=1
IF EXIST "msys\home\developer\mingle_error.log" (
    set ERROR_CHECK=1
    FOR /F "eol=; tokens=1,2* delims=," %%i in (msys\home\developer\mingle_error.log) do (
        set ERRL=%%i
        set ERR_MSG=%%j
    )
)

IF %ERROR_CHECK% EQU 1 (
    ECHO %ERRL% %ERR_MSG%
    EXIT /B 55
   
)

IF EXIST msys\home\developer\build.log (
    COPY /Y msys\home\developer\build.log .
)

ECHO.
ECHO "Setup Complete."
ECHO.

:EXIT
@endlocal