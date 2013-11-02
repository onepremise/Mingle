@ECHO off
@setlocal enableextensions enabledelayedexpansion
REM ===========================================================================
REM SETUP PROFILE
REM ===========================================================================
findstr /I "MINGLE_BASE" msys\etc\profile 2> nul
if ERRORLEVEL 1 (
   ECHO.
   ECHO Removing old profile...
   ECHO.
   DEL msys\etc\profile
)

IF NOT EXIST "msys\etc\profile" (
    ECHO.
    ECHO "Make Sure Previous PYTHONPATH is cleared and profile is updated..."
    ECHO.
    COPY mingle\profile msys\etc 

    msys\bin\bash -l -c "echo 'export MINGLE_BASE=%CD%'|sed -e 's/\([a-xA-X]\):\\\/\/\1\//' -e 's/\\\/\//g'>>/etc/profile"
    msys\bin\bash -l -c "echo 'export CURL_CA_BUNDLE=$MINGLE_BASE/mingw64/share/curl/ca-bundle.crt'>>/etc/profile"
    msys\bin\bash -l -c "echo 'export GIT_SSL_CAPATH=$MINGLE_BASE/mingw64/share/curl/ca-bundle.crt'>>/etc/profile"
) ELSE (
    ECHO.
    ECHO "Updating MSYS profile..."
    ECHO.
    msys\bin\bash -l -c "newpath=%CD:\=/%; sed 's|export MINGLE_BASE=.*|export MINGLE_BASE='$newpath'|' /etc/profile>/etc/profile2"
    ECHO.>>msys\etc\profile2
    msys\bin\bash -l -c "mv /etc/profile2 /etc/profile"    
)

REM ===========================================================================
REM SETUP FSTAB
REM ===========================================================================
IF NOT EXIST "msys/etc/fstab" (
    ECHO "Setup MSYS fstab..."
    
    msys\bin\bash -l -c "echo '%CD:\=/%/mingw64' /mingw>/etc/fstab"  
) ELSE (
    ECHO "Updating MSYS fstab..."

    msys\bin\bash -l -c "newpath=%CD:\=/%/mingw64; sed 's|.*\mingw|'$newpath' \/mingw|' /etc/fstab>/etc/fstab2"
    msys\bin\bash -l -c "mv /etc/fstab2 /etc/fstab"
)

endlocal