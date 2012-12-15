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

if not exist "packages\MSYS-20111123.zip" (
    ECHO "Downloading msys..."
    powershell -command ". .\setuptools\Get-WebFile.ps1; Get-WebFile -url 'http://sourceforge.net/projects/mingw-w64/files/External binary packages (Win64 hosted)/MSYS (32-bit)/MSYS-20111123.zip/download' -fileName 'packages\MSYS-20111123.zip'"
)

if not exist "packages\x86_64-w64-mingw32-gcc-4.7.2-release-win64_rubenvb.7z" (
    ECHO "Downloading x86_64-w64-mingw32-gcc..."
    powershell -command ". .\setuptools\Get-WebFile.ps1; Get-WebFile -url 'http://sourceforge.net/projects/mingw-w64/files/Toolchains targetting Win64/Personal Builds/rubenvb/gcc-4.7-release/x86_64-w64-mingw32-gcc-4.7.2-release-win64_rubenvb.7z/download' -fileName 'packages\x86_64-w64-mingw32-gcc-4.7.2-release-win64_rubenvb.7z'"
)

ECHO "Extracting base tools..."
ECHO.

if not exist "msys" setuptools\unzip packages\MSYS-20111123.zip
if not exist "mingw64" setuptools\7za x packages\x86_64-w64-mingw32-gcc-4.7.2-release-win64_rubenvb.7z

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

copy C:\Windows\System32\gdi32.dll mingw64\win64bitlibs /y
copy C:\Windows\System32\msimg32.dll mingw64\win64bitlibs /y
copy C:\Windows\System32\ws2_32.dll mingw64\win64bitlibs /y
copy C:\Windows\System32\crypt32.dll mingw64\win64bitlibs /y
copy C:\Windows\System32\Wldap32.dll mingw64\win64bitlibs /y

move mingw64\win64bitlibs\gdi32.dll mingw64\win64bitlibs\libgdi32.dll
move mingw64\win64bitlibs\msimg32.dll mingw64\win64bitlibs\libmsimg32
move mingw64\win64bitlibs\ws2_32.dll mingw64\win64bitlibs\libws2_32.dll
move mingw64\win64bitlibs\crypt32.dll mingw64\win64bitlibs\libcrypt32.dll
move mingw64\win64bitlibs\Wldap32.dll mingw64\win64bitlibs\libwldap32.dll

ECHO.
ECHO "Copy build scripts and configs..."
ECHO.

copy setuptools\mingw.jam msys\home\developer
copy setuptools\get-dependencies.sh msys\home\developer

ECHO "Build dependencies..."
ECHO.

msys\bin\mintty msys/bin/bash -l -c "cd /home/developer;./get-dependencies.sh 2>&1 | tee build.log"

IF EXIST msys\home\developer\build.log (
    COPY /Y msys\home\developer\build.log .
)

ECHO.
ECHO "Setup Complete."
ECHO.