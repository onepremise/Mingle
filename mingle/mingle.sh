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

export AD_MFOUR=1.4.16
export AD_AUTOCONF=2.69
export AD_AUTOMAKE=1.12.5
export AD_GMP=5.1.2
export AD_MPFR=3.1.2
export AD_MPC=1.0.1
export AD_MINGW64_CRT=2.0.8
export AD_PEXPORTS=0.46
export AD_GLIBC=2.16.0
export AD_BZIP=1.0.6
export AD_SEVENZIPPATH=9.20
export AD_SEVENZIP=920
export AD_PTHREADS=2-9-1
export AD_PKGCONFIG=0.27.1
export AD_BINUTILS_VERSION=2.23.1
export AD_ICU_VERSION=50_1
export AD_ZLIB_VERSION=1.2.8

export AD_LIBICONV=1.14
export AD_POLAR_VERSION=1.2.3
export AD_OPENSSL_VERSION=1.0.1c

export AD_LIBCURL_VERSION=7.28.1
export AD_RAGEL_VERSION=6.8

export AD_EXPAT_VERSION=2.1.0
export AD_LIBXML2_VERSION=2.9.1

export AD_CUNIT_VERSION=2.1-2
export AD_GDB_VERSION=7.5

export AD_TCL_VERSION_MAJOR=8.6
export AD_TCL_VERSION_MINOR=.1
export AD_TCL_VERSION=$AD_TCL_VERSION_MAJOR$AD_TCL_VERSION_MINOR

export AD_TK_VERSION=8.6.1

export AD_APR_VERSION=1.4.8
export AD_APRUTIL_VERSION=1.5.2
export AD_SERF_VERSION=1.3.1
export AD_SVN_VERSION=1.8.3
export AD_GIT_VERSION=

export AD_LIBSIGC_PATH_VERSION=2.3
export AD_LIBSIGC_VERSION=2.3.1

export AD_BOOST_JAM_VERSION=3.1.18

export AD_BOOST_MINOR_VERSION=52
export AD_BOOST_PATH_VERSION=1."$AD_BOOST_MINOR_VERSION".0
export AD_BOOST_VERSION=1_"$AD_BOOST_MINOR_VERSION"_0

export AD_FONT_CONFIG=2.10.0
export AD_FREETYPE_VERSION=2.4.10
export AD_GRAPHITE2_VERSION=1.2.4
export AD_HARFBUZZ_VERSION=0.9.25

export AD_LIBPNG_MAJOR=1.6
export AD_LIBPNG_MINOR=.2
export AD_LIBPNG_VERSION=$AD_LIBPNG_MAJOR$AD_LIBPNG_MINOR
export AD_LIBJPEG_VERSION=1.2.1
export AD_TIFF_VERSION=4.0.3

export AD_LIBXSLT_VERSION=1.1.27
export AD_DOCBK_VERSION=1.76.1
export AD_GTKDOC_VERSION=1.19
export AD_GTK_VERSION=3.8.8

export AD_PROJ_VERSION=4.8.0
export AD_PROJ_GRIDS_VERSION=1.6RC1
export AD_GEOTIFF_VERSION=1.4.0
export AD_GDAL_VERSION=1.9.2
export AD_GEOS_VERSION=3.3.6

export AD_PIXMAN_VERSION=0.28.2
export AD_CAIRO_VERSION=1.12.14
export AD_CAIROMM_VERSION=1.10.0
export AD_PYCAIRO_VERSION=1.10.0

export AD_PYTHON_MAJOR=2.7
export AD_PYTHON_MINOR=.3
export AD_PYTHON_VERSION=$AD_PYTHON_MAJOR$AD_PYTHON_MINOR
export AD_SETUPTOOLS_VERSION=0.6c11
export AD_NOSE_VERSION=1.2.1
export AD_WAF_VERSION=1.7.11
export AD_SCONS_VERSION=2.3.0

export AD_JSONC_VERSION=master

export AD_XML_COMMONS_RESOLVER_VERSION=1.2
export AD_DOCBOOK_XML_VERSION43=4.3
export AD_DOCBOOK_XML_VERSION44=4.4
export AD_DOCBOOK_XML_VERSION45=4.5

export AD_SQLITE_VERSION=3071500
export AD_BERKELEY_DB=6.0.20
export AD_PERL_DB=0.53
export AD_PERL_FILE_DB=1.829
export AD_POSTGRES_VERSION=9.2.2
export AD_POSTGIS_VERSION=2.0.3

export AD_MAPNIK_VERSION=2.1.0

export AD_SWIG_VERSION=2.0.10
export AD_PERL_VERSION=5.18.0
export AD_PERL_SHRT_VERSION=5.0
export AD_PCRE_VERSION=8.33

export AD_TEXTINFO=5.1

export AD_PROTO_BUF=2.5.0
export AD_PROTO_BUF_C=0.15

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
        
        if [ ! -e "/mingw/lib/libmingle.a" ]; then
            mingleLog "Supplementing GCC with libmingle..."
            cp -rf $MINGLE_BASE/mingle/libmingle .
            buildInstallGeneric "libmingle" false true false "" false false "" "" "libmingle.a" "" ""
        fi
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
        mingleAutoBuild  "tar" "1.26" "http://ftp.gnu.org/gnu/tar/tar-1.26.tar.gz" "" "tar-*" true true false "" true true "" "" "tar.exe" "" "tar --version"
    else
        mingleLog "TAR is up to date." true
    fi
}


install7Zip() {
    if ! 7za &> /dev/null; then
        mingleLog "Installing 7zip..." true
        
        mingleCategoryDownload "7zip" "$AD_SEVENZIP" "http://sourceforge.net/projects/sevenzip/files/7-Zip/$AD_SEVENZIPPATH/7za$AD_SEVENZIP.zip/download" "7za$AD_SEVENZIP.zip"
        
        ad_cd "$MINGLE_BUILD_DIR"
        
        ad_mkdir 7zip
        
        mingleCategoryDecompress "7zip" "$AD_SEVENZIP" "7za$AD_SEVENZIP.*" "7zip"
        
        ad_cd 7zip
    
        cp 7z* /bin || mingleError $? "failed to copy 7zip, aborting!"
        
        ad_cd "$MINGLE_BUILD_DIR"
    else
        mingleLog "7zip Already Installed." true
    fi
}

updateMake() {
    mingleLog "Updating Make..." true

    local _project="make-$MAKE*"
    
    mingleDownload "http://sourceforge.net/projects/mingw-w64/files/External%20binary%20packages%20%28Win64%20hosted%29/make/make-$MAKE.zip/download" "make-$MAKE.zip"

    mingleDecompress "$_project"

    #cp -rf $_project/bin_amd64/m* /bin
    cp -rf $_project/bin_ix86 /bin
}

