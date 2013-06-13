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

export AD_MFOUR=1.4.16
export AD_AUTOCONF=2.69
export AD_AUTOMAKE=1.12.5
export AD_GMP=5.1.2
export AD_MPFR=3.1.2
export AD_MPC=1.0.1
export AD_MINGW64_CRT=2.0.8
export AD_GLIBC=2.16.0
export AD_ZLIB=1.2.7
export AD_BZIP=1.0.6
export AD_SEVENZIPPATH=9.20
export AD_SEVENZIP=920
export AD_PTHREADS=2-9-1
export AD_PKGCONFIG=0.27.1
export AD_BINUTILS_VERSION=2.23.1
export AD_ICU_VERSION=50_1
export AD_ZLIB_VERSION=1.2.7
export AD_EXPAT_VERSION=2.1.0
export AD_LIBICONV=1.14
export AD_POLAR_VERSION=1.2.3
export AD_OPENSSL_VERSION=1.0.1c
export AD_LIBXML2_VERSION=2.9.0
export AD_LIBCURL_VERSION=7.28.1

export AD_GDB_VERSION=7.5

export AD_TCL_VERSION_MAJOR=8.6
export AD_TCL_VERSION_MINOR=.0
export AD_TCL_VERSION=$AD_TCL_VERSION_MAJOR$AD_TCL_VERSION_MINOR

export AD_TK_VERSION=8.6.0

export AD_APR_VERSION=1.4.6
export AD_SVN_VERSION=1.7.9
export AD_GIT_VERSION=

export AD_LIBSIGC_PATH_VERSION=2.3
export AD_LIBSIGC_VERSION=2.3.1

export AD_BOOST_JAM_VERSION=3.1.18

export AD_BOOST_MINOR_VERSION=52
export AD_BOOST_PATH_VERSION=1."$AD_BOOST_MINOR_VERSION".0
export AD_BOOST_VERSION=1_"$AD_BOOST_MINOR_VERSION"_0

export AD_FONT_CONFIG=2.10.0
export AD_FREETYPE_VERSION=2.4.10

export AD_SQLITE_VERSION=3071500

export AD_LIBPNG_MAJOR=1.6
export AD_LIBPNG_MINOR=.2
export AD_LIBPNG_VERSION=$AD_LIBPNG_MAJOR$AD_LIBPNG_MINOR
export AD_LIBJPEG_VERSION=1.2.1
export AD_TIFF_VERSION=4.0.3

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

export AD_POSTGRES_VERSION=9.2.2

export AD_MAPNIK_VERSION=2.1.0

export AD_SWIG_VERSION=2.0.9
export AD_PERL_VERSION=5.16.2
export AD_PERL_SHRT_VERSION=5.0

mingleDownloadPackages () {
    echo "Checking Downloads..."

    mingleDownload "http://sourceforge.net/projects/mingw/files/MSYS/Base/findutils/findutils-4.4.2-2/findutils-4.4.2-2-msys-1.0.13-bin.tar.lzma/download" "findutils-4.4.2-2-msys-1.0.13-bin.tar.lzma"
    mingleDownload "http://ftp.gnu.org/gnu/tar/tar-1.26.tar.gz"    
    mingleDownload "http://sourceforge.net/projects/sevenzip/files/7-Zip/$AD_SEVENZIPPATH/7za$AD_SEVENZIP.zip/download" "7za$AD_SEVENZIP.zip"
#   mingleDownload "http://sourceforge.net/projects/mingw-w64/files/External%20binary%20packages%20%28Win64%20hosted%29/make/make-$MAKE.zip/download" "make-$MAKE.zip"
    mingleDownload "http://ftp.gnu.org/gnu/m4/m4-$AD_MFOUR.tar.xz"
    mingleDownload "http://ftp.gnu.org/gnu/autoconf/autoconf-$AD_AUTOCONF.tar.gz"
    mingleDownload "http://ftp.gnu.org/gnu/automake/automake-$AD_AUTOMAKE.tar.gz"
    mingleDownload "ftp://ftp.gmplib.org/pub/gmp-$AD_GMP/gmp-$AD_GMP.tar.xz"
    mingleDownload "http://www.mpfr.org/mpfr-current/mpfr-$AD_MPFR.tar.xz"
    mingleDownload "http://multiprecision.org/mpc/download/mpc-$AD_MPC.tar.gz"
    mingleDownload "http://downloads.sourceforge.net/project/mingw-w64/mingw-w64/mingw-w64-release/mingw-w64-v$AD_MINGW64_CRT.tar.gz"
    mingleDownload "http://ftp.gnu.org/gnu/libc/glibc-$AD_GLIBC.tar.xz"
    mingleDownload "http://ftp.gnu.org/gnu/gdb/gdb-$AD_GDB_VERSION.tar.gz"
    mingleDownload "http://prdownloads.sourceforge.net/tcl/tcl$AD_TCL_VERSION-src.tar.gz"
    mingleDownload "http://prdownloads.sourceforge.net/tcl/tk$AD_TK_VERSION-src.tar.gz"
    mingleDownload "http://ftpmirror.gnu.org/libtool/libtool-2.4.2.tar.gz"
    mingleDownload "http://sourceforge.net/projects/libpng/files/zlib/$AD_ZLIB/zlib-$AD_ZLIB.tar.gz/download" "zlib-$AD_ZLIB.tar.gz"
    mingleDownload "http://www.bzip.org/$AD_BZIP/bzip2-$AD_BZIP.tar.gz"
    mingleDownload "http://ftp.gnu.org/pub/gnu/libiconv/libiconv-$AD_LIBICONV.tar.gz"
    mingleDownload "ftp://sourceware.org/pub/pthreads-win32/pthreads-w32-$AD_PTHREADS-release.zip"
    mingleDownload "http://pkgconfig.freedesktop.org/releases/pkg-config-$AD_PKGCONFIG.tar.gz"
    mingleDownload "http://ftp.gnu.org/gnu/binutils/binutils-$AD_BINUTILS_VERSION.tar.gz"
    mingleDownload "http://sourceforge.net/projects/boost/files/boost-jam/3.1.18/boost-jam-$AD_BOOST_JAM_VERSION.tgz/download" "boost-jam-$AD_BOOST_JAM_VERSION.tgz"
    mingleDownload "http://sourceforge.net/projects/boost/files/boost/"$AD_BOOST_PATH_VERSION"/boost_"$AD_BOOST_VERSION".7z/download" "boost_"$AD_BOOST_VERSION".7z"
    mingleDownload "http://sourceforge.net/projects/libjpeg-turbo/files/$AD_LIBJPEG_VERSION/libjpeg-turbo-$AD_LIBJPEG_VERSION-gcc64.exe/download" "libjpeg-turbo-$AD_LIBJPEG_VERSION-gcc64.exe"
    mingleDownload "http://www.freedesktop.org/software/fontconfig/release/fontconfig-$AD_FONT_CONFIG.tar.gz"
    mingleDownload "http://ftp.igh.cnrs.fr/pub/nongnu/freetype/freetype-$AD_FREETYPE_VERSION.tar.gz"
    mingleDownload "ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng`echo $AD_LIBPNG_MAJOR|sed 's/\.//'`/libpng-$AD_LIBPNG_VERSION.tar.gz"
    mingleDownload "http://www.zlib.net/zlib-$AD_ZLIB_VERSION.tar.gz"
    mingleDownload "ftp://ftp.remotesensing.org/pub/libtiff/tiff-$AD_TIFF_VERSION.tar.gz"
    mingleDownload "http://curl.haxx.se/download/curl-$AD_LIBCURL_VERSION.tar.bz2"
    mingleDownload "http://mirror.cc.columbia.edu/pub/software/apache/apr/apr-$AD_APR_VERSION.tar.bz2"
    mingleDownload "http://www.apache.org/dist/subversion/subversion-$AD_SVN_VERSION.tar.bz2"
    mingleDownload "https://github.com/git/git/archive/master.zip" "git-master.zip"
    mingleDownload "http://ftp.gnome.org/pub/GNOME/sources/libsigc++/$AD_LIBSIGC_PATH_VERSION/libsigc++-$AD_LIBSIGC_VERSION.tar.xz"
    mingleDownload "http://www.cairographics.org/releases/pixman-$AD_PIXMAN_VERSION.tar.gz"
    mingleDownload "http://www.cairographics.org/releases/cairo-$AD_CAIRO_VERSION.tar.xz"
    mingleDownload "http://www.cairographics.org/releases/cairomm-$AD_CAIROMM_VERSION.tar.gz"
    mingleDownload "http://download.icu-project.org/files/icu4c/50.1/icu4c-$AD_ICU_VERSION-src.tgz"
    mingleDownload "https://polarssl.org/download/polarssl-$AD_POLAR_VERSION-gpl.tgz"
    mingleDownload "http://www.openssl.org/source/openssl-$AD_OPENSSL_VERSION.tar.gz"
    mingleDownload "ftp://xmlsoft.org/libxml2/libxml2-$AD_LIBXML2_VERSION.tar.gz"
    mingleDownload "http://sourceforge.net/projects/expat/files/expat/$AD_EXPAT_VERSION/expat-$AD_EXPAT_VERSION.tar.gz/download" "expat-$AD_EXPAT_VERSION.tar.gz"
    mingleDownload "http://download.osgeo.org/geos/geos-$AD_GEOS_VERSION.tar.bz2"
    mingleDownload "http://download.osgeo.org/gdal/gdal-$AD_GDAL_VERSION.tar.gz"
    mingleDownload "http://www.sqlite.org/sqlite-autoconf-$AD_SQLITE_VERSION.tar.gz"
    mingleDownload "http://download.osgeo.org/proj/proj-$AD_PROJ_VERSION.tar.gz"
    mingleDownload "ftp://ftp.remotesensing.org/pub/geotiff/libgeotiff/libgeotiff-$AD_GEOTIFF_VERSION.zip"
    mingleDownload "http://download.osgeo.org/proj/proj-datumgrid-$AD_PROJ_GRIDS_VERSION.zip"
    mingleDownload "http://www.python.org/ftp/python/$AD_PYTHON_VERSION/Python-$AD_PYTHON_VERSION.tgz"
    mingleDownload "https://pypi.python.org/packages/source/s/setuptools/setuptools-0.6c11.tar.gz"
    mingleDownload "https://pypi.python.org/packages/source/n/nose/nose-$AD_NOSE_VERSION.tar.gz"
    mingleDownload "http://waf.googlecode.com/files/waf-$AD_WAF_VERSION.tar.bz2"
    mingleDownload "http://www.cairographics.org/releases/py2cairo-$AD_PYCAIRO_VERSION.tar.bz2"
    mingleDownload "http://ftp.postgresql.org/pub/source/v$AD_POSTGRES_VERSION/postgresql-$AD_POSTGRES_VERSION.tar.gz"
    mingleDownload "https://download.oracle.com/otn/other/occi/occivc9-winx64-111070-133869.zip"
    mingleDownload "https://github.com/downloads/mapnik/mapnik/mapnik-v$AD_MAPNIK_VERSION.tar.bz2"
    mingleDownload "https://github.com/onepremise/mapnik/archive/master.zip" "mapnik-latest.zip"
    mingleDownload "http://downloads.sourceforge.net/project/swig/swigwin/swigwin-$AD_SWIG_VERSION/swigwin-$AD_SWIG_VERSION.zip"
    mingleDownload "http://www.cpan.org/src/$AD_PERL_SHRT_VERSION/perl-$AD_PERL_VERSION.tar.gz"
    mingleDownload "https://github.com/openstreetmap/mapnik-stylesheets/archive/master.zip" "mapnik-stylesheets.zip"
    #mingleDownload "https://github.com/mapnik/node-mapnik/archive/master.zip" "node-mapnik.zip"
    #mingleDownload "http://nodejs.org/dist/v0.10.0/node-v0.10.0.tar.gz"
    #mingleDownload "https://github.com/mitsuhiko/werkzeug/archive/master.zip" "werkzeug.zip"
    mingleDownload "https://bitbucket.org/springmeyer/tilelite/get/7edec82b0e1f.zip" "tilelite.zip"
}

