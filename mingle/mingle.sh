#!/bin/bash
#
#  Author:       Jason Huntley
#  Email:        onepremise@gmail.com
#  Description:  MinGW 64bit AutoDeploy script
#
#  Change Log
#
#  Date                   Description                 Initials
#-------------------------------------------------------------
#  12-11-12             Initial Coding                  JAH
#
#=============================================================
if [ -e $MINGLE_BASE/mingle/mingle/api/mingle-api.sh ]; then
    source $MINGLE_BASE/mingle/mingle/api/mingle-api.sh
elif [ -e /mingw/lib/mingle/api/mingle-api.sh ]; then
    source /mingw/lib/mingle/api/mingle-api.sh
else
    echo
    echo ERROR: Unable to find mingle-api, required to build and install packages!
    echo
    exit 9999
fi

#export POSTGIS_PATH=/mingw/var/lib/postgres/$AD_POSTGRES_VERSION/main
export POSTGIS_PATH=/g/var/lib/postgres/$AD_POSTGRES_VERSION/main

mingleSourceValidation() {
    mingleLog "Validating Syntax..."
    
    exit 0
}

updateGCC() {
    if [ ! -e /mingw/x86_64-w64-mingw32/include/gcc-mingw.patch ]; then
        mingleLog "Updating GCC..." true

        cp $MINGLE_BASE/patches/gcc/gcc-mingw.patch /mingw/x86_64-w64-mingw32/include

        ad_cd /mingw/x86_64-w64-mingw32/include
        
        ad_patch "gcc-mingw.patch"
        
        ad_cd "$MINGLE_BUILD_DIR"

        sed 's/\(template<class Q>\)/\/\/\1/g' /mingw/x86_64-w64-mingw32/include/unknwn.h > unknwn.h
        mv unknwn.h /mingw/x86_64-w64-mingw32/include/unknwn.h || mingleError $? "Failed to update GCC, aborting!"

        ad_cd "$MINGLE_BUILD_DIR"
    fi
}

updateFindCommand() {
    if [ ! -e $MINGLE_BASE/msys/bin/find.exe ]; then
      mingleLog "Update Find Command..." true
      #mingleDownload "http://sourceforge.net/projects/mingw/files/MSYS/Base/findutils/findutils-4.4.2-2/findutils-4.4.2-2-msys-1.0.13-bin.tar.lzma/download" "findutils-4.4.2-2-msys-1.0.13-bin.tar.lzma"
      cp $MINGLE_BASE/mingle/bin/find.exe /bin || mingleError $? "failed to copy find, aborting!"
      cp $MINGLE_BASE/mingle/bin/xargs.exe /bin || mingleError $? "failed to xargs find, aborting!"
    fi
}

#experimental
updateTarCommand() {
    if ad_isDateNewerThanFileModTime "2013-01-01" "/mingw/bin/tar.exe"; then
        mingleAutoBuild  "tar" "1.26" "http://ftp.gnu.org/gnu/tar/tar-1.26.tar.gz" "" "tar-*" true true false false "" true true "" "" "tar.exe" "" "tar --version"
    else
        mingleLog "TAR is up to date." true
    fi
}


install7Zip() {
    local _version="920"
    local _versionpath="9.20"
    
    if ! 7za &> /dev/null; then
        mingleLog "Installing 7zip..." true
        
        mingleCategoryDownload "7zip" "$_version" "http://sourceforge.net/projects/sevenzip/files/7-Zip/$_versionpath/7za$_version.zip/download" "7za$_version.zip"
        
        ad_cd "$MINGLE_BUILD_DIR"
        
        ad_mkdir 7zip
        
        mingleCategoryDecompress "7zip" "$_version" "7za$_version.*" "7zip"
        
        ad_cd 7zip
    
        cp 7z* /bin || mingleError $? "failed to copy 7zip, aborting!"
        
        ad_cd "$MINGLE_BUILD_DIR"
    else
        mingleLog "7zip Already Installed." true
    fi
}

