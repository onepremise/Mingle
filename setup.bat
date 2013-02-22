@ECHO off

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

if not exist "packages" mkdir packages

ECHO "Set Execution Policy..."
ECHO.

powershell -command "Set-ExecutionPolicy Unrestricted"

set MSYSTOOLS="MSYS-20111123.zip"

if not exist "packages\%MSYSTOOLS%" (
     ECHO "Downloading msys..."
     powershell -command ". .\setuptools\Get-WebFile.ps1; Get-WebFile -url 'http://sourceforge.net/projects/mingw-w64/files/External binary packages (Win64 hosted)/MSYS (32-bit)/%MSYSTOOLS%/download' -fileName 'packages\\%MSYSTOOLS%'"
)

if not exist "packages\%MSYSTOOLS%" (
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

if not exist "packages\%GCCCOMPILER%" (
    ECHO "Downloading %GCCCOMPILER%..."
    powershell -command ". .\setuptools\Get-WebFile.ps1; Get-WebFile -url %GCCURL% -fileName 'packages\\%GCCCOMPILER%'"
)

REM if not exist "packages\%GCCCOMPILERUPDATE%" (
REM     ECHO "Downloading %GCCCOMPILERUPDATE%..."
REM     powershell -command ". .\setuptools\Get-WebFile.ps1; Get-WebFile -url %GCCUPDATEURL% -fileName 'packages\\%GCCCOMPILERUPDATE%'"
REM )

if not exist "packages\%GCCCOMPILER%" (
    ECHO "Failed to download compiler!"
    ECHO.
    EXIT /B 1
)

ECHO "Extracting base tools..."
ECHO.

if not exist "msys" setuptools\unzip packages\MSYS-20111123.zip
if not exist "mingw64" (
    setuptools\7za x packages\%GCCCOMPILER%
REM     setuptools\7za x -y packages\%GCCCOMPILERUPDATE% -ir!*mingw64\x86_64-w64-mingw32*
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


ECHO "Creating shortcut..."
ECHO.

powershell -command ". .\setuptools\createShortcut.ps1; createShortcut -TargetPath '%CD%\msys\msys.bat' -LinkPath '.\msys.lnk'" 

ECHO "Reset Execution Policy..."
ECHO.

powershell -command "Set-ExecutionPolicy Restricted"

ECHO "Setup MSYS..."
ECHO.

msys\bin\bash -l -c "ECHO '%CD%\mingw64' /mingw>/etc/fstab"
if not exist "msys\home\developer" msys\bin\bash -l -c "mkdir /home/developer"

ECHO "Make Sure Previous PYTHONPATH is cleared..."
ECHO.

COPY setuptools\profile msys\etc 

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
    ECHO "Retrieve MASM..."
    
    if not exist "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\x86_amd64" (
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

    copy "C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\mspdb110.dll" mingw64\bin\
    copy "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\x86_amd64\*.*" mingw64\bin\
)

ECHO.
ECHO "Create windows 64bit library directory..."
ECHO.

IF NOT EXIST mingw64\win64bitlibs (
    mkdir mingw64\win64bitlibs
)

ECHO.
ECHO "Copy 64bit system libraries..."
ECHO.

COPY C:\Windows\System32\gdi32.dll mingw64\win64bitlibs /y
COPY C:\Windows\System32\msimg32.dll mingw64\win64bitlibs /y
COPY C:\Windows\System32\ws2_32.dll mingw64\win64bitlibs /y
COPY C:\Windows\System32\crypt32.dll mingw64\win64bitlibs /y
COPY C:\Windows\System32\Wldap32.dll mingw64\win64bitlibs /y

move mingw64\win64bitlibs\gdi32.dll mingw64\win64bitlibs\libgdi32.dll
move mingw64\win64bitlibs\msimg32.dll mingw64\win64bitlibs\libmsimg32
move mingw64\win64bitlibs\ws2_32.dll mingw64\win64bitlibs\libws2_32.dll
move mingw64\win64bitlibs\crypt32.dll mingw64\win64bitlibs\libcrypt32.dll
move mingw64\win64bitlibs\Wldap32.dll mingw64\win64bitlibs\libwldap32.dll

ECHO.
ECHO "Copy build scripts and configs..."
ECHO.

COPY setuptools\mingw.jam msys\home\developer
COPY setuptools\get-dependencies.sh msys\home\developer

IF NOT EXIST "msys\home\developer\patches" MKDIR msys\home\developer\patches
XCOPY /S /Y patches msys\home\developer\patches

ECHO "Build dependencies..."
ECHO.

msys\bin\mintty msys/bin/bash -l -c "cd /home/developer;./get-dependencies.sh 2>&1 | tee build.log"

IF EXIST msys\home\developer\build.log (
    COPY /Y msys\home\developer\build.log .
)

ECHO.
ECHO "Setup Complete."
ECHO.