updateGCC() {
    echo "Updating GCC..."

    sed 's/\(template<class Q>\)/\/\/\1/g' /mingw/x86_64-w64-mingw32/include/unknwn.h > unknwn.h
    mv unknwn.h /mingw/x86_64-w64-mingw32/include/unknwn.h || mingleError $? "Failed to update GCC, aborting!"
}

updateFindCommand() {
    echo
    echo "Update Find Command..."
    local _project="findutils-*"

    # Don't use mingle decomp until the find command has been updated.
    if ls $MINGLE_CACHE/findutils-*-bin.tar.lzma &> /dev/null; then
        lzma -d $MINGLE_CACHE/findutils-*-bin.tar.lzma || mingleError $? "failed to decompress find, aborting!"
    fi
        
    tar xvf $MINGLE_CACHE/findutils-*-bin.tar || mingleError $? "failed to unarchive find, aborting!"
    
    cp bin/find.exe /bin || mingleError $? "failed to copy find, aborting!"
    cp bin/xargs.exe /bin || mingleError $? "failed to xargs find, aborting!"

    echo
}

#experimental
updateTarCommand() {
    if ad_isDateNewerThanFileModTime "2013-01-01" "/mingw/bin/tar.exe"; then
        #export "CFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64"
        #export "LDFLAGS=-L/mingw/lib"
        #export "CPPFLAGS=-I/mingw/include  -D_WIN64 -DMS_WIN64"

        buildInstallGeneric "tar-*" true "" "tarzzz" "" "tar --version"
    else
        echo "TAR is up to date."
    fi
}


install7Zip() {
    echo
    echo "Installing 7zip..."
    echo
    
    if ! 7za &> /dev/null; then
        mingleDecompress "7za$AD_SEVENZIP.zip"
        unzip -uo 7za$AD_SEVENZIP.zip
    
        cp 7z* /bin
    else
        echo "Already Installed."        
    fi
    
    echo
}

updateMake() {
    echo "Updating Make..."

    local _project="make-$MAKE*"

    mingleDecompress "$_project"

    #cp -rf $_project/bin_amd64/m* /bin
    cp -rf $_project/bin_ix86 /bin
}

buildInstallM4() {
    buildInstallGeneric "m4-*" true "" "m4" "" "m4 --version"
}

buildInstallAutoconf() {
    export "M4=/bin/m4"
    buildInstallGeneric "autoconf-*" true "" "autoconf" "" "autoconf --version"
}

buildInstallAutoMake() {
    buildInstallGeneric "automake-*" true "" "automake" "" "automake --version"
}

buildInstallGMP() {
    export "CFLAGS="
    export "LDFLAGS="
    export "CPPFLAGS=" 
    buildInstallGeneric "gmp-*" false "--enable-cxx " "libgmp.a" "" ""
}

buildInstallMPFR() {
    buildInstallGeneric "mpfr-*" true "--with-gmp=/mingw --disable-shared" "libmpfr.a" "" ""
}

buildInstallMPC() {
    buildInstallGeneric "mpc-*" true "--with-gmp=/mingw --with-mpfr=/mingw --disable-shared" "libmpc.a" "" ""
}

buildInstallMingw64CRT() {
    if ad_isDateNewerThanFileModTime "2013-01-01" "/mingw/x86_64-w64-mingw32/lib/libcrtdll.a"; then
        export "CFLAGS="
        export "LDFLAGS="
        export "CPPFLAGS=" 
        buildInstallGeneric "mingw-w64-*" false "--enable-lib64 --with-gmp --with-crt --with-mpfr --with-mpc --disable-multilib --enable-languages=c,c++ --with-pkgversion=\"MinGW64-Windows\"" "x" "" ""
    else
        echo "Mingw64 CRT is up to date."
    fi
}

buildInstallLibtool() {
    buildInstallGeneric "libtool-*" true "" "libtool" "" "libtool --version"
}

buildInstallGLibC() {
    buildInstallGeneric "glibc-*" true "" "xxx" "" ""
}

buildInstallGDB() {
    local _project="gdb-*"

    if ad_isDateNewerThanFileModTime "2013-01-01" "/mingw/bin/gdb.exe"; then
        mingleDecompress "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")

        cd $_projectDir || mingleError $? "cd failed, aborting!"
        
        if [ ! -e gdb-mingw.patch ]; then
            cp /home/developer/patches/gdb/$AD_GDB_VERSION/gdb-mingw.patch .
            ad_patch "gdb-mingw.patch"
        fi

        if [ ! -e gdb-python.patch ]; then
            cp /home/developer/patches/gdb/$AD_GDB_VERSION/gdb-python.patch .
            ad_patch "gdb-python.patch"
        fi

        echo
        echo "Remove any old config.cache files..."
        echo
        find . -name 'config.cache' -exec rm {} \;
        
        cd ..

        export "CFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64"
        export "LDFLAGS=-L/mingw/lib"
        export "CPPFLAGS=-I/mingw/include  -D_WIN64 -DMS_WIN64"

        buildInstallGeneric "$_project" false "--with-gmp --with-mpfr --with-mpc --with-python --enable-shared" "x" "" "gdb --version"

        cd $_projectDir/gdb

        # Need to fix this in Makefile
        x86_64-w64-mingw32-gcc.exe -o _gdb.pyd -s -shared -Wl,--out-implib=libgdb.dll.a  -Wl,--export-all-symbols -Wl,--enable-auto-import -Wl,--whole-archive *.o -Wl,--no-whole-archive -L../bfd -lbfd -L../liberty -liberty -L/mingw/lib -L../readline -lreadline -lhistory -L../libdecnumber -ldecnumber -L../opcodes -lopcodes -lz -lws2_32 -lpython2.7 -lexpat -L../intl -lintl -liconv

        cp -f _gdb.pyd /mingw/share/gdb/python/gdb
        cp -rf /mingw/share/gdb/python/gdb /mingw/lib/python2.7/site-packages/gdb

        cd ../..
    else
        echo "GDB is up to date."
    fi
}