updateMake() {
    mingleLog "Updating Make..." true

    local _projectName="make"
    local _version="3.82.90-20111115"
    local _projectSearchName="make-$_version*"
    local _url="ftp://www.mirrorservice.org/sites/downloads.sourceforge.net/m/mi/mingw-w64/External%20binary%20packages%20(Win64%20hosted)/make/make-$_version.zip"
    local _target="make-$_version.zip"

    if ad_isDateNewerThanFileModTime "2014-01-01" "/bin/make.exe"; then
        mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
        mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"
        
        cp -rf $_projectSearchName/bin_amd64/* /mingw/bin
        #cp -rf $_project/bin_ix86 /bin
    else
        mingleLog "Make is up to date." true
    fi 
}

buildInstallLibMingle() {
    ad_cd "$MINGLE_BUILD_DIR"
    mingleLog "Checking for binary libmingle.a..." true
    if [ ! -e "/mingw/lib/libmingle.a" ]; then
        mingleLog "Installing libmingle..."
        cp -rf $MINGLE_BASE/mingle/libmingle .
        buildInstallGeneric "libmingle" false true false false "" false false "" "" "libmingle.a" "" ""
    fi
}

buildInstallDLFCN() {
    local _projectName="dlfcn-win32"
    local _version="r19"
    local _url="https://dlfcn-win32.googlecode.com/files/dlfcn-win32-${_version}.tar.bz2"
    local _target=""
    local _projectSearchName="dlfcn-win32*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=false #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--enable-shared"
    local _makeParameters=""
    local _binCheck="libdl.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallUniString() {
    local _projectName="libunistring"
    local _version="0.9.3"
    local _url="http://ftp.gnu.org/gnu/libunistring/libunistring-${_version}.tar.gz"
    local _target=""
    local _projectSearchName="libunistring-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=false #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libunistring.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleLog "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_projectName..." true
         
        ad_setDefaultEnv

        mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
        mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"

        local _projectdir=$(ad_getDirFromWC "$_projectSearchName")
        
        ad_cd "$_projectdir"

        ./autogen.sh --skip-gnulib
         
        mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    else
        mingleLog "$_projectName Already Installed." true
    fi
}

buildInstallLibFFI() {
    local _projectName="libffi"
    local _version="3.1"
    local _url="ftp://sourceware.org/pub/libffi/libffi-${_version}.tar.gz"
    local _target=""
    local _projectSearchName="libffi-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=true #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libffi.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallAtomicOps() {
    local _projectName="libatomic_ops"
    local _version="7_2f"
    local _url="https://github.com/ivmai/libatomic_ops/archive/libatomic_ops-${_version}.tar.gz"
    local _target=""
    local _projectSearchName="libatomic_ops-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libatomic_ops.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallBDWGC() {
    local _projectName="bdwgc"
    # local _version="7_2f"
    # local _version="7_4_2"
    local _version="7.5.0-dev"
    local _url="https://github.com/ivmai/bdwgc/archive/b41c6771a3405eb9074651a7638639edbf662245.zip"
    # local _url="https://github.com/ivmai/bdwgc/archive/gc${_version}.tar.gz"
    local _target="bdwgc-${_version}.zip"
    local _projectSearchName="bdwgc-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--enable-cplusplus --enable-threads=pthreads --enable-thread-local-alloc --enable-parallel-mark"
    local _makeParameters=""
    local _binCheck="libgc.a"
    local _postBuildCommand=""
    local _exeToTest=""
    
    mingleLog "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_projectName..." true
        
        ad_setDefaultEnv
        
        export "CFLAGS=-I/mingw/include -D_WIN64 -D__WIN64 -DMS_WIN64 -D__MINGW32__ -O2 -DSKIP_THREADKEY_TEST"
        export "CPPFLAGS=-I/mingw/include -D_WIN64 -D__WIN64 -DMS_WIN64 -D__MINGW32__ -O2 -DSKIP_THREADKEY_TEST"
        export "CXXFLAGS=$CPPFLAGS"        
   
        mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
        mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"
        local _projectdir=$(ad_getDirFromWC $_projectSearchName)
       
        ad_cd "$_projectdir"
        if [ ! -e $_projectName-mingw.patch ]; then
           cp $MINGLE_BASE/patches/$_projectName/$_version/$_projectName-mingw.patch .
           ad_patch "$_projectName-mingw.patch"    
        fi
        
        mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    else
        mingleLog "$_projectName Already Installed." true
    fi
}

#
#  GDB Notes:
#  Given a SCM value v, you can usually type
#  (gdb) call gdb_print(filename)
#  (gdb) print gdb_output
#
buildInstallGuile() {
    local _projectName="guile"
    
    local _version="2.0.11"
    #local _version="2.1.0.1118-b9a5-dirty"
    #local _version="2.1.0-dev"
    #local _version="2.0.7.182-e9381"
    #local _url="http://hydra.nixos.org/build/13488741/download/4/guile-${_version}.tar.xz"
    #local _url="http://git.savannah.gnu.org/cgit/guile.git/snapshot/guile-c6a7930b38a55aa2402f4ed722a4ef460ad67810.tar.gz"
    # local _url="ftp://ftp.gnu.org/gnu/guile/guile-${_version}.tar.gz"
    local _url="http://wingolog.org/priv/guile-${_version}.tar.gz"
    
    local _target="guile-${_version}.tar.gz"
    local _projectSearchName="guile-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=true #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--disable-debug-malloc --disable-guile-debug --disable-error-on-warning --disable-rpath --enable-deprecated --enable-networking --enable-nls --enable-posix --enable-regex --disable-static --with-libunistring-prefix=/mingw"
    local _makeParameters="V=1"
    local _binCheck="libguile.a"
    local _postBuildCommand=""
    local _exeToTest=""
    
    mingleLog "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_projectName..." true
        
        ad_setDefaultEnv
        
        # -DSCM_DEBUG_TYPING_STRICTNESS=2
        # -DSCM_DEBUG_PAIR_ACCESSES=1
        # -DSCM_DEBUG=1
        export "CFLAGS=-I/mingw/include -D__MINGW32__ -g -mms-bitfields"
        export "CPPFLAGS=-I/mingw/include -D__MINGW32__ -g -mms-bitfields"  
        
        export "CXXFLAGS=$CPPFLAGS"
        export "GUILE_SYSTEM_PATH=$MINGLE_BUILD_DIR/guile-$_version/module"
   
        mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
        mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"
        local _projectdir=$(ad_getDirFromWC $_projectSearchName)
       
        ad_cd "$_projectdir"
        if [ ! -e $_projectName-mingw.patch ]; then
           cp $MINGLE_BASE/patches/$_projectName/$_version/$_projectName-mingw.patch .
           ad_patch "$_projectName-mingw.patch"
           mkdir ./lib/mingle
           cp -f $MINGLE_BASE/mingle/libmingle/include/mingle/config.h ./lib/mingle
           cp -f $MINGLE_BASE/mingle/libmingle/include/mingw-path.h ./lib
           cp -f $MINGLE_BASE/mingle/libmingle/include/c-string-manip.h ./lib
           cp -f $MINGLE_BASE/mingle/libmingle/pathconversion.c ./lib
           cp -f $MINGLE_BASE/mingle/libmingle/c-string-manip.c ./lib
           cp -f $MINGLE_BASE/mingle/libmingle/include/filename.h ./lib
           cp -f $MINGLE_BASE/mingle/libmingle/realpath.c ./lib
           cp -f $MINGLE_BASE/mingle/libmingle/realloc.c ./lib
        fi
        
        mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    else
        mingleLog "$_projectName Already Installed." true
    fi
}

buildInstallMake() {
    local _projectName="make"
    local _version="4.0"
    local _url="http://ftp.gnu.org/gnu/make/make-${_version}.tar.gz"
    local _target=""
    local _projectSearchName="make-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="make"
    local _postBuildCommand=""
    local _exeToTest="make --version"
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_projectName..." true
        
        ad_setDefaultEnv
        
        export "CFLAGS=-I/mingw/include -D_WIN64 -D__WIN64 -DMS_WIN64 -DWIN32 -DWINDOWS32 -Ofast"
        export "CPPFLAGS=-I/mingw/include -D_WIN64 -D__WIN64 -DMS_WIN64 -DWIN32 -DWINDOWS32 -O2"
        export "CXXFLAGS=$CPPFLAGS"
        #export "LIBS=$LIBS -L/mingw/lib -lmingle -lws2_32"
        #export "CC=x86_64-w64-mingw32-gcc -I/mingw/include/mingle"
        # export "CXX=x86_64-w64-mingw32-gcc -I/mingw/include/mingle"
        export "LIBS=-Lw32 -lw32 $LIBS"
        export "CC=x86_64-w64-mingw32-gcc -Iw32/include"
        export "CXX=x86_64-w64-mingw32-gcc -Iw32/include"
        
        mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
        mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"

        local _projectdir=$(ad_getDirFromWC "$_projectSearchName")
    
    ad_cd $_projectdir/w32
    
    ./configure $(ad_get_config_options)
    
    make || mingleError $? "make failed, aborting!"
    
    ad_cd ".."
    
        mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    else
        mingleLog "$_project Already Installed." true
    fi
    
    ad_run_test "$_exeToTest"
}

buildInstallSomething() {
    local _projectName=""
    local _version=""
    local _url=""
    local _target=""
    local _projectSearchName=""
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck=""
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallM4() {
    local _projectName="m4"
    local _version="1.4.16"
    local _url="http://ftp.gnu.org/gnu/m4/m4-$_version.tar.xz"
    local _target=""
    local _projectSearchName="m4-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="m4"
    local _postBuildCommand=""
    local _exeToTest="m4 --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallAutoconf() {
    export "M4=/bin/m4"

    local _projectName="autoconf"
    local _version="2.69"
    local _url="http://ftp.gnu.org/gnu/autoconf/autoconf-$_version.tar.gz"
    local _target=""
    local _projectSearchName="autoconf-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="autoconf"
    local _postBuildCommand=""
    local _exeToTest="autoconf --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallAutoMake() {
    local _projectName="automake"
    local _version="1.12.5"
    local _url="http://ftp.gnu.org/gnu/automake/automake-$_version.tar.gz"
    local _target=""
    local _projectSearchName="automake-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="automake"
    local _postBuildCommand=""
    local _exeToTest="automake --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    
    cp -rf $MINGLE_BASE/patches/automake/share/*.m4 /mingw/share/aclocal-1.12 || mingleError $? "failed to copy m4 includes, aborting!"
}

buildInstallGMP() {
    ad_clearEnv
    
    export "CFLAGS=-Ofast -funroll-all-loops"
    export "CPPFLAGS=$CFLAGS"
    
    local _projectName="gmp"
    local _version="5.1.2"
    local _url="ftp://ftp.gmplib.org/pub/gmp-$_version/gmp-$_version.tar.xz"
    local _target=""
    local _projectSearchName="gmp-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--enable-cxx"
    local _makeParameters=""
    local _binCheck="libgmp.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"      
}

buildInstallMPFR() {
    local _projectName="mpfr"
    local _version="3.1.2"
    local _url="http://www.mpfr.org/mpfr-current/mpfr-$_version.tar.xz"
    local _target=""
    local _projectSearchName="mpfr-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--with-gmp=/mingw --disable-shared"
    local _makeParameters=""
    local _binCheck="libmpfr.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"          
}

buildInstallMPC() {
    local _projectName="mpc"
    local _version="1.0.1"
    local _url="http://multiprecision.org/mpc/download/mpc-$_version.tar.gz"
    local _target=""
    local _projectSearchName="mpc-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--with-gmp=/mingw --with-mpfr=/mingw --disable-shared"
    local _makeParameters=""
    local _binCheck="libmpc.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"      
}

buildInstallMingw64CRT() {
    local _projectName="mingw-w64"
    local _version="2.0.8"
    local _url="http://downloads.sourceforge.net/project/mingw-w64/mingw-w64/mingw-w64-release/mingw-w64-v$_version.tar.gz"
    local _target=""
    local _projectSearchName="mingw-w64-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--enable-lib64 --with-gmp --with-crt --with-mpfr --with-mpc --disable-multilib --enable-languages=c,c++ --with-pkgversion=\"MinGW64-Windows\""
    local _makeParameters=""
    local _binCheck="x"
    local _postBuildCommand=""
    local _exeToTest=""
    
    if ad_isDateNewerThanFileModTime "2013-01-01" "/mingw/x86_64-w64-mingw32/lib/libcrtdll.a"; then
        ad_clearEnv
        mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    else
        mingleLog "Mingw64 CRT is up to date." true
    fi    
}

buildInstallLibtool() {
    local _projectName="libtool"
    local _version="2.4.2"
    local _url="http://ftpmirror.gnu.org/libtool/libtool-2.4.2.tar.gz"
    local _target=""
    local _projectSearchName="libtool-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libtool"
    local _postBuildCommand=""
    local _exeToTest="libtool --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"      
}

buildInstallPExports() {
    local _projectName="pexports"
    local _version="0.46"
    local _url="http://downloads.sourceforge.net/project/mingw/MinGW/Extension/pexports/pexports-$_version/pexports-$_version-mingw32-src.tar.xz"
    local _target=""
    local _projectSearchName="pexports-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="pexports"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"      
}

buildInstallGenDef() {
    local _project="gendef*"
    local _binCheck="gendef"
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then   
        mingleLog "Building $_project..." true
        
        local _projectDir=$(ad_getDirFromWC "mingw-w64-*")
        
        ad_cd $_projectDir
        ad_cd mingw-w64-tools
        
        cp -rf gendef $MINGLE_BUILD_DIR
        
        ad_cd "$MINGLE_BUILD_DIR"
    
        buildInstallGeneric "$_project" true true false true "" true true "" "" "$_binCheck" "" ""
    fi
}

buildInstallHexdump() {
    local _projectName="hexdump"
    local _version="1.0"
    local _url="https://github.com/wahern/hexdump/archive/master.zip"
    local _target="hexdump-$_version.zip"
    local _projectSearchName="hexdump-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="hexdump"
    local _postBuildCommand=""
    local _exeToTest="hexdump -V"

    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_projectName..." true
        
        ad_setDefaultEnv
        
        mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
        mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"

        local _projectdir=$(ad_getDirFromWC "$_projectSearchName")
    
    ad_cd $_projectdir
    
    make CFLAGS="-std=gnu99 -Ofast -Wall -Wextra -Werror -Wno-unused-variable -Wno-unused-parameter -Wno-error=clobbered" || mingleError $? "make failed, aborting!"
    
    cp $_binCheck /mingw/bin || mingleError $? "Failed to copy $_binCheck, aborting!"
    else
        mingleLog "$_project Already Installed." true
    fi
    
    ad_run_test "$_exeToTest"   
}

buildInstallGLibC() {
    local _projectName="glibc"
    local _version="2.16.0"
    local _url="http://ftp.gnu.org/gnu/libc/glibc-$_version.tar.xz"
    local _target=""
    local _projectSearchName="glibc-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="xxxx"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"          
}

buildInstallNasm() {
    local _projectName="nasm"
    local _version="2.07"
    local _url="http://sourceforge.net/projects/nasm/files/nasm%20sources/$_version/nasm-$_version.tar.gz"
    local _target=""
    local _projectSearchName="nasm-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="nasm"
    local _postBuildCommand=""
    local _exeToTest="nasm -v"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"          
}

buildInstallYasm() {
    local _projectName="yasm"
    local _version="1.2.0"
    local _url="http://www.tortall.net/projects/yasm/releases/yasm-$_version.tar.gz"
    local _target=""
    local _projectSearchName="yasm-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="yasm"
    local _postBuildCommand=""
    local _exeToTest="yasm --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"          
}

buildInstallRagel() {
    local _projectName="ragel"
    local _version="6.8"
    local _url="http://www.complang.org/ragel/ragel-$_version.tar.gz"
    local _target=""
    local _projectSearchName="ragel-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="ragel.exe"
    local _postBuildCommand=""
    local _exeToTest="ragel --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"            
}

buildInstallCMake() { 
    local _projectName="cmake"
    local _version="2.8.12.1"
    local _url="http://www.cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz"
    local _target=""
    local _projectSearchName="cmake-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="cmake"
    local _postBuildCommand=""
    local _exeToTest="cmake --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"              
}

buildInstallGperf() {
    local _projectName="gperf"
    local _version="3.0.4"
    local _url="http://ftp.gnu.org/pub/gnu/gperf/gperf-$_version.tar.gz"
    local _target=""
    local _projectSearchName="gperf-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="gperf"
    local _postBuildCommand=""
    local _exeToTest="gperf --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"   
}

# Things to watch:
# http://sourceware.org/bugzilla/show_bug.cgi?id=12127
# http://forums.codeblocks.org/index.php/topic,11301.0.html
buildInstallGDB() {
    local _project="gdb-*"
    local _version="7.5"

    if ad_isDateNewerThanFileModTime "2014-01-01" "/mingw/bin/gdb.exe"; then
        mingleLog "Building $_project..." true    
        
        ad_clearEnv
        
        mingleCategoryDownload "gdb" "$_version" "http://ftp.gnu.org/gnu/gdb/gdb-$_version.tar.gz"
        mingleCategoryDecompress "gdb" "$_version" "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")

        ad_cd $_projectDir || mingleError $? "cd failed, aborting!"
        
        if [ ! -e gdb-mingw.patch ]; then
            cp $MINGLE_BASE/patches/gdb/$_version/gdb-mingw.patch .
            ad_patch "gdb-mingw.patch"
        fi

# This patch seems to regress all the py-gdb functionality.
# Really wierd solution to getting python to work when it already does in mingw. Disabling.
#        if [ ! -e gdb-python.patch ]; then
#            cp $MINGLE_BUILD_DIR/patches/gdb/$_version/gdb-python.patch .
#            ad_patch "gdb-python.patch"
#        fi

        mingleLog "Isolating dependencies..."

        if [ ! -e dependencies/include/sys ]; then
            ad_mkdir dependencies/include/sys
            ad_mkdir dependencies/lib
        fi
        
        cp -f /mingw/include/mingle/sys/utsname.h dependencies/include/sys
        cp -f /mingw/lib/libmingle.a dependencies/lib
        
    local _savedir=`pwd`

        mingleLog "Remove any old config.cache files..."
        find . -name 'config.cache' -exec rm {} \;
        
        ad_cd ".."

        export "CFLAGS=-I/mingw/include -I$_savedir/dependencies/include -D_WIN64 -DMS_WIN64 -D__MINGW__"
        export "LDFLAGS=-L/mingw/lib -L$_savedir/dependencies/lib -lmingle"
        export "CPPFLAGS=-I/mingw/include -I$_savedir/dependencies/include -D_WIN64 -DMS_WIN64 -D__MINGW__"

        buildInstallGeneric "$_project" false true false false "" true true "--with-gmp --with-mpfr --with-mpc --with-python --enable-shared" "" "x" "" "gdb --version"

        ad_cd $_projectDir/gdb

        # Need to fix this in Makefile
        #x86_64-w64-mingw32-gcc.exe -o _gdb.pyd -s -shared -Wl,--out-implib=libgdb.dll.a  -Wl,--export-all-symbols -Wl,--enable-auto-import -Wl,--whole-archive *.o -Wl,--no-whole-archive -L../bfd -lbfd -L../liberty -liberty -L/mingw/lib -L../readline -lreadline -lhistory -L../libdecnumber -ldecnumber -L../opcodes -lopcodes -lz -lws2_32 -lpython2.7 -lexpat -L../intl -lintl -liconv

        #cp -f _gdb.pyd /mingw/share/gdb/python/gdb
        #cp -rf /mingw/share/gdb/python/gdb /mingw/lib/python2.7/site-packages/gdb

        ad_cd "$MINGLE_BUILD_DIR"
    else
        mingleLog "GDB is up to date." true
    fi
}

buildInstallCUnit() {    
    local _projectName="CUnit"
    local _version="2.1-2"
    local _url="http://downloads.sourceforge.net/project/cunit/CUnit/$_version/CUnit-$_version-src.tar.bz2"
    local _target=""
    local _projectSearchName="CUnit-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libcunit.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"                  
}

buildInstallTCL() {
    local _project="tcl*"
    local _majversion="8.6"
    local _minversion=".1"
    local _version="$_majversion$_minversion"
    #local _binCheck="xxx"
    local _binCheck="tclsh"
    local _exeToTest=""
    
    ad_setDefaultEnv
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
        
        mingleCategoryDownload "tcl" "$_version" "http://prdownloads.sourceforge.net/tcl/tcl$_version-src.tar.gz"
        
        mingleCategoryDecompress "tcl" "$_version" "$_project"

        local _projectdir=$(ad_getDirFromWC "$_project")
    
    ad_cd $_projectdir
    
    if [ ! -e tcl-mingw.patch ]; then
            cp $MINGLE_BASE/patches/tcl/$_version/tcl-mingw.patch .
            ad_patch "tcl-mingw.patch"
        fi
        
        ad_cd win
        
        aclocal || mingleError $? "aclocal failed, aborting!"
        autoconf || mingleError $? "autoconf failed, aborting!"

        ./configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --prefix=/mingw --enable-64bit --enable-shared=no

        make || mingleError $? "make failed, aborting!"

        local _savedir=`pwd`

        ad_cd /mingw/bin
        
        local mm_ver=`echo $_majversion|sed 's/\.//'`

        ln -sf $_savedir/tclsh${mm_ver}s.exe tclsh.exe

        ad_cd $_savedir
        
        make install || mingleError $? "make failed, aborting!"
        
        make clean
        
        ./configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --prefix=/mingw --enable-64bit --enable-shared=yes
        
        make || mingleError $? "make failed, aborting!"
        make install || mingleError $? "make failed, aborting!"
        
        #cp -f libtcl${mm_ver}.dll.a /mingw/lib
        #cp -f tcl${mm_ver}.dll /mingw/bin
    #cp -f tclsh${mm_ver}.exe /mingw/bin

        ad_cd "$MINGLE_BUILD_DIR"
    else
        mingleLog "$_project Already Installed." true
    fi
    
    ad_run_test "$_exeToTest"
}

buildInstallTk() {
    local _majversion="8.6"
    local _minversion=".1"
    local _version="$_majversion$_minversion"
    local _project="tk$_majversion*"
    local _cleanEnv=true
    local _binCheck="libtk86.a"
    local _postBuildCommand=""
    local _exeToTest=""
    
    if $_cleanEnv; then
        ad_setDefaultEnv
    fi
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
        
        mingleCategoryDownload "tk" "$_version" "http://prdownloads.sourceforge.net/tcl/tk$_version-src.tar.gz"
            
        mingleCategoryDecompress "tk" "$_version" "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")
        
    cd $_projectDir || mingleError $? "cd 1 failed, aborting!"
        
    if [ ! -e tk-mingw.patch ]; then
        cp $MINGLE_BASE/patches/tk/$_version/tk-mingw.patch .
        ad_patch "tk-mingw.patch"
        fi

        ad_cd $_projectDir/win
        
        aclocal || mingleError $? "aclocal failed, aborting!"
            
        autoconf || mingleError $? "autoconf failed, aborting!"

        ./configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --prefix=/mingw --enable-64bit --enable-shared=yes --with-tcl=/mingw/lib

        make || mingleError $? "make failed, aborting!"
        make install || mingleError $? "make failed, aborting!"

        make clean
        
        ./configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --prefix=/mingw --enable-64bit --enable-shared=no --with-tcl=/mingw/lib
    
    make || mingleError $? "make failed, aborting!"
        make install || mingleError $? "make install failed, aborting!"
        
        #cp -f libtk86.dll.a /mingw/lib
        #cp -f tk86.dll /mingw/bin
        #cp -f wish86.exe /mingw/bin
        
        ad_cd "$MINGLE_BUILD_DIR"
        
        ad_exec_script "$_project" "$_postBuildCommand"
    else
        mingleLog "$_project Already Installed." true
    fi
    
    ad_run_test "$_exeToTest"
}

buildInstallZlib() {
    local _project="zlib-*"
    local _version="1.2.8"
    
    if [ ! -e /mingw/bin/zlib1.dll ]; then
        mingleLog "Building zlib..." true
        
        mingleCategoryDownload "zlib" "$_version" "http://www.zlib.net/zlib-$_version.tar.gz"
                
        mingleCategoryDecompress "zlib" "$_version" "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)
    
        ad_cd $_projectdir

        make -f win32/Makefile.gcc || mingleError $? "make failed, aborting!"

        cp zlib1.dll /mingw/bin
        cp zconf.h zlib.h /mingw/include
        cp libz.a /mingw/lib
        cp libz.dll.a /mingw/lib

        if [ ! -e example.exe ]; then
            mingleError $? "Build Failed!"
        else
            ./example.exe||mingleError $? "Test Failed!"
        fi

        ad_cd "$MINGLE_BUILD_DIR"
    else
        mingleLog "zLib Already Installed." true     
    fi
}

buildInstallBzip2() {
    local _project="bzip2-*"
    local _version="1.0.6"

    mingleLog "Building bzip2..." true
    
    if [ ! -e /mingw/bin/bzip2 ]; then
        mingleCategoryDownload "bzip2" "$_version" "http://www.bzip.org/$_version/bzip2-$_version.tar.gz"
                    
        mingleCategoryDecompress "bzip2" "$_version" "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)
    
        ad_cd "$_projectdir"

        make || mingleError $? "make failed, aborting!"

        cp -f bzip2 /mingw/bin
        cp -f bzip2recover /mingw/bin
        cp -f libbz2.a /mingw/lib
        cp -f bzlib.h /mingw/include

        ad_cd "$MINGLE_BUILD_DIR"
    else
        mingleLog "Already Installed."        
    fi
}

buildInstallLibiconv() {
    local _project="libiconv-*"
    local _version="1.14"

    mingleLog "Building libiconv..." true

    if [ -e /mingw/lib/libiconv.dll.a ] && [ -e /mingw/lib/libiconv.a ]; then
        mingleLog "Already Installed." 
        return
    fi
    
    mingleCategoryDownload "libiconv" "$_version" "http://ftp.gnu.org/pub/gnu/libiconv/libiconv-$_version.tar.gz"
                    
    mingleCategoryDecompress "libiconv" "$_version" "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)
    
    ad_cd $_projectdir
    
    if [ ! -e /mingw/lib/libiconv.dll.a ]; then
        mingleLog "Building Dynamic lib..."
        ./configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --prefix=/mingw
        make clean
        make || mingleError $? "make failed, aborting!"
        make install-strip || mingleError $? "make install failed, aborting!"

        if ! iconv --version; then
            mingleError $? "iconv failed, Build Failed!"
        fi
    else
        mingleLog "Dynamic Library Already Installed."        
    fi
    
    if [ ! -e /mingw/lib/libiconv.a ]; then
        mingleLog "Building Static lib..."
        make clean
        ./configure --build=x86_64-w64-mingw32 --disable-shared --prefix=/mingw
        make || mingleError $? "make failed, aborting!"
        make install-strip || mingleError $? "make install failed, aborting!"
        
        if ! iconv --version; then
            mingleError $? "iconv failed, Build Failed!"
        fi 
    else
        mingleLog "Static Library Already Installed."        
    fi
    
    mingleLog "Fix the libraries just to be safe..."
    sed -e "s/dlname=''/dlname='..\/bin\/libiconv-2.dll'/" -e "s/library_names=''/library_names='libiconv.dll.a'/" /mingw/lib/libiconv.la>libiconv.la
    mv libiconv.la /mingw/lib/libiconv.la
    
    sed -e "s/dlname=''/dlname='..\/bin\/libcharset-1.dll'/" -e "s/library_names=''/library_names='libcharset.dll.a'/" /mingw/lib/libcharset.la>libcharset.la
    mv libcharset.la /mingw/lib/libcharset.la
    
    ad_cd ".."
}

buildInstallPThreads() {
    local _version="2-9-1"
    if [ ! -e /mingw/bin/pthreadGC2.dll ]; then
        mingleLog "Installing pThreads..." true
        
        local _project="pthreads-*"

        mingleCategoryDownload "pthreads" "$_version" "ftp://sourceware.org/pub/pthreads-win32/pthreads-w32-$_version-release.zip"
        mingleCategoryDecompress "pthreads" "$_version" "$_project"

        ad_cd Pre-built.2

        cp -f dll/x64/*.dll /mingw/bin
        cp -f include/*.h /mingw/include
        cp -f lib/x64/* /mingw/lib

        ad_cd ".."
    else
        mingleLog "Already Installed."        
    fi
}

buildInstallBinutils() {   
    local _projectName="binutils"
    local _version="2.23.1"
    local _url="http://ftp.gnu.org/gnu/binutils/binutils-$_version.tar.gz"
    local _target=""
    local _projectSearchName="binutils-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="dllwrap.exe"
    local _postBuildCommand=""
    local _exeToTest="dllwrap.exe --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"                      
}

buildInstallPkgconfig() {
    local _project="pkg-config-*"
    local _version=0.27.1

    if [ ! -e /mingw/bin/pkg-config ]; then
        mingleLog "Installing $_project..." true
        
        mingleCategoryDownload "pkg-config" "$_version" "http://pkgconfig.freedesktop.org/releases/pkg-config-$_version.tar.gz"
        mingleCategoryDecompress "pkg-config" "$_version" "$_project"

        ad_setDefaultEnv

        export "CFLAGS=-std=c99 $CFLAGS"

        local _projectdir=$(ad_getDirFromWC $_project)
    
        ad_cd "$_projectdir"
    
        aclocal --force
        libtoolize
    
        ad_cd "$MINGLE_BUILD_DIR"
    
        buildInstallGeneric "$_project" true true false true "" true true "--with-internal-glib" "" "pkg-config" "" "pkg-config --version"
    else
        mingleLog "$_project already installed."
    fi
}

buildInstallFlex() {
    local _projectName="flex"
    local _version="2.5.4a-1"
    local _url="http://sourceforge.net/projects/gnuwin32/files/flex/${_version}/flex-${_version}-src.zip"
    local _target=""
    local _projectSearchName="flex-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libflex.a"
    local _postBuildCommand=""
    local _exeToTest=""
    
    mingleLog "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_projectName..." true
         
        ad_setDefaultEnv
         
        export "CFLAGS=-I/mingw/include -D_WIN64 -D__WIN64 -DMS_WIN64 -DWIN32 -Ofast"
        export "CPPFLAGS=-I/mingw/include -D_WIN64 -D__WIN64 -DMS_WIN64 -DWIN32 -O2"
        export "CXXFLAGS=$CPPFLAGS"
        export "LIBS=$LIBS -L/mingw/lib -lmingle -lws2_32"
        export "CC=x86_64-w64-mingw32-gcc -I/mingw/include/mingle"
        export "CXX=x86_64-w64-mingw32-gcc -I/mingw/include/mingle"
    
        mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
        mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName" "flex-${_version}"

        local _projectdir=$(ad_getDirFromWC $_projectSearchName)
        
        ad_cd "$_projectdir"
         
        cp -rf src/flex/2.5.4a/flex-2.5.4a/* . || mingleError $? "mv failed, aborting!"
         
        mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
        
        if [ -e /mingw/bin/flex.exe ]; then
            mv -f /mingw/bin/flex.exe /mingw/bin/gnu_flex.exe || mingleError $? "mv failed, aborting!"
        fi
        
        mingleCategoryDownload "winflexbison" "2.5.3" "https://github.com/onepremise/winflexbison/archive/master.zip" "winflexbison-2.5.3.zip"
        mingleCategoryDecompress "winflexbison" "2.5.3" "winflexbison*"
        
        # ad_cd "$_projectdir"
        
        # make clean || mingleError $? "Failed to clean, aborting!"
        
        # cp -rf ../winflexbison-master/flex/src/* . || mingleError $? "Failed to copy, aborting!"
        # cp -rf ../winflexbison-master/flex/src/*.c . || mingleError $? "Failed to copy, aborting!"
        # cp -rf ../winflexbison-master/flex/src/*.h . || mingleError $? "Failed to copy, aborting!"
        
        # mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    else
        mingleLog "$_projectName Already Installed." true
    fi 
}

buildInstallBison() {
    local _projectName="bison"
    local _version="3.0"
    local _url="http://ftp.gnu.org/gnu/bison/bison-3.0.tar.gz"
    local _target=""
    local _projectSearchName="bison-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--prefix=$MINGLE_BASE_MX/mingw64"
    local _makeParameters=""
    local _binCheck="libbison.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest" 
}

buildInstallWinFlexBison() {
    local _projectName="win_flex_bison"
    local _version="2.5.3"
    local _url="http://superb-dca2.dl.sourceforge.net/project/winflexbison/win_flex_bison-latest.zip"
    local _target="win_flex_bison-2.5.3.zip"
    local _projectSearchName="win_flex_bison*"
    local _binCheck="win_flex.exe"
    local _exeToTest=""
    
    mingleLog "Checking for binary $_binCheck..."
    if ! ( [ -e "/lib/$_binCheck" ] || [ -e "/bin/$_binCheck" ] );then
        mingleLog "Building $_projectName..." true
        
        mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
        mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName" "$_projectName"
        
        local _projectdir=$(ad_getDirFromWC $_projectSearchName)
            
        ad_cd "$_projectdir"
        
        cp -rf *.exe /bin || mingleError $? "Failed to copy, aborting!"
        cp -rf data /bin || mingleError $? "Failed to copy, aborting!"
        cp -rf FlexLexer.h /include || mingleError $? "Failed to copy, aborting!"
    else
        mingleLog "$_projectName Already Installed." true        
    fi
}

buildInstallTermCap() {
    local _projectName="termcap"
    local _version="1.3.1"
    local _url="ftp://ftp.gnu.org/gnu/termcap/termcap-$_version.tar.gz"
    local _target=""
    local _projectSearchName="termcap-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libtermcap.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"       
}

buildInstallReadline() {
    local _projectName="readline"
    local _version="6.3"
    local _url="https://ftp.gnu.org/gnu/readline/readline-${_version}.tar.gz"
    local _target=""
    local _projectSearchName="readline-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libreadline.dll.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleLog "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
         mingleLog "Building $_projectName..." true
         
         ad_setDefaultEnv
         
     export "CFLAGS=$CFLAGS -D_POSIX -DHAVE_POSIX_SIGNALS"
     export "LIBS=$LIBS -L/mingw/lib -lmingle -lws2_32"
     export "CC=x86_64-w64-mingw32-gcc -I/mingw/include/mingle"
         export "CXX=x86_64-w64-mingw32-gcc -I/mingw/include/mingle"
    
         mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
         mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"

         local _projectdir=$(ad_getDirFromWC $_projectSearchName)
        
         ad_cd "$_projectdir"

         if [ ! -e $_projectName-mingw.patch ]; then
            cp $MINGLE_BASE/patches/$_projectName/$_version/$_projectName-mingw.patch .
            ad_patch "$_projectName-mingw.patch"    
         fi
         
         mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    else
        mingleLog "$_projectName Already Installed." true
    fi
}

buildInstallNcurses() {
    local _projectName="ncurses"
    local _version="5.9-20150110"
    local _url="ftp://invisible-island.net/ncurses/current/ncurses-$_version.tgz"
    local _target=""
    local _projectSearchName="ncurses-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=false #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--with-shared --with-cxx-shared --with-normal --disable-relink --disable-rpath --without-ada --enable-warnings  --disable-home-terminfo --enable-database  --disable-home-terminfo --enable-sp-funcs --disable-sigwinch --enable-term-driver --enable-interop --disable-termcap --with-progs --with-libtool --enable-pc-files --mandir=/mingw/share/man"
    local _makeParameters=""
    local _binCheck="libncurses++.a"
    local _postBuildCommand=""
    local _exeToTest=""
    
    ad_setDefaultEnv
    
    export CFLAGS="$CFLAGS -I../progs -I../include"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"       
}

installLibJPEG () {
    local _version="1.2.1"
    
    if [ ! -e /mingw/lib/libturbojpeg.a ]; then
        mingleLog "Installing libjpeg-turbo..." true
        
        ad_cd "$MINGLE_BUILD_DIR"
        
        mingleCategoryDownload "libjpeg-turbo" "$_version" "http://sourceforge.net/projects/libjpeg-turbo/files/$_version/libjpeg-turbo-$_version-gcc64.exe/download" "libjpeg-turbo-$_version-gcc64.exe"
        
        STOREPATH=`pwd`

        if [ ! -e libjpeg-turbo ]; then
            mkdir libjpeg-turbo
        fi

        ad_cd libjpeg-turbo

        DOSPATH=`cmd /c 'echo %CD%'`
        
        ad_cd $MINGLE_CACHE/libjpeg-turbo/$_version

        EXECPATH=`pwd -W`

        ad_cd $STOREPATH
        
        if [ ! -e "libjpeg-turbo.tar" ]; then
            cmd /c "$EXECPATH/libjpeg-turbo-1.2.1-gcc64.exe /S /D=$DOSPATH"

            if [ ! -e "$DOSPATH/uninstall_1.2.1.exe" ]; then
                mingleError -1 "Failed to install libturbo, aborting!"
            fi

            tar cvf libjpeg-turbo.tar libjpeg-turbo --exclude=uninstall*

            cd libjpeg-turbo

            cmd /c "uninstall_1.2.1.exe /S"

            ad_cd ".."

            sleep 2

            rmdir libjpeg-turbo
        fi

        tar xvf libjpeg-turbo.tar
        cp -rf libjpeg-turbo/* /mingw
    else
        mingleLog "libjpeg-turbo already installed." true
    fi
}

installLibPNG() {
    local _majorversion="1.6"
    local _minorversion=".2"
    local _version="$_majorversion$_minorversion"
    
    if [ ! -e /mingw/bin/libpng*.dll ]; then
        mingleLog "Installing libPNG..." true
        
        mingleCategoryDownload "libpng" "$_version" "ftp://ftp.simplesystems.org/pub/libpng/png/src/history/libpng`echo $_majorversion|sed 's/\.//'`/libpng-$_version.tar.gz"
        mingleCategoryDecompress "libpng" "$_version" "libpng-*"
        
        cd libpng-* || mingleError $? "cd failed, aborting!"

        export "CFLAGS=-I/mingw/include"
        export "LDFLAGS=-L/mingw/lib"
        export "CPPFLAGS=$CFLAGS"
        
        ./configure --host=x86_64-w64-mingw32 --prefix=/mingw

        make || mingleError $? "make failed, aborting!"
        make install || mingleError $? "make install failed, aborting!"

        ad_cd ".."
    else
        mingleLog "libPNG Already Installed." true
    fi
    
    echo
}

installLibTiff() {
    local _projectName="tiff"
    local _version="4.0.3"
    local _url="ftp://ftp.remotesensing.org/pub/libtiff/tiff-$_version.tar.gz"
    local _target=""
    local _projectSearchName="tiff-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="tiffinfo"
    local _postBuildCommand=""
    local _exeToTest="tiffinfo"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"    
}

buildInstallSigc() {
    local _projectName="libsigc"
    local _version="2.3.1"
    local _pathver="2.3"
    local _url="http://ftp.gnome.org/pub/GNOME/sources/libsigc++/$_pathver/libsigc++-$_version.tar.xz"
    local _target=""
    local _projectSearchName="libsigc++-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=false #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libsigc-2.0-0.dll"
    local _postBuildCommand=""
    local _exeToTest=""
    
    ad_clearEnv
    
    export "CFLAGS=-I/mingw/include -D_WIN64 -D__WIN64 -DMS_WIN64 -Ofast -funroll-all-loops"
    export "CPPFLAGS=$CFLAGS"
    export "LDFLAGS=-L/mingw/lib"    

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"    
}

buildInstallPixman() {
    local _projectName="pixman"
    local _version="0.28.2"
    local _url="http://www.cairographics.org/releases/pixman-$_version.tar.gz"
    local _target=""
    local _projectSearchName="pixman-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libpixman-1.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"   
}

buildInstallCairo() {
    local _project="cairo-*"
        
    local _projectName="cairo"
    local _version="1.12.14"
    local _url="http://www.cairographics.org/releases/cairo-$_version.tar.xz"
    local _target=""
    local _projectSearchName="$_project"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=false #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--enable-gtk-doc"
    local _makeParameters=""
    local _binCheck="libcairo.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"    
    
    if ! ( [ -e "/mingw/lib/libcairo.dll" ] && [ -e "/mingw/bin/libcairo.dll" ] );then
        mingleLog "Manually generating libcairo DLL..." true

        local _projectdir=$(ad_getDirFromWC $_project)

        ad_cd "$_projectdir"

        x86_64-w64-mingw32-gcc.exe -o libcairo.dll -s -shared -Wl,--out-implib=libcairo.dll.a  -Wl,--export-all-symbols -Wl,--enable-auto-import -Wl,--whole-archive src/.libs/libcairo.a -Wl,--no-whole-archive -L/mingw/lib -lpixman-1 -lz -lgdi32 -lpng -lfontconfig -lfreetype -lmsimg32 || mingleError $? "Failed to generate dll, aborting!"

        cp libcairo.dll /mingw/lib || mingleError $? "Failed to copy dll, aborting!"
        cp libcairo.dll /mingw/bin || mingleError $? "Failed to copy dll, aborting!"
        cp libcairo.dll.a /mingw/lib || mingleError $? "Failed to copy lib, aborting!"

        local _shortProjectName=$(ad_getShortLibName $_project)

        mingleLog "Short Name: $_shortProjectName"

        ad_fix_shared_lib "$_shortProjectName"
        ad_fix_shared_lib "libcairo-script-interpreter"

        ad_cd ".."
    fi
}

buildInstallCairomm() {
    local _projectName="cairomm"
    local _version="1.10.0"
    local _url="http://www.cairographics.org/releases/cairomm-$_version.tar.gz"
    local _target=""
    local _projectSearchName="cairomm-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libcairomm-1.0.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"   
}

buildInstallPolarSSL() {
    local _project="polarssl-*"
    local _version="1.2.3"
    local _additionFlags=""
    #local _binCheck="xxx"
    local _binCheck="polarssl_selftest.exe"
    local _exeToTest=""

    ad_setDefaultEnv
    
    export SHARED=1
    export "WINDOWS=1"
    export "CC=gcc"
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
         mingleLog "Building $_project..." true
         
        mingleCategoryDownload "polarssl" "$_version" "https://polarssl.org/download/polarssl-$_version-gpl.tgz"
        mingleCategoryDecompress "polarssl" "$_version" "$_project"
        
        local _projectdir=$(ad_getDirFromWC $_project)
        cd $_projectdir
        sed -e 's/DESTDIR=\/usr\/local/DESTDIR=\/mingw/g' Makefile>Makefile2
        mv Makefile2 Makefile
        ad_cd ".."
        
        ad_make "$_project"
    else
        mingleLog "$_project Already Installed." true
    fi
    
    ad_run_test "$_exeToTest"
    
    echo
}

buildInstallLOpenSSL() {
    local _project="openssl-*"
    local _version="1.0.1j"
    local _additionFlags=""
    local _binCheck="libssl.a"
    local _exeToTest="openssl version"

    ad_setDefaultEnv
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
         
        mingleCategoryDownload "openssl" "$_version" "http://www.openssl.org/source/openssl-$_version.tar.gz"
        mingleCategoryDecompress "openssl" "$_version" "$_project"        
        
        local _dir=$(ad_getDirFromWC "$_project")
        
        ad_cd $_dir
        
        ./Configure mingw64 shared no-asm no-idea no-mdc2 no-rc5 --prefix=/mingw
        
        ad_cd ".."
        
        ad_make "$_project"
    else
        echo "$_project Already Installed." true
    fi
    
    ad_run_test "$_exeToTest"
    
    echo    
}

buildInstallLibXML2() {
    local _projectName="libxml2"
    local _version="2.9.1"
    local _url="https://git.gnome.org/browse/libxml2/snapshot/libxml2-$_version.tar.gz"
    local _target=""
    local _projectSearchName="libxml2-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--enable-shared --enable-static --with-icu"
    local _makeParameters=""
    local _binCheck="xmllint"
    local _postBuildCommand=""
    local _exeToTest="xmllint --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallXerces() {
    local _projectName="xerces-c"
    local _version="3.1.1"
    local _url="http://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.1.1.tar.gz"
    local _target=""
    local _projectSearchName="xerces-c*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags="-I m4"
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="pparse"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallLibXSLT() {
    local _project="libxslt-*"
    local _version="1.1.27"

    if [ -e /mingw/bin/xsltproc ]; then
        mingleLog "$_project Already Installed." true
        return;
    fi
    
    mingleLog "Building $_project..." true

    ad_setDefaultEnv
    
    export "CFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64"
    export "CPPFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64"
 
    mingleCategoryDownload "libxslt" "$_version" "https://git.gnome.org/browse/libxslt/snapshot/libxslt-$_version.tar.gz"
    mingleCategoryDecompress "libxslt" "$_version" "$_project"

    local _projectDir=$(ad_getDirFromWC "$_project")

    ad_cd "$_projectDir"

    if [ ! -e xslt-mingw.patch ]; then
        cp $MINGLE_BASE/patches/xslt/$_version/xslt-mingw.patch .
        ad_patch "xslt-mingw.patch"
    fi

    ad_cd "$MINGLE_BUILD_DIR"
    
    buildInstallGeneric "$_project" false true false false "" false true "" "" "xsltproc" "" "xsltproc --version"
}

buildInstallCurl() {
    local _project="curl-*"
    local _version="7.28.1"
    
    if [ -e /mingw/lib/libcurl.a ]; then
        mingleLog "$_project Already Installed." true
        return;
    fi
    
    mingleLog "Building $_project..." true

    mingleCategoryDownload "curl" "$_version" "http://curl.haxx.se/download/curl-$_version.tar.bz2"
    mingleCategoryDecompress "curl" "$_version" "$_project"   
    
    local _projectDir=$(ad_getDirFromWC "$_project")
    
    ad_cd "$_projectDir"
    
    ./buildconf
    
    ad_cd ".."
    
    if [ ! -e /mingw/share/curl ]; then
        mkdir -p /mingw/share/curl
    fi
    
    buildInstallGeneric "$_project" true true false false "" false true "--with-ca-bundle=$MINGLE_BASE/mingw64/share/curl/ca-bundle.crt" "" "libcurl.a" "" "curl --version"
}

buildInstallAPR() {
    local _project="apr-*"
    local _version="1.4.8"

    if [ -e /mingw/lib/libapr-1.a ]; then
        mingleLog "$_project Already Installed." true
        return;
    fi
    
    mingleLog "Building $_project..." true

    ad_clearEnv
    
    export "CFLAGS=-I/mingw/include -D__MINGW__ -DAPU_DECLARE_STATIC"
    export "LDFLAGS=-L/mingw/lib"
    export "CPPFLAGS=-I/mingw/include -D__MINGW__  -DAPU_DECLARE_STATIC"

    mingleCategoryDownload "apr" "$_version" "http://archive.apache.org/dist/apr/apr-$_version.tar.gz"
    mingleCategoryDecompress "apr" "$_version" "$_project"  
    
    local _projectDir=$(ad_getDirFromWC "$_project")

    ad_cd "$_projectDir"

    if [ ! -e apr-mingw.patch ]; then
        cp $MINGLE_BASE/patches/apr/$_version/apr-mingw.patch .
        ad_patch "apr-mingw.patch"
    fi

    ad_cd ".."
    
    buildInstallGeneric "apr-*" false true false false "" true true "--enable-shared" "" "libapr-1.a" "" "apr-1-config --version"

    mkdir -p /mingw/include/apr-1/arch/win32
    cp -f $_projectDir/include/arch/apr_private_common.h /mingw/include/apr-1/arch
    cp -rf $_projectDir/include/arch/win32 /mingw/include/apr-1/arch
}

buildInstallAPRUtil() {
    local _project="apr-util-*"
    local _version="1.5.2"
    local _additionFlags="--with-apr=/mingw/bin/apr-1-config --with-expat=/mingw --with-berkeley-db=/mingw/include:/mingw/lib --with-sqlite3=/mingw --with-pgsql=/mingw"
    local _binCheck="libaprutil-1.a"
    local _exeToTest="apu-1-config --version"

    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then   
        mingleLog "Building $_project..." true
        
        ad_clearEnv
    
        export "CFLAGS=-I/mingw/include -D__MINGW__ -DAPU_DECLARE_STATIC"
        export "LDFLAGS=-L/mingw/lib"
        export "CPPFLAGS=-I/mingw/include -D__MINGW__  -DAPU_DECLARE_STATIC"
        
        mingleCategoryDownload "apr-util" "$_version" "http://archive.apache.org/dist/apr/apr-util-$_version.tar.gz"
        mingleCategoryDecompress "apr-util" "$_version" "$_project"  

        local _projectdir=$(ad_getDirFromWC $_project)
        
        ad_cd "$_projectdir"    

        if [ ! -e apr-util-mingw.patch ]; then
            cp $MINGLE_BASE/patches/apr-util/$_version/apr-util-mingw.patch .
            ad_patch "apr-util-mingw.patch"
        fi
        
        ad_cd ".."
        
        buildInstallGeneric "$_project" false true false true "-I build" true true "$_additionFlags" "" "$_binCheck" "" "$_exeToTest"
    else
        mingleLog "$_project Already Installed." true
    fi
}

buildInstallBerkeleyDB() {
    local _project="db-*"
    local _version="6.0.20"
    local _additionFlags="--prefix=/mingw --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-mingw --enable-cxx --disable-replication --enable-tcl --with-tcl=/mingw/lib --enable-stl --enable-compat185 --enable-dbm"
    local _binCheck="db_verify.exe"
    local _exeToTest="db_verify -V"

    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true

        ad_setDefaultEnv
        #ad_clearEnv
        
        export "LDFLAGS=$LDFLAGS -ltcl86"

        mingleCategoryDownload "db" "$_version" "http://download.oracle.com/berkeley-db/db-$_version.tar.gz"
        mingleCategoryDecompress "db" "$_version" "$_project" 

        local _projectdir=$(ad_getDirFromWC $_project)
        
        ad_cd "$_projectdir"
        
        if [ ! -e db-mingw.patch ]; then
            cp $MINGLE_BASE/patches/db/$_version/db-mingw.patch .
            ad_patch "db-mingw.patch"
        fi        

        cd dist

        ./s_config

        ad_cd ".."/build_unix
        
        ../dist/configure $_additionFlags || mingleError $? "configure failed, aborting!"

        make || mingleError $? "make failed, aborting!"

        make install || mingleError $? "make failed, aborting!"
        
        ad_run_test "$_exeToTest"
    else
        mingleLog "$_project Already Installed." true
    fi
}

buildInstallDocBook() {
    local _project="docbook-*"
    local _xmlcommonsversion="1.2"
    local _docbookversion="1.76.1"
    local _docbook43version="4.3"
    local _docbook44version="4.4"
    local _docbook45version="4.5"
    local _shareDir=\$MINGLE_BASE_MX/mingw64/share
    local _shareDirVal=`eval echo "$_shareDir"`
    local _msysDir=`echo $(tr '[:upper:]' '[:lower:]' <<< ${MINGLE_BASE_MX:0:1})${MINGLE_BASE_MX:1}/msys`
    local _etcDir=$_msysDir/etc

    if ( [ -e "/etc/xml/catalog" ] && [ -e "/etc/xml/docbook" ] );then
        mingleLog "$_project Already Installed." true
        return;
    else
        mingleLog "Installing $_project..."
    fi

    ad_mkdir /etc/xml
    ad_mkdir /etc/xml/resolver
    ad_mkdir $_shareDirVal/xml
    ad_mkdir $_shareDirVal/xml/docbook
    ad_mkdir $_shareDirVal/xml/docbook/schema
    ad_mkdir $_shareDirVal/xml/docbook/schema/dtd
    ad_mkdir $_shareDirVal/xml/docbook/stylesheet
    ad_mkdir $_shareDirVal/xml/docbook/stylesheet/docbook-xsl
        
    mingleCategoryDownload "xml-commons-resolver" "$_xmlcommonsversion" "http://archive.apache.org/dist/xerces/xml-commons/xml-commons-resolver-$_xmlcommonsversion.tar.gz"
    mingleCategoryDownload "docbook-xsl" "$_docbookversion" "http://sourceforge.net/projects/docbook/files/docbook-xsl/$_docbookversion/docbook-xsl-$_docbookversion.tar.bz2"
    
    mingleCategoryDecompress "xml-commons-resolver" "$_xmlcommonsversion" "xml-commons-resolver-*"

    if [ ! -e "$_shareDirVal/xml/xml-commons-resolver-$_xmlcommonsversion" ]; then
        mv xml-commons-resolver-$_xmlcommonsversion $_shareDirVal/xml
    fi

    export CLASSPATH=$_shareDir/xml/xml-commons-resolver-$_xmlcommonsversion/resolver.jar

    mingleCategoryDecompress "docbook-xsl" "$_docbookversion" "docbook-xsl-*"

    ad_cd docbook-xsl-*

    if [ ! -e $_shareDirVal/xml/docbook/stylesheet/docbook-xsl/catalog.xml ]; then
        cp -rf . $_shareDirVal/xml/docbook/stylesheet/docbook-xsl
    fi

    ad_cd $_shareDirVal/xml/docbook/stylesheet/docbook-xsl

    local _homesave=$HOME

    export HOME=$MINGLE_BUILD_DIR

    ./install.sh --batch

    mv $MINGLE_BUILD_DIR/.resolver/CatalogManager.properties /etc/xml/resolver/CatalogManager.properties

    export HOME=$_homesave

    source $_shareDirVal/xml/docbook/stylesheet/docbook-xsl/.profile.incl

    ad_cd "$_shareDirVal/xml/docbook/stylesheet/docbook-xsl"

    echo source $_shareDir/xml/docbook/stylesheet/docbook-xsl/.profile.incl>>/etc/profile

    ad_cd "$MINGLE_BUILD_DIR"

    mingleCategoryDownload "docbook-xml" "$_docbook43version" "http://docbook.org/xml/$_docbook43version/docbook-xml-$_docbook43version.zip"
    mingleCategoryDecompress "docbook-xml" "$_docbook43version" "docbook-xml-$_docbook43version.zip" "docbook-xml-$_docbook43version"
    mv docbook-xml-$_docbook43version $_shareDirVal/xml/docbook/schema/dtd/$_docbook43version

    mingleCategoryDownload "docbook-xml" "$_docbook44version" "http://docbook.org/xml/$_docbook44version/docbook-xml-$_docbook44version.zip"
    mingleCategoryDecompress "docbook-xml" "$_docbook44version" "docbook-xml-$_docbook44version.zip" "docbook-xml-$_docbook44version"
    mv docbook-xml-$_docbook44version $_shareDirVal/xml/docbook/schema/dtd/$_docbook44version

    mingleCategoryDownload "docbook-xml" "$_docbook45version" "http://docbook.org/xml/$_docbook45version/docbook-xml-$_docbook45version.zip"
    mingleCategoryDecompress "docbook-xml" "$_docbook45version"  "docbook-xml-$_docbook45version.zip" "docbook-xml-$_docbook45version"
    mv docbook-xml-$_docbook45version $_shareDirVal/xml/docbook/schema/dtd/$_docbook45version

    if [ ! -e /etc/xml/docbook ]; then
        xmlcatalog --noout --create /etc/xml/docbook || mingleError $? "failed to create docbook, aborting!"
    else
        rm /etc/xml/docbook
        xmlcatalog --noout --create /etc/xml/docbook || mingleError $? "failed to create docbook, aborting!"
    fi

    ad_cd "/"

    mingleLog "Creating /etc/xml/docbook..." true

    cmd /c "xmlcatalog --noout --add \"public\" \"-//OASIS//DTD DocBook XML V4.3//EN\" \"http://www.oasis-open.org/docbook/xml/4.3/docbookx.dtd\" ./etc/xml/docbook"

    cmd /c "xmlcatalog --noout --add \"public\" \"-//OASIS//DTD DocBook XML CALS Table Model V4.3//EN\" \"file:///$_shareDirVal/xml/docbook/xml/4.3/calstblx.dtd\" ./etc/xml/docbook"

    cmd /c "xmlcatalog --noout --add \"public\" \"-//OASIS//DTD XML Exchange Table Model 19990315//EN\" \"file:///$_shareDirVal/xml/docbook/xml/4.3/soextblx.dtd\" ./etc/xml/docbook"

    cmd /c "xmlcatalog --noout --add \"public\" \"-//OASIS//ELEMENTS DocBook XML Information Pool V4.3//EN\" \"file:///$_shareDirVal/xml/docbook/xml/4.3/dbpoolx.mod\" ./etc/xml/docbook"

    cmd /c "xmlcatalog --noout --add \"public\" \"-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.3//EN\" \"file:///$_shareDirVal/xml/docbook/xml/4.3/dbhierx.mod\" ./etc/xml/docbook"

    cmd /c "xmlcatalog --noout --add \"public\" \"-//OASIS//ELEMENTS DocBook XML HTML Tables V4.3//EN\" \"file:///$_shareDirVal/xml/docbook/xml/4.3/htmltblx.mod\" ./etc/xml/docbook"

    cmd /c "xmlcatalog --noout --add \"public\" \"-//OASIS//ENTITIES DocBook XML Notations V4.3//EN\" \"file:///$_shareDirVal/xml/docbook/xml/4.3/dbnotnx.mod\" ./etc/xml/docbook"

    cmd /c "xmlcatalog --noout --add \"public\" \"-//OASIS//ENTITIES DocBook XML Character Entities V4.3//EN\" \"file:///$_shareDirVal/xml/docbook/xml/4.3/dbcentx.mod\" ./etc/xml/docbook"

    cmd /c "xmlcatalog --noout --add \"public\" \"-//OASIS//ENTITIES DocBook XML Additional General Entities V4.3//EN\" \"file:///$_shareDirVal/xml/docbook/xml/4.3/dbgenent.mod\" ./etc/xml/docbook"

    cmd /c "xmlcatalog --noout --add \"rewriteSystem\" \"http://www.oasis-open.org/docbook/xml/4.3\" \"file:///$_shareDirVal/xml/docbook/xml/4.3\" ./etc/xml/docbook"

    cmd /c "xmlcatalog --noout --add \"rewriteURI\" \"http://www.oasis-open.org/docbook/xml/4.3\" \"file:///$_shareDirVal/xml/docbook/xml/4.3\" ./etc/xml/docbook"

    mingleLog "Creating /etc/xml/catalog..." true
    
    if [ ! -e /etc/xml/catalog ]; then
        xmlcatalog --noout --create /etc/xml/catalog || mingleError $? "failed to create catalog, aborting!"
    else
        rm /etc/xml/catalog
        xmlcatalog --noout --create /etc/xml/catalog || mingleError $? "failed to create catalog, aborting!"
    fi

    cmd /c "xmlcatalog --noout --add \"delegatePublic\" \"-//OASIS//ENTITIES DocBook XML\" \"file:///$_etcDir/xml/docbook\" ./etc/xml/catalog"

    cmd /c "xmlcatalog --noout --add \"delegatePublic\" \"-//OASIS//DTD DocBook XML\" \"file:///$_etcDir/xml/docbook\" ./etc/xml/catalog"

    cmd /c "xmlcatalog --noout --add \"delegateSystem\" \"http://www.oasis-open.org/docbook\" \"file:///$_etcDir/xml/docbook\" ./etc/xml/catalog"

    cmd /c "xmlcatalog --noout --add \"delegateURI\" \"http://www.oasis-open.org/docbook\" \"file:///$_etcDir/xml/docbook\" ./etc/xml/catalog"

    cmd /c "xmlcatalog --noout --add \"rewriteSystem\" \"http://docbook.sourceforge.net/release/xsl/1.76.1\" \"file:///$_shareDirVal/xml/docbook/stylesheet/docbook-xsl\" ./etc/xml/catalog"

    cmd /c "xmlcatalog --noout --add \"rewriteURI\" \"http://docbook.sourceforge.net/release/xsl/1.76.1\" \"file:///$_shareDirVal/xml/docbook/stylesheet/docbook-xsl\" ./etc/xml/catalog"

    cmd /c "xmlcatalog --noout --add \"rewriteSystem\" \"http://docbook.sourceforge.net/release/xsl/current\" \"file:///$_shareDirVal/xml/docbook/stylesheet/docbook-xsl\" ./etc/xml/catalog"

    cmd /c "xmlcatalog --noout --add \"rewriteURI\" \"http://docbook.sourceforge.net/release/xsl/current\" \"file:///$_shareDirVal/xml/docbook/stylesheet/docbook-xsl\" ./etc/xml/catalog"

    ad_cd "$MINGLE_BUILD_DIR"
}

buildInstallGTKDoc() {
    local _project="gtk-doc-*"
    local _version="1.19"
    local _additionFlags=""
    local _binCheck="gtkdoc-check"
    local _exeToTest="gtkdoc-check --version"

    if [ ! -e "/mingw/bin/$_binCheck" ];then
        mingleLog "Building $_project..." true
    
        mingleCategoryDownload "gtk-doc" "$_version" "https://download.gnome.org/sources/gtk-doc/$_version/gtk-doc-$_version.tar.xz"
        mingleCategoryDecompress "gtk-doc" "$_version" "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)

        ad_cd "$_projectdir"

        if [ ! -e gtk-mingw.patch ]; then
            cp $MINGLE_BASE/patches/gtk/$_version/gtk-mingw.patch .
            ad_patch "gtk-mingw.patch"
        fi

        buildInstallGeneric "$_project" true true false true "-I m4" true true "$_additionFlags" "" "$_binCheck" "" "$_exeToTest"

        ad_cd "$MINGLE_BUILD_DIR"
    else
        mingleLog "$_project Already Installed." true
    fi
}

buildInstallGLib() {
    local _projectName="glib"
    local _version="2.34.3"
    local _url="http://ftp.gnome.org/pub/gnome/sources/glib/2.34/glib-2.34.3.tar.xz"
    local _target=""
    local _projectSearchName="$_projectName-*"
    local _projectDir=$(ad_getDirFromWC $_projectSearchName)
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=true #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--disable-silent-rules"
    local _makeParameters=""
    local _binCheck="libglib-2.0-0.dll"
    local _postBuildCommand=""
    local _exeToTest=""


    mingleLog "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_projectName..." true
    
        ad_setDefaultEnv
    
        export "CFLAGS=$CFLAGS -D__MINGW32__"
        export "CPPFLAGS=$CFLAGS"
        export "CXXFLAGS=$CFLAGS"
        export "LDFLAGS=$LDFLAGS -lmingle"
    
        mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
        mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"

        local _projectdir=$(ad_getDirFromWC $_projectSearchName)
        
        ad_cd "$_projectdir"

        if [ ! -e glib-mingw.patch ]; then
            cp $MINGLE_BASE/patches/$_projectName/$_version/glib-mingw.patch .
            ad_patch "glib-mingw.patch"    
        fi
        
        if [ -e glib/glibconfig.h ]; then
            ad_rm glib/glibconfig.h
        fi
        
        if [ ! -e ".deps" ]; then
            mkdir .deps
        fi
    
        mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    else
        mingleLog "$_projectName Already Installed." true
    fi
}

buildInstallGTK() {
    local _project="gtk-*"
}

buildInstallFFMpeg() {
    local _projectName="ffmpeg"
    local _version="2.3.1"
    local _url="http://ffmpeg.org/releases/ffmpeg-$_version.tar.bz2"
    local _target=""
    local _projectSearchName="ffmpeg-*"
    local _projectDir=$(ad_getDirFromWC $_projectSearchName)
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="ffmpeg"
    local _postBuildCommand=""
    local _exeToTest="ffmpeg -version"
    
    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallPJSIP() {
    local _projectName="pjproject"
    local _version="2.2.1"
    local _url="http://www.pjsip.org/release/$_version/pjproject-$_version.tar.bz2"
    local _target=""
    local _projectSearchName="pjproject-*"
    local _projectDir=$(ad_getDirFromWC $_projectSearchName)
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libpjsip-x86_64-w64-mingw32.a"
    local _postBuildCommand=""
    local _exeToTest=""
    
    mingleLog "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_projectName..." true    
    
        ad_setDefaultEnv
    
        export "CFLAGS=$CFLAGS -fpermissive"
        export "CPPFLAGS=$CFLAGS"
        export "CXXFLAGS=$CFLAGS"
    
        mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
        mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"

        local _projectdir=$(ad_getDirFromWC $_projectSearchName)
        
        ad_cd "$_projectdir"

        if [ ! -e pjproject-mingw.patch ]; then
            cp $MINGLE_BASE/patches/$_projectName/$_version/pjproject-mingw.patch .
            ad_patch "pjproject-mingw.patch"    
        fi    
    
        mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    else
        mingleLog "$_projectName Already Installed." true
    fi
}

buildInstallSDL() {
    local _projectName="SDL2"
    local _version="2.0.3"
    local _url="https://www.libsdl.org/release/SDL2-$_version.zip"
    local _target=""
    local _projectSearchName="SDL2-*"
    local _projectDir=$(ad_getDirFromWC $_projectSearchName)
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="SDL2.dll"
    local _postBuildCommand=""
    local _exeToTest=""
    
    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallRuby() {
    local _projectName="ruby"
    local _majorversion="2.1"
    local _version="2.1.2"
    local _url="http://cache.ruby-lang.org/pub/ruby/${_majorversion}/ruby-${_version}.tar.gz"
    local _target=""
    local _projectSearchName="ruby-*"
    local _projectDir=$(ad_getDirFromWC $_projectSearchName)
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="ruby.exe"
    local _postBuildCommand=""
    local _exeToTest=""
    
    ad_setDefaultEnv
        
    export "CFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64"
    export "CPPFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64"
    export "CXXFLAGS=$CPPFLAGS"
    # export "LDFLAGS=$LDFLAGS -lreadline"
    
    #To fix
    # Failed to configure dbm. It will not be installed.
    # Failed to configure fiddle. It will not be installed.
    # Failed to configure gdbm. It will not be installed.
    # Failed to configure pty. It will not be installed.
    # Failed to configure readline. It will not be installed.

    # Failed to configure syslog. It will not be installed.
    # Failed to configure tk. It will not be installed.
    # Failed to configure tk/tkutil. It will not be installed.

    
    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    
    if [ ! -e "/mingw/bin/ruby.exe" ] && [ -e "$MINGLE_BASE/mingw" ]; then
        cp -rf $MINGLE_BASE/mingw/* /mingw
        rm -rf $MINGLE_BASE/mingw
    fi
}

fixQTHeaderPaths() {
    local _projectPath=$1
    local _relPath=$2

    ad_cd "$_projectPath/$_relPath"

    find . -name "*_p.h"|
    while read filename; do
        sed 's/\.\.\/\.\.\/\.\.\/\.\.\/\.\.\//\.\.\/\.\.\/\.\.\/\.\.\//g' $filename>$filename.backup
        mv $filename.backup $filename
    done

    ad_cd "$_projectPath"
}

buildInstallQt() {
    local _projectName="qt"
    local _version="5.3.0"
    local _url="http://download.qt-project.org/archive/qt/5.3/5.3.0/single/qt-everywhere-opensource-src-5.3.0.tar.gz"
    local _target="qt-$_version.tar.gz"
    local _projectSearchName="qt-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _makeParameters=""
    local _binCheck="qtdiag.exe"
    local _postBuildCommand=""
    local _exeToTest="qtdiag.exe"
    
    mingleLog "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_projectName..." true
        
        ad_setDefaultEnv

        mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
        mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"
        
        local _projectDir=$(ad_getDirFromWC $_projectSearchName)
        
        ad_cd "$_projectDir"
        
        local _qtbase=`pwd`
        
        mingleLog "_qtbase = $_qtbase..." true

        # -fno-strict-aliasing
        export "CFLAGS=-D__MINGW__ -D_WIN64 -D__WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO -Wno-error=switch -Wno-error=strict-aliasing -Wno-error=sign-compare"
        export "CPPFLAGS=$CFLAGS"
        export "CXXFLAGS=$CFLAGS"
        export "LDFLAGS=$LDFLAGS" 
        
        local _configureFlags="-extprefix $MINGLE_BASE_MX/mingw64 -shared -opensource -confirm-license -platform win32-g++ -developer-build -c++11 -fontconfig -system-zlib -system-freetype -iconv -icu -system-harfbuzz -system-libpng -system-libjpeg -opengl desktop -openssl -plugin-sql-odbc -plugin-sql-sqlite -qt-pcre -qt-sql-psql -nomake tests -D__MINGW__ -D_WIN64 -D__WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO -I$MINGLE_BASE/mingw64/include -I$MINGLE_BASE/mingw64/include/freetype2 -I$_qtbase/qtwebkit/Source/WebCore/generated -L$_qtbase/dependencies -L/mingw/lib -lfontconfig -lfreetype -v"

        fixQTHeaderPaths "$_projectDir" "qtactiveqt/include"
        fixQTHeaderPaths "$_projectDir" "qtbase/include"
        fixQTHeaderPaths "$_projectDir" "qtconnectivity/include"
        fixQTHeaderPaths "$_projectDir" "qtdeclarative/include"
        fixQTHeaderPaths "$_projectDir" "qtenginio/include"
        fixQTHeaderPaths "$_projectDir" "qtlocation/include"
        fixQTHeaderPaths "$_projectDir" "qtmultimedia/include"
        fixQTHeaderPaths "$_projectDir" "qtquick1/include"
        fixQTHeaderPaths "$_projectDir" "qtscript/include"
        fixQTHeaderPaths "$_projectDir" "qtsensors/include"
        fixQTHeaderPaths "$_projectDir" "qtserialport/include"
        fixQTHeaderPaths "$_projectDir" "qtsvg/include"
        fixQTHeaderPaths "$_projectDir" "qttools/include"
        fixQTHeaderPaths "$_projectDir" "qtwebkit/include"
        fixQTHeaderPaths "$_projectDir" "qtwebsockets/include"
        fixQTHeaderPaths "$_projectDir" "qtwinextras/include"
        fixQTHeaderPaths "$_projectDir" "qtx11extras/include"
        fixQTHeaderPaths "$_projectDir" "qtxmlpatterns/include"

        ad_cd "$_projectDir"

        ad_auto_patch $_projectName $_version "$_projectDir"
        
        ad_cd "$_projectDir"

        export "PATH=$PATH:$(ad_cwd)/qtbase/lib"
        export QT_PLUGIN_PATH=/mingw/plugins
        echo "export QT_PLUGIN_PATH=/mingw/plugins">>/etc/profile

        mingleLog "PATH=$PATH" true
    
        ad_mkdir "dependencies"
    
        cp /mingw/lib/libicui18n.dll.a dependencies/libicuin.dll.a || mingleError $? "cp failed, aborting!"
        cp /mingw/lib/libicudata.dll.a dependencies/libicudt.dll.a || mingleError $? "cp failed, aborting!"
        
        mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"

        ad_cd "$_projectDir"
        
        make module-qtwebkit install
    else
        mingleLog "$_projectName Already Installed." true
    fi
}

buildInstallLibqrencode() {
    local _projectName="qrencode"
    local _version="3.4"
    local _url="https://github.com/fukuchi/libqrencode/archive/$_version.zip"
    local _target="libqrencode-$_version.zip"
    local _projectSearchName="libqrencode-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libqrencode.a"
    local _postBuildCommand=""
    local _exeToTest="qrencode.exe -V"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallMiniupnp () {
    local _projectName="miniupnp"
    local _version="11"
    local _url="https://github.com/onepremise/miniupnp/archive/master.zip"
    local _target="miniupnp-$_version.zip"
    local _projectSearchName="miniupnp-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libminiupnpc.dll.a"
    local _postBuildCommand=""
    local _exeToTest=""
    
    mingleLog "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
         mingleLog "Building $_project..." true
        
         ad_setDefaultEnv
         
         export "INSTALLPREFIX=/mingw"
         
         mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
         mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"

         local _projectdir=$(ad_getDirFromWC $_projectSearchName)
        
         ad_cd "$_projectdir/miniupnpc"
         
         make -f Makefile.mingw init upnpc-static upnpc-shared
         
         cp -rf miniupnpc.lib libminiupnpc.dll.a
         
         local HEADERS="bsdqueue.h miniupnpc.h miniwget.h upnpcommands.h igd_desc_parse.h upnpreplyparse.h upnperrors.h miniupnpctypes.h portlistingparse.h declspec.h"
         local LIBRARY="libminiupnpc.a libminiupnpc.dll.a"
         local UPNPCEXEDLL=miniupnpc.dll
         local INSTALLDIRINC=$INSTALLPREFIX/include/miniupnpc
         local INSTALLDIRLIB=$INSTALLPREFIX/lib
         local INSTALLDIRBIN=$INSTALLPREFIX/bin
         local INSTALLDIRMAN=$INSTALLPREFIX/share/man
         
         install -d $INSTALLDIRBIN
         install -d $INSTALLDIRINC
         install -d $INSTALLDIRLIB
         install -d $INSTALLDIRMAN/man3
         
         install -m 644 $HEADERS $INSTALLDIRINC || mingleError $? "failed to install headers, aborting!"
         install -m 644 $LIBRARY $INSTALLDIRLIB || mingleError $? "failed to install libraries, aborting!"
         install -m 644 $UPNPCEXEDLL $INSTALLDIRBIN || mingleError $? "failed to install dll, aborting!"
         install -m 755 external-ip.sh $INSTALLDIRBIN/external-ip || mingleError $? "failed to install external-ip, aborting!"
         install man3/miniupnpc.3 $INSTALLDIRMAN/man3/miniupnpc.3 || mingleError $? "failed to install miniupnpc.3, aborting!"
         gzip -f $INSTALLDIRMAN/man3/miniupnpc.3
     
         make -f Makefile.mingw pythonmodule PYTHON=python

         ad_cd "$MINGLE_BUILD_DIR"
     
         ad_run_test "$_exeToTest"
    else
        mingleLog "$_projectName Already Installed." true
    fi
}

buildInstallCryptocpp() {
    local _projectName="cryptopp"
    local _version="562"
    local _url="http://www.cryptopp.com/cryptopp$_version.zip"
    local _target="cryptopp$_version.zip"
    local _projectSearchName="cryptopp*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters="CXXFLAGS=\"-std=c++11 -DNDEBUG -Ofast -msse2 -msse3 -mssse3 -fno-keep-inline-dllexport $CXXFLAGS\" LDFLAGS=\"-Wl,--enable-auto-image-base\" PREFIX=\"/mingw\""
    local _binCheck="libcryptopp.a"
    local _postBuildCommand=""
    local _exeToTest=""
    
     mingleLog "Checking for binary $_binCheck..."
     if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
         mingleLog "Building $_projectName..." true
    
         mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
         mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName" "$_projectName"

         local _projectdir=$(ad_getDirFromWC $_projectSearchName)
        
         ad_cd "$_projectdir"

         #if [ ! -e $_projectName-mingw.patch ]; then
         #   cp $MINGLE_BASE/patches/$_projectName/$_version/$_projectName-mingw.patch .
         #   ad_patch "$_projectName-mingw.patch"
         #fi
         
         mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    else
        mingleLog "$_projectName Already Installed." true
    fi
}

buildInstallArgTable() {
    local _projectName="argtable"
    local _version="2-13"
    local _url="http://prdownloads.sourceforge.net/argtable/argtable$_version.tar.gz"
    local _target=""
    local _projectSearchName="argtable*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=false #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libargtable2.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallLibmicrohttpd() {
    local _projectName="libmicrohttpd"
    local _version="0.9.39"
    local _url="http://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-$_version.tar.gz"
    local _target="libmicrohttpd-$_version.tar.gz"
    local _projectSearchName="libmicrohttpd-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=false #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libmicrohttpd.a"
    local _postBuildCommand=""
    local _exeToTest=""

    ad_clearEnv
    
    export "CFLAGS=-I/mingw/include"
    
    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallJSONRPCCPP() {
    local _projectName="libjson-rpc-cpp"
    local _version="0.3.2"
    local _url="https://github.com/cinemast/libjson-rpc-cpp/archive/v$_version.zip"
    local _target="libjson-rpc-cpp-$_version.zip"
    local _projectSearchName="libjson-rpc-cpp-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=true #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libjsonrpccpp-common.a"
    local _postBuildCommand=""
    local _exeToTest=""

     mingleLog "Checking for binary $_binCheck..."
     if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
         mingleLog "Building $_projectName..." true
         
         ad_setDefaultEnv
         
         mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
         mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"

         local _projectdir=$(ad_getDirFromWC $_projectSearchName)
        
         ad_cd "$_projectdir"
         
         ad_mkdir win32-deps/include

         #if [ ! -e $_projectName-mingw.patch ]; then
         #   cp $MINGLE_BASE/patches/$_projectName/$_version/$_projectName-mingw.patch .
         #   ad_patch "$_projectName-mingw.patch"    
         #fi
         
         ad_cd "$MINGLE_BUILD_DIR"
	         
	 ad_mkdir $_projectName-build
	         
         ad_cd $_projectName-build
         
         cmake $_projectdir -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_BUILD_TYPE=Release -G "MSYS Makefiles" -DCMAKE_INSTALL_PREFIX:PATH=$MINGLE_BASE/mingw64 -DJSONCPP_INCLUDE_DIR=$MINGLE_BASE/mingw64/include -DJSONCPP_LIBRARY=$MINGLE_BASE/mingw64/lib/libjsoncpp.a -DCMAKE_CXX_FLAGS="-I$MINGLE_BASE/mingw64/include" -DBOOST_INCLUDEDIR=$MINGLE_BASE/mingw64/include/boost-1_56 -DBOOST_LIBRARYDIR=$MINGLE_BASE/lib -DBoost_COMPILER="-48" -DCMAKE_CXX_FLAGS="-I$MINGLE_BASE/mingw64/include -I$MINGLE_BASE/mingw64/include/boost-1_56" -DCMAKE_SHARED_LINKER_FLAGS="-Wl,--allow-multiple-definition" -DCMAKE_CXX_STANDARD_LIBRARIES="-lWs2_32"|| mingleError $? "cmake failed, aborting!"
         
         buildInstallGeneric "$_projectName-build" true false false false "" false false "" "" "$_binCheck" "" ""
         
         ad_cd "$MINGLE_BUILD_DIR"
         ad_cd $_projectName-build
         
         if [ "$_version" == "0.4.1"]; then
             cp -rf dist/* /mingw || mingleError $? "copy failed, aborting!"
         fi
    else
        mingleLog "$_projectName Already Installed." true
    fi
}

buildInstallBitcoin() {
    local _projectName="bitcoin"
    local _version="master"
    local _url="https://github.com/bitcoin/bitcoin/archive/master.zip"
    local _target="bitcoin-$_version.zip"
    local _projectSearchName="bitcoin-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--with-gui --with-qrencode --with-miniupnpc --enable-upnp-default --with-qt-incdir=/mingw/include --with-qt-libdir=/mingw/lib --with-boost=/mingw --with-boost-system=boost_system-48-mt-1_52 --with-boost-filesystem=boost_filesystem-48-mt-1_52 --with-boost-program-options=boost_program_options-48-mt-1_52 --with-boost-thread=boost_thread-48-mt-1_52 --with-boost-chrono=boost_chrono-48-mt-1_52 --with-incompatible-bdb --enable-shared"
    local _makeParameters="USE_QRCODE=1 USE_UPNP=1 USE_IPV6=1"
    local _binCheck="bitcoin-qt"
    local _postBuildCommand=""
    local _exeToTest=""
 
     mingleLog "Checking for binary $_binCheck..."
     if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
         mingleLog "Building $_projectName..." true
        
         ad_setDefaultEnv

         export "CFLAGS=$CFLAGS -I/mingw/include/boost-1_52 -DBOOST_USE_WINDOWS_H"
         export "CPPFLAGS=$CPPFLAGS -I/mingw/include/boost-1_52 -DBOOST_USE_WINDOWS_H"
         export "CXXFLAGS=$CXXFLAGS -I/mingw/include/boost-1_52 -DBOOST_USE_WINDOWS_H"
         export "LDFLAGS=$LDFLAGS -lboost_program_options-48-mt-1_52"
    
         mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
         mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"

         local _projectdir=$(ad_getDirFromWC $_projectSearchName)
        
         ad_cd "$_projectdir"

         if [ ! -e bitcoin-mingw.patch ]; then
            cp $MINGLE_BASE/patches/$_projectName/$_version/bitcoin-mingw.patch .
            ad_patch "bitcoin-mingw.patch"    
         fi
         
         mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
         
         ad_cd "$_projectdir"/src/leveldb/include
         
         cp -rf * /mingw/include/
         
         ad_cd ".."
         
         cp libleveldb.a /mingw/lib
         cp libmemenv.a /mingw/lib
    else
        mingleLog "$_projectName Already Installed." true
    fi
}

# WIP
buildInstallEthereum() {
    local _project="cpp-ethereum"
    local _url="https://github.com/onepremise/cpp-ethereum/archive/develop.zip"
    local _projectSearchName="cpp-ethereum*"
    local _version="master"
    local _binCheck="libethereum.dll.a"

    mingleLog "Checking $_project..." true
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] ); then
        mingleLog "Building $_project..." true

        mingleCategoryDownload "cpp-ethereum" "$_version" "$_url" "cpp-ethereum-$_version.zip"
        mingleCategoryDecompress "cpp-ethereum" "$_version" "$_projectSearchName"

        local _projectdir=$(ad_getDirFromWC $_projectSearchName)
        
        ad_cd "$MINGLE_BUILD_DIR"
        
        ad_mkdir cpp-ethereum-build
        
        ad_setDefaultEnv
        
        ad_cd cpp-ethereum-build
        
        export "CFLAGS=$CFLAGS -D_MSC_VER -I\"/mingw/include/boost-1_56\""
        export "LDFLAGS=$LDFLAGS -Wl,--allow-multiple-definition"
        
        #CXX_DEFINES
        cmake ../cpp-ethereum-develop -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_BUILD_TYPE=Release -G "MSYS Makefiles" -DCMAKE_INSTALL_PREFIX:PATH=$MINGLE_BASE/mingw64 -DPYTHON_INCLUDE_DIR:PATH=$MINGLE_BASE/mingw64/include/python2.7 -DBOOST_INCLUDEDIR=$MINGLE_BASE/mingw64/include/boost-1_56 -DBOOST_LIBRARYDIR=$MINGLE_BASE/lib -DBoost_COMPILER="-48" -DCRYPTOPP_INCLUDE_DIR=$MINGLE_BASE/mingw64/include -DCRYPTOPP_LIBRARY=$MINGLE_BASE/mingw64/lib/libcryptopp.a -DJSONCPP_INCLUDE_DIR=$MINGLE_BASE/mingw64/include -DJSONCPP_LIBRARY=$MINGLE_BASE/mingw64/lib/libjsoncpp.a -DJSON_RPC_CPP_INCLUDE_DIR=$MINGLE_BASE/mingw64/include -DJSON_RPC_CPP_COMMON_LIBRARY=$MINGLE_BASE/mingw64/lib/libjsonrpccpp-common.dll.a -DJSON_RPC_CPP_SERVER_LIBRARY=$MINGLE_BASE/mingw64/lib/libjsonrpccpp-server.dll.a -DJSON_RPC_CPP_CLIENT_LIBRARY=$MINGLE_BASE/mingw64/lib/libjsonrpccpp-client.dll.a -DCMAKE_CXX_FLAGS="-I$MINGLE_BASE/mingw64/include -I$MINGLE_BASE/mingw64/include/ncurses -DBOOST_USE_WINDOWS_H" -DCMAKE_SHARED_LINKER_FLAGS="-Wl,--allow-multiple-definition"|| mingleError $? "cmake failed, aborting!"
        
        #mingleError $? "cmake stop, aborting!"

        buildInstallGeneric "$_project-build" true true false false "" false false "" "" "$_binCheck" "" ""
    else
        mingleLog "Already Installed."  
    fi
}

buildInstallCpuMiner() {
    local _projectName="cpuminer"
    local _version="master"
    local _url="https://github.com/pooler/cpuminer/archive/master.zip"
    local _target="cpuminer-$_version.zip"
    local _projectSearchName="cpuminer-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="minerd"
    local _postBuildCommand=""
    local _exeToTest="minerd --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"

    if [ ! -e /mingw/bin/minerd-pooler.exe ]; then
        cp -f /mingw/bin/minerd.exe /mingw/bin/minerd-pooler.exe
    fi
}

buildInstallCpuMinerMulti() {
    local _projectName="cpuminer-multi"
    local _version="master"
    local _url="https://github.com/LucasJones/cpuminer-multi/archive/master.zip"
    local _target="cpuminer-multi-$_version.zip"
    local _projectSearchName="cpuminer-multi-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="minerd"
    local _postBuildCommand=""
    local _exeToTest="minerd --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"

    if [ ! -e /mingw/bin/minerd-multi.exe ]; then
        cp -f /mingw/bin/minerd.exe /mingw/bin/minerd-multi.exe
    fi
}

buildInstallSVN() {
    local _project="subversion-*"
    local _version="1.8.3"
    local _additionFlags="--libdir=/mingw/lib/perl/site/lib --with-swig --with-berkeley-db --enable-bdb6 --disable-nls --with-apr-util=/mingw --with-apr=/mingw --with-serf=/mingw --enable-shared PERL=/mingw/bin/perl MAKE=dmake"
    local _binCheck="svn.exe"
    local _exeToTest="svn --version"

    mingleLog "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
        
        ad_setDefaultEnv
        
        export "CFLAGS=-I/mingw/include -D_WIN64 -D__WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO -I$MINGLE_BASE_MX/mingw64/include/apr-1 -DAPU_DECLARE_STATIC -DAPR_DECLARE_STATIC -D__MINGW32__"
        export "CPPFLAGS=$CFLAGS"
        export "LDFLAGS=$LDFLAGS -L$MINGLE_BASE_MX/mingw64/x86_64-w64-mingw32/lib -lole32 -lmlang -luuid -lws2_32"
        export "LIBS=-lintl -lserf-1 -lpsapi -lversion"
        
        mingleLog MINGLE_BASE_MX=$MINGLE_BASE_MX
        
        mingleCategoryDownload "subversion" "$_version" "http://archive.apache.org/dist/subversion/subversion-$_version.zip"
        mingleCategoryDecompress "subversion" "$_version" "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)
        
        ad_cd "$_projectdir"

        if [ ! -e svn-mingw.patch ]; then
            cp $MINGLE_BASE/patches/subversion/$_version/svn-mingw.patch .
            ad_patch "svn-mingw.patch"
            cp $MINGLE_BASE/patches/subversion/$_version/bindings-mingw.patch .
            ad_patch "bindings-mingw.patch"
            cp $MINGLE_BASE/patches/subversion/$_version/auth-mingw.patch .
            ad_patch "auth-mingw.patch" 
            cp $MINGLE_BASE/patches/subversion/$_version/compiler-mingw.patch .
            ad_patch "compiler-mingw.patch"
            cp $MINGLE_BASE/patches/subversion/$_version/svn-po-mingw.patch .
            ad_patch "svn-po-mingw.patch"
        fi
        
        dos2unix build/generator/templates/build-outputs.mk.ezt

        ad_cd ".."
        
        # Make sure you build this with drive substitution turned on, "setup.bat -b -c"
        # Otherwise, gcc will crash from parsing paths, which concatenate out too long.
        # This causes segfault.
        buildInstallGeneric "$_project" false true false false "" false true "$_additionFlags" "" "$_binCheck" "" ""
        
        export "CFLAGS=$CFLAGS -I$MINGLE_BASE_MX/mingw64/include"
        
        ad_cd "$_projectdir"
        make check-swig-pl MAKE=dmake || mingleError $? "make check-swig-pl failed, aborting!"
        make install-swig-pl MAKE=dmake || mingleError $? "make install-swig-pl failed, aborting!"
        
        ad_cd "$MINGLE_BUILD_DIR"
    else
        mingleLog "$_project Already Installed." true
    fi

    ad_run_test "$_exeToTest"
    
    echo   
}

buildInstallGit() {
    local _project="git-*"
    local _binCheck="git.exe"
    local _exeToTest="git.exe --version"

    mingleLog "Checking $_project..." true
    
    if [ ! -e /mingw/bin/$_binCheck ]; then
        mingleLog "Building $_project..." true
        
        ad_clearEnv

        mingleCategoryDownload "git" "master" "https://github.com/onepremise/git/archive/master.zip" "git-master.zip"
        mingleCategoryDecompress "git" "master" "$_project"

        ad_cd $_project

        make CFLAGS='-O2 -Icompat/win32 -I/mingw/include -D__MINGW32__ -D__USE_MINGW_ANSI_STDIO -DWIN32 -DHAVE_MMAP -DPCRE_STATIC' LDFLAGS='-L/mingw/lib -lgrep' USE_LIBPCRE=Yes LIBPCREDIR=/mingw CURLDIR=/mingw EXPATDIR=/mingw PERL_PATH=/mingw/bin/perl.exe PYTHON_PATH=/mingw/bin/python.exe TCL_PATH=/mingw/bin/tclsh.exe TCLTK_PATH=/mingw/bin/tclsh.exe DEFAULT_EDITOR=/bin/vim NO_R_TO_GCC_LINKER=Yes NEEDS_LIBICONV=True V=1 prefix=/mingw CC=gcc INSTALL=/bin/install sysconfdir=/mingw/etc EXTLIBS='-lgrep -lws2_32 -lpcre -lz -liconv -lintl' || mingleError $? "make failed, aborting!"

        make install CFLAGS='-O2 -Icompat/win32 -I/mingw/include -D__MINGW32__ -D__USE_MINGW_ANSI_STDIO -DWIN32 -DHAVE_MMAP -DPCRE_STATIC' LDFLAGS='-L/mingw/lib -lgrep' USE_LIBPCRE=Yes LIBPCREDIR=/mingw CURLDIR=/mingw EXPATDIR=/mingw PERL_PATH=/mingw/bin/perl.exe PYTHON_PATH=/mingw/bin/python.exe TCL_PATH=/mingw/bin/tclsh.exe TCLTK_PATH=/mingw/bin/tclsh.exe DEFAULT_EDITOR=/bin/vim NO_R_TO_GCC_LINKER=Yes NEEDS_LIBICONV=True V=1 prefix=/mingw CC=gcc INSTALL=/bin/install sysconfdir=/mingw/etc EXTLIBS='-lgrep -lws2_32 -lpcre -lz -liconv -lintl' || mingleError $? "make install failed, aborting!"

        ad_cd ".."
        
    git config --system push.default matching || mingleError $? "git config failed, aborting!"
        git config --system http.sslcainfo $CURL_CA_BUNDLE || mingleError $? "git config failed, aborting!"
        
        ad_run_test "$_exeToTest"
    else
        mingleLog "$_project Already Installed." true      
    fi
    
    echo
}

buildInstallCABundle() {
    local _project="curl-*"
    local _version="7.28.1"
    
    mingleLog "Checking $_project..." true
    
    if [ -e /mingw/share/curl/ca-bundle.crt ]; then
        mingleLog "ca-bundle.crt Already Installed." true
        return;
    fi
    
    mingleLog "Building $_project..." true
    
    mingleCategoryDownload "curl" "$_version" "http://curl.haxx.se/download/curl-$_version.tar.bz2"
    mingleCategoryDecompress "curl" "$_version" "$_project"   
    
    local _projectDir=$(ad_getDirFromWC "$_project")
    
    ad_cd "$_projectDir"
    
    ./buildconf
    
    ./configure
    
    make ca-bundle
    
    cp lib/ca-bundle.crt /mingw/share/curl || mingleError $? "failed to generate ca-bundle.crt, aborting!"
    
    ad_cd ".."
}

buildInstallFontConfig() {
    local _project="fontconfig-*"
    local _version="2.10.0"
    local _additionFlags="--enable-libxml2 --disable-docs --enable-shared"
    local _binCheck="fc-list"
    local _exeToTest="fc-query --version"

    export "FREETYPE_LIBS=`freetype-config --libs`"

    mingleLog "Checking $_project..." true
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
    
        ad_setDefaultEnv

        mingleCategoryDownload "fontconfig" "$_version" "http://www.freedesktop.org/software/fontconfig/release/fontconfig-$_version.tar.gz"
        mingleCategoryDecompress "fontconfig" "$_version" "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)
        
        ad_cd "$_projectdir"
        
        if [ ! -e fontconfig-mingw.patch ]; then
            cp $MINGLE_BASE/patches/fontconfig/$_version/fontconfig-mingw.patch .
            ad_patch "fontconfig-mingw.patch"
        fi
        
        mkdir -p /mingw/share/fontconfig/conf.avail        
        cp -rf conf.d/*.conf /mingw/share/fontconfig/conf.avail
        
        ad_cd ".."
    
        #export "CFLAGS=$CFLAGS -DFC_DBG_CONFIG"
        ad_configure "$_project" false false false "" false "$_additionFlags"
        ad_make "$_project" ""

        local _shortProjectName=$(ad_getShortLibName $_project)
            
        mingleLog "Short Name: $_shortProjectName"
            
        ad_fix_shared_lib "$_shortProjectName"
    else
        mingleLog "$_project Already Installed." true
    fi
    
    ad_run_test "$_exeToTest"
    
    echo    
}

buildInstallFreeType() {
    local _project="freetype-*"
    local _version="2.4.10"
    
    mingleLog "Checking $_project..." true
    
    if [ ! -e /mingw/lib/libfreetype.a ]; then
        mingleLog "Building $_project..." true

        mingleCategoryDownload "freetype" "$_version" "http://ftp.igh.cnrs.fr/pub/nongnu/freetype/freetype-$_version.tar.gz"
        mingleCategoryDecompress "freetype" "$_version" "$_project"

        ad_cd freetype-*

        make setup unix
        ./configure --host=x86_64-w64-mingw32 --prefix=/mingw
        mkdir objs/.libs

        make || mingleError $? "make failed, aborting!"
        make install -i || mingleError $? "make install  failed, aborting!"

        ad_cd ".."
    else
        mingleLog "Already Installed." true
    fi
    
    echo
}

buildInstallGraphite2() {
    local _project="graphite2-*"
    local _version="1.2.4"
    local _binCheck="libgraphite2.dll"

    mingleLog "Checking $_project..." true
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] ); then
        mingleLog "Building $_project..." true

        mingleCategoryDownload "graphite2" "$_version" "http://sourceforge.net/projects/silgraphite/files/graphite2/graphite2-$_version.tgz"
        mingleCategoryDecompress "graphite2" "$_version" "$_project"

        ad_cd $_project

        cmake.exe -G "MSYS Makefiles" --debug-output -DGRAPHITE2_NTRACING=ON -DCMAKE_INSTALL_PREFIX=$MINGLE_BASE_MX/mingw64

        buildInstallGeneric "$_project" true true false false "" false false "" "" "$_binCheck" "" ""
    else
        mingleLog "Already Installed."  
    fi
}

buildInstallHarfBuzz() {
    local _projectName="harfbuzz"
    local _version="0.9.25"
    local _url="https://github.com/behdad/harfbuzz/archive/8fc1f7fe74a25bf8549f5edd79c7da6b720eb064.zip"
    local _target="harfbuzz-$_version.zip"
    local _projectSearchName="harfbuzz-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--with-graphite2=yes"
    local _makeParameters=""
    local _binCheck="libharfbuzz.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallSQLite() {
    local _projectName="sqlite"
    local _version="3071500"
    local _url="http://www.sqlite.org/sqlite-autoconf-$_version.tar.gz"
    local _target=""
    local _projectSearchName="sqlite-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libsqlite3.a"
    local _postBuildCommand=""
    local _exeToTest="sqlite3 --version"
    
    ad_setDefaultEnv
            
    export "CFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64 -O2"
    export "CPPFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64 -O2"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallICU() {
    local _project="icu4c-*"
    local _version="50_1"
    
    mingleLog "Checking $_project..." true
    
    if [ ! -e /mingw/lib/libicui18n.dll ]; then
        mingleLog "Building $_project..." true
        
        mingleCategoryDownload "icu4c" "$_version" "http://download.icu-project.org/files/icu4c/50.1/icu4c-$_version-src.tgz"
        mingleCategoryDecompress "icu4c" "$_version" "$_project"

        #Apply patch http://bugs.icu-project.org/trac/ticket/9728
        mingleLog "Applying patch from http://bugs.icu-project.org/trac/ticket/9728..."

        #wget http://bugs.icu-project.org/trac/export/32780/icu/trunk/source/common/unicode/platform.h
        #wget http://bugs.icu-project.org/trac/export/32780/icu/trunk/source/common/unicode/umachine.h
        #wget http://bugs.icu-project.org/trac/export/32780/icu/trunk/source/common/unicode/ustring.h
        #wget http://bugs.icu-project.org/trac/export/32780/icu/trunk/source/test/intltest/strtest.cpp

        #mv platform.h icu/source/common/unicode/
        #mv umachine.h icu/source/common/unicode/
        #mv ustring.h icu/source/common/unicode/
        #mv strtest.cpp icu/source/test/intltest/
        cd icu || mingleError $? "cd failed, aborting!"
        
        if [ ! -e icu-mingw.patch ]; then
            cp $MINGLE_BASE/patches/icu/$_version/icu-mingw.patch .
            ad_patch "icu-mingw.patch"
        fi  
        
        ad_cd source

        ./runConfigureICU MinGW  --prefix=/mingw

        make || mingleError $? "make failed, aborting!"
        make install || mingleError $? "make install failed, aborting!"
        
        cp -f /mingw/lib/libicu*.dll /mingw/bin
        
        #local _origPath=`pwd`
        #cd /mingw/lib
        #ad_rename "./icu.*.dll" "s/^icu/libicu/g"
        #cd "$_origPath"
        
        #cp /mingw/lib/libicuuc50.dll /mingw/bin/icuuc50.dll || mingleError $? "cp failed, aborting!"
        #cp /mingw/lib/libicudt50.dll /mingw/bin/icudt50.dll || mingleError $? "cp failed, aborting!"
        #cp /mingw/lib/libicuin.dll /mingw/lib/libicui18n.dll || mingleError $? "cp failed, aborting!"
        #cp /mingw/lib/libicudt.dll /mingw/lib/libicudata.dll || mingleError $? "cp failed, aborting!"
        
        #ad_cd ".."
        
        ad_create_libtool_la 'icui18n'
        ad_create_libtool_la 'icuuc'
        ad_create_libtool_la 'icudata'
        ad_create_libtool_la 'icuio'
        ad_create_libtool_la 'icule'
        ad_create_libtool_la 'iculx'
        ad_create_libtool_la 'icutu'
        ad_create_libtool_la 'icutest'
        
        #ad_generateImportLibraryForDLL 'libicui18n.dll'
        #ad_generateImportLibraryForDLL 'libicudata.dll'
        #ad_generateImportLibraryForDLL 'libicudt.dll'
        #ad_generateImportLibraryForDLL 'libicuin.dll'
        #ad_generateImportLibraryForDLL 'libicuio.dll'
        #ad_generateImportLibraryForDLL 'libicule.dll'
        #ad_generateImportLibraryForDLL 'libiculx.dll'
        #ad_generateImportLibraryForDLL 'libicutest.dll'
        #ad_generateImportLibraryForDLL 'libicutu.dll'
        #ad_generateImportLibraryForDLL 'libicuuc.dll'
        
        ad_cd "$MINGLE_BUILD_DIR"
    else
        mingleLog "Already Installed."
    fi  
    
    if ! icu-config --cflags; then
        mingleError $? "ICU Test Failed!"
    fi
}

buildInstallPostgres() {
    local _project="postgresql-*"
    local _version="9.2.2"
    
    mingleLog "Checking $_project..." true

    if [ -e /mingw/lib/libpq.dll ] && [ -e /mingw/bin/postgres.exe ]; then
        mingleLog "Already Installed."
        return;
    fi
    
    mingleLog "Building $_project..." true
    mingleCategoryDownload "postgresql" "$_version" "http://ftp.postgresql.org/pub/source/v$_version/postgresql-$_version.tar.gz"
    mingleCategoryDecompress "postgresql" "$_version" "$_project"

    local _projectDir=$(ad_getDirFromWC "$_project")

    ad_cd "$_projectDir"

    if [ ! -e postgresql-mingw.patch ]; then
        cp $MINGLE_BASE/patches/postgresql/$_version/postgresql-mingw.patch .
        ad_patch "postgresql-mingw.patch"
    fi

    ad_cd ".."

    export "CFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64"
    export "LDFLAGS=-L/mingw/lib"
    export "CPPFLAGS=-I/mingw/include  -D_WIN64 -DMS_WIN64"

    buildInstallGeneric "$_project" false true false false "" true true "" "" "postgres" "" "postgres --version"
    
    if [ -e /mingw/lib/libpq.dll ]; then
        cp -rf /mingw/lib/libpq.dll /mingw/bin
    fi

    ad_cd "$_projectDir"
    cd contrib/hstore || mingleError $? "cd failed, aborting!"

    make CFLAGS+=-I/mingw/include/postgresql/server CPPFLAGS+=-I/mingw/include/postgresql/server
    make install CFLAGS+=-I/mingw/include/postgresql/server CPPFLAGS+=-I/mingw/include/postgresql/server clean

    ad_cd "$MINGLE_BUILD_DIR"
}

buildInstallExpat() {
    local _projectName="expat"
    local _version="2.1.0"
    local _url="http://sourceforge.net/projects/expat/files/expat/$_version/expat-$_version.tar.gz"
    local _target=""
    local _projectSearchName="expat-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libexpat.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallLibproj() {
    local _projectName="proj"
    local _version="4.8.0"
    local _url="http://download.osgeo.org/proj/proj-$_version.tar.gz"
    local _target=""
    local _projectSearchName="proj-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libproj.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallProjDatumgrid() {
    local _project="proj-datumgrid*"
    local _version="1.6RC1"

    mingleLog "Checking $_project..." true
    
    if [ ! -e /mingw/share/proj/ntv1_can.dat ]; then
        mingleLog "Building $_project..." true
        
        mingleCategoryDownload "proj-datumgrid" "$_version" "http://download.osgeo.org/proj/proj-datumgrid-$_version.zip"
        mingleCategoryDecompress "proj-datumgrid" "$_version" "$_project" "proj-datumgrid"
        
        ad_cd $MINGLE_BUILD_DIR/proj-datumgrid

        cp -rf * /mingw/share/proj || mingleError $? "cp failed, aborting!"
     
        export PROJ_LIB=/mingw/share/proj

        mingleLog "export PROJ_LIB=/mingw/share/proj">>/etc/profile

        ad_cd "$MINGLE_BUILD_DIR"
    else
        mingleLog "Already Installed."        
    fi  
}

buildInstallLibGeotiff() {
    local _projectName="libgeotiff"
    local _version="1.4.0"
    local _url="ftp://ftp.remotesensing.org/pub/geotiff/libgeotiff/libgeotiff-$_version.zip"
    local _target=""
    local _projectSearchName="libgeotiff-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--enable-shared --enable-incode-epsg"
    local _makeParameters=""
    local _binCheck="libgeotiff.dll.a"
    local _postBuildCommand=""
    local _exeToTest="geotifcp"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    
    _configureFlags="--enable-static --enable-incode-epsg"
    _binCheck="libgeotiff.a"
    
    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallLibgeos() {
    local _projectName="geos"
    local _version="3.3.6"
    local _url="http://download.osgeo.org/geos/geos-$_version.tar.bz2"
    local _target=""
    local _projectSearchName="geos-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags="-I macros"
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libgeos.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallGDAL() {
    local _project="gdal-*"
    local _version="1.9.2"
    local _configureFlags=""
    local _binCheck="libgdal-1.dll"
    local _exeToTest="gdal_grid --version"
    
    mingleLog "Checking $_project..." true
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
    
        ad_setDefaultEnv
        
        mingleCategoryDownload "gdal" "$_version" "http://download.osgeo.org/gdal/gdal-$_version.tar.gz"
        mingleCategoryDecompress "gdal" "$_version" "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")

        ad_configure "$_project" true true true "" true "$_configureFlags"

        #Not sure why but libtool crashes in bash if you have CPPFLAGS set
        ad_clearEnv

        ad_make "$_project"
    else
        mingleLog "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
}

buildInstallPython() {
    local _project="Python-*"
    local _majorversion="2.7"
    local _minorversion=".3"
    local _version="$_majorversion$_minorversion"
    local _binCheck="python.exe"
    local _exeToTest="python --version"
    
    mingleLog "Checking $_project..." true
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
        
        ad_setDefaultEnv
        
        mingleCategoryDownload "Python" "$_version" "https://www.python.org/ftp/python/$_version/Python-$_version.tgz"
        mingleCategoryDecompress "Python" "$_version" "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")
        
        if ls -d cpython*/ &> /dev/null; then
            mv cpython* python-latest
        fi
        
        ad_cd $_projectDir
        
        if [ ! -e python-mingw.patch ]; then
            #http://bugs.python.org/issue3754
            #http://bugs.python.org/issue4709
            
            #my update
            cp $MINGLE_BASE/patches/python/$_version/python-mingw.patch .
            ad_patch "python-mingw.patch"
        fi

        mingleLog "Isolating dependencies..."

        if [ ! -e dependencies/include/sys ]; then
            mkdir -p dependencies/include/sys
            mkdir -p dependencies/lib
        fi

        cp -rf /mingw/lib/tcl* dependencies/lib/
        cp -rf /mingw/lib/libtcl* dependencies/lib/
        cp -rf /mingw/include/tcl* dependencies/include

        cp -rf /mingw/lib/libtk86.a dependencies/lib/
        cp -rf /mingw/include/tk* dependencies/include
        cp -rf /mingw/include/X11* dependencies/include

        cp -f /mingw/lib/libexpat.* dependencies/lib
        cp -f /mingw/include/expat* dependencies/include

        cp -f /mingw/lib/libz.* dependencies/lib
        cp -f /mingw/include/z* dependencies/include

        cp -f /mingw/lib/libsqlite* dependencies/lib
        cp -f /mingw/include/sqlite* dependencies/include

        cp -f /mingw/lib/libbz* dependencies/lib
        cp -f /mingw/include/bz* dependencies/include

        cp -f /mingw/lib/libcrypto* dependencies/lib
        cp -f /mingw/lib/libssl* dependencies/lib
        cp -rf /mingw/include/openssl* dependencies/include
        
        cp -f /mingw/include/mingle/sys/utsname.h dependencies/include/sys
        cp -f /mingw/include/mingle/mingw-path.h dependencies/include
        cp -f /mingw/lib/libmingle.a dependencies/lib
        
        echo "# Edit this file for local setup changes">Modules/Setup.local
        echo "_socket socketmodule.c">>Modules/Setup.local
        echo "_ssl _ssl.c -DUSE_SSL -lssl -lcrypto -lws2_32">>Modules/Setup.local

        ad_cd "$MINGLE_BUILD_DIR"
  
        export "CFLAGS=-IPC -D__MINGW32__ -Idependencies/include -I/mingw/ssl"
        export "CFLAGS=$CFLAGS -D_WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO -D__MINGLE__"

        export "CPPFLAGS=-IPC -D__MINGW32__ -Idependencies/include -I/mingw/ssl"
        export "CPPFLAGS=$CPPFLAGS -D_WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO -D__MINGLE__"
        
        export "LDFLAGS=-Ldependencies/lib"
        export "LIBS=-lmingle"
               
        ad_configure "$_project" false true false "" true "--with-libs=-lmingle --with-system-expat --enable-loadable-sqlite-extensions build_alias=x86_64-w64-mingw32 host_alias=x86_64-w64-mingw32 target_alias=x86_64-w64-mingw32"

        ad_cd "$MINGLE_BUILD_DIR"        

        ad_cd $_projectDir

        cp -f PC/pyconfig.h .
        
        ad_make $_project
        
        ln -s /mingw/bin/python$_majorversion /mingw/bin/python
    else
        mingleLog "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
}