buildInstallSomething() {
    local _projectName=""
    local _version=""
    local _url=""
    local _target=""
    local _projectSearchName=""
    local _cleanEnv= #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal= #true/false
    local _aclocalFlags=""
    local _runAutoconf= #true/false
    local _runConfigure= #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck=""
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallM4() {
    local _projectName="m4"
    local _version="$AD_MFOUR"
    local _url="http://ftp.gnu.org/gnu/m4/m4-$AD_MFOUR.tar.xz"
    local _target=""
    local _projectSearchName="m4-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="m4"
    local _postBuildCommand=""
    local _exeToTest="m4 --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallAutoconf() {
    export "M4=/bin/m4"

    local _projectName="autoconf"
    local _version="$AD_AUTOCONF"
    local _url="http://ftp.gnu.org/gnu/autoconf/autoconf-$AD_AUTOCONF.tar.gz"
    local _target=""
    local _projectSearchName="autoconf-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="autoconf"
    local _postBuildCommand=""
    local _exeToTest="autoconf --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallAutoMake() {
    local _projectName="automake"
    local _version="$AD_AUTOMAKE"
    local _url="http://ftp.gnu.org/gnu/automake/automake-$AD_AUTOMAKE.tar.gz"
    local _target=""
    local _projectSearchName="automake-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="automake"
    local _postBuildCommand=""
    local _exeToTest="automake --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    
    cp -rf $MINGLE_BASE/patches/automake/share/*.m4 /mingw/share/aclocal-1.12 || mingleError $? "failed to copy m4 includes, aborting!"
}

buildInstallGMP() {
    ad_clearEnv
    
    export "CFLAGS=-Ofast -funroll-all-loops"
    export "CPPFLAGS=$CFLAGS"
    
    local _projectName="gmp"
    local _version="$AD_GMP"
    local _url="ftp://ftp.gmplib.org/pub/gmp-$AD_GMP/gmp-$AD_GMP.tar.xz"
    local _target=""
    local _projectSearchName="gmp-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--enable-cxx"
    local _makeParameters=""
    local _binCheck="libgmp.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"      
}

buildInstallMPFR() {
    local _projectName="mpfr"
    local _version="$AD_MPFR"
    local _url="http://www.mpfr.org/mpfr-current/mpfr-$AD_MPFR.tar.xz"
    local _target=""
    local _projectSearchName="mpfr-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--with-gmp=/mingw --disable-shared"
    local _makeParameters=""
    local _binCheck="libmpfr.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"          
}

buildInstallMPC() {
    local _projectName="mpc"
    local _version="$AD_MPC"
    local _url="http://multiprecision.org/mpc/download/mpc-$AD_MPC.tar.gz"
    local _target=""
    local _projectSearchName="mpc-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--with-gmp=/mingw --with-mpfr=/mingw --disable-shared"
    local _makeParameters=""
    local _binCheck="libmpc.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"      
}

buildInstallMingw64CRT() {
    local _projectName="mingw-w64"
    local _version="$AD_MPC"
    local _url="http://downloads.sourceforge.net/project/mingw-w64/mingw-w64/mingw-w64-release/mingw-w64-v$AD_MINGW64_CRT.tar.gz"
    local _target=""
    local _projectSearchName="mingw-w64-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
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
        mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
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
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libtool"
    local _postBuildCommand=""
    local _exeToTest="libtool --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"      
}

buildInstallPExports() {
    local _projectName="pexports"
    local _version="$AD_PEXPORTS"
    local _url="http://downloads.sourceforge.net/project/mingw/MinGW/Extension/pexports/pexports-$AD_PEXPORTS/pexports-$AD_PEXPORTS-mingw32-src.tar.xz"
    local _target=""
    local _projectSearchName="pexports-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="pexports"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"      
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
    
        buildInstallGeneric "$_project" true true true "" true true "" "" "$_binCheck"
    fi
}

buildInstallGLibC() {
    local _projectName="glibc"
    local _version="$AD_GLIBC"
    local _url="http://ftp.gnu.org/gnu/libc/glibc-$AD_GLIBC.tar.xz"
    local _target=""
    local _projectSearchName="glibc-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="xxxx"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"          
}

buildInstallRagel() {
    local _projectName="ragel"
    local _version="$AD_RAGEL_VERSION"
    local _url="http://www.complang.org/ragel/ragel-$AD_RAGEL_VERSION.tar.gz"
    local _target=""
    local _projectSearchName="ragel-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="ragel.exe"
    local _postBuildCommand=""
    local _exeToTest="ragel --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"            
}

buildInstallCMake() { 
    local _projectName="cmake"
    local _version="2.8.12.1"
    local _url="http://www.cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz"
    local _target=""
    local _projectSearchName="cmake-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="cmake"
    local _postBuildCommand=""
    local _exeToTest="cmake --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"              
}

buildInstallGperf() {
    local _projectName="gperf"
    local _version="3.0.4"
    local _url="http://ftp.gnu.org/pub/gnu/gperf/gperf-$_version.tar.gz"
    local _target=""
    local _projectSearchName="gperf-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="gperf"
    local _postBuildCommand=""
    local _exeToTest="gperf --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"   
}

# Things to watch:
# http://sourceware.org/bugzilla/show_bug.cgi?id=12127
# http://forums.codeblocks.org/index.php/topic,11301.0.html
buildInstallGDB() {
    local _project="gdb-*"

    if ad_isDateNewerThanFileModTime "2014-01-01" "/mingw/bin/gdb.exe"; then
        mingleLog "Building $_project..." true    
        
        ad_clearEnv
        
        mingleCategoryDownload "gdb" "$AD_GDB_VERSION" "http://ftp.gnu.org/gnu/gdb/gdb-$AD_GDB_VERSION.tar.gz"
        mingleCategoryDecompress "gdb" "$AD_GDB_VERSION" "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")

        ad_cd $_projectDir || mingleError $? "cd failed, aborting!"
        
        if [ ! -e gdb-mingw.patch ]; then
            cp $MINGLE_BASE/patches/gdb/$AD_GDB_VERSION/gdb-mingw.patch .
            ad_patch "gdb-mingw.patch"
        fi

# This patch seems to regress all the py-gdb functionality.
# Really wierd solution to getting python to work when it already does in mingw. Disabling.
#        if [ ! -e gdb-python.patch ]; then
#            cp $MINGLE_BUILD_DIR/patches/gdb/$AD_GDB_VERSION/gdb-python.patch .
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

        buildInstallGeneric "$_project" false true false "" true true "--with-gmp --with-mpfr --with-mpc --with-python --enable-shared" "" "x" "" "gdb --version"

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
    local _version="$AD_CUNIT_VERSION"
    local _url="http://downloads.sourceforge.net/project/cunit/CUnit/$AD_CUNIT_VERSION/CUnit-$AD_CUNIT_VERSION-src.tar.bz2"
    local _target=""
    local _projectSearchName="CUnit-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libcunit.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"                  
}

buildInstallTCL() {
    local _project="tcl*"
    #local _binCheck="xxx"
    local _binCheck="tclsh"
    local _exeToTest=""
    
    ad_setDefaultEnv
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
        
        mingleCategoryDownload "tcl" "$AD_TCL_VERSION" "http://prdownloads.sourceforge.net/tcl/tcl$AD_TCL_VERSION-src.tar.gz"
        
        mingleCategoryDecompress "tcl" "$AD_TCL_VERSION" "$_project"

        local _projectdir=$(ad_getDirFromWC "$_project")
	
	ad_cd $_projectdir
	
	if [ ! -e tcl-mingw.patch ]; then
	        cp $MINGLE_BASE/patches/tcl/$AD_TCL_VERSION/tcl-mingw.patch .
	        ad_patch "tcl-mingw.patch"
        fi
        
        ad_cd win
        
        aclocal || mingleError $? "aclocal failed, aborting!"
        
        autoconf || mingleError $? "autoconf failed, aborting!"

        ./configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --prefix=/mingw --enable-64bit --enable-shared=no

        make || mingleError $? "make failed, aborting!"

        local _savedir=`pwd`

        ad_cd /mingw/bin
        
        local mm_ver=`echo $AD_TCL_VERSION_MAJOR|sed 's/\.//'`

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
    local _project="tk$AD_TCL_VERSION_MAJOR*"
    local _cleanEnv=true
    local _binCheck="libtk86.a"
    local _postBuildCommand=""
    local _exeToTest=""
    
    if $_cleanEnv; then
        ad_setDefaultEnv
    fi
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
        
        mingleCategoryDownload "tk" "$AD_TK_VERSION" "http://prdownloads.sourceforge.net/tcl/tk$AD_TK_VERSION-src.tar.gz"
	        
        mingleCategoryDecompress "tk" "$AD_TK_VERSION" "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")
		
	cd $_projectDir || mingleError $? "cd 1 failed, aborting!"
		
	if [ ! -e tk-mingw.patch ]; then
	    cp $MINGLE_BASE/patches/tk/$AD_TK_VERSION/tk-mingw.patch .
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
    
    if [ ! -e /mingw/bin/zlib1.dll ]; then
        mingleLog "Building zlib..." true
        
        mingleCategoryDownload "zlib" "$AD_ZLIB_VERSION" "http://www.zlib.net/zlib-$AD_ZLIB_VERSION.tar.gz"
		        
        mingleCategoryDecompress "zlib" "$AD_ZLIB_VERSION" "$_project"

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

    mingleLog "Building bzip2..." true
    
    if [ ! -e /mingw/bin/bzip2 ]; then
        mingleCategoryDownload "bzip2" "$AD_BZIP" "http://www.bzip.org/$AD_BZIP/bzip2-$AD_BZIP.tar.gz"
			        
        mingleCategoryDecompress "bzip2" "$AD_BZIP" "$_project"

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

    mingleLog "Building libiconv..." true

    if [ -e /mingw/lib/libiconv.dll.a ] && [ -e /mingw/lib/libiconv.a ]; then
        mingleLog "Already Installed." 
        return
    fi
    
    mingleCategoryDownload "libiconv" "$AD_LIBICONV" "http://ftp.gnu.org/pub/gnu/libiconv/libiconv-$AD_LIBICONV.tar.gz"
			        
    mingleCategoryDecompress "libiconv" "$AD_LIBICONV" "$_project"

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
    if [ ! -e /mingw/bin/pthreadGC2.dll ]; then
        mingleLog "Installing pThreads..." true
        
        local _project="pthreads-*"

        mingleCategoryDownload "pthreads" "$AD_PTHREADS" "ftp://sourceware.org/pub/pthreads-win32/pthreads-w32-$AD_PTHREADS-release.zip"
        mingleCategoryDecompress "pthreads" "$AD_PTHREADS" "$_project"

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
    local _version="$AD_BINUTILS_VERSION"
    local _url="http://ftp.gnu.org/gnu/binutils/binutils-$AD_BINUTILS_VERSION.tar.gz"
    local _target=""
    local _projectSearchName="binutils-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="dllwrap.exe"
    local _postBuildCommand=""
    local _exeToTest="dllwrap.exe --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"                      
}

buildInstallPkgconfig() {
    local _project="pkg-config-*"

    if [ ! -e /mingw/bin/pkg-config ]; then
        mingleLog "Installing $_project..." true
        
        mingleCategoryDownload "pkg-config" "$AD_PKGCONFIG" "http://pkgconfig.freedesktop.org/releases/pkg-config-$AD_PKGCONFIG.tar.gz"
        mingleCategoryDecompress "pkg-config" "$AD_PKGCONFIG" "$_project"

        ad_setDefaultEnv

        export "CFLAGS=-std=c99 $CFLAGS"

        local _projectdir=$(ad_getDirFromWC $_project)
    
        ad_cd "$_projectdir"
    
        aclocal --force
        libtoolize
    
        ad_cd "$MINGLE_BUILD_DIR"
    
        buildInstallGeneric "$_project" true true true "" true true "--with-internal-glib" "" "pkg-config" "" "pkg-config --version"
    else
        mingleLog "$_project already installed."
    fi
}

installLibJPEG () {
    if [ ! -e /mingw/lib/libturbojpeg.a ]; then
        mingleLog "Installing libjpeg-turbo..." true
        
        ad_cd "$MINGLE_BUILD_DIR"
        
        mingleCategoryDownload "libjpeg-turbo" "$AD_LIBJPEG_VERSION" "http://sourceforge.net/projects/libjpeg-turbo/files/$AD_LIBJPEG_VERSION/libjpeg-turbo-$AD_LIBJPEG_VERSION-gcc64.exe/download" "libjpeg-turbo-$AD_LIBJPEG_VERSION-gcc64.exe"
        
        STOREPATH=`pwd`

        if [ ! -e libjpeg-turbo ]; then
            mkdir libjpeg-turbo
        fi

        ad_cd libjpeg-turbo

        DOSPATH=`cmd /c 'echo %CD%'`
        
        ad_cd $MINGLE_CACHE/libjpeg-turbo/$AD_LIBJPEG_VERSION

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
    if [ ! -e /mingw/bin/libpng*.dll ]; then
        mingleLog "Installing libPNG..." true
        
        mingleCategoryDownload "libpng" "$AD_LIBPNG_VERSION" "ftp://ftp.simplesystems.org/pub/libpng/png/src/history/libpng`echo $AD_LIBPNG_MAJOR|sed 's/\.//'`/libpng-$AD_LIBPNG_VERSION.tar.gz"
        mingleCategoryDecompress "libpng" "$AD_LIBPNG_VERSION" "libpng-*"
        
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
    local _version="$AD_TIFF_VERSION"
    local _url="ftp://ftp.remotesensing.org/pub/libtiff/tiff-$AD_TIFF_VERSION.tar.gz"
    local _target=""
    local _projectSearchName="tiff-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="tiffinfo"
    local _postBuildCommand=""
    local _exeToTest="tiffinfo"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"    
}

buildInstallSigc() {
    ad_clearEnv
    
    export "CFLAGS=-I/mingw/include -D_WIN64 -D__WIN64 -DMS_WIN64 -Ofast -funroll-all-loops"
    export "CPPFLAGS=$CFLAGS"
    export "LDFLAGS=-L/mingw/lib"
    
    local _projectName="libsigc"
    local _version="$AD_LIBSIGC_VERSION"
    local _url="http://ftp.gnome.org/pub/GNOME/sources/libsigc++/$AD_LIBSIGC_PATH_VERSION/libsigc++-$AD_LIBSIGC_VERSION.tar.xz"
    local _target=""
    local _projectSearchName="libsigc++-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libsigc-2.0-0.dll"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"    
}

buildInstallPixman() {
    local _projectName="pixman"
    local _version="$AD_PIXMAN_VERSION"
    local _url="http://www.cairographics.org/releases/pixman-$AD_PIXMAN_VERSION.tar.gz"
    local _target=""
    local _projectSearchName="pixman-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libpixman-1.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"   
}

buildInstallCairo() {
    local _project="cairo-*"
        
    local _projectName="cairo"
    local _version="$AD_CAIRO_VERSION"
    local _url="http://www.cairographics.org/releases/cairo-$AD_CAIRO_VERSION.tar.xz"
    local _target=""
    local _projectSearchName="$_project"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--enable-gtk-doc"
    local _makeParameters=""
    local _binCheck="libcairo.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"    
    
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
    local _version="$AD_CAIROMM_VERSION"
    local _url="http://www.cairographics.org/releases/cairomm-$AD_CAIROMM_VERSION.tar.gz"
    local _target=""
    local _projectSearchName="cairomm-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libcairomm-1.0.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"   
}

buildInstallPolarSSL() {
    local _project="polarssl-*"
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
         
        mingleCategoryDownload "polarssl" "$AD_POLAR_VERSION" "https://polarssl.org/download/polarssl-$AD_POLAR_VERSION-gpl.tgz"
        mingleCategoryDecompress "polarssl" "$AD_POLAR_VERSION" "$_project"
        
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
    local _additionFlags=""
    local _binCheck="libssl.a"
    local _exeToTest="openssl version"

    ad_setDefaultEnv
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
         
        mingleCategoryDownload "openssl" "$AD_OPENSSL_VERSION" "http://www.openssl.org/source/openssl-$AD_OPENSSL_VERSION.tar.gz"
        mingleCategoryDecompress "openssl" "$AD_OPENSSL_VERSION" "$_project"        
        
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
    local _version="$AD_LIBXML2_VERSION"
    local _url="https://git.gnome.org/browse/libxml2/snapshot/libxml2-$AD_LIBXML2_VERSION.tar.gz"
    local _target=""
    local _projectSearchName="libxml2-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--enable-shared --enable-static --with-icu"
    local _makeParameters=""
    local _binCheck="xmllint"
    local _postBuildCommand=""
    local _exeToTest="xmllint --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallXerces() {
    local _projectName="xerces-c"
    local _version="3.1.1"
    local _url="http://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.1.1.tar.gz"
    local _target=""
    local _projectSearchName="xerces-c*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags="-I m4"
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="pparse"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallLibXSLT() {
    local _project="libxslt-*"

    if [ -e /mingw/bin/xsltproc ]; then
        mingleLog "$_project Already Installed." true
        return;
    fi
    
    mingleLog "Building $_project..." true

    ad_setDefaultEnv
    
    export "CFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64"
    export "CPPFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64"
 
    mingleCategoryDownload "libxslt" "$AD_LIBXSLT_VERSION" "https://git.gnome.org/browse/libxslt/snapshot/libxslt-$AD_LIBXSLT_VERSION.tar.gz"
    mingleCategoryDecompress "libxslt" "$AD_LIBXSLT_VERSION" "$_project"

    local _projectDir=$(ad_getDirFromWC "$_project")

    ad_cd "$_projectDir"

    if [ ! -e xslt-mingw.patch ]; then
        cp $MINGLE_BASE/patches/xslt/$AD_LIBXSLT_VERSION/xslt-mingw.patch .
        ad_patch "xslt-mingw.patch"
    fi

    ad_cd "$MINGLE_BUILD_DIR"
    
    buildInstallGeneric "$_project" false true false "" false true "" "" "xsltproc" "" "xsltproc --version"
}

buildInstallCurl() {
    local _project="curl-*"
    
    if [ -e /mingw/lib/libcurl.a ]; then
        mingleLog "$_project Already Installed." true
        return;
    fi
    
    mingleLog "Building $_project..." true

    mingleCategoryDownload "curl" "$AD_LIBCURL_VERSION" "http://curl.haxx.se/download/curl-$AD_LIBCURL_VERSION.tar.bz2"
    mingleCategoryDecompress "curl" "$AD_LIBCURL_VERSION" "$_project"   
    
    local _projectDir=$(ad_getDirFromWC "$_project")
    
    ad_cd "$_projectDir"
    
    ./buildconf
    
    ad_cd ".."
    
    if [ ! -e /mingw/share/curl ]; then
        mkdir -p /mingw/share/curl
    fi
    
    buildInstallGeneric "$_project" true true false "" false true "--with-ca-bundle=$MINGLE_BASE/mingw64/share/curl/ca-bundle.crt" "" "libcurl.a" "" "curl --version"
}

buildInstallAPR() {
    local _project="apr-*"

    if [ -e /mingw/lib/libapr-1.a ]; then
        mingleLog "$_project Already Installed." true
        return;
    fi
    
    mingleLog "Building $_project..." true

    ad_clearEnv
    
    export "CFLAGS=-I/mingw/include -D__MINGW__ -DAPU_DECLARE_STATIC"
    export "LDFLAGS=-L/mingw/lib"
    export "CPPFLAGS=-I/mingw/include -D__MINGW__  -DAPU_DECLARE_STATIC"

    mingleCategoryDownload "apr" "$AD_APR_VERSION" "http://archive.apache.org/dist/apr/apr-$AD_APR_VERSION.tar.gz"
    mingleCategoryDecompress "apr" "$AD_APR_VERSION" "$_project"  
    
    local _projectDir=$(ad_getDirFromWC "$_project")

    ad_cd "$_projectDir"

    if [ ! -e apr-mingw.patch ]; then
        cp $MINGLE_BASE/patches/apr/$AD_APR_VERSION/apr-mingw.patch .
        ad_patch "apr-mingw.patch"
    fi

    ad_cd ".."
    
    buildInstallGeneric "apr-*" false true false "" true true "--enable-shared" "" "libapr-1.a" "" "apr-1-config --version"

    mkdir -p /mingw/include/apr-1/arch/win32
    cp -f $_projectDir/include/arch/apr_private_common.h /mingw/include/apr-1/arch
    cp -rf $_projectDir/include/arch/win32 /mingw/include/apr-1/arch
}

buildInstallAPRUtil() {
    local _project="apr-util-*"
    local _additionFlags="--with-apr=/mingw/bin/apr-1-config --with-expat=/mingw --with-berkeley-db=/mingw/include:/mingw/lib --with-sqlite3=/mingw --with-pgsql=/mingw"
    local _binCheck="libaprutil-1.a"
    local _exeToTest="apu-1-config --version"

    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then   
        mingleLog "Building $_project..." true
        
        ad_clearEnv
    
        export "CFLAGS=-I/mingw/include -D__MINGW__ -DAPU_DECLARE_STATIC"
        export "LDFLAGS=-L/mingw/lib"
        export "CPPFLAGS=-I/mingw/include -D__MINGW__  -DAPU_DECLARE_STATIC"
        
        mingleCategoryDownload "apr-util" "$AD_APRUTIL_VERSION" "http://archive.apache.org/dist/apr/apr-util-$AD_APRUTIL_VERSION.tar.gz"
        mingleCategoryDecompress "apr-util" "$AD_APRUTIL_VERSION" "$_project"  

        local _projectdir=$(ad_getDirFromWC $_project)
        
        ad_cd "$_projectdir"    

        if [ ! -e apr-util-mingw.patch ]; then
            cp $MINGLE_BASE/patches/apr-util/$AD_APRUTIL_VERSION/apr-util-mingw.patch .
            ad_patch "apr-util-mingw.patch"
        fi
        
        ad_cd ".."
        
        buildInstallGeneric "$_project" false true true "-I build" true true "$_additionFlags" "" "$_binCheck" "" "$_exeToTest"
    else
        mingleLog "$_project Already Installed." true
    fi
}

buildInstallBerkeleyDB() {
    local _project="db-*"
    local _additionFlags="--prefix=/mingw --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-mingw --enable-cxx --disable-replication --enable-tcl --with-tcl=/mingw/lib --enable-stl --enable-compat185 --enable-dbm"
    local _binCheck="db_verify.exe"
    local _exeToTest="db_verify -V"

    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true

        ad_setDefaultEnv
        #ad_clearEnv
        
        export "LDFLAGS=$LDFLAGS -ltcl86"

        mingleCategoryDownload "db" "$AD_BERKELEY_DB" "http://download.oracle.com/berkeley-db/db-$AD_BERKELEY_DB.tar.gz"
        mingleCategoryDecompress "db" "$AD_BERKELEY_DB" "$_project" 

        local _projectdir=$(ad_getDirFromWC $_project)
        
        ad_cd "$_projectdir"
        
        if [ ! -e db-mingw.patch ]; then
            cp $MINGLE_BASE/patches/db/$AD_BERKELEY_DB/db-mingw.patch .
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
	    
    mingleCategoryDownload "xml-commons-resolver" "$AD_XML_COMMONS_RESOLVER_VERSION" "http://archive.apache.org/dist/xerces/xml-commons/xml-commons-resolver-$AD_XML_COMMONS_RESOLVER_VERSION.tar.gz"
    mingleCategoryDownload "docbook-xsl" "$AD_DOCBK_VERSION" "http://sourceforge.net/projects/docbook/files/docbook-xsl/$AD_DOCBK_VERSION/docbook-xsl-$AD_DOCBK_VERSION.tar.bz2"
    
    mingleCategoryDecompress "xml-commons-resolver" "$AD_XML_COMMONS_RESOLVER_VERSION" "xml-commons-resolver-*"

    if [ ! -e "$_shareDirVal/xml/xml-commons-resolver-$AD_XML_COMMONS_RESOLVER_VERSION" ]; then
        mv xml-commons-resolver-$AD_XML_COMMONS_RESOLVER_VERSION $_shareDirVal/xml
    fi

    export CLASSPATH=$_shareDir/xml/xml-commons-resolver-$AD_XML_COMMONS_RESOLVER_VERSION/resolver.jar

    mingleCategoryDecompress "docbook-xsl" "$AD_DOCBK_VERSION" "docbook-xsl-*"

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

    mingleCategoryDownload "docbook-xml" "$AD_DOCBOOK_XML_VERSION43" "http://docbook.org/xml/$AD_DOCBOOK_XML_VERSION43/docbook-xml-$AD_DOCBOOK_XML_VERSION43.zip"
    mingleCategoryDecompress "docbook-xml" "$AD_DOCBOOK_XML_VERSION43" "docbook-xml-$AD_DOCBOOK_XML_VERSION43.zip" "docbook-xml-$AD_DOCBOOK_XML_VERSION43"
    mv docbook-xml-$AD_DOCBOOK_XML_VERSION43 $_shareDirVal/xml/docbook/schema/dtd/$AD_DOCBOOK_XML_VERSION43

    mingleCategoryDownload "docbook-xml" "$AD_DOCBOOK_XML_VERSION44" "http://docbook.org/xml/$AD_DOCBOOK_XML_VERSION44/docbook-xml-$AD_DOCBOOK_XML_VERSION44.zip"
    mingleCategoryDecompress "docbook-xml" "$AD_DOCBOOK_XML_VERSION44" "docbook-xml-$AD_DOCBOOK_XML_VERSION44.zip" "docbook-xml-$AD_DOCBOOK_XML_VERSION44"
    mv docbook-xml-$AD_DOCBOOK_XML_VERSION44 $_shareDirVal/xml/docbook/schema/dtd/$AD_DOCBOOK_XML_VERSION44

    mingleCategoryDownload "docbook-xml" "$AD_DOCBOOK_XML_VERSION45" "http://docbook.org/xml/$AD_DOCBOOK_XML_VERSION45/docbook-xml-$AD_DOCBOOK_XML_VERSION45.zip"
    mingleCategoryDecompress "docbook-xml" "$AD_DOCBOOK_XML_VERSION45"  "docbook-xml-$AD_DOCBOOK_XML_VERSION45.zip" "docbook-xml-$AD_DOCBOOK_XML_VERSION45"
    mv docbook-xml-$AD_DOCBOOK_XML_VERSION45 $_shareDirVal/xml/docbook/schema/dtd/$AD_DOCBOOK_XML_VERSION45

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
    local _additionFlags=""
    local _binCheck="gtkdoc-check"
    local _exeToTest="gtkdoc-check --version"

    if [ ! -e "/mingw/bin/$_binCheck" ];then
        mingleLog "Building $_project..." true
    
        mingleCategoryDownload "gtk-doc" "$AD_GTKDOC_VERSION" "https://download.gnome.org/sources/gtk-doc/$AD_GTKDOC_VERSION/gtk-doc-$AD_GTKDOC_VERSION.tar.xz"
        mingleCategoryDecompress "gtk-doc" "$AD_GTKDOC_VERSION" "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)

        ad_cd "$_projectdir"

        if [ ! -e gtk-mingw.patch ]; then
            cp $MINGLE_BASE/patches/gtk/$AD_GTKDOC_VERSION/gtk-mingw.patch .
            ad_patch "gtk-mingw.patch"
        fi

        buildInstallGeneric "$_project" true true true "-I m4" true true "$_additionFlags" "" "$_binCheck" "" "$_exeToTest"

        ad_cd "$MINGLE_BUILD_DIR"
    else
        mingleLog "$_project Already Installed."
    fi
}

buildInstallGTK() {
    local _project="gtk-*"
}

buildInstallQt() {
    local _projectName="qt"
    local _version="5.3.0"
    local _url="http://download.qt-project.org/archive/qt/5.3/5.3.0/single/qt-everywhere-opensource-src-5.3.0.tar.gz"
    local _target="qt-$_version.tar.gz"
    local _projectSearchName="qt-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _configureFlags="-platform win32-g++"
    local _makeParameters=""
    local _binCheck="qt"
    local _postBuildCommand=""
    local _exeToTest=""
    
    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallBitcoin() {
    local _projectName="bitcoin"
    local _version="master"
    local _url="https://github.com/bitcoin/bitcoin/archive/master.zip"
    local _target="bitcoin-$_version.zip"
    local _projectSearchName="bitcoin-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="bitcoin-qt"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallSVN() {
    local _project="subversion-*"
    local _additionFlags="--libdir=/mingw/lib/perl/site/lib --with-swig --with-berkeley-db --enable-bdb6 --with-apr-util=/mingw --with-apr=/mingw --with-serf=/mingw --enable-shared PERL=/mingw/bin/perl MAKE=dmake"
    local _binCheck="svn.exe"
    local _exeToTest="svn --version"

    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
        
        ad_setDefaultEnv
        
        export "CFLAGS=-I/mingw/include -D_WIN64 -D__WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO -I$MINGLE_BASE_MX/mingw64/include/apr-1 -DAPU_DECLARE_STATIC -DAPR_DECLARE_STATIC -D__MINGW32__"
        export "CPPFLAGS=$CFLAGS"
        export "LDFLAGS=$LDFLAGS -L$MINGLE_BASE_MX/mingw64/x86_64-w64-mingw32/lib -lole32 -lmlang -luuid -lws2_32"
        export "LIBS=-lserf-1 -lpsapi -lversion"
        
        mingleLog MINGLE_BASE_MX = $MINGLE_BASE_MX
        
        mingleCategoryDownload "subversion" "$AD_SVN_VERSION" "http://archive.apache.org/dist/subversion/subversion-$AD_SVN_VERSION.zip"
        mingleCategoryDecompress "subversion" "$AD_SVN_VERSION" "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)
        
        ad_cd "$_projectdir"

        if [ ! -e svn-mingw.patch ]; then
            cp $MINGLE_BASE/patches/subversion/$AD_SVN_VERSION/svn-mingw.patch .
            ad_patch "svn-mingw.patch"
            cp $MINGLE_BASE/patches/subversion/$AD_SVN_VERSION/bindings-mingw.patch .
            ad_patch "bindings-mingw.patch"
            cp $MINGLE_BASE/patches/subversion/$AD_SVN_VERSION/auth-mingw.patch .
            ad_patch "auth-mingw.patch" 
            cp $MINGLE_BASE/patches/subversion/$AD_SVN_VERSION/compiler-mingw.patch .
            ad_patch "compiler-mingw.patch"            
        fi
        
        dos2unix build/generator/templates/build-outputs.mk.ezt

        ad_cd ".."
        
        # Make sure you build this with drive substitution turned on, "setup.bat -b -c"
        # Otherwise, gcc will crash from parsing paths, which concatenate out too long.
        # This causes segfault.
        buildInstallGeneric "$_project" false true false "" false true "$_additionFlags" "" "$_binCheck" "" ""
        
        ad_cd "$_projectdir"
        make check-swig-pl MAKE=dmake || mingleError $? "make check-swig-pl failed, aborting!"
        make install-swig-pl MAKE=dmake || mingleError $? "make install-swig-pl failed, aborting!"
        
        ad_cd "$MINGLE_BUILD_DIR"
    else
        mingleLog "Already Installed."
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

        make CFLAGS='-O2 -Icompat/win32 -I/mingw/include -D__MINGW32__ -D__USE_MINGW_ANSI_STDIO -DWIN32 -DHAVE_MMAP -DPCRE_STATIC' LDFLAGS=-L/mingw/lib NO_GETTEXT=Yes USE_LIBPCRE=Yes LIBPCREDIR=/mingw CURLDIR=/mingw EXPATDIR=/mingw PERL_PATH=/mingw/bin/perl.exe PYTHON_PATH=/mingw/bin/python.exe TCL_PATH=/mingw/bin/tclsh.exe TCLTK_PATH=/mingw/bin/tclsh.exe DEFAULT_EDITOR=/bin/vim NO_R_TO_GCC_LINKER=Yes NEEDS_LIBICONV=True V=1 prefix=/mingw CC=gcc INSTALL=/bin/install sysconfdir=/mingw/etc|| mingleError $? "make failed, aborting!"

        make install CFLAGS='-O2 -Icompat/win32 -I/mingw/include -D__MINGW32__ -D__USE_MINGW_ANSI_STDIO -DWIN32 -DHAVE_MMAP -DPCRE_STATIC' LDFLAGS=-L/mingw/lib NO_GETTEXT=Yes USE_LIBPCRE=Yes LIBPCREDIR=/mingw CURLDIR=/mingw EXPATDIR=/mingw PERL_PATH=/mingw/bin/perl.exe PYTHON_PATH=/mingw/bin/python.exe TCL_PATH=/mingw/bin/tclsh.exe TCLTK_PATH=/mingw/bin/tclsh.exe DEFAULT_EDITOR=/bin/vim NO_R_TO_GCC_LINKER=Yes NEEDS_LIBICONV=True V=1 prefix=/mingw CC=gcc INSTALL=/bin/install sysconfdir=/mingw/etc|| mingleError $? "make install failed, aborting!"

        ad_cd ".."
        
	git config --system push.default matching
        git config --system http.sslcainfo $CURL_CA_BUNDLE
    else
        mingleLog "Already Installed."          
    fi
    
    echo
}

buildInstallCABundle() {
    local _project="curl-*"
    
    mingleLog "Checking $_project..." true
    
    if [ -e /mingw/share/curl/ca-bundle.crt ]; then
        mingleLog "ca-bundle.crt Already Installed." true
        return;
    fi
    
    mingleLog "Building $_project..." true
    
    mingleCategoryDownload "curl" "$AD_LIBCURL_VERSION" "http://curl.haxx.se/download/curl-$AD_LIBCURL_VERSION.tar.bz2"
    mingleCategoryDecompress "curl" "$AD_LIBCURL_VERSION" "$_project"   
    
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
    local _additionFlags="--enable-libxml2 --disable-docs"
    local _binCheck="fc-list"
    local _exeToTest="fc-query --version"

    export "FREETYPE_LIBS=`freetype-config --libs`"

    mingleLog "Checking $_project..." true
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
    
        ad_setDefaultEnv

        mingleCategoryDownload "fontconfig" "$AD_FONT_CONFIG" "http://www.freedesktop.org/software/fontconfig/release/fontconfig-$AD_FONT_CONFIG.tar.gz"
        mingleCategoryDecompress "fontconfig" "$AD_FONT_CONFIG" "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)
        
        ad_cd "$_projectdir"
        
        if [ ! -e fontconfig-mingw.patch ]; then
            cp $MINGLE_BASE/patches/fontconfig/$AD_FONT_CONFIG/fontconfig-mingw.patch .
            ad_patch "fontconfig-mingw.patch"
        fi
        
        mkdir -p /mingw/share/fontconfig/conf.avail        
        cp -rf conf.d/*.conf /mingw/share/fontconfig/conf.avail
        
        ad_cd ".."
    
        #export "CFLAGS=$CFLAGS -DFC_DBG_CONFIG"
        ad_configure "$_project" true false "" true "$_additionFlags"
        ad_make "$_project"

        local _shortProjectName=$(ad_getShortLibName $_project)
            
        mingleLog "Short Name: $_shortProjectName"
            
        ad_fix_shared_lib "$_shortProjectName"
    else
        mingleLog "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
    
    echo    
}

buildInstallFreeType() {
    local _project="freetype-*"
    
    mingleLog "Checking $_project..." true
    
    if [ ! -e /mingw/lib/libfreetype.a ]; then
        mingleLog "Building $_project..." true

        mingleCategoryDownload "freetype" "$AD_FREETYPE_VERSION" "http://ftp.igh.cnrs.fr/pub/nongnu/freetype/freetype-$AD_FREETYPE_VERSION.tar.gz"
        mingleCategoryDecompress "freetype" "$AD_FREETYPE_VERSION" "$_project"

        ad_cd freetype-*

        make setup unix
        ./configure --host=x86_64-w64-mingw32 --prefix=/mingw
        mkdir objs/.libs

        make || mingleError $? "make failed, aborting!"
        make install -i || mingleError $? "make install  failed, aborting!"

        ad_cd ".."
    else
        mingleLog "Already Installed."          
    fi
    
    echo
}

buildInstallGraphite2() {
    local _project="graphite2-*"
    local _binCheck="libgraphite2.dll"

    mingleLog "Checking $_project..." true
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] ); then
        mingleLog "Building $_project..." true

        mingleCategoryDownload "graphite2" "$AD_GRAPHITE2_VERSION" "http://sourceforge.net/projects/silgraphite/files/graphite2/graphite2-$AD_GRAPHITE2_VERSION.tgz"
        mingleCategoryDecompress "graphite2" "$AD_GRAPHITE2_VERSION" "$_project"

        ad_cd $_project

        cmake.exe -G "MSYS Makefiles" --debug-output -DGRAPHITE2_NTRACING=ON -DCMAKE_INSTALL_PREFIX=$MINGLE_BASE_MX/mingw64

        buildInstallGeneric "$_project" true true false "" false false "" "" "$_binCheck" "" ""
    else
        mingleLog "Already Installed."  
    fi
}

buildInstallHarfBuzz() {
    local _projectName="harfbuzz"
    local _version="$AD_HARFBUZZ_VERSION"
    local _url="https://github.com/behdad/harfbuzz/archive/8fc1f7fe74a25bf8549f5edd79c7da6b720eb064.zip"
    local _target="harfbuzz-$AD_HARFBUZZ_VERSION.zip"
    local _projectSearchName="harfbuzz-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--with-graphite2=yes"
    local _makeParameters=""
    local _binCheck="libharfbuzz.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallSQLite() {
    local _projectName="sqlite"
    local _version="$AD_SQLITE_VERSION"
    local _url="http://www.sqlite.org/sqlite-autoconf-$AD_SQLITE_VERSION.tar.gz"
    local _target=""
    local _projectSearchName="sqlite-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
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

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallICU() {
    local _project="icu4c-*"
    
    mingleLog "Checking $_project..." true
    
    if [ ! -e /mingw/lib/libicui18n.dll ]; then
        mingleLog "Building $_project..." true
        
        mingleCategoryDownload "icu4c" "$AD_ICU_VERSION" "http://download.icu-project.org/files/icu4c/50.1/icu4c-$AD_ICU_VERSION-src.tgz"
        mingleCategoryDecompress "icu4c" "$AD_ICU_VERSION" "$_project"

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
            cp $MINGLE_BASE/patches/icu/$AD_ICU_VERSION/icu-mingw.patch .
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
    
    mingleLog "Checking $_project..." true

    if [ -e /mingw/lib/libpq.dll ] && [ -e /mingw/bin/postgres.exe ]; then
        mingleLog "Already Installed."
        return;
    fi
    
    mingleLog "Building $_project..." true
    mingleCategoryDownload "postgresql" "$AD_POSTGRES_VERSION" "http://ftp.postgresql.org/pub/source/v$AD_POSTGRES_VERSION/postgresql-$AD_POSTGRES_VERSION.tar.gz"
    mingleCategoryDecompress "postgresql" "$AD_POSTGRES_VERSION" "$_project"

    local _projectDir=$(ad_getDirFromWC "$_project")

    ad_cd "$_projectDir"

    if [ ! -e postgresql-mingw.patch ]; then
        cp $MINGLE_BASE/patches/postgresql/$AD_POSTGRES_VERSION/postgresql-mingw.patch .
        ad_patch "postgresql-mingw.patch"
    fi

    ad_cd ".."

    export "CFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64"
    export "LDFLAGS=-L/mingw/lib"
    export "CPPFLAGS=-I/mingw/include  -D_WIN64 -DMS_WIN64"

    buildInstallGeneric "$_project" false true false "" true true "" "" "postgres" "" "postgres --version"
    
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
    local _version="$AD_EXPAT_VERSION"
    local _url="http://sourceforge.net/projects/expat/files/expat/$AD_EXPAT_VERSION/expat-$AD_EXPAT_VERSION.tar.gz"
    local _target=""
    local _projectSearchName="expat-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libexpat.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallLibproj() {
    local _projectName="proj"
    local _version="$AD_PROJ_VERSION"
    local _url="http://download.osgeo.org/proj/proj-$AD_PROJ_VERSION.tar.gz"
    local _target=""
    local _projectSearchName="proj-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libproj.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallProjDatumgrid() {
    local _project="proj-datumgrid*"

    mingleLog "Checking $_project..." true
    
    if [ ! -e /mingw/share/proj/ntv1_can.dat ]; then
        mingleLog "Building $_project..." true
        
        if [ ! -e proj-datumgrid ]; then
            mkdir proj-datumgrid
        fi
        
        mingleCategoryDownload "proj-datumgrid" "$AD_PROJ_GRIDS_VERSION" "http://download.osgeo.org/proj/proj-datumgrid-$AD_PROJ_GRIDS_VERSION.zip"
        mingleCategoryDecompress "proj-datumgrid" "$AD_PROJ_GRIDS_VERSION" "$_project" "proj-datumgrid"
        
        ad_cd proj-datumgrid

        cp -rf * /mingw/share/proj || mingleError $? "cp failed, aborting!"
     
        export PROJ_LIB=/mingw/share/proj

        mingleLog "export PROJ_LIB=/mingw/share/proj">>/etc/profile

        ad_cd ".."
    else
        mingleLog "Already Installed."        
    fi  
}

buildInstallLibGeotiff() {
    local _projectName="libgeotiff"
    local _version="$AD_GEOTIFF_VERSION"
    local _url="ftp://ftp.remotesensing.org/pub/geotiff/libgeotiff/libgeotiff-$AD_GEOTIFF_VERSION.zip"
    local _target=""
    local _projectSearchName="libgeotiff-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--enable-shared --enable-incode-epsg"
    local _makeParameters=""
    local _binCheck="libgeotiff.dll.a"
    local _postBuildCommand=""
    local _exeToTest="geotifcp"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    
    _configureFlags="--enable-static --enable-incode-epsg"
    _binCheck="libgeotiff.a"
    
    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallLibgeos() {
    local _projectName="geos"
    local _version="$AD_GEOS_VERSION"
    local _url="http://download.osgeo.org/geos/geos-$AD_GEOS_VERSION.tar.bz2"
    local _target=""
    local _projectSearchName="geos-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags="-I macros"
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libgeos.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallGDAL() {
    local _project="gdal-*"
    local _configureFlags=""
    local _binCheck="libgdal-1.dll"
    local _exeToTest="gdal_grid --version"
    
    mingleLog "Checking $_project..." true
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
    
        ad_setDefaultEnv
        
        mingleCategoryDownload "gdal" "$AD_GDAL_VERSION" "http://download.osgeo.org/gdal/gdal-$AD_GDAL_VERSION.tar.gz"
        mingleCategoryDecompress "gdal" "$AD_GDAL_VERSION" "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")
  
        ad_configure "$_project" true false "" true "$_configureFlags"

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
    local _binCheck="python.exe"
    local _exeToTest="python --version"
    
    mingleLog "Checking $_project..." true
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true
        
        ad_setDefaultEnv
        
        mingleCategoryDownload "Python" "$AD_PYTHON_VERSION" "https://www.python.org/ftp/python/$AD_PYTHON_VERSION/Python-$AD_PYTHON_VERSION.tgz"
        mingleCategoryDecompress "Python" "$AD_PYTHON_VERSION" "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")
        
        if ls -d cpython*/ &> /dev/null; then
            mv cpython* python-latest
        fi
        
        ad_cd $_projectDir
        
        if [ ! -e python-mingw.patch ]; then
            #http://bugs.python.org/issue3754
            #http://bugs.python.org/issue4709
            
            #my update
            cp $MINGLE_BASE/patches/python/$AD_PYTHON_VERSION/python-mingw.patch .
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
               
        ad_configure "$_project" true false "" true "--with-libs=-lmingle --with-system-expat --enable-loadable-sqlite-extensions build_alias=x86_64-w64-mingw32 host_alias=x86_64-w64-mingw32 target_alias=x86_64-w64-mingw32"

        ad_cd "$MINGLE_BUILD_DIR"        

        ad_cd $_projectDir

        cp -f PC/pyconfig.h .
        
        ad_make $_project
        
        ln -s /mingw/bin/python$AD_PYTHON_MAJOR /mingw/bin/python
    else
        mingleLog "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
}

buildInstallSetupTools() {
    local _savedir=`pwd`
    local _project="setuptools-*"
    
    mingleLog "Checking $_project..." true
    if [ ! -e /mingw/lib/python$AD_PYTHON_MAJOR/site-packages/easy_install.exe ]; then
        mingleLog "Downloading and configuring Python SetupTools..." true
        
        mingleCategoryDownload "Python" "0.6c11" "https://pypi.python.org/packages/source/s/setuptools/setuptools-0.6c11.tar.gz"
        mingleCategoryDecompress "Python" "0.6c11" "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")

        ad_cd $_project

        setup.py install --install-purelib `python -c "import sysconfig;print sysconfig.get_path('purelib')"` --install-scripts `python -c "import sysconfig;print sysconfig.get_path('purelib')"` --exec-prefix=`python -c "import sysconfig;print sysconfig.get_path('purelib')"`

        ad_cd /mingw/lib/python$AD_PYTHON_MAJOR/site-packages
        
        echo "[easy_install]">setup.cfg
        echo >> setup.cfg
        echo "install_dir = `python -c "import sysconfig;print sysconfig.get_path('purelib')"`">> setup.cfg

        mingleLog "Complete."
    else
        mingleLog "Already Installed."
    fi

    cd $_savedir
}