buildInstallTCL() {
    local _project="tcl$AD_TCL_VERSION_MAJOR*"
    local _additionFlags="--enable-64bit --enable-shared=no"
    #local _binCheck="xxx"
    local _binCheck="tclsh"
    local _exeToTest=""
    
    echo
    echo "Building $_project..."
    echo
    
    ad_setDefaultEnv
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleDecompress "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)

        cd $_projectdir/compat/zlib

        make -f win32/Makefile.gcc    

        cd ../../win

        cp -rf ../compat/zlib/*.o .

        ./configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --prefix=/mingw $_additionFlags

        make || mingleError $? "make failed, aborting!"

        local _savedir=`pwd`

        cd /mingw/bin

        ln -sf $_savedir/tclsh`echo $AD_TCL_VERSION_MAJOR|sed 's/\.//'`s.exe tclsh.exe

        cd $_savedir
        
        make install || mingleError $? "make failed, aborting!"

        cd /mingw/bin

        ln -sf tclsh`echo $AD_TCL_VERSION_MAJOR|sed 's/\.//'`s.exe tclsh.exe

        cd $_savedir

        cd ..
        cd ..
    else
        echo "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
    
    echo
}

buildInstallTk() {
    local _project="tk$AD_TCL_VERSION_MAJOR*"
    local _cleanEnv=true
    local _configureFlags="--enable-64bit --enable-shared=no" "libtk86.a"
    local _binCheck="libtk86.a"
    local _postBuildCommand=""
    local _exeToTest=""
    
    echo
    echo "Building $_project..."
    echo
    
    if $_cleanEnv; then
        ad_setDefaultEnv
    fi
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleDecompress "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")

        cd $_projectDir/win

        ./configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --prefix=/mingw $_additionFlags

        make || mingleError $? "make failed, aborting!"
        make install || mingleError $? "make install failed, aborting!"

        cd ../..
        
        ad_exec_script "$_project" "$_postBuildCommand"
    else
        echo "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
    
    echo   
}

buildInstallZlib() {
    local _project="zlib-*"

    echo
    echo "Building zlib..."
    echo
    
    if [ ! -e /mingw/bin/zlib1.dll ]; then
        mingleDecompress "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)
    
        cd $_projectdir

        make -f win32/Makefile.gcc || mingleError $? "make failed, aborting!"

        cp zlib1.dll /mingw/bin
        cp zconf.h zlib.h /mingw/include
        cp libz.a /mingw/lib
        cp libz.dll.a /mingw/lib

        if ! example.exe; then
            echo "Build Failed!"
            exit 0;
        fi

        cd ..
    else
        echo "Already Installed."        
    fi
    
    echo
}

buildInstallBzip2() {
    local _project="bzip2-*"

    echo
    echo "Building bzip2..."
    echo
    
    if [ ! -e /mingw/bin/bzip2 ]; then
        mingleDecompress "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)
    
        cd $_projectdir || mingleError $? "cd failed, aborting!"

        make || mingleError $? "make failed, aborting!"

        cp -f bzip2 /mingw/bin
        cp -f bzip2recover /mingw/bin
        cp -f libbz2.a /mingw/lib
        cp -f bzlib.h /mingw/include

        cd ..
    else
        echo "Already Installed."        
    fi
    
    echo    
}

buildInstallLibiconv() {
    local _project="libiconv-*"
    echo
    echo "Building libiconv..."
    echo
    
    mingleDecompress "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)
    
    cd $_projectdir
    
    if [ ! -e /mingw/lib/libiconv.dll.a ]; then
        echo "Building Dynamic lib..."
        ./configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --prefix=/mingw
        make clean
        make || mingleError $? "make failed, aborting!"
        make install-strip || mingleError $? "make install failed, aborting!"

        if ! iconv --version; then
             echo "Build Failed!"
            exit 0;
        fi
    else
        echo "Dynamic Library Already Installed."        
    fi
    
    if [ ! -e /mingw/lib/libiconv.a ]; then
        echo "Building Static lib..."
        make clean
        ./configure --build=x86_64-w64-mingw32 --disable-shared --prefix=/mingw
        make || mingleError $? "make failed, aborting!"
        make install-strip || mingleError $? "make install failed, aborting!"
        
        if ! iconv --version; then
             echo "Build Failed!"
            exit 0;
        fi 
    else
        echo "Static Library Already Installed."        
    fi
    
    echo "Fix the libraries just to be safe..."
    sed -e "s/dlname=''/dlname='..\/bin\/libiconv-2.dll'/" -e "s/library_names=''/library_names='libiconv.dll.a'/" /mingw/lib/libiconv.la>libiconv.la
    mv libiconv.la /mingw/lib/libiconv.la
    
    sed -e "s/dlname=''/dlname='..\/bin\/libcharset-1.dll'/" -e "s/library_names=''/library_names='libcharset.dll.a'/" /mingw/lib/libcharset.la>libcharset.la
    mv libcharset.la /mingw/lib/libcharset.la
    
    cd ..
    
    echo
}

buildInstallPThreads() {
    echo
    echo "Installing pThreads..."
    echo
    
    if [ ! -e /mingw/bin/pthreadGC2.dll ]; then
        local _project="pthreads-*"

        mingleDecompress "$_project"

        cd Pre-built.2

        cp -f dll/x64/*.dll /mingw/bin
        cp -f include/*.h /mingw/include
        cp -f lib/x64/* /mingw/lib

        cd ..
    else
        echo "Already Installed."        
    fi
    
    echo
}

buildInstallBinutils() {
    buildInstallGeneric "binutils-*" true "" "dllwrap.exe" "" "dllwrap.exe --version"
}

buildInstallPkgconfig() {
    buildInstallGeneric "pkg-config-*" true "--with-internal-glib" "pkg-config" "" "pkg-config --version"
}

installLibJPEG () {
    echo
    echo "Installing libjpeg-turbo..."
    echo

    STOREPATH=`pwd`

    if [ ! -e libjpeg-turbo ]; then
        mkdir libjpeg-turbo
    fi

    cd libjpeg-turbo

    DOSPATH=`cmd /c 'echo %CD%'`


    cd $MINGLE_CACHE

    EXECPATH=`pwd -W`

    cd $STOREPATH

    if [ ! -e /mingw/lib/libturbojpeg.a ]; then
        if [ ! -e "libjpeg-turbo.tar" ]; then
            cmd /c "$EXECPATH/libjpeg-turbo-1.2.1-gcc64.exe /S /D=$DOSPATH"

            if [ ! -e "$DOSPATH/uninstall_1.2.1.exe" ]; then
                mingleError -1 "Failed to install libturbo, aborting!"
            fi

            tar cvf libjpeg-turbo.tar libjpeg-turbo --exclude=uninstall*

            cd libjpeg-turbo

            cmd /c "uninstall_1.2.1.exe /S"

            cd ..

            sleep 2

            rmdir libjpeg-turbo
        fi

        tar xvf libjpeg-turbo.tarcd
        cp -rf libjpeg-turbo/* /mingw
    else
        echo "libjpeg-turbo already installed."
    fi

    echo
}

installLibPNG() {
    echo
    echo "Installing libPNG..."
    echo
    
    if [ ! -e /mingw/bin/libpng*.dll ]; then
        mingleDecompress "libpng-*"

        cd libpng-* || mingleError $? "cd failed, aborting!"

        export "CFLAGS=-I/mingw/include"
        export "LDFLAGS=-L/mingw/lib"

        if [ ! -e Makefile ]; then
            ./configure --host=x86_64-w64-mingw32 --prefix=/mingw
        fi

        make || mingleError $? "make failed, aborting!"
        make install || mingleError $? "make install failed, aborting!"

        cd ..
    else
        echo "Already Installed."
    fi
    
    echo
}

installLibTiff() {
    buildInstallGeneric "tiff-*" true "" "tiffinfo" "" "tiffinfo"
}

buildInstallSigc() {
    buildInstallGeneric "libsigc++-*" true "" "libsigc-2.0-0.dll"
}

buildInstallPixman() {
    buildInstallGeneric "pixman-$AD_PIXMAN_VERSION*" true "" "libpixman-1.a"
}

buildInstallCairo() {
    local _project="cairo-$AD_CAIRO_VERSION*"

    buildInstallGeneric "$_project" true "" "libcairo.a"

    if ! ( [ -e "/mingw/lib/libcairo.dll" ] && [ -e "/mingw/bin/libcairo.dll" ] );then
        echo "Manually generating libcairo DLL..."

        local _projectdir=$(ad_getDirFromWC $_project)

        cd $_projectdir || mingleError $? "cd failed, aborting!"

        x86_64-w64-mingw32-gcc.exe -o libcairo.dll -s -shared -Wl,--out-implib=libcairo.dll.a  -Wl,--export-all-symbols -Wl,--enable-auto-import -Wl,--whole-archive src/.libs/libcairo.a -Wl,--no-whole-archive -L/mingw/lib -lpixman-1 -lz -lgdi32 -lpng -lfontconfig -lfreetype -lmsimg32 || mingleError $? "Failed to generate dll, aborting!"

        cp libcairo.dll /mingw/lib || mingleError $? "Failed to copy dll, aborting!"
        cp libcairo.dll /mingw/bin || mingleError $? "Failed to copy dll, aborting!"
        cp libcairo.dll.a /mingw/lib || mingleError $? "Failed to copy lib, aborting!"

        local _shortProjectName=$(ad_getShortLibName $_project)

        echo "Short Name: $_shortProjectName"

        ad_fix_shared_lib "$_shortProjectName"
        ad_fix_shared_lib "libcairo-script-interpreter"

        cd ..
    fi
}

buildInstallCairomm() {
    buildInstallGeneric "cairomm-*" true "" "libcairomm-1.0.a"
}

buildInstallPolarSSL() {
    local _project="polarssl-*"
    local _additionFlags=""
    #local _binCheck="xxx"
    local _binCheck="polarssl_selftest.exe"
    local _exeToTest=""
    
    echo
    echo "Building $_project..."
    echo
    
    ad_setDefaultEnv
    
    export SHARED=1
    export "WINDOWS=1"
    export "CC=gcc"
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleDecompress "$_project"
        local _projectdir=$(ad_getDirFromWC $_project)
        cd $_projectdir
        sed -e 's/DESTDIR=\/usr\/local/DESTDIR=\/mingw/g' Makefile>Makefile2
        mv Makefile2 Makefile
        cd ..
        
        ad_make "$_project"
    else
        echo "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
    
    echo
}

buildInstallLOpenSSL() {
    local _project="openssl-*"
    local _additionFlags=""
    local _binCheck="libssl.a"
    local _exeToTest="openssl version"
    
    echo
    echo "Building $_project..."
    echo
    
    ad_setDefaultEnv
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleDecompress "$_project"
        
        local _dir=$(ad_getDirFromWC "$_project")
        cd $_dir
        ./Configure mingw64 shared no-asm no-idea no-mdc2 no-rc5 --prefix=/mingw
        cd ..
        
        ad_make "$_project"
    else
        echo "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
    
    echo    
}

buildInstallLibXML2() {
    buildInstallGeneric "libxml2-*" true "--enable-shared --enable-static --with-icu" "xmllint" "" "xmllint --version"
}

buildInstallCurl() {
    #buildInstallGeneric "curl-*" true "--with-polarssl" "libcurl.a" "" "curl --version"
    buildInstallGeneric "curl-*" true "" "libcurl.a" "" "curl --version"
}

buildInstallAPR() {
    buildInstallGeneric "apr-*" true "" "xxxx" ""
}

buildInstallSVN() {
    buildInstallGeneric "subversion-*" true "" "xxxx" ""
}

buildInstallGit() {
    buildInstallGeneric "git-master*" true "" "xxxx" ""
}

buildInstallFontConfig() {
    local _project="fontconfig-*"
    local _additionFlags="--enable-libxml2 --disable-docs"
    local _binCheck="fc-list"
    local _exeToTest="fc-list"
    
    echo
    echo "Building $_project..."
    echo
    
    ad_setDefaultEnv
 
    export "FREETYPE_LIBS=`freetype-config --libs`"
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleDecompress "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)
        
        cd $_projectdir
        
        if [ ! -e fontconfig-mingw.patch ]; then
            cp /home/developer/patches/fontconfig/$AD_FONT_CONFIG/fontconfig-mingw.patch .
            ad_patch "fontconfig-mingw.patch"
        fi
        
        mkdir -p /mingw/share/fontconfig/conf.avail        
        cp -rf conf.d/*.conf /mingw/share/fontconfig/conf.avail
        
        cd ..
        
        #export "CFLAGS=$CFLAGS -DFC_DBG_CONFIG"
        ad_configure "$_project" "$_additionFlags"
        ad_make "$_project"

        local _shortProjectName=$(ad_getShortLibName $_project)
            
        echo "Short Name: $_shortProjectName"
            
        ad_fix_shared_lib "$_shortProjectName"
    else
        echo "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
    
    echo    
}

buildInstallFreeType() {
    echo
    echo "Installing freetype..."
    echo
    
    if [ ! -e /mingw/lib/libfreetype.a ]; then
        mingleDecompress "freetype-*"

        cd freetype-*

        make setup unix
        ./configure --host=x86_64-w64-mingw32 --prefix=/mingw
        mkdir objs/.libs

        make || mingleError $? "make failed, aborting!"
        make install -i || mingleError $? "make install  failed, aborting!"

        cd ..
    else
        echo "Already Installed."          
    fi
    
    echo
}

buildInstallSQLite() {
    buildInstallGeneric "sqlite-*" true "" "libsqlite3.a" "" "sqlite3 --version"
}

buildInstallICU() {
    echo
    echo "Installing ICU..."
    echo
    
    if [ ! -e /mingw/lib/libicui18n.dll ]; then
        mingleDecompress "icu4c-*"

        #Apply patch http://bugs.icu-project.org/trac/ticket/9728
        echo "Applying patch from http://bugs.icu-project.org/trac/ticket/9728..."

        wget http://bugs.icu-project.org/trac/export/32780/icu/trunk/source/common/unicode/platform.h
        wget http://bugs.icu-project.org/trac/export/32780/icu/trunk/source/common/unicode/umachine.h
        wget http://bugs.icu-project.org/trac/export/32780/icu/trunk/source/common/unicode/ustring.h
        wget http://bugs.icu-project.org/trac/export/32780/icu/trunk/source/test/intltest/strtest.cpp

        mv platform.h icu/source/common/unicode/
        mv umachine.h icu/source/common/unicode/
        mv ustring.h icu/source/common/unicode/
        mv strtest.cpp icu/source/test/intltest/

        cd icu/source

        ./runConfigureICU MinGW  --prefix=/mingw

        make || mingleError $? "make failed, aborting!"
        make install || mingleError $? "make install failed, aborting!"
        
        cp -f /mingw/lib/icu*.dll /mingw/bin
        
        local _origPath=`pwd`
        cd /mingw/lib
        ad_rename "./icu.*.dll" "s/^icu/libicu/g"
        cd "$_origPath"
        
        cp /mingw/lib/libicuuc50.dll /mingw/bin/icuuc50.dll || mingleError $? "cp failed, aborting!"
        cp /mingw/lib/libicudt50.dll /mingw/bin/icudt50.dll || mingleError $? "cp failed, aborting!"
        cp /mingw/lib/libicuin.dll /mingw/lib/libicui18n.dll || mingleError $? "cp failed, aborting!"
        cp /mingw/lib/libicudt.dll /mingw/lib/libicudata.dll || mingleError $? "cp failed, aborting!"
        
        cd ..
        cd ..
    else
        echo "Already Installed."
    fi  
    
    if ! icu-config --cflags; then
        echo "ICU Test Failed!"
        exit 0;
    fi      
    
    echo
}

buildInstallPostgres() {
    local _project="postgresql-*"

    mingleDecompress "$_project"

    local _projectDir=$(ad_getDirFromWC "$_project")

    cd "$_projectDir" || mingleError $? "cd failed, aborting!"

    if [ ! -e postgresql-mingw.patch ]; then
        cp /home/developer/patches/postgresql/$AD_POSTGRES_VERSION/postgresql-mingw.patch .
        ad_patch "postgresql-mingw.patch"
    fi

    cd ..

    buildInstallGeneric "$_project" true "" "postgres" "" "postgres --version"
    
    if [ -e /mingw/lib/libpq.dll ]; then
        cp -rf /mingw/lib/libpq.dll /mingw/bin
    fi
}

buildInstallExpat() {
    buildInstallGeneric "expat-*" true "" "libexpat.a"
}

buildInstallLibproj() {
    buildInstallGeneric "proj-*" true "" "libproj.a"
}

buildInstallProjDatumgrid() {
    echo
    echo "Installing proj-datumgrid..."
    echo
    
    if [ ! -e /mingw/share/proj/ntv1_can.dat ]; then
        if [ ! -e proj-datumgrid ]; then
            mkdir proj-datumgrid
        fi

        cd proj-datumgrid

        mingleDecompress "proj-datumgrid*"

        cp -f * /mingw/share/proj

        cd ..
    else
        echo "Already Installed."        
    fi
    
    echo    
}

buildInstallLibGeotiff() {
    buildInstallGeneric "libgeotiff-*" true "--enable-shared --enable-incode-epsg" "libgeotiff.dll.a" "" "geotifcp"
    
    buildInstallGeneric "libgeotiff-*" true "--enable-static --enable-incode-epsg" "libgeotiff.a" "" "geotifcp"
}

buildInstallLibgeos() {
    buildInstallGeneric "geos-*" true "" "libgeos.a" "" ""
}

buildInstallGDAL() {
    local _project="gdal-*"
    local _configureFlags=""
    local _binCheck="libgdal-1.dll"
    local _exeToTest="gdal_grid --version"
    
    echo
    echo "Building $_project..."
    echo

    cd $MINGLE_BUILD_DIR
    
    ad_setDefaultEnv
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleDecompress "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")

        ad_configure "$_project" "$_configureFlags"

        #Not sure why but libtool crashes in bash if you have CPPFLAGS set
        ad_clearEnv

        ad_make "$_project"
    else
        echo "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
    
    echo    
}

buildInstallPython() {
    local _project="Python-*"
    local _binCheck="python$AD_PYTHON_MAJOR"
    local _exeToTest="python --version"

    echo
    echo "Building $_project..."
    echo
    
    $ad_setDefaultEnv
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$ _binCheck" ] );then
        mingleDecompress $_project

        local _projectDir=$(ad_getDirFromWC "$_project")
        
        if ls -d cpython*/ &> /dev/null; then
            mv cpython* python-latest
        fi
        
        cd $_projectDir
        
        if [ ! -e python-mingw.patch ]; then
            #http://bugs.python.org/issue3754
            #http://bugs.python.org/issue4709
            
            #my update
            cp /home/developer/patches/python/$AD_PYTHON_VERSION/python-mingw.patch .
            ad_patch "python-mingw.patch"
        fi

        echo "Isolating dependencies..."

        if [ ! -e dependencies ]; then
            mkdir dependencies
            mkdir dependencies/include
            mkdir dependencies/lib
        fi

        cp -rf /mingw/lib/tcl* dependencies/lib/
        cp -rf /mingw/lib/libtcl* dependencies/lib/
        cp -rf /mingw/include/tcl* dependencies/include

        cp -rf /mingw/lib/libtk* dependencies/lib/
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
        
        echo "# Edit this file for local setup changes">Modules/Setup.local
        echo "_socket socketmodule.c">>Modules/Setup.local
        echo "_ssl _ssl.c -DUSE_SSL -lssl -lcrypto -lws2_32">>Modules/Setup.local

        cd ..          
        
        export "CFLAGS=$CFLAGS -IPC -D__MINGW32__ -Idependencies/include -I/mingw/ssl"
        export "LDFLAGS=$LDFLAGS -Ldependencies/lib"
               
        ad_configure "$_project" "--with-system-expat --enable-loadable-sqlite-extensions build_alias=x86_64-w64-mingw32 host_alias=x86_64-w64-mingw32 target_alias=x86_64-w64-mingw32"

        ad_make $_project
        
        ln -s /mingw/bin/python$AD_PYTHON_MAJOR /mingw/bin/python
    else
        echo "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
}