buildInstallSetupTools() {
    local _savedir=`pwd`
    local _project="setuptools-*"
    local _majorversion="2.7"
    local _minorversion=".3"
    local _version="$_majorversion$_minorversion"    
    
    mingleLog "Checking $_project..." true
    if [ ! -e /mingw/lib/python$_majorversion/site-packages/easy_install.exe ]; then
        mingleLog "Downloading and configuring Python SetupTools..." true
        
        mingleCategoryDownload "Python" "0.6c11" "https://pypi.python.org/packages/source/s/setuptools/setuptools-0.6c11.tar.gz"
        mingleCategoryDecompress "Python" "0.6c11" "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")

        ad_cd $_project

        setup.py install --install-purelib `python -c "import sysconfig;print sysconfig.get_path('purelib')"` --install-scripts `python -c "import sysconfig;print sysconfig.get_path('purelib')"` --exec-prefix=`python -c "import sysconfig;print sysconfig.get_path('purelib')"`

        ad_cd /mingw/lib/python$_majorversion/site-packages
        
        echo "[easy_install]">setup.cfg
        echo >> setup.cfg
        echo "install_dir=`python -c "import sysconfig;print sysconfig.get_path('purelib')"`">> setup.cfg

        mingleLog "Complete."
    else
        mingleLog "Already Installed."
    fi

    cd $_savedir
}