buildInstallNose() {
    local _savedir=`pwd`

    mingleLog "Checking Nose..." true
    
    if [ ! -e /mingw/lib/python$AD_PYTHON_MAJOR/site-packages/nosetests.exe ]; then
        mingleLog "Downloading and configuring Nose..." true
        
        cd /mingw/lib/python$AD_PYTHON_MAJOR/site-packages
        easy_install --install-dir=. nose
    else
        echo "Already Installed."
    fi

    ad_cd $_savedir
}

buildInstallWerkzeug() {
    mingleLog "Downloading and configuring Werkzeug..." true

    local _savedir=`pwd`

    ad_cd /mingw/lib/python$AD_PYTHON_MAJOR/site-packages
    
    easy_install --install-dir=. Werkzeug

    ad_cd $_savedir
}

buildInstallPyTest() {
    mingleLog "Downloading and configuring PyTest..." true

    local _savedir=`pwd`

    ad_cd /mingw/lib/python$AD_PYTHON_MAJOR/site-packages
    
    easy_install --install-dir=. pytest

    ad_cd $_savedir
}

buildInstallScons() {
    local _project="scons-*"

    mingleLog "Checking $_project..." true
    if [ ! -e /mingw/bin/scons.py ]; then
        mingleLog "Building $_project..." true
        
        mingleCategoryDownload "scons" "$AD_SCONS_VERSION" "http://sourceforge.net/projects/scons/files/scons/$AD_SCONS_VERSION/scons-$AD_SCONS_VERSION.tar.gz"
        mingleCategoryDecompress "scons" "$AD_SCONS_VERSION" "$_project"

        local _projectdir=$(ad_getDirFromWC "$_project")

        ad_cd "$_projectdir"
        
        if [ ! -e scons-mingw.patch ]; then
             cp $MINGLE_BASE/patches/scons/$AD_SCONS_VERSION/scons-mingw.patch . || mingleError $? "patch failed, aborting!"
             ad_patch "scons-mingw.patch"
        fi                

        python setup.py install --install-lib "/mingw/lib/python2.7/site-packages" --install-scripts "/mingw/bin" --no-install-bat --standard-lib
        
        ad_cd ".."
    else
        mingleLog "$_project Already Installed."
    fi    
}