buildInstallSetupTools() {
    echo
    echo "Downloading and configuring Python SetupTools..."
    echo

    local _savedir=`pwd`
    local _project="setuptools-*"

    mingleDecompress "$_project"

    local _projectDir=$(ad_getDirFromWC "$_project")

    cd $_project || mingleError $? "cd failed, aborting!"
        
    if [ ! -e /mingw/lib/python$AD_PYTHON_MAJOR/site-packages/easy_install.exe ]; then
        setup.py install --install-purelib `python -c "import sysconfig;print sysconfig.get_path('purelib')"` --install-scripts `python -c "import sysconfig;print sysconfig.get_path('purelib')"` --exec-prefix=`python -c "import sysconfig;print sysconfig.get_path('purelib')"`

        cd /mingw/lib/python$AD_PYTHON_MAJOR/site-packages
        echo "[easy_install]">setup.cfg
        echo >> setup.cfg
        echo "install_dir = `python -c "import sysconfig;print sysconfig.get_path('purelib')"`">> setup.cfg

        echo "Complete."
    else
        echo "Already Installed."
    fi

    cd $_savedir
}

buildInstallNose() {
    echo
    echo "Downloading and configuring Nose..."
    echo

    local _savedir=`pwd`

    if [ ! -e /mingw/lib/python$AD_PYTHON_MAJOR/site-packages/nosetests.exe ]; then
        cd /mingw/lib/python$AD_PYTHON_MAJOR/site-packages
        easy_install --install-dir=. nose
    else
        echo "Already Installed."
    fi

    cd $_savedir
}