buildInstallNose() {
    local _savedir=`pwd`
    local _majorversion="2.7"
    
    mingleLog "Checking Nose..." true
    
    if [ ! -e /mingw/lib/python$_majorversion/site-packages/nosetests.exe ]; then
        mingleLog "Downloading and configuring Nose..." true
        
        cd /mingw/lib/python$_majorversion/site-packages
        easy_install --install-dir=. nose
    else
        echo "Already Installed."
    fi

    ad_cd $_savedir
}

buildInstallWerkzeug() {
    mingleLog "Downloading and configuring Werkzeug..." true

    local _savedir=`pwd`
    local _majorversion="2.7"

    ad_cd /mingw/lib/python$_majorversion/site-packages
    
    easy_install --install-dir=. Werkzeug

    ad_cd $_savedir
}

buildInstallPyTest() {
    mingleLog "Downloading and configuring PyTest..." true

    local _savedir=`pwd`
    local _majorversion="2.7"

    ad_cd /mingw/lib/python$_majorversion/site-packages
    
    easy_install --install-dir=. pytest

    ad_cd $_savedir
}

buildInstallScons() {
    local _project="scons-*"
    local _version="2.3.0"
    local _pymajorversion="2.7"

    mingleLog "Checking $_project..." true
    if [ ! -e /mingw/bin/scons.py ]; then
        mingleLog "Building $_project..." true
        
        mingleCategoryDownload "scons" "$_version" "http://sourceforge.net/projects/scons/files/scons/$_version/scons-$_version.tar.gz"
        mingleCategoryDecompress "scons" "$_version" "$_project"

        local _projectdir=$(ad_getDirFromWC "$_project")

        ad_cd "$_projectdir"
        
        if [ ! -e scons-mingw.patch ]; then
             cp $MINGLE_BASE/patches/scons/$_version/scons-mingw.patch . || mingleError $? "patch failed, aborting!"
             ad_patch "scons-mingw.patch"
        fi                

        python setup.py install --install-lib "/mingw/lib/python$_pymajorversion/site-packages" --install-scripts "/mingw/bin" --no-install-bat --standard-lib
        
        ad_cd ".."
    else
        mingleLog "$_project Already Installed."
    fi    
}