buildInstallSerf() {
    local _project="serf-*"

    mingleLog "Checking $_project..." true
    if [ ! -e /mingw/lib/libserf-1.dll.a ]; then
        mingleLog "Building $_project..." true
        
        ad_setDefaultEnv
        
        mingleCategoryDownload "serf" "$AD_SERF_VERSION" "https://serf.googlecode.com/files/serf-$AD_SERF_VERSION.tar.bz2"
        mingleCategoryDecompress "serf" "$AD_SERF_VERSION" "$_project"

        local _projectdir=$(ad_getDirFromWC "$_project")

        ad_cd "$_projectdir"
        
        if [ ! -e serf-mingw.patch ]; then
             cp $MINGLE_BASE/patches/serf/$AD_SERF_VERSION/serf-mingw.patch . || mingleError $? "patch failed, aborting!"
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

buildInstallNode() {
    local _projectName="node"
    local _version=""
    local _url=""
    local _target=""
    local _projectSearchName="node-v*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="xxx"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallNodeMapnik() {
    local _projectName="node-mapnik"
    local _version=""
    local _url=""
    local _target=""
    local _projectSearchName="node-mapnik*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="xxx"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallWAF() {
    local _project="waf-*"

    mingleLog "Checking $_project..." true
    if [ ! -e /mingw/bin/waf ]; then
        mingleLog "Building $_project..." true

        mingleCategoryDownload "waf" "$AD_WAF_VERSION" "http://waf.googlecode.com/files/waf-$AD_WAF_VERSION.tar.bz2"
        mingleCategoryDecompress "waf" "$AD_WAF_VERSION" "$_project"
        
        local _projectdir=$(ad_getDirFromWC "$_project")

        ad_cd "$_projectdir"

        if [ ! -e waf-mingw.patch ]; then
             cp $MINGLE_BASE/patches/waf/$AD_WAF_VERSION/waf-mingw.patch . || mingleError $? "patch failed, aborting!"
             ad_patch "waf-mingw.patch"
        fi

        ad_cd ".."

        buildInstallGeneric "waf-*" true true false "" true true "" "" "waf" "" ""

        ad_cd "$_projectdir"

        cp waf /mingw/bin || mingleError $? "failed to install waf, aborting!"

        ad_cd ".."
    else
        mingleLog "$_project Already Installed."
    fi
}

buildInstallBoostJam() {
    local _projectName="boost-jam"
    local _version="$AD_BOOST_JAM_VERSION"
    local _url="http://sourceforge.net/projects/boost/files/boost-jam/3.1.18/boost-jam-$AD_BOOST_JAM_VERSION.tgz"
    local _target=""
    local _projectSearchName="boost-jam*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="bjam"
    local _postBuildCommand="cp bin.ntx86_64/*.exe /mingw/bin"
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallBoost() {
    local _project="boost_*"
    local _binCheck="boost_system-48-mt-1_$AD_BOOST_MINOR_VERSION.dll"

    mingleLog "Checking $_project..." true
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Building $_project..." true

        mingleCategoryDownload "boost" "$AD_BOOST_VERSION" "http://sourceforge.net/projects/boost/files/boost/"$AD_BOOST_PATH_VERSION"/boost_"$AD_BOOST_VERSION".7z"
        mingleCategoryDecompress "boost" "$AD_BOOST_VERSION" "$_project"
        
        local _projectDir=$(ad_getDirFromWC "$_project")

        cd $_project || mingleError $? "cd failed, aborting!"

        if [ ! -e boost-mingw.patch ]; then
            # Apply patch for https://svn.boost.org/trac/boost/ticket/5023
            cp $MINGLE_BASE/patches/boost/$AD_BOOST_PATH_VERSION/boost-mingw.patch .
            ad_patch "boost-mingw.patch"
        fi

        ad_cd ".."

        export CPLUS_INCLUDE_PATH=/mingw/include/python2.7
        buildInstallGeneric "boost_*" true true false "" true true "" "" "boost_system-47-mt-1_$AD_BOOST_MINOR_VERSION.dll" "" ""
        export CPLUS_INCLUDE_PATH=

        ad_relocate_bin_dlls "boost_"
    else
        mingleLog "$_project Already Installed."
    fi
}

buildInstallPyCairo() {
    local _project="py2cairo-*"
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

        mingleCategoryDownload "py2cairo" "$AD_PYCAIRO_VERSION" "http://www.cairographics.org/releases/py2cairo-$AD_PYCAIRO_VERSION.tar.bz2"
        mingleCategoryDecompress "py2cairo" "$AD_PYCAIRO_VERSION" "$_project"
        
        local _projectDir=$(ad_getDirFromWC "$_project")
        
        ad_cd "$_projectDir"
        
        #Expand waflib
        ./waf --version

        #patch waflib
        cd waf-*/waflib

        if [ ! -e waf-mingw.patch ]; then
            cp $MINGLE_BASE/patches/py2cairo/$AD_PYCAIRO_VERSION/waf-mingw.patch .
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

    mingleLog "Checking $_project..." true
    if [ -e /mingw/lib/mapnik.dll ] && [ -e /mingw/lib/libmapnik.dll.a ]; then
        mingleLog "$_project Already Installed." 
        return
    fi
    
    mingleLog "Building $_project..." true
    
    mingleCategoryDownload "mapnik" "$AD_MAPNIK_VERSION" "https://github.com/downloads/mapnik/mapnik/mapnik-v$AD_MAPNIK_VERSION.tar.bz2"
    mingleCategoryDecompress "mapnik" "$AD_MAPNIK_VERSION" "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)

    ad_cd "$_projectdir"
        
    if [ ! -e mapnik-mingw.patch ]; then
         #my update
         cp $MINGLE_BASE/patches/mapnik/$AD_MAPNIK_VERSION/mapnik-mingw.patch .
         ad_patch "mapnik-mingw.patch"
    fi

    ad_cd ".."

    buildInstallGeneric "$_project" true true false "" true true "PREFIX=/mingw CUSTOM_CXXFLAGS=-DMS_WIN64 BOOST_INCLUDES=/mingw/include/boost-1_53 BOOST_LIBS=/mingw/lib CC=x86_64-w64-mingw32-gcc-4.7.2.exe CXX=x86_64-w64-mingw32-g++.exe" "" "mapnik.dll" "" "mapnik-config --version"

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

    buildInstallGeneric "$_project" true true false "" true true "PREFIX=/mingw CUSTOM_CXXFLAGS=-DMS_WIN64 CUSTOM_CXXFLAGS=-D__MINGW__ BOOST_INCLUDES=/mingw/include/boost-1_53 BOOST_LIBS=/mingw/lib CC=gcc.exe CXX=g++.exe" "" "mapnik.dll" "" "mapnik-config --version"

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

    mingleLog "Checking $_project..." true
    if [ -e /mingw/bin/perl5.18.0 ]; then
        echo "$_project Already Installed." 
        echo
        return
    fi

    mingleLog "Building $_project..." true
    
    ad_setDefaultEnv

    mingleCategoryDownload "perl" "$AD_PERL_VERSION" "http://www.cpan.org/src/$AD_PERL_SHRT_VERSION/perl-$AD_PERL_VERSION.tar.gz"
    mingleCategoryDecompress "perl" "$AD_PERL_VERSION" "$_project"
    
    local _projectdir=$(ad_getDirFromWC $_project)

    ad_cd $_projectdir

    #Notes from http://sourceforge.net/projects/perlmingw/files/Compiler%20for%2064%20bit%20Windows/
    if [ ! -e perl-mingw.patch ]; then
         cp $MINGLE_BASE/patches/perl/$AD_PERL_VERSION/perl-mingw.patch .
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

    mingleLog "Checking $_project..." true
    if [ -e /mingw/bin/pcregrep ]; then
        echo "$_project Already Installed." 
        echo
        return
    fi
    
    mingleLog "Building $_project..." true

    mingleCategoryDownload "pcre" "$AD_PCRE_VERSION" "http://sourceforge.net/projects/pcre/files/pcre/$AD_PCRE_VERSION/pcre-$AD_PCRE_VERSION.tar.gz/download" "pcre-$AD_PCRE_VERSION.tar.gz"
    mingleCategoryDecompress "pcre" "$AD_PCRE_VERSION" "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)

    ad_cd $_projectdir

    if [ ! -e pcre-mingw.patch ]; then
         cp $MINGLE_BASE/patches/pcre/$AD_PCRE_VERSION/pcre-mingw.patch .
         ad_patch "pcre-mingw.patch"
    fi

    buildInstallGeneric "$_project" true true true "-I m4" true true "--disable-cpp --disable-shared --enable-newline-is-anycrlf --enable-utf8 --enable-unicode-properties" "" "pcregrep" "" ""
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
    
    mingleCategoryDownload "BerkeleyDB" "$AD_PERL_DB" "http://search.cpan.org/CPAN/authors/id/P/PM/PMQS/BerkeleyDB-$AD_PERL_DB.tar.gz"
    mingleCategoryDecompress "BerkeleyDB" "$AD_PERL_DB" "$_project"
    
    local _projectdir=$(ad_getDirFromWC $_project)
    
    ad_cd "$_projectdir"
    
    perl Makefile.PL INC=-I/mingw/include LIBS="-lpthread -ldb-6.0.dll"
    dmake
    dmake test
    dmake install
    
    ad_cd "$MINGLE_BUILD_DIR"
    
    _project="DB_File-*"
    
    mingleCategoryDownload "DB_File" "$AD_PERL_FILE_DB" "http://search.cpan.org/CPAN/authors/id/P/PM/PMQS/DB_File-$AD_PERL_FILE_DB.tar.gz"
    mingleCategoryDecompress "DB_File" "$AD_PERL_FILE_DB" "$_project"
    
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

    mingleLog "Checking $_project..." true
    if [ -e /mingw/bin/texi2any ]; then
        mingleLog "$_project Already Installed." true
        return
    fi
    
    mingleLog "Building $_project..." true
    
    mingleCategoryDownload "texinfo" "$AD_TEXTINFO" "http://ftp.gnu.org/gnu/texinfo/texinfo-$AD_TEXTINFO.tar.gz"
    mingleCategoryDecompress "texinfo" "$AD_TEXTINFO" "$_project"
    
    local _projectdir=$(ad_getDirFromWC $_project)

    ad_cd $_projectdir

    if [ ! -e texinfo-mingw.patch ]; then
         cp $MINGLE_BASE/patches/texinfo/$AD_TEXTINFO/texinfo-mingw.patch .
         ad_patch "texinfo-mingw.patch"
    fi
	
    buildInstallGeneric "$_project" true true true "-I gnulib/m4" true true "" "" "texi2any" "" "texi2any --version"
}

buildInstallGetText() {
    local _projectName="gettext"
    local _version="0.19"
    local _url="http://ftp.gnu.org/pub/gnu/gettext/gettext-$_version.tar.gz"
    local _target=""
    local _projectSearchName="gettext-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=false #true/false
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
    
    export "CFLAGS=-I/mingw/include -O2"
    export "CPPFLAGS=$CFLAGS"
    export "CXXFLAGS=$CPPFLAGS"
    export "CC=x86_64-w64-mingw32-gcc"
    export "CXX=x86_64-w64-mingw32-g++"    
	
    buildInstallGeneric "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"

    #Currently, msmerge hangs.
    if [ -e /mingw/bin/msgmerge.exe ]; then
        mv /mingw/bin/msgmerge.exe /mingw/bin/msgmerge.exe.disabled
    fi
}

buildInstallSwig() {
    mingleLog "Checking $_project..." true
    if [ -e /usr/local/bin/swig ]; then
        mingleLog "$_project Already Installed." true
        return
    fi
    
    local _projectName="swig"
    local _version="$AD_SWIG_VERSION"
    local _url="http://downloads.sourceforge.net/project/swig/swig/swig-$AD_SWIG_VERSION/swig-$AD_SWIG_VERSION.tar.gz"
    local _target=""
    local _projectSearchName="swig-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="swig"
    local _postBuildCommand=""
    local _exeToTest="swig -version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    
    export "SWIG_LIB=/mingw/share/swig/2.0.10"
    echo "export SWIG_LIB=/mingw/share/swig/2.0.10">>/etc/profile
}

buildInstallJSONC() {   
    local _projectName="json-c"
    local _version="$AD_JSONC_VERSION"
    local _url="https://github.com/json-c/json-c/archive/be002fbb96c484f89aee2c843b89bdd00b0a5e46.zip"
    local _target="json-c-$AD_JSONC_VERSION.zip"
    local _projectSearchName="json-c-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters="LN_S=ln -s"
    local _binCheck="libjson-c-2.dll"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"    

    if [ ! -e /mingw/include/json ]; then
        ln -s /mingw/include/json-c/ /mingw/include/json || mingleError $? "json-c: ln failed, aborting!"
    fi
}

buildInstallPostGIS () {
    local _project="postgis-*"

    if [ -e /mingw/lib/postgresql/postgis-2.0.dll ]; then
        mingleLog "$_project Already Installed." true
        return
    fi
    
    mingleCategoryDownload "postgis" "$AD_POSTGIS_VERSION" "http://download.osgeo.org/postgis/source/postgis-$AD_POSTGIS_VERSION.tar.gz"
    mingleCategoryDecompress "postgis" "$AD_POSTGIS_VERSION" "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)

    ad_cd $_projectdir

    if [ ! -e postgis-mingw.patch ]; then
         cp $MINGLE_BASE/patches/postgis/$AD_POSTGIS_VERSION/postgis-mingw.patch .
         ad_patch "postgis-mingw.patch"
    fi
        
    export "PG_CPPFLAGS=-D__ERRCODE_DEFINED_MS"

    buildInstallGeneric "$_project" true true false "" true true "--with-jsondir=/mingw" "" "/mingw/lib/postgresql/postgis-2.0.dll"
}

updatePostgresSqlConf() {
    local _variable=$1
    local _value=$2
    
    mingleLog "Updating $_variable = $_value..."
    
    sed -e "s/[#]*\("$_variable"\)\s*=\s*[[:alnum:]\.\_\%\'-]*/\1 = "$_value"/g" $POSTGIS_PATH/postgresql.conf>$POSTGIS_PATH/update.conf
    mv $POSTGIS_PATH/update.conf $POSTGIS_PATH/postgresql.conf    
}

initializePostGISDB () {
    mingleLog "Creating PostGIS Database..." true

    export PGPASSWORD=temp123

    initdb -U postgres -D $POSTGIS_PATH -E 'UTF8' --lc-collate='English_United States.1252' --lc-ctype='English_United States.1252'

    # Tune Parameters for postgresql.conf
    # autovacuum = off
    # checkpoint_segments = 20
    # shared_buffers = 512MB # min 128kB
    # work_mem = 256MB # min 64kB
    # maintenance_work_mem = 512MB # min 1MB
    # synchronous_commit = off

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
    psql postgres postgres <<< "CREATE DATABASE osm WITH OWNER = osm ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252' CONNECTION LIMIT = -1;"
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
    local _version="$AD_PROTO_BUF"
    local _url="http://protobuf.googlecode.com/files/protobuf-$AD_PROTO_BUF.zip"
    local _target=""
    local _projectSearchName="protobuf-*"
    local _cleanEnv=true #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags="-I m4"
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags=""
    local _makeParameters=""
    local _binCheck="libprotobuf.a"
    local _postBuildCommand=""
    local _exeToTest=""

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
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
 
        export "CFLAGS=-I/mingw/include/mingle -I/mingw/include -D_WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO -D__MINGW32__"
        export "LDFLAGS=-L/mingw/lib -lmingle -lws2_32"
        export "CPPFLAGS=-I/mingw/include/mingle -I/mingw/include -D_WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO -D__MINGW32__"
        
        ad_cd $_projectDir
        
        ./autogen.sh --prefix=/mingw
        
        #CFLAGS are not needed for generating protobuf-c libtool wrapper
        sed 's/^LTCFLAGS=.*/LTCFLAGS="-D_WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO -D__MINGW32__"/g' libtool>libtool2
        mv -f libtool2 libtool
        
        ad_cd ".."

        ad_make "$_project"
    else
        mingleLog "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
    
    echo       
}
    
buildInstallOsm2pgsql() {
    export "CFLAGS=-I/mingw/include -DWIN32 -D_WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO -D__MINGW32__"
    #export "LDFLAGS=-L/mingw/lib -lmingle"
    export "LIBS=-L/mingw/lib -lmingle"
    export "CPPFLAGS=$CFLAGS"    
    export "CC=x86_64-w64-mingw32-gcc -I/mingw/include/mingle"
    export "CXX=x86_64-w64-mingw32-gcc -I/mingw/include/mingle"
    
    local _projectName="osm2pgsql"
    local _version="master"
    local _url="https://github.com/onepremise/osm2pgsql/archive/master.zip"
    local _target="osm2pgsql.zip"
    local _projectSearchName="osm2pgsql*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=true #true/false
    local _runACLocal=true #true/false
    local _aclocalFlags="-I m4"
    local _runAutoconf=true #true/false
    local _runConfigure=true #true/false
    local _configureFlags="--with-zlib=/mingw --with-bzip2=/mingw --with-geos=/mingw/bin/geos-config --with-libxml2=/mingw/bin/xml2-config --with-proj=/mingw --with-postgresql=/mingw/bin/pg_config.exe --with-protobuf-c=/mingw"
    local _makeParameters=""
    local _binCheck="osm2pgsql.exe"
    local _postBuildCommand=""
    local _exeToTest="osm2pgsql.exe --version"

    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
}

buildInstallCPIO() {
    local _projectName="cpio"
    local _version="2.11"
    local _url="http://ftp.gnu.org/gnu/cpio/cpio-$_version.tar.gz"
    local _target=""
    local _projectSearchName="cpio-*"
    local _cleanEnv=false #true/false
    local _runAutoGenIfExists=false #true/false
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
    
    buildInstallGeneric "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
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
    local _runACLocal=false #true/false
    local _aclocalFlags=""
    local _runAutoconf=false #true/false
    local _runConfigure=false #true/false
    local _configureFlags=""
    local _makeParameters="JAVAHOME=\"$UPD_JH\" CFLAGS=\"-I$UPD_JH/include/win32  -O -fPIC -c\" LFLAGS=\"-shared -fPIC -v -L$UPD_JH/lib\" JLIBRARIES=\" -L$UPD_JH_MX/jre/lib/amd64 -L$UPD_JH_MX/jre/lib/i386 -ljawt\""
    local _binCheck="fta.dll"
    local _postBuildCommand=""
    local _exeToTest=""
    
    mingleAutoBuild "$_projectName" "$_version" "$_url" "$_target" "$_projectSearchName" $_cleanEnv $_runAutoGenIfExists $_runACLocal "$_aclocalFlags" $_runAutoconf $_runConfigure "$_configureFlags" "$_makeParameters" "$_binCheck" "$_postBuildCommand" "$_exeToTest"
    
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleLog "Updating $_projectName..." true
        local _projectDir=$(ad_getDirFromWC "$_projectSearchName")
        
        ad_cd $_projectDir/bin
        mv libfta.so fta.dll
    else
        mingleLog "Already Installed."
    fi
}

MINGLE_SUITE_BASE=false
MINGLE_SUITE_XML=false
MINGLE_SUITE_FONTS=false
MINGLE_SUITE_ENCYPT=false
MINGLE_SUITE_NETWORK=false
MINGLE_SUITE_CA=false
MINGLE_SUITE_DB=false
MINGLE_SUITE_PERL=false
MINGLE_SUITE_TEXT=false
MINGLE_SUITE_UTIL=false
MINGLE_SUITE_SWIG=false
MINGLE_SUITE_PYTHON=false
MINGLE_SUITE_JAVA=false
MINGLE_SUITE_DEBUG=false
MINGLE_SUITE_BOOST=false
MINGLE_SUITE_IMAGE_TOOLS=false
MINGLE_SUITE_MATH=false
MINGLE_SUITE_SCM=false
MINGLE_SUITE_GRAPHICS=false
MINGLE_SUITE_UI=false
MINGLE_SUITE_CRYPTOCURRENCY=false
MINGLE_SUITE_GEO_SPATIAL=false
MINGLE_MAPNIK=false
MINGLE_MAPNIK_TOOLS=false
MINGLE_SIMULATION=false
MINGLE_OSM2PGSQL=false
MINGLE_EXCLUDE_DEP=false

suiteBase() {
    if [ $SUITE_BASE ]; then
        return;
    else
        SUITE_BASE=true
    fi

    updateFindCommand

    updateGCC
    
    #experimental
    #updateTarCommand

    install7Zip
    #buildInstallPThreads
    buildInstallAutoconf
    buildInstallAutoMake
    buildInstallLibtool
    buildInstallPkgconfig
    
    buildInstallGMP
    buildInstallMPFR
    buildInstallMPC
    
    buildInstallMingw64CRT
    buildInstallPExports
    buildInstallGenDef
    
    buildInstallZlib
    buildInstallBzip2
    buildInstallLibiconv
    buildInstallBinutils
    buildInstallTCL
    buildInstallTk
    buildInstallSigc
    buildInstallJSONC

    #Keep the msys M4 for now due to build issues it causes with autoconf
    #buildInstallM4
    #Not ready for mingw64
    #buildInstallGLibC
    
    buildInstallRagel
    buildInstallCMake
    buildInstallGperf
}

suiteXML() {
    if $MINGLE_SUITE_XML ; then
        return;
    else
        MINGLE_SUITE_XML=true
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
    if $MINGLE_SUITE_FONTS ; then
        return;
    else
        MINGLE_SUITE_FONTS=true
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
    if $MINGLE_SUITE_ENCYPT ; then
        return;
    else
        MINGLE_SUITE_ENCYPT=true
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
      suiteBase
    fi

    buildInstallPolarSSL
    buildInstallLOpenSSL
}

suiteNetworking() {
    if $MINGLE_SUITE_NETWORK ; then
        return;
    else
        MINGLE_SUITE_NETWORK=true
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
      suiteEncryption
    fi

    buildInstallCurl
    buildInstalProtobuf
    buildInstallProtobufC
}

suiteCABundle() {
    if $MINGLE_SUITE_CA ; then
        return;
    else
        MINGLE_SUITE_CA=true
    fi
    
    if ! $MINGLE_EXCLUDE_DEP; then
        suiteNetworking
        suitePerl
    fi
    
    buildInstallCABundle
}

suiteDatabase() {
    if $MINGLE_SUITE_DB ; then
        return;
    else
        MINGLE_SUITE_DB=true
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
    if $MINGLE_SUITE_PYTHON ; then
        return;
    else
        MINGLE_SUITE_PYTHON=true
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
    if $MINGLE_SUITE_PERL ; then
        return;
    else
        MINGLE_SUITE_PERL=true
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
    if $MINGLE_SUITE_TEXT ; then
        return;
    else
        MINGLE_SUITE_TEXT=true
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
    if $MINGLE_SUITE_UTIL ; then
        return;
    else
        MINGLE_SUITE_UTIL=true
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
    if $MINGLE_SUITE_JAVA ; then
        return;
    else
        MINGLE_SUITE_JAVA=true
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
    if $MINGLE_SUITE_SWIG ; then
        return;
    else
        MINGLE_SUITE_SWIG=true
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
    if $MINGLE_SUITE_DEBUG ; then
        return;
    else
        MINGLE_SUITE_DEBUG=true
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
    if $MINGLE_SUITE_BOOST ; then
        return;
    else
        MINGLE_SUITE_BOOST=true
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
    buildInstallBoost
}

suiteSCMTools() {
    if $MINGLE_SUITE_SCM ; then
        return;
    else
        MINGLE_SUITE_SCM=true
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
    if $MINGLE_SUITE_IMAGE_TOOLS ; then
        return;
    else
        MINGLE_SUITE_IMAGE_TOOLS=true
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
    if $MINGLE_SUITE_UI ; then
        return;
    else
        MINGLE_SUITE_UI=true
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteImageTools
        suiteXML
    fi

    buildInstallGTK
    buildInstallQt
}

suiteMathLibraries() {
    if $MINGLE_SUITE_MATH ; then
        return;
    else
        MINGLE_SUITE_MATH=true
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
    if $MINGLE_SUITE_CRYPTOCURRENCY ; then
        return;
    else
        MINGLE_SUITE_CRYPTOCURRENCY=true
    fi
    
    if ! $MINGLE_EXCLUDE_DEP; then
        suiteUILibraries
    fi
    
    buildInstallBitcoin
}

suiteGrpahicLibraries() {
    if $MINGLE_SUITE_GRAPHICS ; then
        return;
    else
        MINGLE_SUITE_GRAPHICS=true
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
    if $MINGLE_SUITE_GEO_SPATIAL ; then
        return;
    else
        MINGLE_SUITE_GEO_SPATIAL=true
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
    fi

    buildInstallLibgeos
    buildInstallGDAL
    buildInstallPostGIS
}

suiteMapnik() {
    local _useDev=$1

    if $MINGLE_MAPNIK ; then
        return;
    else
        MINGLE_MAPNIK=true
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
    if $MINGLE_MAPNIK_TOOLS; then
        return;
    else
        MINGLE_MAPNIK_TOOLS=true
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
    if $MINGLE_SIMULATION; then
        return;
    else
        MINGLE_SIMULATION=true
    fi

    if ! $MINGLE_EXCLUDE_DEP; then
        suiteBase
    fi
    
    buildInstallOpenFTA
}

suiteOSM2PTSQL() {
    if $MINGLE_OSM2PGSQL; then
        return;
    else
        MINGLE_OSM2PGSQL=true
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