buildInstallWerkzeug() {
    echo
    echo "Downloading and configuring Werkzeug..."
    echo

    local _savedir=`pwd`

    cd /mingw/lib/python$AD_PYTHON_MAJOR/site-packages
    easy_install --install-dir=. Werkzeug

    cd $_savedir
}

buildInstallPyTest() {
    echo
    echo "Downloading and configuring Werkzeug..."
    echo

    local _savedir=`pwd`

    cd /mingw/lib/python$AD_PYTHON_MAJOR/site-packages
    easy_install --install-dir=. pytest

    cd $_savedir
}

buildInstallTileLite() {
    echo
    echo "Downloading and configuring TileLite..."
    echo

    local _savedir=`pwd`
    local _project="tilelite*"

    mingleDecompress "$_project"

    local _projectDir=$(ad_getDirFromWC "$_project")

    cd $_project || mingleError $? "cd failed, aborting!"

    if [ ! -e /mingw/lib/python$AD_PYTHON_MAJOR/site-packages/liteserv.py ]; then
         python setup.py install --install-purelib `python -c "import sysconfig;print sysconfig.get_path('purelib')"` --install-scripts `python -c "import sysconfig;print sysconfig.get_path('purelib')"` --exec-prefix=`python -c "import sysconfig;print sysconfig.get_path('purelib')"`
    else
        echo "Already Installed."
    fi

    cd $_savedir
}

buildInstallNode() {
    buildInstallGeneric "node-v*" true "" "xxx"
}

buildInstallNodeMapnik() {
    buildInstallGeneric "node-mapnik*" true "" "xxx"
}

buildInstallWAF() {

    local _project="waf-*"

    mingleDecompress "$_project"

    local _projectdir=$(ad_getDirFromWC "$_project")

    cd "$_projectdir" || mingleError $? "cd failed, aborting!"
        
    if [ ! -e waf-mingw.patch ]; then
         cp /home/developer/patches/waf/$AD_WAF_VERSION/waf-mingw.patch .
         ad_patch "waf-mingw.patch"
    fi

    cd ..

    buildInstallGeneric "waf-*" true "" "waf" "" ""

    cd "$_projectdir" || mingleError $? "cd failed, aborting!"

    cp waf /mingw/bin || mingleError $? "failed to install waf, aborting!"

    cd ..
}

buildInstallBoostJam() {
    buildInstallGeneric "boost-jam*" true "" "bjam" "cp bin.ntx86_64/*.exe /mingw/bin" ""
}

buildInstallBoost() {
    local _project="boost_*"

    mingleDecompress "$_project"

    local _projectDir=$(ad_getDirFromWC "$_project")

    cd $_project || mingleError $? "cd failed, aborting!"
        
    if [ ! -e boost-mingw.patch ]; then
        # Apply patch for https://svn.boost.org/trac/boost/ticket/5023
        cp /home/developer/patches/boost/$AD_BOOST_PATH_VERSION/boost-mingw.patch .
        ad_patch "boost-mingw.patch"
    fi

    cd ..

    export CPLUS_INCLUDE_PATH=/mingw/include/python2.7
    buildInstallGeneric "boost_*" true "" "boost_system-47-mt-1_$AD_BOOST_MINOR_VERSION.dll" "" ""
    export CPLUS_INCLUDE_PATH=

    ad_relocate_bin_dlls "boost_"
}

buildInstallPyCairo() {
    local _project="py2cairo-*"
    local _additionFlags=""
    local _binCheck="/pkgconfig/pycairo.pc"
    local _exeToTest=""
    
    echo
    echo "Building $_project..."
    echo
    
    ad_setDefaultEnv

    export "PYTHON_CONFIG=/mingw/bin/python2.7-config"
    export "CFLAGS=$CFLAGS -I/mingw/include/Python2.7"
    export "LDFLAGS=$LDFLAGS -lpixman-1"
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleDecompress "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")
        
        cd "$_projectDir" || mingleError $? "cd failed, aborting!"
        
        #Expand waflib
        ./waf --version

        #patch waflib
        cd waf-*/waflib

        if [ ! -e waf-mingw.patch ]; then
            cp /home/developer/patches/py2cairo/$AD_PYCAIRO_VERSION/waf-mingw.patch .
            ad_patch "waf-mingw.patch"
            rm Node.pyc
        fi

        cd ../..

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
        
        cd ..
    else
        echo "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
    
    echo      
}

buildInstallMapnik() {
    local _project="mapnik-v*"

    mingleDecompress "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)

    cd "$_projectdir" || mingleError $? "cd failed, aborting!"
        
    if [ ! -e mapnik-mingw.patch ]; then
         #my update
         cp /home/developer/patches/mapnik/$AD_MAPNIK_VERSION/mapnik-mingw.patch .
         ad_patch "mapnik-mingw.patch"
    fi

    cd ..

    buildInstallGeneric "mapnik-*" true "PREFIX=/mingw CUSTOM_CXXFLAGS=-DMS_WIN64 CUSTOM_CXXFLAGS=-D__MINGW__ BOOST_INCLUDES=/mingw/include/boost-1_53 BOOST_LIBS=/mingw/lib CC=x86_64-w64-mingw32-gcc-4.7.2.exe CXX=x86_64-w64-mingw32-g++.exe" "mapnik.dll" "" "mapnik-config --version"

    ln -sf /mingw/lib/mapnik.dll /mingw/bin/mapnik.dll
}

buildInstallMapnikDev() {
    local _project="mapnik-latest*"

    mingleDecompress "$_project"

    buildInstallGeneric "mapnik-*" true "PREFIX=/mingw CUSTOM_CXXFLAGS=-DMS_WIN64 CUSTOM_CXXFLAGS=-D__MINGW__ BOOST_INCLUDES=/mingw/include/boost-1_53 BOOST_LIBS=/mingw/lib CC=x86_64-w64-mingw32-gcc-4.7.2.exe CXX=x86_64-w64-mingw32-g++.exe" "mapnik.dll" "" "mapnik-config --version"

    ln -sf /mingw/lib/mapnik.dll /mingw/bin/mapnik.dll
}

buildInstallMapnikStylesheets() {
    local _project="mapnik-stylesheets*"

    mingleDecompress "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)

    cd "$_projectdir" || mingleError $? "cd failed, aborting!"

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

    cd ..
}