buildInstallSerf() {
    local _project="serf-*"
    local _version="1.3.1"

    mingleLog "Checking $_project..." true
    if [ ! -e /mingw/lib/libserf-1.dll.a ]; then
        mingleLog "Building $_project..." true
        
        ad_setDefaultEnv
        
        mingleCategoryDownload "serf" "$_version" "https://serf.googlecode.com/files/serf-$_version.tar.bz2"
        mingleCategoryDecompress "serf" "$_version" "$_project"

        local _projectdir=$(ad_getDirFromWC "$_project")

        ad_cd "$_projectdir"
        
        if [ ! -e serf-mingw.patch ]; then
             cp $MINGLE_BASE/patches/serf/$_version/serf-mingw.patch . || mingleError $? "patch failed, aborting!"
             ad_patch "serf-mingw.patch"
        fi        

        scons.py APR=/mingw/include/apr-1 CC=gcc APU=/mingw/bin OPENSSL=/mingw PREFIX=/mingw ZLIB=/mingw/include --debug=explain APR_STATIC=True
        scons.py APR=/mingw/include/apr-1 CC=gcc APU=/mingw/bin OPENSSL=/mingw PREFIX=/mingw ZLIB=/mingw/include --debug=explain APR_STATIC=True install
        
        mv /mingw/lib/libserf-1.dll /mingw/bin || mingleError $? "Serf Install failed, aborting!"

        ad_cd ".."
    else
        mingleLog "$_project Already Installed."
    fi 
}

