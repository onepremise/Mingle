@ECHO off
@setlocal enableextensions enabledelayedexpansion

REM ===========================================================================
REM SETUP PROFILE
REM ===========================================================================

IF EXIST "msys\etc\profile" (
  ECHO.
  ECHO Searching current settings...
  ECHO.
  findstr /I "MINGLE_BASE" msys\etc\profile 2> nul
  if ERRORLEVEL 1 (
     ECHO.
     ECHO Removing old profile...
     ECHO.
     DEL msys\etc\profile
  )
)

IF NOT EXIST "msys\etc\profile" (
    ECHO.
    ECHO "Make Sure Previous PYTHONPATH is cleared and profile is updated..."
    ECHO.
    COPY mingle\profile msys\etc 

    msys\bin\bash -l -c "echo 'export MINGLE_BASE_DOS=%CD%'|sed -e 's/\\\/\\\\\\\/g' -e 's/\\\*$//g' >>/etc/profile"
    msys\bin\bash -l -c "echo 'export MINGLE_BASE_MX=%CD:\=/%'|sed -e 's/\\\/\//g' -e 's/\/$//g' >>/etc/profile"
    msys\bin\bash -l -c "echo 'export MINGLE_BASE=%CD%'|sed -e 's/\([a-xA-X]\):\\\/\/\1\//' -e 's/\\\/\//g' -e 's|\/$||g' >>/etc/profile"
    msys\bin\bash -l -c "echo 'export CURL_CA_BUNDLE=$MINGLE_BASE/mingw64/share/curl/ca-bundle.crt'>>/etc/profile"
    msys\bin\bash -l -c "echo 'export GIT_SSL_CAPATH=$MINGLE_BASE/mingw64/share/curl/ca-bundle.crt'>>/etc/profile"
) ELSE (
    ECHO.
    ECHO "Updating MSYS profile..."
    ECHO.
        
    SET OPATH=%CD%
    SET CPATH=!OPATH:\=/!
    SET NPATH=/!CPATH::=!
    
    msys\bin\bash -l -c "sed -e 's|export MINGLE_BASE_DOS=.*|export MINGLE_BASE_DOS='%CD:\=\\\\\\\\\\\\\\\%'|' -e 's|\\\*$||g' /etc/profile>/etc/profile2"
    ECHO.>>msys\etc\profile2
    msys\bin\bash -l -c "mv /etc/profile2 /etc/profile"
    
    msys\bin\bash -l -c "sed -e 's|export MINGLE_BASE_MX=.*|export MINGLE_BASE_MX='%CD:\=/%'|' -e 's|\/$||g' /etc/profile>/etc/profile2"
    ECHO.>>msys\etc\profile2
    msys\bin\bash -l -c "mv /etc/profile2 /etc/profile"    
    
    msys\bin\bash -l -c "newpath=!NPATH!; sed -e 's|export MINGLE_BASE=.*|export MINGLE_BASE='$newpath'|' -e 's|\/$||g' /etc/profile>/etc/profile2"
    ECHO.>>msys\etc\profile2
    msys\bin\bash -l -c "mv /etc/profile2 /etc/profile"    
)

REM ===========================================================================
REM SETUP FSTAB
REM ===========================================================================
IF NOT EXIST "msys/etc/fstab" (
    ECHO "Setup MSYS fstab..."
	ECHO.
    
    msys\bin\bash -l -c "echo '%CD:\=/%/mingw64' /mingw>/etc/fstab"  
) ELSE (
    ECHO "Updating MSYS fstab..."
	ECHO.

    msys\bin\bash -l -c "newpath=%CD:\=/%/mingw64; sed -e 's|.*\mingw|'$newpath' /mingw|' -e 's|//|/|' /etc/fstab>/etc/fstab2"
    msys\bin\bash -l -c "mv /etc/fstab2 /etc/fstab"
)

REM ===========================================================================
REM UPDATE GIT PATHS
REM ===========================================================================
IF EXIST "mingw64/bin/git.exe" (
    ECHO "Updating git config..."
	ECHO.
	msys\bin\bash -l -c "git config --global http.sslcainfo $GIT_SSL_CAPATH"
    msys\bin\bash -l -c "git config -f $MINGLE_BASE/mingw64/etc/gitconfig http.sslcainfo $GIT_SSL_CAPATH"
)

REM ===========================================================================
REM UPDATE PERL PATHS
REM ===========================================================================
IF EXIST "mingw64/bin/perl.exe" (
    ECHO "Updating perl config.pm and config_heav.pl..."
	ECHO.

    msys\bin\bash -l -c "newpath=%CD:\=\\\\\\\%\\\\\\\mingw64; sed -e 's|\([=; >\x27]*\).:[^:]*\\\*mingw64|\1'$newpath'|g' /mingw/lib/perl/Config.pm > /mingw/lib/perl/Config2.pm"

    msys\bin\bash -l -c "mv /mingw/lib/perl/Config2.pm /mingw/lib/perl/Config.pm"

    msys\bin\bash -l -c "newpath=%CD:\=\\\\\\\%\\\\\\\mingw64; sed -e 's|\([=; >\x27]*\).:[^:]*\\\*mingw64|\1'$newpath'|g' /mingw/lib/perl/Config_heavy.pl > /mingw/lib/perl/Config_heavy2.pl"

    msys\bin\bash -l -c "mv /mingw/lib/perl/Config_heavy2.pl /mingw/lib/perl/Config_heavy.pl"
)

ECHO.

endlocal