buildInstallPerl() {
    buildInstallGeneric "perl-*" true "" "xxx" "" ""
}

buildInstallSwig() {
    buildInstallGeneric "swigwin-*" true "" "xxx" "" ""
}

ad_isDateNewerThanFileModTime() {
    local _checkdate=$1
    local _filename=$2

    if [ ! -e $_filename ]; then
        return 0
    fi

    local _chkdtseconds=`date -d "$_checkdate" +%s`

    local _getfiledate=`stat -c %y $_filename|sed 's/ .*//'`
    local _cnvrtfieldate=`date -d "$_getfiledate" +%s`

    echo "comparing provided date ($_checkdate, $_chkdtseconds), with filedate ($_getfiledate, $_cnvrtfieldate)."

    if [ "$_chkdtseconds" -gt "$_cnvrtfieldate" ]; then
        return 0
    fi

    return 1
}

ad_getDirFromWC() {
    local _project="$1"
    local _result=`find . -maxdepth 1 -name "$_project" -prune -type d -print | head -1`

    echo "$_result"
}

ad_getArchiveFromWC() {
    local _project="$1"
    local _result=`find $MINGLE_CACHE -maxdepth 1 -name "$_project" -prune -type f -print | head -1`

    echo "$_result"
}

ad_rename() {
    local _wildcard="$1"
    local _regex="$2"
    
    echo "Renaming _wildcard=$1, _regex=$2 "
    
    find . -regex "$_wildcard" | while read line; do
        A=`basename ${line} | sed $_regex`
        B=`dirname ${line}`
        
        echo mv ${line} "${B}/${A}"
        mv ${line} "${B}/${A}" || mingleError $? "rename failed, aborting!"
    done
}

ad_relocate_bin_dlls() {
    local _dllPrefix="$1"

    echo "Checking for DLLS with prefix: $_dllPrefix.*.dll..."

    find /mingw/lib -regex "/mingw/lib/$_dllPrefix.*\.dll" | while read line; do
        echo "Copying ${line} to /mingw/bin..."
        cp -u ${line} "/mingw/bin" || mingleError $? "ad_relocate_bin_dlls failed, aborting"
    done
}

ad_fix_pkg_cfg() {
    local _pkgconfigfile=/mingw/lib/pkgconfig/$1

     sed 's/\\/\//g' $_pkgconfigfile>$_pkgconfigfile-2
     mv $_pkgconfigfile-2 $_pkgconfigfile
}

ad_fix_shared_lib() {  
    local _origPath=`pwd`
    cd /mingw/lib || mingleError $? "ad_fix_shared_lib cd failed, aborting"
    
    local _libraryName=`ls $1*.a|sed -e 's/\.dll\.a//' -e 's/\.a//'|uniq|sort|head -1`
    
    echo "Parsed library name: $_libraryName"    
    
    if [ ! -e "$_libraryName".dll.a ] && [ -e "$_libraryName".a ]; then
        cp -f "$_libraryName".a "$_libraryName".dll.a
    fi
    
    #ad_rename "./icu.*.dll" "s/^icu/libicu/g"

    if [ -e "$_libraryName.la" ]; then
        echo "Updating $_libraryName.la..."
        
        sed -e "s/dlname='.*/dlname='..\/bin\/$_libraryName.dll'/g" $_libraryName.la>$_libraryName-2
        mv $_libraryName-2 $_libraryName.la

        sed -e "s/\(library_names='\).*/\1$_libraryName.dll.a'/g" $_libraryName.la>$_libraryName-2
        mv $_libraryName-2 $_libraryName.la

        sed -e "s/\(old_library='\).*/\1$_libraryName.a'/g" $_libraryName.la>$_libraryName-2
        mv $_libraryName-2 $_libraryName.la
    else
        echo "$_libraryName.la doesn't exist!. Generating..."
    fi
    
    cd "$_origPath" || mingleError $? "ad_fix_shared_lib cd failed, aborting"
}

ad_clearEnv() {
    echo
    echo "Resetting environment flags..."
    echo

    unset PKG_CONFIG_PATH
    unset CFLAGS
    unset LDFLAGS
    unset CPPFLAGS
    unset CRYPTO
}

ad_setDefaultEnv() {
    echo
    echo "Resetting environment flags to default..."
    echo

    export "PKG_CONFIG_PATH=/mingw/lib/pkgconfig"
    #for debugging: CFLAGS=-g -fno-inline -fno-strict-aliasing
    export "CFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO"
    export "LDFLAGS=-L/mingw/lib"
    export "CPPFLAGS=-I/mingw/include  -D_WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO"
    export "CRYPTO=POLARSSL"
}

ad_patch() {
    local _patchFile=$1
    local _workingDir=`pwd`

    if [ "$MINGLE_BUILD_DIR" == "$_workingDir" ]; then
        echo
        echo "Patching failed! Patch should be ran from project directory."
        echo

        mingleError -1 "Patching failed! Patch should be ran from project directory."
    fi

    patch --ignore-whitespace -f -p1 < $_patchFile
}

ad_configure() {
    local _project=$1
    local _additionFlags=$2
    
    local _projectDir=$(ad_getDirFromWC "$_project")

    cd $_projectDir || mingleError $? "ad_configure cd failed, aborting!"

    if [ -e "configure.ac" ] || [ -e "configure.in" ]; then
        if [ -e "/mingw/bin/autoconf" ];then
            echo
            echo "Executing autoconf..."

            autoconf || mingleError $? "ad_configure autoconf failed, aborting!"
        fi
        
        if [ -e "/mingw/bin/autoheader" ];then
            echo
            echo "Executing autoheader..."

            autoheader
        fi
    fi
        
    if [ -e "configure" ]; then
        local _counter=1
        local _retries=3
        local _options="--prefix=/mingw --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32"

        echo
        echo "Using CFLAGS: $CFLAGS"
        echo "Using CPPFLAGS: $CPPFLAGS"
        echo "Using LDFLAGS: $LDFLAGS"

        echo
        echo "executing: ./configure $_options $_additionFlags"
        echo

        local _newflags="$_options $_additionFlags"

        ./configure $_newflags &>out.txt
        while [ $? -ge 1 ]
        do
            if [ $_counter -gt $_retries ]; then
                echo "Max configure retries reached. Build Failed!"
                exit 1
            fi

            local _test=`cat out.txt|grep "unrecognized option"|sed -e "s/^.*\(--.*\)'/\1/"`

            if [ -z "$_test" ]; then
                _test=`cat out.txt|grep "error: no such option:"|sed -e "s/^.*\(--.*\)/\1/"`
                if [ -z "$_test" ]; then
                    exit 1
                fi
            fi

            _newflags=`echo "$_newflags "|sed -e "s/$_test[^ ]* //"`
            _counter=$(( $_counter + 1 ))

            echo
            echo "Retrying without option: $_test..."
            echo

            echo
            echo "executing: ./configure $_newflags"
            echo
            
            ./configure $_newflags &>out.txt
        done

        cat out.txt

        if [ -e "out.txt" ]; then
            rm out.txt
        fi
    fi
        
    cd ..
}

ad_make_clean() {
    local _project=$1

    echo
    echo "Executing make clean for $_project..."
    echo
    
    local _projectDir=$(ad_getDirFromWC "$_project")

    cd $_projectDir || mingleError $? "cd failed, aborting"
    
    make distclean || make clean

    cd ..
}

ad_make() {
    echo
    echo "Executing make..."
    echo

    local _project=$1
    
    local _projectDir=$(ad_getDirFromWC "$_project")
    cd $_projectDir || mingleError $? "cd failed, aborting"
    
    make || mingleError $? "make failed, aborting!"
    make install || mingleError $? "make install failed, aborting"
    
    cd ..
}

ad_boost_jam() {
    local _project=$1
    
    local _projectDir=$(ad_getDirFromWC "$_project")
    cd $_projectDir || mingleError $? "ad_boost_jam cd failed, aborting!"
    
    #this is needed for boost https://svn.boost.org/trac/boost/ticket/6350
    cp /home/developer/mingw.jam tools/build/v2/tools

    
   ./bootstrap.sh --with-icu --prefix=/mingw --with-toolset=mingw || mingleError $? "ad_boost_jam boostrap failed, aborting"
   
    bjam --prefix=/mingw -sICU_PATH=/mingw -sICONV_PATH=/mingw toolset=mingw address-model=64 threadapi=win32 variant=debug,release link=static,shared threading=multi define=MS_WIN64 define=BOOST_USE_WINDOWS_H --define=__MINGW32__ --define=_WIN64 --define=MS_WIN64 install || mingleError $? "ad_boost_jam bjam failed, aborting"
    
    cd ..
}

ad_build() {
    local _project=$1
    
    local _projectDir=$(ad_getDirFromWC "$_project")
    cd $_projectDir || mingleError $? "cd failed, aborting"
    
    ./build.sh  || mingleError $? "ad_build build.sh failed, aborting"
    
    cd ..
}

ad_exec_script() {
    local _project="$1"
    local _postBuildCommand="$2"
    
    local _projectDir=$(ad_getDirFromWC "$_project")
    cd $_projectDir || mingleError $? "cd failed, aborting"
        
    if [ ! -z "$_postBuildCommand" ]; then
        echo "Executing post command: '$_postBuildCommand'"
        `$_postBuildCommand`
    fi
        
    cd ..
}