buildInstallTileLite() {
    local _savedir=`pwd`
    local _project="tilelite*"

    mingleLog "Checking $_project..." true
    if [ ! -e /mingw/lib/python$AD_PYTHON_MAJOR/site-packages/liteserv.py ]; then
        mingleLog "Downloading and configuring TileLite..." true
        
        mingleCategoryDownload "tilelite" "c1f84defd807" "https://bitbucket.org/springmeyer/tilelite/get/c1f84defd807.zip" "tilelite.zip"
        mingleCategoryDecompress "tilelite" "c1f84defd807" "$_project"        

        local _changenameof=`find . -maxdepth 1 -name "*tilelite*" -type d`

        if [ -n "$_changenameof" ] && [ ! -e "tilelite" ]; then
            mv $_changenameof tilelite || mingleError $? "mv failed, aborting!"
        fi

        local _projectDir=$(ad_getDirFromWC "$_project")

        cd $_project || mingleError $? "cd failed, aborting!"

        python setup.py install --install-purelib `python -c "import sysconfig;print sysconfig.get_path('purelib')"` --install-scripts `python -c "import sysconfig;print sysconfig.get_path('purelib')"` --exec-prefix=`python -c "import sysconfig;print sysconfig.get_path('purelib')"`
    else
        mingleLog "$_project Already Installed."
    fi

    cd $_savedir
}

# Developer abandoned, left for Go.
buildInstallNode() {
    local _projectName="node"
    local _version=""
    local _url=""
    local _target=""
    local _projectSearchName="node-v*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="xxx"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallNodeMapnik() {
    local _projectName="node-mapnik"
    local _version=""
    local _url=""
    local _target=""
    local _projectSearchName="node-mapnik*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="xxx"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallWAF() {
    local _project="waf-*"
    local _version="1.7.11"

    mingleLog "Checking $_project..." true
    if [ ! -e /mingw/bin/waf ]; then
        mingleLog "Building $_project..." true

        mingleCategoryDownload "waf" "$_version" "http://waf.googlecode.com/files/waf-$_version.tar.bz2"
        mingleCategoryDecompress "waf" "$_version" "$_project"
        
        local _projectdir=$(ad_getDirFromWC "$_project")

        ad_cd "$_projectdir"

        if [ ! -e waf-mingw.patch ]; then
             cp $MINGLE_BASE/patches/waf/$_version/waf-mingw.patch . || mingleError $? "patch failed, aborting!"
             ad_patch "waf-mingw.patch"
        fi

        ad_cd ".."

        buildInstallGeneric "waf-*" true true false false "" true true "" "" "waf" "" ""

        ad_cd "$_projectdir"

        cp waf /mingw/bin || mingleError $? "failed to install waf, aborting!"

        ad_cd ".."
    else
        mingleLog "$_project Already Installed."
    fi
}

buildInstallBoostJam() {
    local _projectName="boost-jam"
    local _version="3.1.18"
    local _url="http://sourceforge.net/projects/boost/files/boost-jam/$_version/boost-jam-$_version.tgz"
    local _target=""
    local _projectSearchName="boost-jam*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="bjam"
    local _postBuildCommand="cp bin.ntx86_64/*.exe /mingw/bin"
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallBoost52() {
    buildInstallBoost "52"
}

buildInstallBoost56() {
    buildInstallBoost "56"
}

buildInstallBoost() {
    local _minorversion="$1"
    local _pathversion="1.${_minorversion}.0"
    local _version="1_${_minorversion}_0"
    local _project="boost_${_version}*"
    local _binCheck="boost_system-48-mt-1_$_minorversion.dll"

    mingleLog "Checking $_project..." true
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true

        mingleCategoryDownload "boost" "$_version" "http://sourceforge.net/projects/boost/files/boost/"$_pathversion"/boost_"$_version".7z"
        mingleCategoryDecompress "boost" "$_version" "$_project"
        
        local _projectDir=$(ad_getDirFromWC "$_project")

        cd $_project || mingleError $? "cd failed, aborting!"

        if [ ! -e boost-mingw.patch ]; then
            # Apply patch for https://svn.boost.org/trac/boost/ticket/5023
            cp $MINGLE_BASE/patches/boost/$_pathversion/boost-mingw.patch .
            ad_patch "boost-mingw.patch"
        fi

        ad_cd ".."

        export CPLUS_INCLUDE_PATH=/mingw/include/python2.7
        buildInstallGeneric "$_project" true true false false "" true true "" "" "$_binCheck" "" ""
        export CPLUS_INCLUDE_PATH=

        ad_relocate_bin_dlls "boost_"
    else
        mingleLog "$_project Already Installed."
    fi
}

buildInstallPyCairo() {
    local _project="py2cairo-*"
    local _version="1.10.0"
    local _additionFlags=""
    local _binCheck="/pkgconfig/pycairo.pc"
    local _exeToTest=""
    
    mingleLog "Checking $_project..." true
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true

        ad_setDefaultEnv

        export "PYTHON_CONFIG=/mingw/bin/python2.7-config"
        export "CFLAGS=$CFLAGS -I/mingw/include/Python2.7"
        export "LDFLAGS=$LDFLAGS -lpixman-1"

        mingleCategoryDownload "py2cairo" "$_version" "http://www.cairographics.org/releases/py2cairo-$_version.tar.bz2"
        mingleCategoryDecompress "py2cairo" "$_version" "$_project"
        
        local _projectDir=$(ad_getDirFromWC "$_project")
        
        ad_cd "$_projectDir"
        
        #Expand waflib
        ./waf --version

        #patch waflib
        cd waf-*/waflib

        if [ ! -e waf-mingw.patch ]; then
            cp $MINGLE_BASE/patches/py2cairo/$_version/waf-mingw.patch .
            ad_patch "waf-mingw.patch"
            rm Node.pyc
        fi

        ad_cd ".."/..

        ./waf --version 2>&1|| mingleError $? "failed to patch pycairo, aborting!"

        ./waf configure --target=x86_64-w64-mingw32 --prefix=/mingw --libdir=/mingw/lib --check-c-compiler=gcc 2>&1 || mingleError $? "failed to configure pycairo, aborting!"
        ./waf build 2>&1 || mingleError $? "failed to build pycairo, aborting!"
        ./waf install 2>&1 || mingleError $? "failed to install pycairo, aborting!"

        if [ -e "/mingw/bin/pkgconfig/pycairo.pc" ]; then
            mv /mingw/bin/pkgconfig/pycairo.pc /mingw/lib/pkgconfig
            rmdir /mingw/bin/pkgconfig
            ad_fix_pkg_cfg "pycairo.pc"
        fi

        if [ -e "/mingw/bin/python2.7" ]; then
            cp -rf /mingw/bin/python2.7 /mingw/lib
            rm -rf /mingw/bin/python2.7
        fi
        
        ad_cd ".."
    else
        mingleLog "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
    
    echo      
}

buildInstallMapnik() {
    local _project="mapnik-v*"
    local _version="2.1.0"

    mingleLog "Checking $_project..." true
    if [ -e /mingw/lib/mapnik.dll ] && [ -e /mingw/lib/libmapnik.dll.a ]; then
        mingleLog "$_project Already Installed." 
        return
    fi
    
    mingleLog "Building $_project..." true
    
    mingleCategoryDownload "mapnik" "$_version" "https://github.com/downloads/mapnik/mapnik/mapnik-v$_version.tar.bz2"
    mingleCategoryDecompress "mapnik" "$_version" "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)

    ad_cd "$_projectdir"
        
    if [ ! -e mapnik-mingw.patch ]; then
         #my update
         cp $MINGLE_BASE/patches/mapnik/$_version/mapnik-mingw.patch .
         ad_patch "mapnik-mingw.patch"
    fi

    ad_cd ".."

    buildInstallGeneric "$_project" true true false false "" true true "PREFIX=/mingw CUSTOM_CXXFLAGS=-DMS_WIN64 BOOST_INCLUDES=/mingw/include/boost-1_53 BOOST_LIBS=/mingw/lib CC=x86_64-w64-mingw32-gcc-4.7.2.exe CXX=x86_64-w64-mingw32-g++.exe" "" "mapnik.dll" "" "mapnik-config --version"

    ln -sf /mingw/lib/mapnik.dll /mingw/bin/mapnik.dll || mingleError $? "Mapnik install failed, aborting!"
}

buildInstallMapnikDev() {
    local _project="mapnik-*"

    mingleLog "Checking $_project..." true
    if [ -e /mingw/lib/mapnik.dll ] && [ -e /mingw/lib/libmapnik.dll.a ]; then
        mingleLog "$_project Already Installed." 
        return
    fi
    
    mingleLog "Building $_project..." true
    
    mingleCategoryDownload "mapnik" "master" "https://github.com/onepremise/mapnik/archive/master.zip" "mapnik-master.zip"
    mingleCategoryDecompress "mapnik" "master" "$_project"

    buildInstallGeneric "$_project" true true false false "" true true "PREFIX=/mingw CUSTOM_CXXFLAGS=-DMS_WIN64 CUSTOM_CXXFLAGS=-D__MINGW__ BOOST_INCLUDES=/mingw/include/boost-1_53 BOOST_LIBS=/mingw/lib CC=gcc.exe CXX=g++.exe" "" "mapnik.dll" "" "mapnik-config --version"

    ln -sf /mingw/lib/mapnik.dll /mingw/bin/mapnik.dll || mingleError $? "Mapnik install failed, aborting!"
}

buildInstallMapnikStylesheets() {
    local _project="mapnik-stylesheets*"
    
    mingleLog "Building $_project..." true

    mingleCategoryDownload "mapnik-stylesheets" "master" "https://github.com/openstreetmap/mapnik-stylesheets/archive/master.zip" "mapnik-stylesheets.zip"
    mingleCategoryDecompress "mapnik-stylesheets" "master" "$_project"    

    local _projectdir=$(ad_getDirFromWC $_project)

    ad_cd "$_projectdir"

    if [ ! -e "world_boundaries-spherical.tgz" ];then
        wget http://tile.openstreetmap.org/world_boundaries-spherical.tgz
        tar xzf world_boundaries-spherical.tgz
    fi

    if [ ! -e "processed_p.tar.bz2" ];then
        wget http://tile.openstreetmap.org/processed_p.tar.bz2
        tar xjf processed_p.tar.bz2 -C world_boundaries
    fi

    if [ ! -e "shoreline_300.tar.bz2" ];then
        wget http://tile.openstreetmap.org/shoreline_300.tar.bz2
        tar xjf shoreline_300.tar.bz2 -C world_boundaries
    fi

    if [ ! -e "ne_10m_populated_places.zip" ];then
        wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_populated_places.zip
        unzip -q ne_10m_populated_places.zip -d world_boundaries
    fi

    if [ ! -e "ne_110m_admin_0_boundary_lines_land.zip" ];then
        wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_boundary_lines_land.zip
        unzip -q ne_110m_admin_0_boundary_lines_land.zip -d world_boundaries
    fi

    # generate_xml.py --host=localhost --port=5432 --dbname osm --user osm --password osm --accept-none osm.xml ha-osm.xml generate_xml.py --host=localhost --port=5432 --dbname osm --user osm --password osm --accept-none osm.xml ha-osm.xml

    # liteserv.py mapnik-xml/ha-osm.xml
    # liteserv.py mapnik-xml/ha-osm.xml --processes=4 --caching
    # liteserv.py mapnik-xml/ha-osm.xml --caching

    ad_cd ".."
}

buildInstalldMake() {
    local _project="dmake*"

    mingleLog "Checking Environment for $_project..." true
    if ! grep MAKESTARTUP /etc/profile; then
        echo
        echo "Adding MAKESTARTUP to profile..."
        echo
        export MAKESTARTUP=/usr/local/lib/dmake/startup/startup.mk
        echo "export MAKESTARTUP=/usr/local/lib/dmake/startup/startup.mk">>/etc/profile
    fi

    mingleLog "Checking $_project..." true
    if [ -e /usr/local/bin/dmake ]; then
        echo "$_project Already Installed." 
        echo
        return
    fi
    
    mingleLog "Installing $_project..." true
    
    mingleCategoryDownload "dmake" "4.12.2.2" "http://search.cpan.org/CPAN/authors/id/S/SH/SHAY/dmake-4.12.2.2.zip"
    mingleCategoryDecompress "dmake" "4.12.2.2" "$_project"  

    local _projectdir=$(ad_getDirFromWC $_project)

    cp $_projectdir/dmake /usr/local/bin
    mkdir /usr/local/lib/dmake
    cp -rf $_projectdir/startup /usr/local/lib/dmake
    
    export MAKESTARTUP=/usr/local/lib/dmake/startup/startup.mk

    echo "export MAKESTARTUP=/usr/local/lib/dmake/startup/startup.mk">>/etc/profile
}

buildInstallPerl() {
    local _project="perl*"
    local _version="5.18.0"
    local _shortversion="5.0"

    mingleLog "Checking $_project..." true
    if [ -e /mingw/bin/perl5.18.0 ]; then
        echo "$_project Already Installed." 
        echo
        return
    fi

    mingleLog "Building $_project..." true
    
    ad_setDefaultEnv

    mingleCategoryDownload "perl" "$_version" "http://www.cpan.org/src/$_shortversion/perl-$_version.tar.gz"
    mingleCategoryDecompress "perl" "$_version" "$_project"
    
    local _projectdir=$(ad_getDirFromWC $_project)

    ad_cd $_projectdir

    #Notes from http://sourceforge.net/projects/perlmingw/files/Compiler%20for%2064%20bit%20Windows/
    if [ ! -e perl-mingw.patch ]; then
         cp $MINGLE_BASE/patches/perl/$_version/perl-mingw.patch .
         ad_patch "perl-mingw.patch"
    fi

    # Remove if old default config preexists
    if [ -e config.sh ]; then
        rm config.sh
    fi

    ad_cd win32

    local _perl_install=`echo $MINGLE_BASE_DOS | sed -e 's/:$/:\\\/g' -e 's/\\\/\\\\\\\/g'`
    
    mingleLog "Executing dmake MINGLE_BASE*=$_perl_install..."

    dmake MINGLE_BASE*=$_perl_install || mingleError $? "dmake failed, aborting!"

    mingleLog "Executing dmake install MINGLE_BASE*=$_perl_install..."
    dmake install MINGLE_BASE*=$_perl_install || mingleError $? "dmake install failed, aborting!"

    ad_cd ".."/..
}

buildInstallPCRE() {
    local _project="pcre-*"
    local _version="8.33"

    mingleLog "Checking $_project..." true
    if [ -e /mingw/bin/pcregrep ]; then
        echo "$_project Already Installed." 
        echo
        return
    fi
    
    mingleLog "Building $_project..." true

    mingleCategoryDownload "pcre" "$_version" "http://sourceforge.net/projects/pcre/files/pcre/$_version/pcre-$_version.tar.gz/download" "pcre-$AD_PCRE_VERSION.tar.gz"
    mingleCategoryDecompress "pcre" "$_version" "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)

    ad_cd $_projectdir

    if [ ! -e pcre-mingw.patch ]; then
         cp $MINGLE_BASE/patches/pcre/$_version/pcre-mingw.patch .
         ad_patch "pcre-mingw.patch"
    fi

    buildInstallGeneric "$_project" true true false true "-I m4" true true "--disable-cpp --disable-shared --enable-newline-is-anycrlf --enable-utf8 --enable-unicode-properties" "" "pcregrep" "" ""
}

buildInstallCPANMinus() {
    mingleLog "Checking for cpanm..." true
    
    if [ -e /mingw/bin/cpanm ]; then
        echo "CPAN Minus Already Installed." 
        echo
        return     
    fi
    
    mingleLog "Installing cpanm..." true
    
    mingleCategoryDownload "cpanm" "master" "https://raw.github.com/miyagawa/cpanminus/master/cpanm"
    
    cp $MINGLE_CACHE/cpanm/master/cpanm /mingw/bin
}

buildInstallEncode() {
    mingleLog "Checking for Encode..." true
    
    if [ -e /mingw/lib/perl/site/lib/Encode/Encoder.pm ]; then
        mingleLog "CPAN Encode Already Installed."
        return     
    fi
    
    mingleLog "Installing Encode..." true
    
    cpanm Encode
    
    if [ ! -e /mingw/lib/perl/site/lib/Encode/Encoder.pm ]; then
        mingleError 9999 "Encode install failed, aborting!"
    fi
}

buildInstallDBPerl() {
    mingleLog "Checking for DBPerl..." true
    if [ -e /mingw/lib/perl/site/lib/BerkeleyDB.pm ] && [ -e /mingw/lib/perl/site/lib/DB_File.pm ]; then
        mingleLog "BerkeleyDB Encode Already Installed."
        return     
    fi
    
    mingleLog "Building DBPerl..." true
    
    local _project="BerkeleyDB-*"
    local _version="0.53"
    
    mingleCategoryDownload "BerkeleyDB" "$_version" "http://search.cpan.org/CPAN/authors/id/P/PM/PMQS/BerkeleyDB-$_version.tar.gz"
    mingleCategoryDecompress "BerkeleyDB" "$_version" "$_project"
    
    local _projectdir=$(ad_getDirFromWC $_project)
    
    ad_cd "$_projectdir"
    
    perl Makefile.PL INC=-I/mingw/include LIBS="-lpthread -ldb-6.0.dll"
    dmake
    dmake test
    dmake install
    
    ad_cd "$MINGLE_BUILD_DIR"
    
    local _project="DB_File-*"
    local _version="1.829"
    
    mingleCategoryDownload "DB_File" "$_version" "http://search.cpan.org/CPAN/authors/id/P/PM/PMQS/DB_File-$_version.tar.gz"
    mingleCategoryDecompress "DB_File" "$_version" "$_project"
    
    _projectdir=$(ad_getDirFromWC $_project)   
    
    ad_cd "$_projectdir"
    
    perl Makefile.PL INC=-I/mingw/include LIBS="-lpthread -ldb-6.0.dll"
    dmake
    dmake test
    dmake install
    
    ad_cd ".."
    
    if [ ! -e /mingw/lib/perl/site/lib/BerkeleyDB.pm ] || [ ! -e /mingw/lib/perl/site/lib/DB_File.pm ]; then
        mingleError 9999 "BerkeleyDB and DBFile install failed, aborting!"
    fi
}

buildInstallUserAgent() {
    mingleLog "Checking for UserAgent..." true
    if [ -e /mingw/lib/perl/site/lib/LWP/UserAgent.pm ]; then
        echo "CPAN UserAgent Already Installed." 
        echo
        return     
    fi
    
    mingleLog "Installing UserAgent..." true
    
    cpanm --local-lib /mingw/lib/perl/site LWP::UserAgent
    
    cp -rf /mingw/lib/perl/site/lib/perl5/* /mingw/lib/perl/site/lib
    rm -rf /mingw/lib/perl/site/lib/perl5
    mv -f /mingw/lib/perl/site/bin/* /mingw/bin
    rmdir /mingw/lib/perl/site/bin
    
    if [ ! -e /mingw/lib/perl/site/lib/LWP/UserAgent.pm ]; then
        mingleError 9999 "UserAgent install failed, aborting!"
    fi
}

buildInstallTextInfo() {
    local _project="texinfo-*"
    local _version="5.1"

    mingleLog "Checking $_project..." true
    if [ -e /mingw/bin/texi2any ]; then
        mingleLog "$_project Already Installed." true
        return
    fi
    
    ad_setDefaultEnv

    export "CFLAGS=$CFLAGS -D__MINGW32__"
    export "LIBS=$LIBS -lmingle -lws2_32"
    export "CC=x86_64-w64-mingw32-gcc -I/mingw/include/mingle"
    export "CXX=x86_64-w64-mingw32-gcc -I/mingw/include/mingle"
    
    mingleLog "Building $_project..." true
    
    mingleCategoryDownload "texinfo" "$_version" "http://ftp.gnu.org/gnu/texinfo/texinfo-$_version.tar.gz"
    mingleCategoryDecompress "texinfo" "$_version" "$_project"
    
    local _projectdir=$(ad_getDirFromWC $_project)

    ad_cd $_projectdir

    if [ ! -e texinfo-mingw.patch ]; then
         cp $MINGLE_BASE/patches/texinfo/$_version/texinfo-mingw.patch .
         ad_patch "texinfo-mingw.patch"
    fi
    
    buildInstallGeneric "$_project" false true false true "-I gnulib/m4" true true "" "" "texi2any" "" "texi2any --version"
}

buildInstallGetText() {
    local _projectName="gettext"
    local _version="0.19"
    local _url="http://ftp.gnu.org/pub/gnu/gettext/gettext-$_version.tar.gz"
    local _target=""
    local _projectSearchName="gettext-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=false #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--enable-shared --enable-static"
    local _makeParameters=""
    local _binCheck="gettext"
    local _postBuildCommand=""
    local _exeToTest="gettext --version"
    
    mingleLog "Checking $_projectName..." true
    if [ -e /mingw/bin/$_binCheck ]; then
        mingleLog "$_projectName Already Installed." true
        return
    fi
    
    mingleLog "Building $_projectName..." true
    
    mingleCategoryDownload "$_projectName" "$_version" "$_url"
    mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"
    
    local _projectdir=$(ad_getDirFromWC $_projectSearchName)

    ad_cd $_projectdir

    if [ ! -e $_projectName-mingw.patch ]; then
         cp $MINGLE_BASE/patches/$_projectName/$_version/$_projectName-mingw.patch .
         ad_patch "$_projectName-mingw.patch"
    fi
    
    ad_setDefaultEnv
    
    export "CFLAGS=-I/mingw/include -D_WIN64 -D__WIN64 -DMS_WIN64 -O2 -D__MINGW32__ -D__USE_MINGW_ANSI_STDIO"
    export "CPPFLAGS=$CFLAGS"
    export "CXXFLAGS=$CPPFLAGS"
    export "CC=x86_64-w64-mingw32-gcc"
    export "CXX=x86_64-w64-mingw32-g++"    
    
    buildInstallGeneric "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"

    #Currently, msmerge hangs.
    if [ -e /mingw/bin/msgmerge.exe ]; then
        mv /mingw/bin/msgmerge.exe /mingw/bin/msgmerge.exe.disabled
    fi
    
    #copy libgrep.a and langinfo.h
    #gettext-tools/libgrep
    
    ad_cd $_projectdir
    
    if [ -e gettext-tools/libgrep/libgrep.a ]; then
        mingleLog "Installing libgrep..." true
        cp gettext-tools/libgrep/libgrep.a /mingw/lib
        cp gettext-tools/libgrep/langinfo.h /mingw/include
    fi
}

buildInstallSwig() {
    mingleLog "Checking $_project..." true
    if [ -e /usr/local/bin/swig ]; then
        mingleLog "$_project Already Installed." true
        return
    fi
    
    local _projectName="swig"
    local _version="2.0.10"
    local _url="http://downloads.sourceforge.net/project/swig/swig/swig-$_version/swig-$_version.tar.gz"
    local _target=""
    local _projectSearchName="swig-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="swig"
    local _postBuildCommand=""
    local _exeToTest="swig -version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    
    export "SWIG_LIB=/mingw/share/swig/2.0.10"
    echo "export SWIG_LIB=/mingw/share/swig/2.0.10">>/etc/profile
}

buildInstallJSONC() {   
    local _projectName="json-c"
    local _version="ec4879ac5b502ae81f6b73450b960ede11ad2560"
    local _url="https://github.com/json-c/json-c/archive/$_version.zip"
    local _target="json-c-$_version.zip"
    local _projectSearchName="json-c-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters="LN_S=ln -s"
    local _binCheck="libjson-c-2.dll"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"    

    if [ ! -e /mingw/include/json ]; then
        ln -s /mingw/include/json-c/ /mingw/include/json || mingleError $? "json-c: ln failed, aborting!"
    fi
}

buildInstallJSONCPP() {   
    local _projectName="jsoncpp"
    local _version="1.0.0"
    local _url="https://github.com/open-source-parsers/jsoncpp/archive/$_version.tar.gz"
    local _target="jsoncpp-$_version.tar.gz"
    local _projectSearchName="jsoncpp*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=false #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=false #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libjsoncpp.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleLog "Checking $_projectName..." true
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] ); then
        mingleLog "Building $_project..." true

        mingleCategoryDownload "$_projectName" "$_version" "$_url" "$_target"
        mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"

        local _projectdir=$(ad_getDirFromWC $_projectSearchName)
        
        ad_cd "$MINGLE_BUILD_DIR"
        
        ad_mkdir jsoncpp-build
        
        ad_setDefaultEnv
        
        ad_cd jsoncpp-build
        
        ad_mkdir jsoncpp/include
        ad_mkdir jsoncpp/lib
        
        #CXX_DEFINES
        cmake ../$_projectName-$_version -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_BUILD_TYPE=Release -G "MSYS Makefiles" -DCMAKE_INSTALL_PREFIX:PATH=$MINGLE_BUILD_DIR/jsoncpp-build/jsoncpp -DCMAKE_CXX_FLAGS="-std=c++11" || mingleError $? "cmake failed, aborting!"

        buildInstallGeneric "$_projectName-build" true true false false "" false false "" "" "$_binCheck" "" ""
        
        ad_mkdir $MINGLE_BASE/mingw64/include/jsoncpp
        
        cp -rf jsoncpp/include/json $MINGLE_BASE/mingw64/include/jsoncpp || mingleError $? "jsoncpp: cp failed, aborting!"
        cp -rf jsoncpp/lib/* $MINGLE_BASE/mingw64/lib || mingleError $? "jsoncpp: cp failed, aborting!"
    else
        mingleLog "Already Installed."  
    fi  
}

buildInstallPostGIS () {
    local _project="postgis-*"
    local _version="2.0.3"

    if [ -e /mingw/lib/postgresql/postgis-2.0.dll ]; then
        mingleLog "$_project Already Installed." true
        return
    fi
    
    mingleCategoryDownload "postgis" "$_version" "http://download.osgeo.org/postgis/source/postgis-$_version.tar.gz"
    mingleCategoryDecompress "postgis" "$_version" "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)

    ad_cd $_projectdir

    if [ ! -e postgis-mingw.patch ]; then
         cp $MINGLE_BASE/patches/postgis/$_version/postgis-mingw.patch .
         ad_patch "postgis-mingw.patch"
    fi
        
    export "PG_CPPFLAGS=-D__ERRCODE_DEFINED_MS"

    buildInstallGeneric "$_project" true true false false "" true true "--with-jsondir=/mingw" "" "/mingw/lib/postgresql/postgis-2.0.dll" "" ""
}

updatePostgresSqlConf() {
    local _variable=$1
    local _value=$2
    
    mingleLog "Updating $_variable=$_value..."
    
    sed -e "s/[#]*\("$_variable"\)\s*=\s*[[:alnum:]\.\_\%\'-]*/\1="$_value"/g" $POSTGIS_PATH/postgresql.conf>$POSTGIS_PATH/update.conf
    mv $POSTGIS_PATH/update.conf $POSTGIS_PATH/postgresql.conf    
}

initializePostGISDB () {
    mingleLog "Creating PostGIS Database..." true

    export PGPASSWORD=temp123

    initdb -U postgres -D $POSTGIS_PATH -E 'UTF8' --lc-collate='English_United States.1252' --lc-ctype='English_United States.1252'

    # Tune Parameters for postgresql.conf
    # autovacuum=off
    # checkpoint_segments=20
    # shared_buffers=512MB # min 128kB
    # work_mem=256MB # min 64kB
    # maintenance_work_mem=512MB # min 1MB
    # synchronous_commit=off

    mingleLog "Updating postgresql.conf..." true
    
    if [ ! -e $POSTGIS_PATH/postgresql.conf.bak ]; then
        cp $POSTGIS_PATH/postgresql.conf $POSTGIS_PATH/postgresql.conf.bak
    fi
    
    updatePostgresSqlConf 'autovacuum' 'on'
    updatePostgresSqlConf 'checkpoint_segments' 64
    updatePostgresSqlConf 'checkpoint_timeout' '15min'
    updatePostgresSqlConf 'checkpoint_completion_target' '0\.9'
    
    updatePostgresSqlConf 'shared_buffers' '2GB'
    updatePostgresSqlConf 'work_mem' '256MB'
    updatePostgresSqlConf 'maintenance_work_mem' '1GB'
    updatePostgresSqlConf 'synchronous_commit' 'off'
    updatePostgresSqlConf 'wal_level' 'minimal'
    
    updatePostgresSqlConf 'log_directory' "'log'"
    updatePostgresSqlConf 'log_filename' "'postgresql-%Y-%m-%d_%H%M%S.log'"
    updatePostgresSqlConf 'log_destination' "'stderr'"
    #updatePostgresSqlConf 'redirect_stderr' 'on'
    updatePostgresSqlConf 'logging_collector' 'on'
    updatePostgresSqlConf 'log_truncate_on_rotation' 'off'
    updatePostgresSqlConf 'log_rotation_age' '7d'
    updatePostgresSqlConf 'log_rotation_size' '10MB'
    
    updatePostgresSqlConf 'log_connections' 'on'
    updatePostgresSqlConf 'log_disconnections' 'on'
    updatePostgresSqlConf 'log_line_prefix' "'user=%u,db=%d,%m'"

    pg_ctl start -w -D "$POSTGIS_PATH"

    mingleLog "Setting up OSM database, user, and granting permissions..."

    psql postgres postgres <<< "CREATE USER osm WITH PASSWORD 'osm';"
    psql postgres postgres <<< "CREATE DATABASE osm WITH OWNER=osm ENCODING='UTF8' TABLESPACE=pg_default LC_COLLATE='English_United States.1252' LC_CTYPE='English_United States.1252' CONNECTION LIMIT=-1;"
    psql postgres postgres <<< "GRANT ALL PRIVILEGES ON DATABASE osm to osm;"
    psql postgres postgres <<< "ALTER USER osm WITH SUPERUSER;"

    export PGPASSWORD=osm

    mingleLog "Deploying PostGIS..." true

    psql -d osm -U osm -c 'create extension hstore'
    psql -U osm -d osm -f /mingw/share/postgresql/contrib/postgis-2.0/postgis.sql
    psql -U osm -d osm -f /mingw/share/postgresql/contrib/postgis-2.0/spatial_ref_sys.sql

    mingleLog "Initialization Complete."
    mingleLog "Your OSM dbname=osm, username=osm, password=osm."
    mingleLog "However, I recommend updating your password for production use as a start."
}

installPostgresqlService() {
    local _startup=$1
    
    ad_cd $POSTGIS_PATH
    
    local _winpath=`pwd -W`
    
    pg_ctl stop -w -D "/mingw/var/lib/postgres/$AD_POSTGRES_VERSION/main"
    pg_ctl register -w -N "PostGIS Database" -D $_winpath
    
    if $_startup; then
        net start "PostGIS Database"
    fi
}

uninstallPostgresql() {
  ad_cd $POSTGIS_PATH
  
  local _winpath=`pwd -W`
  
  net stop "PostGIS Database"
  
  pg_ctl unregister -w -N "PostGIS Database" -D $_winpath
  
  rm -rf $POSTGIS_PATH
  
  mingleLog "Uninstall Complete."
}

importOSMUSData() {
  local _downloadUrl="http://download.geofabrik.de/north-america-latest.osm.pbf"
  mingleLog "Tune Database for Import..." true
  
  net stop "PostGIS Database"
  updatePostgresSqlConf 'autovacuum' 'off'
  updatePostgresSqlConf 'fsync' 'off'
  net start "PostGIS Database"
  
  mingleLog "Importing US OSM data to Postgres..." true

  ad_cd "$MINGLE_BUILD_DIR"

  if [ ! -e database-data ]; then
      mkdir database-data
  fi
  
  mingleCategoryDownload "cygwin-osm2pgsql" "60" "https://vanguard.houghtonassociates.com/browse/OSM-OSM2PSQL-60/artifact/JOB1/cygwin-package/cygwin-package.zip"
  mingleCategoryDecompress "cygwin-osm2pgsql" "60" "cygwin-package.zip"

  mv -u cygwin-package/* database-data

  ad_cd database-data

  if [ ! -e north-america-latest.osm.pbf ]; then
      wget -c --no-check-certificate $_downloadUrl
  else
      echo
      while :
      do
          read -p "A previous download of the US OSM data, north-america-latest.osm.pbf, was detected. Do you need to continue the download of north-america-latest.osm.pbf?" yn
          case $yn in
            [Yy]* ) wget -c --no-check-certificate $_downloadUrl; break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no.";;
      esac
      done
  fi
  
  mingleLog "Importing north-america-latest.osm.pbf to the database. This may take several hours..." true
  
  ./osm2pgsql.exe -v -c -d osm -U osm -H localhost -P 5432 -S default.style -s -C 1400 --hstore -r pbf north-america-latest.osm.pbf
  #./osm2pgsql.exe -v -c -d osm -U osm -H localhost -P 5432 -S default.style -s -C 1600 --hstore -r pbf us-northeast.osm.pbf
  
  net stop "PostGIS Database"
  updatePostgresSqlConf 'autovacuum' 'on'
  updatePostgresSqlConf 'fsync' 'on'
  net start "PostGIS Database"

  ad_cd ".."
}

fullPostGISSetupWithImport() {
    initializePostGISDB
    installPostgresqlService false
    importOSMUSData
}

buildInstalProtobuf() {
    local _projectName="protobuf"
    local _version="2.5.0"
    local _url="http://protobuf.googlecode.com/files/protobuf-$_version.zip"
    local _target=""
    local _projectSearchName="protobuf-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=false #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags="-I m4"
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libprotobuf.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallProtobufC() {
    local _project="protobuf-c-*"
    local _configureFlags=""
    local _binCheck="protoc-c.exe"
    local _exeToTest="protoc-c.exe --version"
    
    mingleLog "Checking $_project..." true
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
        
        mingleCategoryDownload "protobuf-c" "master" "https://github.com/onepremise/protobuf-c/archive/master.zip" "protobuf-c-latest.zip"
        mingleCategoryDecompress "protobuf-c" "master" "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")
 
        ad_clearEnv
 
        export "CC=x86_64-w64-mingw32-g++ -I/mingw/include/mingle"
        export "CXX=x86_64-w64-mingw32-g++ -I/mingw/include/mingle"
        #export "CFLAGS=-xc++ -std=c++11 -fpermissive -I/mingw/include -D_WIN64 -DMS_WIN64 -D__MINGW32__ -D__USE_MINGW_ANSI_STDIO"
        export "CFLAGS=-fpermissive -I/mingw/include -D_WIN64 -DMS_WIN64 -D__MINGW32__ -D__USE_MINGW_ANSI_STDIO"
        export "LDFLAGS=-L/mingw/lib"
        export "CPPFLAGS=$CFLAGS"
        export "LIBS=-lstdc++ -lmingle -lws2_32"
        
        ad_cd $_projectDir
        
        ./autogen.sh --prefix=/mingw
        
        ad_adjust_libtool
        
        ad_cd $MINGLE_BUILD_DIR

        ad_make "$_project"
    else
        mingleLog "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
    
    echo       
}
    
buildInstallOsm2pgsql() { 
    local _projectName="osm2pgsql"
    local _version="master"
    local _url="https://github.com/onepremise/osm2pgsql/archive/master.zip"
    local _target="osm2pgsql.zip"
    local _projectSearchName="osm2pgsql*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags="-I m4"
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--with-zlib=/mingw --with-bzip2=/mingw --with-geos=/mingw/bin/geos-config --with-libxml2=/mingw/bin/xml2-config --with-proj=/mingw --with-postgresql=/mingw/bin/pg_config.exe --with-protobuf-c=/mingw"
    local _makeParameters=""
    local _binCheck="osm2pgsql.execxx"
    local _postBuildCommand=""
    local _exeToTest="osm2pgsql.exe --version"
    
    export "CFLAGS=$CFLAGS -DWIN32 -D__MINGW32__"
    export "LIBS=-L/mingw/lib -lmingle"
    export "CPPFLAGS=$CFLAGS"
    export "CXXFLAGS=$CPPFLAGS"
    export "CC=x86_64-w64-mingw32-gcc -I/mingw/include/mingle"
    export "CXX=x86_64-w64-mingw32-gcc -I/mingw/include/mingle"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallCPIO() {
    local _projectName="cpio"
    local _version="2.11"
    local _url="http://ftp.gnu.org/gnu/cpio/cpio-$_version.tar.gz"
    local _target=""
    local _projectSearchName="cpio-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=false #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags="-I m4"
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="cpio"
    local _postBuildCommand=""
    local _exeToTest="cpio --version"

    if [ -e /mingw/bin/$_binCheck ]; then
        mingleLog "$_projectName Already Installed." true
        return;
    fi
    
    mingleLog "Building $_projectName..." true

    ad_setDefaultEnv
    
    export "CFLAGS=-D_WIN64 -D__WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO -Ofast -funroll-all-loops -I/mingw/include"
    export "LDFLAGS=-lws2_32"
    export "CPPFLAGS=$CFLAGS -I/mingw/include"
    export "LIBS=-lws2_32"
    export "CC=x86_64-w64-mingw32-gcc"
    export "CXX=x86_64-w64-mingw32-gcc"
 
    mingleCategoryDownload "$_projectName" "$_version" "$_url"
    mingleCategoryDecompress "$_projectName" "$_version" "$_projectSearchName"

    local _projectDir=$(ad_getDirFromWC "$_projectSearchName")

    ad_cd "$_projectDir"

    if [ ! -e $_projectName-mingw.patch ]; then
        cp $MINGLE_BASE/patches/$_projectName/$_version/$_projectName-mingw.patch .
        ad_patch "$_projectName-mingw.patch"
    fi
    
    buildInstallGeneric "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallOpenJDK() {
    local _projectName="openjdk"
    local _version="8-src-b132-03_mar_2014"
    local _url="http://download.java.net/openjdk/jdk8/promoted/b132/openjdk-8-src-b132-03_mar_2014.zip?q=download/openjdk/jdk8/promoted/b132/openjdk-8-src-b132-03_mar_2014.zip"
    local _target=""
    local _projectSearchName="openjdk-*"
    local _cleanEnv=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=false #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="xxxx"
    local _postBuildCommand=""
    local _exeToTest=""
}

buildInstallOpenFTA() {
    export UPD_JH=`echo $JAVA_HOME | sed -e 's/ /\\\ /g'`
    export UPD_JH_MX=`echo $JAVA_HOME_MX | sed -e 's/ /\\\ /g'`
    
    local _projectName="OpenFTA"
    local _version="master"
    local _url="https://github.com/onepremise/OpenFTA/archive/master.zip"
    local _target="OpenFTA-master.zip"
    local _projectSearchName="OpenFTA-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=false #true/false
    local _runAutoreconf=false #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=false #true/false
    local _configureFlags=""
    local _makeParameters="JAVAHOME=\"$UPD_JH\" JAVAC=\"$UPD_JH/bin/javac -XDignore.symbol.file\" CFLAGS=\"-I$UPD_JH/include/win32  -O -fPIC -c\" LFLAGS=\"-shared -fPIC -v -L$UPD_JH/lib\" JLIBRARIES=\" -L$UPD_JH_MX/jre/lib/amd64 -L$UPD_JH_MX/jre/lib/i386 -ljawt\""
    local _binCheck="fta.dll"
    local _postBuildCommand=""
    local _exeToTest=""
    
    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runAutoreconf $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Updating $_projectName..." true
        local _projectDir=$(ad_getDirFromWC "$_projectSearchName")
        
        ad_cd $_projectDir/bin
        mv libfta.so fta.dll
    else
        mingleLog "Already Installed."
    fi
}

MINGLE_SUITE_HISTORY=()

suiteHasBuilt() {
    local _key=$1
    
    if array_contains MINGLE_SUITE_HISTORY "$_key"; then
        return 0
    fi
    
    suiteAddToHistory "$_key"
    
    return 1
}

suiteAddToHistory() {
    local _key=$1
    
    MINGLE_SUITE_HISTORY+=($_key)
}

MINGLE_EXCLUDE_DEP=false

suiteBase() {
    if suiteHasBuilt 'base'; then
        return;
    fi

    updateFindCommand

    #updateMake
    updateGCC
    
    #experimental
    #updateTarCommand

    install7Zip
    #buildInstallPThreads
    buildInstallAutoconf
    buildInstallAutoMake
    buildInstallLibtool
    buildInstallPkgconfig
    buildInstallLibMingle
    
    buildInstallGMP
    buildInstallMPFR
    buildInstallMPC
    
    buildInstallMingw64CRT
    buildInstallPExports
    buildInstallGenDef
    buildInstallHexdump
    
    buildInstallZlib
    buildInstallBzip2
    buildInstallLibiconv
    buildInstallBinutils
    buildInstallNasm
    buildInstallYasm
    # buildInstallFlex
    # buildInstallBison
    buildInstallWinFlexBison
    buildInstallTermCap
    buildInstallReadline
    buildInstallDLFCN
    buildInstallUniString
    buildInstallLibFFI
    buildInstallAtomicOps
    buildInstallBDWGC
    # buildInstallGuile
    # buildInstallMake
    buildInstallTCL
    buildInstallTk
    buildInstallSigc
    buildInstallNcurses
    buildInstallCMake
    buildInstallArgTable

    #Keep the msys M4 for now due to build issues it causes with autoconf
    #buildInstallM4
    #Not ready for mingw64
    #buildInstallGLibC
    
    buildInstallRagel
    buildInstallGperf
}

suiteJSON() {
    if suiteHasBuilt 'json'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
      suiteBase
      suitePython
    fi
    
    buildInstallJSONC
    buildInstallJSONCPP
    buildInstallJSONRPCCPP
}

suiteXML() {
    if suiteHasBuilt 'xml'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
      suiteBase
    fi

    buildInstallExpat
    buildInstallICU
    buildInstallLibXML2
    buildInstallXerces
    buildInstallLibXSLT
    buildInstallDocBook
    buildInstallGTKDoc
}

suiteFonts() {
    if suiteHasBuilt 'fonts'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
      suiteXML
    fi

    buildInstallFreeType
    buildInstallFontConfig
    buildInstallGraphite2
    buildInstallHarfBuzz
}

suiteEncryption() {
    if suiteHasBuilt 'enc'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
      suiteBase
    fi

    buildInstallPolarSSL
    buildInstallLOpenSSL
}

suiteNetworking() {
    if suiteHasBuilt 'net'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
      suiteEncryption
    fi

    buildInstallCurl
    buildInstalProtobuf
    buildInstallProtobufC
    buildInstallMiniupnp
    buildInstallLibmicrohttpd
}

suiteCABundle() {
    if suiteHasBuilt 'ca'; then
        return;
    fi
    
    if ! $MINGLE_EXCLUDE_DEP; then
        suiteNetworking
        suitePerl
    fi
    
    buildInstallCABundle
}

suiteDatabase() {
    if suiteHasBuilt 'db'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
    fi

    buildInstallSQLite
    buildInstallPostgres
    buildInstallBerkeleyDB
}

suitePython() {
    if suiteHasBuilt 'py'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
    fi

    buildInstallPython
    buildInstallSetupTools
    buildInstallNose
    buildInstallWAF
    buildInstallWerkzeug
    buildInstallScons
}

suitePerl() {
    if suiteHasBuilt 'perl'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
        buildInstalldMake
    fi

    buildInstallPerl
    buildInstallPCRE
    buildInstallCPANMinus
    buildInstallEncode
    buildInstallDBPerl
    buildInstallUserAgent
}

suiteTextEditorsConvertors() {
    if suiteHasBuilt 'txt'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
        suitePython
        suitePerl
    fi

    buildInstallTextInfo
    buildInstallGetText
}

suiteUtilities() {
    if suiteHasBuilt 'utils'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suitePython
        suitePerl
        suiteTextEditorsConvertors
    fi
    
    buildInstallCPIO
}

suiteJava() {
    if suiteHasBuilt 'java'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteTextEditorsConvertors
        suiteUtilities
    fi
    
    buildInstallOpenJDK
}

suiteSwig() {
    if suiteHasBuilt 'swig'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
        suitePython
        suitePerl
    fi

    buildInstallSwig
}

suiteDebugTest() {
    if suiteHasBuilt 'dbg'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
        suitePython
    fi

    buildInstallGDB
    buildInstallCUnit
}

suiteBoost() {
    if suiteHasBuilt 'boost'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
        suitePython
        suiteDebugTest
    fi

    buildInstallBoostJam
    buildInstallBoost52
    buildInstallBoost56
}

suiteSCMTools() {
    if suiteHasBuilt 'scm'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
        suitePython
        suiteDebugTest
        suiteBoost
        buildInstallAPR
        buildInstallAPRUtil
        suitePerl
        suiteSwig
        suiteTextEditorsConvertors
        buildInstallSerf
        suiteCABundle
    fi

    buildInstallSVN
    buildInstallGit
}

suiteImageTools() {
    if suiteHasBuilt 'img'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
        suitePython
        suiteDebugTest
        suiteBoost
    fi

    installLibJPEG
    installLibPNG
    installLibTiff
}

suiteUILibraries() {
    if suiteHasBuilt 'ui'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
        suitePython
        suiteDebugTest
        suiteBoost
        suiteImageTools
        buildInstallRuby
        buildInstallGLib
    fi

    buildInstallSDL
    buildInstallGTK
    buildInstallQt
}

suiteMultimedia() {
    if suiteHasBuilt 'mm'; then
        return;
    fi
    
    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteTextEditorsConvertors
        suiteSCMTools
    fi
    
    buildInstallFFMpeg
    buildInstallPJSIP
}

suiteMathLibraries() {
    if suiteHasBuilt 'math'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
        suitePython
        suiteDebugTest
        suiteBoost
    fi
}

suiteCryptoCurrency() {
    if suiteHasBuilt 'cc'; then
        return;
    fi
    
    if ! $MINGLE_EXCLUDE_DEP; then
        suiteEncryption
        suiteNetworking
        suiteUILibraries
        buildInstallLibqrencode
        buildInstallScons
        buildInstallCryptocpp
        buildInstallCurl
        suiteJSON
    fi
    
    buildInstallBitcoin
    buildInstallEthereum
    buildInstallCpuMiner
    buildInstallCpuMinerMulti
}

suiteGrpahicLibraries() {
    if suiteHasBuilt 'grafx'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
        suitePython
        suiteDebugTest
        suiteBoost
        suiteImageTools
        suiteMathLibraries
        suiteTextEditorsConvertors
        buildInstallGLib
    fi

    buildInstallLibproj
    buildInstallProjDatumgrid
    buildInstallLibGeotiff
    buildInstallPixman
    buildInstallCairo
    buildInstallCairomm
    buildInstallPyCairo
}

suiteGeoSpatialLibraries() {
    if suiteHasBuilt 'geo'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteJSON
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
        suitePython
        suiteDebugTest
        suiteBoost
        suiteImageTools
        suiteMathLibraries
        suiteGrpahicLibraries
    fi

    buildInstallLibgeos
    buildInstallGDAL
    buildInstallPostGIS
}

suiteMapnik() {
    local _useDev=$1

    if suiteHasBuilt 'map'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
        suitePython
        suiteDebugTestTest
        suiteBoost
        suiteImageTools
        suiteMathLibraries
        suiteGrpahicLibraries
        suiteGeoSpatialLibraries
    fi

    if $_useDev; then
        buildInstallMapnikDev
    else
        buildInstallMapnik
    fi
}

suiteMapnikTools() {
    if suiteHasBuilt 'maptools'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
        suiteXML
        suiteFonts
        suiteEncryption
        suiteNetworking
        suiteDatabase
        suitePython
        suiteDebugTest
        suiteBoost
        suiteImageTools
        suiteMathLibraries
        suiteGrpahicLibraries
        suiteGeoSpatialLibraries
        suiteMapnik
    fi

    buildInstallMapnikStylesheets
    buildInstallTileLite

    #buildInstallNode
    #buildInstallNodeMapnik
}

suiteSimulation() {
    if suiteHasBuilt 'sim'; then
        return;
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
    fi
    
    buildInstallOpenFTA
}

suiteOSM2PTSQL() {
    if suiteHasBuilt 'osm2pgsql'; then
        return;
    fi
    
    if ! $MINGLE_EXCLUDE_DEP; then
        suiteNetworking
    fi
    
    buildInstallOsm2pgsql
}

suiteAllExceptMapnik() {
    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking
    suiteDatabase
    suitePython
    suiteDebugTest
    suiteBoost
    suitePerl
    suiteSwig
    suiteTextEditorsConvertors
    suiteUtilities
    suiteSCMTools
    suiteImageTools
    suiteMathLibraries
    suiteGrpahicLibraries
    suiteGeoSpatialLibraries
}

suiteAll() {
    suiteAllExceptMapnik
}

if [ -e $MINGLE_BASE/mingle/mingle/api/mingle-menu.sh ]; then
    source $MINGLE_BASE/mingle/mingle/api/mingle-menu.sh
    mingleThrowIfError $? "mingle-menu.sh failed to load without errors!"
elif [ -e /mingw/lib/mingle/api/mingle-menu.sh ]; then
    source /mingw/lib/mingle/api/mingle-menu.sh
    mingleThrowIfError $? "mingle-menu.sh failed to load without errors!"
else
    mingleError $? "ERROR: Unable to find mingle-menu, required to build and install packages!"
fi