ad_run_test() {
    local _exeToTest=$1
    
    if [ ! -z "$_exeToTest" ]; then
        echo
        echo "Executing $_exeToTest..."
        if ! $_exeToTest; then
            mingleError -1 "Build failed, aborting!"
        fi 
    fi    
}

ad_getShortLibName() {
    local _project="$1"
    local _shortProjectName=`echo $_project|sed s/-.*//g`
    
    local _sub=`echo ${_project[@]:0:3}`
    
    if [ "$_sub" != "lib" ]; then
        _shortProjectName="lib$_shortProjectName"
    fi
    
    echo $_shortProjectName
}

buildInstallGeneric() {
    local _project="$1"
    local _cleanEnv=$2 #true/false
    local _configureFlags="$3"
    local _binCheck="$4"
    local _postBuildCommand="$5"
    local _exeToTest="$6"
    
    echo
    echo "Building $_project..."
    echo

    cd $MINGLE_BUILD_DIR
    
    if $_cleanEnv; then
        ad_setDefaultEnv
    fi
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleDecompress "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")

        ad_configure "$_project" "$_configureFlags"

        local _jamCheck=`grep -i BJAM "$_projectDir/bootstrap.sh"`

        if [ -e "$_projectDir/bootstrap.sh" ] && [ ! -z "$_jamCheck" ]; then
            ad_boost_jam "$_project"
        elif [ -e "$_projectDir/build.sh" ]; then
            ad_build "$_project"
        else
            ad_make "$_project"
        fi
        
        local _result=`echo "$_configureFlags"|grep "\-\-enable\-shared"`
        
        if [ ! -z "$_result" ]; then
            echo "Shared Library Enabled."
            
            local _shortProjectName=$(ad_getShortLibName $_project)
            
            echo "Short Name: $_shortProjectName"
            
            ad_fix_shared_lib "$_shortProjectName"
        fi
        
        ad_exec_script "$_project" "$_postBuildCommand"
    else
        echo "Already Installed."
    fi
    
    ad_run_test "$_exeToTest"
    
    echo    
}

MINGLE_SUITE_BASE=false
MINGLE_SUITE_XML=false
MINGLE_SUITE_FONTS=false
MINGLE_SUITE_ENCYPT=false
MINGLE_SUITE_NETWORK=false
MINGLE_SUITE_DB=false
MINGLE_SUITE_PYTHON=false
MINGLE_SUITE_DEBUG=false
MINGLE_SUITE_BOOST=false
MINGLE_SUITE_IMAGE_TOOLS=false
MINGLE_SUITE_MATH=false
MINGLE_SUITE_SCM=false
MINGLE_SUITE_GRAPHICS=false
MINGLE_SUITE_GEO_SPATIAL=false
MINGLE_MAPNIK=false
MINGLE_MAPNIK_TOOLS=false

suiteBase() {
    if [ $SUITE_BASE ]; then
        return;
    else
        SUITE_BASE=true
    fi

    updateGCC

    mingleDownloadPackages

    updateFindCommand
    
    #experimental
    #updateTarCommand

    install7Zip
    buildInstallPThreads
    buildInstallAutoconf
    buildInstallAutoMake
    buildInstallLibtool
    buildInstallPkgconfig
    buildInstallGMP
    buildInstallMPFR
    buildInstallMPC
    buildInstallMingw64CRT
    buildInstallZlib
    buildInstallBzip2
    buildInstallLibiconv
    buildInstallBinutils
    buildInstallTCL
    buildInstallTk
    buildInstallSigc

    #Keep the msys M4 for now due to build issues it causes with autoconf
    #buildInstallM4
    #Not ready for mingw64
    #buildInstallGLibC
}

suiteXML() {
    if $MINGLE_SUITE_XML ; then
        return;
    else
        MINGLE_SUITE_XML=true
    fi

    suiteBase

    buildInstallExpat
    buildInstallICU
    buildInstallLibXML2
}

suiteFonts() {
    if $MINGLE_SUITE_FONTS ; then
        return;
    else
        MINGLE_SUITE_FONTS=true
    fi

    suiteXML

    buildInstallFreeType
    buildInstallFontConfig
}

suiteEncryption() {
    if $MINGLE_SUITE_ENCYPT ; then
        return;
    else
        MINGLE_SUITE_ENCYPT=true
    fi

    suiteBase

    buildInstallPolarSSL
    buildInstallLOpenSSL
}

suiteNetworking() {
    if $MINGLE_SUITE_NETWORK ; then
        return;
    else
        MINGLE_SUITE_NETWORK=true
    fi

    suiteEncryption

    buildInstallCurl
}

suiteDatabase() {
    if $MINGLE_SUITE_DB ; then
        return;
    else
        MINGLE_SUITE_DB=true
    fi

    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking

    buildInstallSQLite
    buildInstallPostgres
}

suitePython() {
    if $MINGLE_SUITE_PYTHON ; then
        return;
    else
        MINGLE_SUITE_PYTHON=true
    fi

    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking
    suiteDatabase

    buildInstallPython
    buildInstallSetupTools
    buildInstallNose
    buildInstallWAF
    buildInstallWerkzeug
}

suitePerl() {
    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking
    suiteDatabase

    #buildInstallPerl
}

suiteSwig() {
    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking
    suiteDatabase
    suitePython
    suitePerl 

    #buildInstallSwig
}

suiteDebug() {
    if $MINGLE_SUITE_DEBUG ; then
        return;
    else
        MINGLE_SUITE_DEBUG=true
    fi

    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking
    suiteDatabase
    suitePython

    buildInstallGDB
}

suiteBoost() {
    if $MINGLE_SUITE_BOOST ; then
        return;
    else
        MINGLE_SUITE_BOOST=true
    fi

    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking
    suiteDatabase
    suitePython
    suiteDebug

    buildInstallBoostJam
    buildInstallBoost
}

suiteSCMTools() {
    if $MINGLE_SUITE_SCM ; then
        return;
    else
        MINGLE_SUITE_SCM=true
    fi

    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking
    suiteDatabase
    suitePython
    suiteDebug
    suiteBoost

    #buildInstallSVN
    #buildInstallGit
}

suiteImageTools() {
    if $MINGLE_SUITE_IMAGE_TOOLS ; then
        return;
    else
        MINGLE_SUITE_IMAGE_TOOLS=true
    fi

    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking
    suiteDatabase
    suitePython
    suiteDebug
    suiteBoost

    installLibJPEG
    installLibPNG
    installLibTiff
}

suiteMathLibraries() {
    if $MINGLE_SUITE_MATH ; then
        return;
    else
        MINGLE_SUITE_MATH=true
    fi

    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking
    suiteDatabase
    suitePython
    suiteDebug
    suiteBoost
}

suiteGrpahicLibraries() {
    if $MINGLE_SUITE_GRAPHICS ; then
        return;
    else
        MINGLE_SUITE_GRAPHICS=true
    fi

    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking
    suiteDatabase
    suitePython
    suiteDebug
    suiteBoost
    suiteImageTools
    suiteMathLibraries

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

    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking
    suiteDatabase
    suitePython
    suiteDebug
    suiteBoost
    suiteImageTools
    suiteMathLibraries
    suiteGrpahicLibraries

    buildInstallLibgeos
    buildInstallGDAL
}

suiteMapnik() {
    local _useDev=$1

    if $MINGLE_MAPNIK ; then
        return;
    else
        MINGLE_MAPNIK=true
    fi

    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking
    suiteDatabase
    suitePython
    suiteDebug
    suiteBoost
    suiteImageTools
    suiteMathLibraries
    suiteGrpahicLibraries
    suiteGeoSpatialLibraries

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

    suiteBase
    suiteXML
    suiteFonts
    suiteEncryption
    suiteNetworking
    suiteDatabase
    suitePython
    suiteDebug
    suiteBoost
    suiteImageTools
    suiteMathLibraries
    suiteGrpahicLibraries
    suiteGeoSpatialLibraries
    suiteMapnik

    buildInstallMapnikStylesheets
    buildInstallTileLite

    #buildInstallNode
    #buildInstallNodeMapnik
    #buildInstallAPR
}

mingleError() {
    local _errorNum=$1
    local _errorMsg="$2"

    if [ -z "$_errorMsg" ]; then
        _errorMsg="The build failed."
    fi

    if [ $_errorNum -eq 0 ]; then
        _errorNum=9999
    fi

    echo
    echo "Current Project Dir: `pwd`"
    echo
    echo "`date +%m-%d-%y\ %T`, $_errorNum $_errorMsg"
    echo "`date +%m-%d-%y\ %T`, \"$_errorNum\" \"$_errorMsg\"">$MINGLE_BUILD_DIR/../mingle_error.log
    echo

    exit $_errorNum
}

mingleReportToolVersions() {
    echo
    echo "Running Bash Version:"
    echo
    bash --version
    echo
}

MINGLE_INITIALIZE=false

mingleInitialize() {
    if ! $MINGLE_INITIALIZE; then
        config="/mingw/etc/mingle.cfg"
        STOREPATH=`pwd`

        mingleReportToolVersions

        echo "Configuration:"

        while read line
        do
            LINE="$line"
            if [ "${LINE:0:1}" = "#" ] ; then
                echo "Skipping disabled variable: $LINE"
            else
                BASHEXPORT=`echo $LINE|sed -e '0,/RE/s/\%/\$/' -e 's/\%//'`
                echo "Exporting: $BASHEXPORT"
                export "`eval echo $BASHEXPORT`"
            fi
        done <"$config"

        MINGLE_CACHE=`echo "$MINGLE_CACHE" | sed -e 's/[a-xA-X]:\\\/\/c\//' -e 's/\\\/\//'`

        echo MINGLE_CACHE=$MINGLE_CACHE

        if [ ! -e "$MINGLE_CACHE" ]; then
            mkdir -p $MINGLE_CACHE || mingleError $? "failed to create cache directory, aborting!"
        fi

        if [ ! -e "$MINGLE_BUILD_DIR" ]; then
            mkdir -p $MINGLE_BUILD_DIR || mingleError $? "failed to create build directory, aborting!"
        fi

        if [ ! -e "/usr/local" ]; then
            mkdir /usr/local || mingleError $? "failed to create directory, aborting!"
        fi

        if [ ! -e "/usr/local/bin" ]; then
            mkdir /usr/local/bin || mingleError $? "failed to create directory, aborting!"
        fi

        if [ ! -e "/usr/local/include" ]; then
            mkdir /usr/local/include || mingleError $? "failed to create directory, aborting!"
        fi

        if [ ! -e "/usr/local/lib" ]; then
            mkdir /usr/local/lib || mingleError $? "failed to create directory, aborting!"
        fi

        MINGLE_INITIALIZE=true
    fi

    cd $MINGLE_BUILD_DIR

    if [ -e "../mingle_error.log" ]; then
        rm ../mingle_error.log
    fi
}

mingleDownload() {
    local _url="$1"
    local _outputFile="$2"
    local _file="`echo $_url|sed 's/.*\///'`"
    local _alreadyDownloaded=false

    if [ -z "$_outputFile" ]; then
        _outputFile=$_file
    fi

    mingleInitialize

    local _savedir=`pwd`

    cd $MINGLE_CACHE

    echo
    echo "Downloading $_url"...

    if [ -e "$_outputFile" ]; then
        _alreadyDownloaded=true
    else
        local _tarcheck="`echo $_outputFile|sed 's/\(.*\)\..*/\1/'`"
        if [ ${_tarcheck: -4} == ".tar" ] && [ -e "$_tarcheck" ]; then
            _alreadyDownloaded=true
        fi
    fi

    if ! $_alreadyDownloaded; then
        if echo $_url|grep -i 'https://'; then
            wget  --no-check-certificate $_url -O $_outputFile || mingleError $? "Download failed for $_file, aborting!"
        else
            wget $_url -O $_outputFile || mingleError $? "Download failed for $_file, aborting!"
        fi
    else
        echo "$_outputFile has already been downloaded."
    fi

    echo

    cd $_savedir
}

mingleDecompress() {
    local _project="$1"
    local _projectDir=$(ad_getDirFromWC "$_project")

    if [ -z "$_projectDir" ]; then
        local _decompFile=$(ad_getArchiveFromWC "$_project")
            
        echo "Decompressing $_decompFile"...
            
        if [ ${_decompFile: -4} == ".tgz" ]; then
            tar xzvf "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
        elif [ ${_decompFile: -3} == ".gz" ]; then
            gzip -d "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
        elif [ ${_decompFile: -3} == ".xz" ]; then
            xz -d "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
        elif [ ${_decompFile: -4} == ".bz2" ]; then
            bzip2 -d "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
        elif [ ${_decompFile: -3} == ".7z" ]; then
            7za x "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
        elif [ ${_decompFile: -4} == ".zip" ]; then
            unzip "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
        elif [ ${_decompFile: -5} == ".lzma" ]; then
            lzma -d "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
        fi
        
        _decompFile=$(ad_getArchiveFromWC "$_project")
        
        if [ ${_decompFile: -4} == ".tar" ]; then
            tar xvf "$_decompFile" || mingleError $? "Failed to unarchive $_decompFile, aborting!"
        fi
    fi
}

mingleCleanup() {
    cd $STOREPATH

    echo
    echo "Finished Building Modules."
    echo
}

mingleGetMaxSetting() {
    mingleGetSelections
    tLen=${#OPTIONS[@]}
    exit $tLen
}

minglePrintSelection() {
    local _selection=$1
    mingleGetSelections

    echo ${OPTIONS[$((_selection-1))]}
}

minglePrintSelections() {
    local _i=0
    mingleGetSelections
    echo
    #printf -- '- %s\n' "${OPTIONS[@]}"

    # get length of an array
    tLen=${#OPTIONS[@]}

    # use for loop read all options
    for (( _i=0; _i<${tLen}; _i++ ));
    do
      echo "$((_i+1))) ${OPTIONS[$_i]}"
    done

    echo
}

mingleGetSelections() {
    OPTIONS=("Base" "XML Libraries" "Font Libraries" "Encryption Libraries" "Networking Libraries" "Database Tools" "Python Tools" "Debugger" "Boost Libraries" "SCM Tools" "Image Libraries" "Math Libraries" "Graphics Libraries" "Geospatial Libraries" "Manpik 2.1.0" "Mapnik Developer Release" "Manpik Tools" "All" "Quit")
}

mingleProcessSelectionNum() {
    local _selection=$1
    local _len=0

    mingleGetSelections

    _len=${#OPTIONS[@]}

    if [ $_selection -lt 1 ] || [ $_selection -gt $_len ]; then
        echo NONE
        mingleProcessSelection "NONE"
        return 1
    else
        mingleProcessSelection "${OPTIONS[$((_selection-1))]}"
    fi

    return 0
}

mingleProcessSelection() {
    local _suite="$1"

    if [ "$_suite" != "Quit" ]; then
        mingleInitialize

        echo
        echo "Preparing suite $_suite..."
        echo
    fi

    case "$_suite" in
    "Quit")
        break
        ;;
    "Base")
        suiteBase
        ;;
    "XML Libraries")
        suiteXML
        ;;
    "Font Libraries")
        suiteFonts
        ;;
    "Encryption Libraries")
        suiteEncryption
        ;;
    "Networking Libraries")
        suiteNetworking
        ;;
    "Database Tools")
        suiteDatabase
        ;;
    "Python Tools")
        suitePython
        ;;
    "Debugger")
        suiteDebug
        ;;
    "Boost Libraries")
        suiteBoost
        ;;
    "SCM Tools")
        suiteSCMTools
        ;;
    "Image Libraries")
        suiteImageTools
        ;;
    "Math Libraries")
        suiteMathLibraries
        ;;
    "Graphics Libraries")
        suiteGrpahicLibraries
        ;;
    "Geospatial Libraries")
        suiteGeoSpatialLibraries
        ;;
    "Manpik 2.1.0")
        suiteMapnik
        ;;
    "Mapnik Developer Release")
        suiteMapnik true
        ;;
    "Mapnik Tools")
        suiteMapnikTools
        ;;
    "All")
        suiteMapnikTools
        break
        ;;
    *)
        echo
        echo "Invalid option. Try another one."
        minglePrintSelections
        break
        ;;  
    esac

    if [ ! -z "$_suite" ] && [ "$_suite" != "NONE" ] && [ "$_suite" != "Quit" ]; then
        mingleCleanup
    fi

    minglePrintSelections
}

mingle_show_help() {
    echo "Usage mingle [OPTION]"
    echo "Deployment script for setting up the development environment in 64 bit MinGW."
    echo
    echo "Arguments:"
    echo "  -h, --help     Show this menu."
    echo "  -s, --suite    Deploy the suite specified by the selected suite below:"
    echo "  -l, --list     List suites of software to choose from."
    echo "  -d, --download Download software only."
    echo "  -k, --lookup   Lookup suite name from numerical value."
    echo "  -m             Get max suite count."

    minglePrintSelections
}

mingleMenu() {
    local _s

    echo
    echo "Welcome to Mingle!"
    echo
    echo "We are going to setup your build environment. Let's get started!"
    echo
    echo "Please Choose from the following:"
    echo "---------------------------------------------------------------------"
    mingleGetSelections

    select _s in "${OPTIONS[@]}"; do
        mingleProcessSelection "$_s"
    done
}


# Initialize our own variables:
verbose=0
suite=""

# http://mywiki.wooledge.org/BashFAQ/035#Manual_loop
while :
do
    case "$1" in
    -h | --help | -\?)
        mingle_show_help
        exit 0
        ;;
    -i | --initialize)
        mingleInitialize
        exit 0
        ;;
    -s | --suite=*)
        suite=${1#*=}
        mingleProcessSelectionNum $suite
        exit $?
        ;;
    -l | --list)
        minglePrintSelections
        exit 0
        ;;
    -d | --download)
        mingleDownloadPackages
        exit 0
        ;;
    -k | --lookup)
        minglePrintSelection $2
        exit 0
        ;;
    -m)
        mingleGetMaxSetting
        exit $?
        ;;
    -v)
        verbose=1
        shift 1
        ;;
    *)
        mingleMenu
        exit 0
        ;;
    esac
done

exit 0