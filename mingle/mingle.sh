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
export AD_PEXPORTS=0.46
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

export AD_CUNIT_VERSION=2.1-2
export AD_GDB_VERSION=7.5

export AD_TCL_VERSION_MAJOR=8.6
export AD_TCL_VERSION_MINOR=.0
export AD_TCL_VERSION=$AD_TCL_VERSION_MAJOR$AD_TCL_VERSION_MINOR

export AD_TK_VERSION=8.6.0

export AD_APR_VERSION=1.4.8
export AD_APRUTIL_VERSION=1.5.2
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

export AD_JSONC_VERSION=master

export AD_BERKELEY_DB=6.0.20
export AD_POSTGRES_VERSION=9.2.2
export AD_POSTGIS_VERSION=2.0.3

export AD_MAPNIK_VERSION=2.1.0

export AD_SWIG_VERSION=2.0.10
export AD_PERL_VERSION=5.18.0
export AD_PERL_SHRT_VERSION=5.0
export AD_PCRE_VERSION=8.33

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
    mingleDownload "http://downloads.sourceforge.net/project/mingw/MinGW/Extension/pexports/pexports-$AD_PEXPORTS/pexports-$AD_PEXPORTS-mingw32-src.tar.xz"
    mingleDownload "http://mingw-w64.svn.sourceforge.net/viewvc/mingw-w64/trunk/mingw-w64-tools/gendef/?view=tar" "gendef.tar.gz"
    mingleDownload "http://prdownloads.sourceforge.net/tcl/tcl$AD_TCL_VERSION-src.tar.gz"
    mingleDownload "http://prdownloads.sourceforge.net/tcl/tk$AD_TK_VERSION-src.tar.gz"
    mingleDownload "http://ftpmirror.gnu.org/libtool/libtool-2.4.2.tar.gz"
    mingleDownload "http://sourceforge.net/projects/cunit/files/CUnit/$AD_CUNIT_VERSION/CUnit-$AD_CUNIT_VERSION-src.tar.bz2/download"
    mingleDownload "http://downloads.sourceforge.net/project/cunit/CUnit/$AD_CUNIT_VERSION/CUnit-$AD_CUNIT_VERSION-src.tar.bz2"
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

    mingleDownload "http://apache.tradebit.com/pub//apr/apr-$AD_APR_VERSION.tar.gz"
    mingleDownload "http://apache.tradebit.com/pub//apr/apr-util-$AD_APRUTIL_VERSION.tar.gz"

    mingleDownload "http://download.oracle.com/berkeley-db/db-$AD_BERKELEY_DB.tar.gz"
    mingleDownload "http://archive.apache.org/dist/subversion/subversion-$AD_SVN_VERSION.tar.gz"
    mingleDownload "https://github.com/onepremise/git/archive/master.zip" "git-master.zip"
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
    mingleDownload "http://downloads.sourceforge.net/project/swig/swig/swig-$AD_SWIG_VERSION/swig-$AD_SWIG_VERSION.tar.gz"
    mingleDownload "http://www.cpan.org/src/$AD_PERL_SHRT_VERSION/perl-$AD_PERL_VERSION.tar.gz"
    mingleDownload "http://sourceforge.net/projects/pcre/files/pcre/$AD_PCRE_VERSION/pcre-$AD_PCRE_VERSION.tar.gz/download" "pcre-$AD_PCRE_VERSION.tar.gz"
    mingleDownload "http://search.cpan.org/CPAN/authors/id/S/SH/SHAY/dmake-4.12-20090907-SHAY.zip"
    mingleDownload "https://github.com/openstreetmap/mapnik-stylesheets/archive/master.zip" "mapnik-stylesheets.zip"
    #mingleDownload "https://github.com/mapnik/node-mapnik/archive/master.zip" "node-mapnik.zip"
    #mingleDownload "http://nodejs.org/dist/v0.10.0/node-v0.10.0.tar.gz"
    #mingleDownload "https://github.com/mitsuhiko/werkzeug/archive/master.zip" "werkzeug.zip"
    mingleDownload "https://bitbucket.org/springmeyer/tilelite/get/c1f84defd807.zip" "tilelite.zip"
    mingleDownload "https://github.com/json-c/json-c/archive/be002fbb96c484f89aee2c843b89bdd00b0a5e46.zip" "json-c-$AD_JSONC_VERSION.zip"
    mingleDownload "http://download.osgeo.org/postgis/source/postgis-$AD_POSTGIS_VERSION.tar.gz"
}

updateGCC() {
    echo "Updating GCC..."

    sed 's/\(template<class Q>\)/\/\/\1/g' /mingw/x86_64-w64-mingw32/include/unknwn.h > unknwn.h
    mv unknwn.h /mingw/x86_64-w64-mingw32/include/unknwn.h || mingleError $? "Failed to update GCC, aborting!"

    cd $MINGLE_BUILD_DIR || mingleError $? "failed to cd $MINGLE_BUILD_DIR, aborting!"
    if [ ! -e "/mingw/x86_64-w64-mingw32/lib/libmingle.a" ]; then
        echo "Supplementing GCC with libmingle..."
        cp -rf $MINGLE_BASE/mingle/libmingle .
        buildInstallGeneric "libmingle" false false "" false false "" "" "xxx" "" ""
    fi
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

        buildInstallGeneric "tar-*" true false "" true true "" "" "tar.exe" "" "tar --version"
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
    buildInstallGeneric "m4-*" true false "" true true "" "" "m4" "" "m4 --version"
}

buildInstallAutoconf() {
    export "M4=/bin/m4"
    buildInstallGeneric "autoconf-*" true false "" true true "" "" "autoconf" "" "autoconf --version"
}

buildInstallAutoMake() {
    buildInstallGeneric "automake-*" true false "" true true "" "" "automake" "" "automake --version"
}

buildInstallGMP() {
    export "CFLAGS="
    export "LDFLAGS="
    export "CPPFLAGS=" 
    buildInstallGeneric "gmp-*" false false "" true true "--enable-cxx " "" "libgmp.a" "" ""
}

buildInstallMPFR() {
    buildInstallGeneric "mpfr-*" true false "" true true "--with-gmp=/mingw --disable-shared" "" "libmpfr.a" "" ""
}

buildInstallMPC() {
    buildInstallGeneric "mpc-*" true false "" true true "--with-gmp=/mingw --with-mpfr=/mingw --disable-shared" "" "libmpc.a" "" ""
}

buildInstallMingw64CRT() {
    if ad_isDateNewerThanFileModTime "2013-01-01" "/mingw/x86_64-w64-mingw32/lib/libcrtdll.a"; then
        export "CFLAGS="
        export "LDFLAGS="
        export "CPPFLAGS=" 
        buildInstallGeneric "mingw-w64-*" false false "" true true "--enable-lib64 --with-gmp --with-crt --with-mpfr --with-mpc --disable-multilib --enable-languages=c,c++ --with-pkgversion=\"MinGW64-Windows\"" "" "x" "" ""
    else
        echo "Mingw64 CRT is up to date."
    fi
}

buildInstallLibtool() {
    buildInstallGeneric "libtool-*" true false "" true true "" "" "libtool" "" "libtool --version"
}

buildInstallPExports() {
    buildInstallGeneric "pexports-*" true false "" true true "" "" "pexports"
}

buildInstallGenDef() {
    buildInstallGeneric "gendef*" true false "" true true "" "" "gendef"
}

buildInstallGLibC() {
    buildInstallGeneric "glibc-*" true false "" true true "" "" "xxx" "" ""
}

# Things to watch:
# http://sourceware.org/bugzilla/show_bug.cgi?id=12127
# http://forums.codeblocks.org/index.php/topic,11301.0.html
buildInstallGDB() {
    local _project="gdb-*"

    if ad_isDateNewerThanFileModTime "2013-01-01" "/mingw/bin/gdb.exe"; then
        mingleDecompress "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")

        cd $_projectDir || mingleError $? "cd failed, aborting!"
        
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

        echo
        echo "Remove any old config.cache files..."
        echo
        find . -name 'config.cache' -exec rm {} \;
        
        cd ..

        export "CFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64 -D__MINGW__"
        export "LDFLAGS=-L/mingw/lib"
        export "CPPFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64 -D__MINGW__"

        buildInstallGeneric "$_project" false false "" true true "--with-gmp --with-mpfr --with-mpc --with-python --enable-shared" "" "x" "" "gdb --version"

        cd $_projectDir/gdb

        # Need to fix this in Makefile
        #x86_64-w64-mingw32-gcc.exe -o _gdb.pyd -s -shared -Wl,--out-implib=libgdb.dll.a  -Wl,--export-all-symbols -Wl,--enable-auto-import -Wl,--whole-archive *.o -Wl,--no-whole-archive -L../bfd -lbfd -L../liberty -liberty -L/mingw/lib -L../readline -lreadline -lhistory -L../libdecnumber -ldecnumber -L../opcodes -lopcodes -lz -lws2_32 -lpython2.7 -lexpat -L../intl -lintl -liconv

        #cp -f _gdb.pyd /mingw/share/gdb/python/gdb
        #cp -rf /mingw/share/gdb/python/gdb /mingw/lib/python2.7/site-packages/gdb

        cd ../..
    else
        echo "GDB is up to date."
    fi
}

buildInstallCUnit() {
    local _project="CUnit-*"

    buildInstallGeneric "$_project" true false "" true true "" "" "libcunit.a"
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
    local _configureFlags="--enable-64bit --enable-shared=no"
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

    if [ -e /mingw/lib/libiconv.dll.a ] && [ -e /mingw/lib/libiconv.a ]; then
        echo "Already Installed." 
        return
    fi
    
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
    buildInstallGeneric "binutils-*" true false "" true true "" "" "dllwrap.exe" "" "dllwrap.exe --version"
}

buildInstallPkgconfig() {
    buildInstallGeneric "pkg-config-*" true false "" true true "--with-internal-glib" "" "pkg-config" "" "pkg-config --version"
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

        tar xvf libjpeg-turbo.tar
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
    buildInstallGeneric "tiff-*" true false "" true true "" "" "tiffinfo" "" "tiffinfo"
}

buildInstallSigc() {
    buildInstallGeneric "libsigc++-*" true false "" true true "" "" "libsigc-2.0-0.dll"
}

buildInstallPixman() {
    buildInstallGeneric "pixman-$AD_PIXMAN_VERSION*" true false "" true true "" "" "libpixman-1.a"
}

buildInstallCairo() {
    local _project="cairo-$AD_CAIRO_VERSION*"

    buildInstallGeneric "$_project" true false "" true true "" "" "libcairo.a"

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
    buildInstallGeneric "cairomm-*" true false "" true true "" "" "libcairomm-1.0.a"
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
    buildInstallGeneric "libxml2-*" true false "" true true "--enable-shared --enable-static --with-icu" "" "xmllint" "" "xmllint --version"
}

buildInstallCurl() {
    #buildInstallGeneric "curl-*" true false "" true true "--with-polarssl" "libcurl.a" "" "curl --version"
    buildInstallGeneric "curl-*" true false "" true true "" "" "libcurl.a" "" "curl --version"
}

buildInstallAPR() {
    local _project="apr-*"

    if [ -e /mingw/lib/libapr-1.a ]; then
        echo "$_project Already Installed."
        return;
    fi

    export "CFLAGS=-I/mingw/include -D__MINGW__ -DAPU_DECLARE_STATIC"
    export "LDFLAGS=-L/mingw/lib"
    export "CPPFLAGS=-I/mingw/include -D__MINGW__  -DAPU_DECLARE_STATIC"

    mingleDecompress "$_project"

    local _projectDir=$(ad_getDirFromWC "$_project")

    cd "$_projectDir" || mingleError $? "cd failed, aborting!"

    if [ ! -e apr-mingw.patch ]; then
        cp $MINGLE_BASE/patches/apr/$AD_APR_VERSION/apr-mingw.patch .
        ad_patch "apr-mingw.patch"
    fi

    cd ..
    buildInstallGeneric "apr-*" false false "" true true "--enable-shared" "" "libapr-1.a" "" "apr-1-config --version"

    mkdir -p /mingw/include/apr-1/arch/win32
    cp -f $_projectDir/include/arch/apr_private_common.h /mingw/include/apr-1/arch
    cp -rf $_projectDir/include/arch/win32 /mingw/include/apr-1/arch
}

buildInstallAPRUtil() {
    export "CFLAGS=-I/mingw/include -D__MINGW__ -DAPU_DECLARE_STATIC"
    export "LDFLAGS=-L/mingw/lib"
    export "CPPFLAGS=-I/mingw/include -D__MINGW__  -DAPU_DECLARE_STATIC"

    buildInstallGeneric "apr-util-*" false false "" true true "--with-apr=/mingw/bin/apr-1-config --with-expat=/mingw" "" "libaprutil-1.a" "" "apu-1-config --version"
}

buildInstallBerkeleyDB() {
    local _project="db-*"
    local _additionFlags="--prefix=/mingw --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-mingw --enable-cxx --disable-replication"
    local _binCheck="db_verify.exe"
    local _exeToTest="db_verify -V"

    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        echo
        echo "Building $_project..."
        echo

        ad_setDefaultEnv
        #ad_clearEnv

        mingleDecompress "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)
        
        cd $_projectdir || mingleError $? "cd failed, aborting!"

        cd dist

        ./s_config
        #aclocal -I aclocal -I aclocal_java
        #autoconf
        #autoheader

        cd ../build_unix
        
        ../dist/configure $_additionFlags || mingleError $? "configure failed, aborting!"

        make || mingleError $? "make failed, aborting!"

        make install || mingleError $? "make failed, aborting!"
    fi

    ad_run_test "$_exeToTest"
}

buildInstallSVN() {
    local _project="subversion-*"
    local _additionFlags="--prefix=/mingw"
    local _binCheck="svn.exe"
    local _exeToTest="svn --version"

    echo
    echo "Building $_project..."
    echo
    
    ad_setDefaultEnv

    export "CFLAGS=$CFLAGS -DAPU_DECLARE_STATIC"
    export "LDFLAGS=$LDFLAGS -lole32 -lmlang -luuid"
    export "CPPFLAGS=$CPPFLAGS -DAPU_DECLARE_STATIC"

    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        mingleDecompress "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)
        
        cd $_projectdir || mingleError $? "cd failed, aborting!"

        if [ ! -e svn-mingw.patch ]; then
            cp $MINGLE_BASE/patches/subversion/$AD_SVN_VERSION/svn-mingw.patch .
            ad_patch "svn-mingw.patch"
        fi

        autoconf || mingleError $? "autoconf failed, aborting!"
        ./configure "$_additionFlags" || mingleError $? "configure failed, aborting!"

        cd ..

        ad_make "$_project"
    else
        echo "Already Installed."
    fi

    ad_run_test "$_exeToTest"
    
    echo   
}

buildInstallGit() {
    local _project="git-*"
    local _binCheck="git.exe"
    local _exeToTest="git.exe --version"

    echo
    echo "Checking $_project..."
    echo
    
    if [ ! -e /mingw/bin/$_binCheck ]; then
        echo
        echo "Building $_project..."
        echo

        mingleDecompress "$_project"

        cd $_project

        make LDFLAGS=-L/mingw/lib NO_GETTEXT=Yes USE_LIBPCRE=Yes LIBPCREDIR=/mingw CURLDIR=/mingw EXPATDIR=/mingw PERL_PATH=/mingw/bin/perl.exe PYTHON_PATH=/mingw/bin/python.exe TCL_PATH=/mingw/bin/tclsh.exe TCLTK_PATH=/mingw/bin/tclsh.exe DEFAULT_EDITOR=/bin/vim NO_R_TO_GCC_LINKER=Yes NEEDS_LIBICONV=True V=1 CFLAGS='-g -O2 -I/mingw/include -D__MINGW32__ -D__USE_MINGW_ANSI_STDIO -DWIN32 -DHAVE_MMAP -DPCRE_STATIC' prefix=/mingw CC=gcc INSTALL=/bin/install|| mingleError $? "make failed, aborting!"

        make install LDFLAGS=-L/mingw/lib NO_GETTEXT=Yes USE_LIBPCRE=Yes LIBPCREDIR=/mingw CURLDIR=/mingw EXPATDIR=/mingw PERL_PATH=/mingw/bin/perl.exe PYTHON_PATH=/mingw/bin/python.exe TCL_PATH=/mingw TCLTK_PATH=/mingw/bin/tclsh.exe DEFAULT_EDITOR=/bin/vim NO_R_TO_GCC_LINKER=Yes NEEDS_LIBICONV=True V=1 CFLAGS='-g -O2 -I/mingw/include -D__MINGW32__ -D__USE_MINGW_ANSI_STDIO -DWIN32 -DHAVE_MMAP -DPCRE_STATIC' prefix=/mingw CC=gcc INSTALL=/bin/install|| mingleError $? "make install failed, aborting!"

        cd ..
    else
        echo "Already Installed."          
    fi
    
    echo
}

buildInstallFontConfig() {
    local _project="fontconfig-*"
    local _additionFlags="--enable-libxml2 --disable-docs"
    local _binCheck="fc-list"
    local _exeToTest="fc-list"

    export "FREETYPE_LIBS=`freetype-config --libs`"

    echo
    echo "Checking for binary $_binCheck..."
    echo
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        echo
        echo "Building $_project..."
        echo
    
        ad_setDefaultEnv

        mingleDecompress "$_project"

        local _projectdir=$(ad_getDirFromWC $_project)
        
        cd $_projectdir || mingleError $? "cd failed, aborting!"
        
        if [ ! -e fontconfig-mingw.patch ]; then
            cp $MINGLE_BASE/patches/fontconfig/$AD_FONT_CONFIG/fontconfig-mingw.patch .
            ad_patch "fontconfig-mingw.patch"
        fi
        
        mkdir -p /mingw/share/fontconfig/conf.avail        
        cp -rf conf.d/*.conf /mingw/share/fontconfig/conf.avail
        
        cd ..
    
        #export "CFLAGS=$CFLAGS -DFC_DBG_CONFIG"
        ad_configure "$_project" false "" true "$_additionFlags"
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
    echo "Checking freetype..."
    echo
    
    if [ ! -e /mingw/lib/libfreetype.a ]; then
        echo
        echo "Building freetype..."
        echo

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
    buildInstallGeneric "sqlite-*" true false "" true true "" "" "libsqlite3.a" "" "sqlite3 --version"
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

    if [ -e /mingw/lib/libpq.dll ] && [ -e /mingw/bin/postgres.exe ]; then
        echo "Already Installed."
        return;
    fi

    mingleDecompress "$_project"

    local _projectDir=$(ad_getDirFromWC "$_project")

    cd "$_projectDir" || mingleError $? "cd failed, aborting!"

    if [ ! -e postgresql-mingw.patch ]; then
        cp $MINGLE_BASE/patches/postgresql/$AD_POSTGRES_VERSION/postgresql-mingw.patch .
        ad_patch "postgresql-mingw.patch"
    fi

    cd ..

    export "CFLAGS=-I/mingw/include -D_WIN64 -DMS_WIN64"
    export "LDFLAGS=-L/mingw/lib"
    export "CPPFLAGS=-I/mingw/include  -D_WIN64 -DMS_WIN64"

    buildInstallGeneric "$_project" false false "" true true "" "" "postgres" "" "postgres --version"
    
    if [ -e /mingw/lib/libpq.dll ]; then
        cp -rf /mingw/lib/libpq.dll /mingw/bin
    fi

    cd "$_projectDir" || mingleError $? "cd failed, aborting!"
    cd contrib/hstore || mingleError $? "cd failed, aborting!"

    make CFLAGS+=-I/mingw/include/postgresql/server CPPFLAGS+=-I/mingw/include/postgresql/server
    make install CFLAGS+=-I/mingw/include/postgresql/server CPPFLAGS+=-I/mingw/include/postgresql/server clean

    cd $MINGLE_BUILD_DIR
}

buildInstallExpat() {
    buildInstallGeneric "expat-*" true false "" true true "" "" "libexpat.a"
}

buildInstallLibproj() {
    buildInstallGeneric "proj-*" true false "" true true "" "" "libproj.a"
}

buildInstallProjDatumgrid() {
    echo
    echo "Installing proj-datumgrid..."
    echo
    
    if [ ! -e /mingw/share/proj/ntv1_can.dat ]; then
        if [ ! -e proj-datumgrid ]; then
            mkdir proj-datumgrid
        fi

        cd proj-datumgrid || mingleError $? "cd failed, aborting!"

        mingleDecompress "proj-datumgrid*"

        cp -f * /mingw/share/proj
     
        export PROJ_LIB=/mingw/share/proj

        echo "export PROJ_LIB=/mingw/share/proj">>/etc/profile

        cd ..
    else
        echo "Already Installed."        
    fi
    
    echo    
}

buildInstallLibGeotiff() {
    buildInstallGeneric "libgeotiff-*" true false "" true true "--enable-shared --enable-incode-epsg" "" "libgeotiff.dll.a" "" "geotifcp"
    
    buildInstallGeneric "libgeotiff-*" true false "" true true "--enable-static --enable-incode-epsg" "" "libgeotiff.a" "" "geotifcp"
}

buildInstallLibgeos() {
    buildInstallGeneric "geos-*" true false "" true true "" "" "libgeos.a" "" ""
}

buildInstallGDAL() {
    local _project="gdal-*"
    local _configureFlags=""
    local _binCheck="libgdal-1.dll"
    local _exeToTest="gdal_grid --version"
    
    echo
    echo "Building $_project..."
    echo
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        ad_setDefaultEnv

        mingleDecompress "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")
  
        ad_configure "$_project" false "" true "$_configureFlags"

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
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$ _binCheck" ] );then
        echo
        echo "Building $_project..."
        echo

        ad_setDefaultEnv

        mingleDecompress $_project

        local _projectDir=$(ad_getDirFromWC "$_project")
        
        if ls -d cpython*/ &> /dev/null; then
            mv cpython* python-latest
        fi
        
        cd $_projectDir || mingleError $? "cd failed, aborting!"
        
        if [ ! -e python-mingw.patch ]; then
            #http://bugs.python.org/issue3754
            #http://bugs.python.org/issue4709
            
            #my update
            cp $MINGLE_BASE/patches/python/$AD_PYTHON_VERSION/python-mingw.patch .
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
               
        ad_configure "$_project" false "" true "--with-libs=-lmingle --with-system-expat --enable-loadable-sqlite-extensions build_alias=x86_64-w64-mingw32 host_alias=x86_64-w64-mingw32 target_alias=x86_64-w64-mingw32"

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
    
    echo "Checking for binary easy_install.exe..."
    if [ ! -e /mingw/lib/python$AD_PYTHON_MAJOR/site-packages/easy_install.exe ]; then
        mingleDecompress "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")

        cd $_project || mingleError $? "cd failed, aborting!"

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

    echo "Checking for binary liteserv.py..."
    if [ ! -e /mingw/lib/python$AD_PYTHON_MAJOR/site-packages/liteserv.py ]; then
        mingleDecompress "$_project"

        local _changenameof=`find . -maxdepth 1 -name "*tilelite*" -type d`

        if [ -n "$_changenameof" ] && [ ! -e "tilelite" ]; then
            mv $_changenameof tilelite || mingleError $? "mv failed, aborting!"
        fi

        local _projectDir=$(ad_getDirFromWC "$_project")

        cd $_project || mingleError $? "cd failed, aborting!"

        python setup.py install --install-purelib `python -c "import sysconfig;print sysconfig.get_path('purelib')"` --install-scripts `python -c "import sysconfig;print sysconfig.get_path('purelib')"` --exec-prefix=`python -c "import sysconfig;print sysconfig.get_path('purelib')"`
    else
        echo "$_project Already Installed."
    fi

    cd $_savedir
}

buildInstallNode() {
    buildInstallGeneric "node-v*" true false "" true true "" "" "xxx"
}

buildInstallNodeMapnik() {
    buildInstallGeneric "node-mapnik*" true false "" true true "" "" "xxx"
}

buildInstallWAF() {

    local _project="waf-*"

    if [ ! -e /mingw/bin/waf ]; then
        mingleDecompress "$_project"

        local _projectdir=$(ad_getDirFromWC "$_project")

        cd "$_projectdir" || mingleError $? "cd failed, aborting!"

        if [ ! -e waf-mingw.patch ]; then
             cp $MINGLE_BASE/patches/waf/$AD_WAF_VERSION/waf-mingw.patch . || mingleError $? "patch failed, aborting!"
             ad_patch "waf-mingw.patch"
        fi

        cd ..

        buildInstallGeneric "waf-*" true false "" true true "" "" "waf" "" ""

        cd "$_projectdir" || mingleError $? "cd failed, aborting!"

        cp waf /mingw/bin || mingleError $? "failed to install waf, aborting!"

        cd ..
    else
        echo "$_project Already Installed."
    fi
}

buildInstallBoostJam() {
    buildInstallGeneric "boost-jam*" true false "" true true "" "" "bjam" "cp bin.ntx86_64/*.exe /mingw/bin" ""
}

buildInstallBoost() {
    local _project="boost_*"
    local _binCheck="boost_system-47-mt-1_$AD_BOOST_MINOR_VERSION.dll"

    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then

        mingleDecompress "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")

        cd $_project || mingleError $? "cd failed, aborting!"

        if [ ! -e boost-mingw.patch ]; then
            # Apply patch for https://svn.boost.org/trac/boost/ticket/5023
            cp $MINGLE_BASE/patches/boost/$AD_BOOST_PATH_VERSION/boost-mingw.patch .
            ad_patch "boost-mingw.patch"
        fi

        cd ..

        export CPLUS_INCLUDE_PATH=/mingw/include/python2.7
        buildInstallGeneric "boost_*" true false "" true true "" "" "boost_system-47-mt-1_$AD_BOOST_MINOR_VERSION.dll" "" ""
        export CPLUS_INCLUDE_PATH=

        ad_relocate_bin_dlls "boost_"
    else
        echo "$_project Already Installed."
    fi
}

buildInstallPyCairo() {
    local _project="py2cairo-*"
    local _additionFlags=""
    local _binCheck="/pkgconfig/pycairo.pc"
    local _exeToTest=""
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        echo
        echo "Building $_project..."
        echo

        ad_setDefaultEnv

        export "PYTHON_CONFIG=/mingw/bin/python2.7-config"
        export "CFLAGS=$CFLAGS -I/mingw/include/Python2.7"
        export "LDFLAGS=$LDFLAGS -lpixman-1"

        mingleDecompress "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")
        
        cd "$_projectDir" || mingleError $? "cd failed, aborting!"
        
        #Expand waflib
        ./waf --version

        #patch waflib
        cd waf-*/waflib

        if [ ! -e waf-mingw.patch ]; then
            cp $MINGLE_BASE/patches/py2cairo/$AD_PYCAIRO_VERSION/waf-mingw.patch .
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

    if [ -e /mingw/lib/mapnik.dll ] && [ -e /mingw/lib/libmapnik.dll.a ]; then
        echo "$_project Already Installed." 
        return
    fi

    mingleDecompress "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)

    cd "$_projectdir" || mingleError $? "cd failed, aborting!"
        
    if [ ! -e mapnik-mingw.patch ]; then
         #my update
         cp $MINGLE_BASE/patches/mapnik/$AD_MAPNIK_VERSION/mapnik-mingw.patch .
         ad_patch "mapnik-mingw.patch"
    fi

    cd ..

    buildInstallGeneric "mapnik-*" true false "" true true "PREFIX=/mingw CUSTOM_CXXFLAGS=-DMS_WIN64 CUSTOM_CXXFLAGS=-D__MINGW__ BOOST_INCLUDES=/mingw/include/boost-1_53 BOOST_LIBS=/mingw/lib CC=x86_64-w64-mingw32-gcc-4.7.2.exe CXX=x86_64-w64-mingw32-g++.exe" "" "mapnik.dll" "" "mapnik-config --version"

    ln -sf /mingw/lib/mapnik.dll /mingw/bin/mapnik.dll
}

buildInstallMapnikDev() {
    local _project="mapnik-*"

    if [ -e /mingw/lib/mapnik.dll ] && [ -e /mingw/lib/libmapnik.dll.a ]; then
        echo "$_project Already Installed." 
        return
    fi

    mingleDecompress "$_project"

    buildInstallGeneric "$_project" true false "" true true "PREFIX=/mingw CUSTOM_CXXFLAGS=-DMS_WIN64 CUSTOM_CXXFLAGS=-D__MINGW__ BOOST_INCLUDES=/mingw/include/boost-1_53 BOOST_LIBS=/mingw/lib CC=x86_64-w64-mingw32-gcc-4.7.2.exe CXX=x86_64-w64-mingw32-g++.exe" "" "mapnik.dll" "" "mapnik-config --version"

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

buildInstalldMake() {
    local _project="dmake*"

    if ! grep MAKESTARTUP /etc/profile; then
        echo
        echo "Adding MAKESTARTUP to profile..."
        echo
        export MAKESTARTUP=/usr/local/lib/dmake/startup/startup.mk
        echo "export MAKESTARTUP=/usr/local/lib/dmake/startup/startup.mk">>/etc/profile
    fi

    if [ -e /usr/local/bin/dmake ]; then
        echo "$_project Already Installed." 
        echo
        return
    fi

    mingleDecompress "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)

    echo "Installing dmake..."
    echo

    cp $_projectdir/dmake /usr/local/bin
    mkdir /usr/local/lib/dmake
    cp -rf $_projectdir/startup /usr/local/lib/dmake
    
    export MAKESTARTUP=/usr/local/lib/dmake/startup/startup.mk

    echo "export MAKESTARTUP=/usr/local/lib/dmake/startup/startup.mk">>/etc/profile
}

buildInstallPerl() {
    local _project="perl*"

    if [ -e /mingw/bin/perl5.18.0 ]; then
        echo "$_project Already Installed." 
        echo
        return
    fi

    echo
    echo "Building $_project..."
    echo

    mingleDecompress "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)

    cd $_project || mingleError $? "cd failed, aborting!"

    #Notes from http://sourceforge.net/projects/perlmingw/files/Compiler%20for%2064%20bit%20Windows/
    if [ ! -e perl-mingw.patch ]; then
         cp $MINGLE_BASE/patches/perl/$AD_PERL_VERSION/perl-mingw.patch .
         ad_patch "perl-mingw.patch"
    fi

    # Remove if old default config preexists
    if [ -e config.sh ]; then
        rm config.sh
    fi

    cd win32 || mingleError $? "cd failed, aborting!"

    local _perl_install=`echo $MINGLE_BASE|sed 's/\//\\\\/g'`

    echo "Executing make..."
    echo

    cmd /c "dmake MINGLE_BASE*=$_perl_install"

    echo "Executing make install..."
    echo
    cmd /c "dmake install MINGLE_BASE*=$_perl_install"

    cd ../..
}

buildInstallPCRE() {
    local _project="pcre-*"

    if [ -e /mingw/bin/pcregrep ]; then
        echo "$_project Already Installed." 
        echo
        return
    fi

    mingleDecompress "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)

    cd $_project || mingleError $? "cd failed, aborting!"

    if [ ! -e pcre-mingw.patch ]; then
         cp $MINGLE_BASE/patches/pcre/$AD_PCRE_VERSION/pcre-mingw.patch .
         ad_patch "pcre-mingw.patch"
    fi

    buildInstallGeneric "$_project" true true "-Im4" true true "--disable-cpp --disable-shared --enable-newline-is-anycrlf --enable-utf8 --enable-unicode-properties" "" "xxx" "" ""
}

buildInstallSwig() {
    local _project="swig-*"

    buildInstallGeneric "$_project" true false "" true true "" "" "swig" "" "swig -version"
}

buildInstallJSONC() {
    local _project="json-c-*"

    buildInstallGeneric "$_project" true false "" true true "" LN_S='ln -s' "libjson-c-2.dll"

    if [ ! -e /mingw/include/json ]; then
        ln -s /mingw/include/json-c/ /mingw/include/json || mingleError $? "json-c: ln failed, aborting!"
    fi
}

buildInstallPostGIS () {
    local _project="postgis-*"

    if [ -e /mingw/lib/postgresql/postgis-2.0.dll ]; then
        echo "$_project Already Installed." 
        echo
        return
    fi

    mingleDecompress "$_project"

    local _projectdir=$(ad_getDirFromWC $_project)

    cd $_project || mingleError $? "cd failed, aborting!"

    if [ ! -e postgis-mingw.patch ]; then
         cp $MINGLE_BASE/patches/postgis/$AD_POSTGIS_VERSION/postgis-mingw.patch .
         ad_patch "postgis-mingw.patch"
    fi
        
    export "PG_CPPFLAGS=-D__ERRCODE_DEFINED_MS"

    buildInstallGeneric "$_project" true false "" true true "--with-jsondir=/mingw" "" "/mingw/lib/postgresql/postgis-2.0.dll"
}

initializePostGISDB () {
    echo "Creating PostGIS Database..."

    psql -U postgres -f /opt/local/share/postgresql90/contrib/hstore.sql
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
    local _result=`find $MINGLE_BUILD_DIR -maxdepth 1 -name "$_project" -prune -type d -print | head -1`

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
    unset CC

    cd $MINGLE_BUILD_DIR
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
    export "CC=x86_64-w64-mingw32-gcc"

    cd $MINGLE_BUILD_DIR
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
    local _runACLocal=$2
    local _aclocalFlags=$3
    local _runAutoconf=$4
    local _additionFlags=$5
    
    local _projectDir=$(ad_getDirFromWC "$_project")

    cd $_projectDir || mingleError $? "ad_configure cd failed, aborting!"

    if [ -e "autogen.sh" ]; then
        ./autogen.sh
    elif [ -e "configure.ac" ] || [ -e "configure.in" ]; then
        if [ -e "/mingw/bin/autoconf" ];then
            echo

            if $_runACLocal; then
                echo "Executing aclocal..."
                
                if [ -n "$_aclocalFlags" ]; then
                    aclocal "$_aclocalFlags" || mingleError $? "ad_configure aclocal failed, aborting!"
                else
                    aclocal || mingleError $? "ad_configure aclocal failed, aborting!"
                fi
            fi

            if $_runAutoconf; then
                echo "Executing autoconf..."
                autoconf || mingleError $? "ad_configure autoconf failed, aborting!"
            fi

            echo
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
                mingleError 9999 "Max configure retries reached. Build Failed!"
            fi

            local _test=`cat out.txt|grep "unrecognized option"|sed -e "s/^.*\(--.*\)'/\1/"`

            if [ -z "$_test" ]; then
                _test=`cat out.txt|grep "error: no such option:"|sed -e "s/^.*\(--.*\)/\1/"`
                if [ -z "$_test" ]; then
                    cat out.txt
                    mingleError 9999 "Configuration Failed for $_project!"
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

# Use single quotes for parameter defines, ex: TEST='cmd -h'
ad_make() {
    local _project=$1
    local _makeParameters="$2"
    
    local _projectDir=$(ad_getDirFromWC "$_project")
    cd $_projectDir || mingleError $? "cd failed, aborting"

    echo
    echo "Executing make $_makeParameters..."
    echo

    if [ -n "$_makeParameters" ]; then    
        make "$_makeParameters" || mingleError $? "make failed, aborting!"

        echo
        echo "Executing make install $_makeParameters..."
        echo
        make install "$_makeParameters" || mingleError $? "make install failed, aborting"
    else
        make || mingleError $? "make failed, aborting!"

        echo
        echo "Executing make install $_makeParameters..."
        echo
        make install || mingleError $? "make install failed, aborting"
    fi

    cd ..
}

ad_boost_jam() {
    local _project=$1
    
    local _projectDir=$(ad_getDirFromWC "$_project")
    cd $_projectDir || mingleError $? "ad_boost_jam cd failed, aborting!"
    
    #this is needed for boost https://svn.boost.org/trac/boost/ticket/6350
    cp $MINGLE_BASE/mingle/mingw.jam tools/build/v2/tools || mingleError $? "ad_boost_jam mingw.jam copy failed, aborting!"

    
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
    local _runACLocal=$3 #true/false
    local _aclocalFlags="$4"
    local _runAutoconf=$5 #true/false
    local _runConfigure=$6 #true/false
    local _configureFlags="$7"
    local _makeParameters="$8"
    local _binCheck="$9"
    local _postBuildCommand="${10}"
    local _exeToTest="${11}"

    cd $MINGLE_BUILD_DIR

    echo
    echo "Generic Build Initiated:"
    echo "  _project:          $_project"
    echo "  _cleanEnv:         $_cleanEnv"
    echo "  _runACLocal:       $_runACLocal"
    echo "  _aclocalFlags:     $_aclocalFlags"
    echo "  _runAutoconf:      $_runAutoconf"
    echo "  _runConfigure:     $_runConfigure"
    echo "  _configureFlags:   $_configureFlags"
    echo "  _makeParameters:   $_makeParameters"
    echo "  _binCheck:         $_binCheck"
    echo "  _postBuildCommand: $_postBuildCommand"
    echo "  _exeToTest:        $_exeToTest"
    echo
    echo "Checking for binary $_binCheck..."
    echo
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        echo
        echo "Building $_project..."
        echo

        if $_cleanEnv; then
            ad_setDefaultEnv
        fi

        mingleDecompress "$_project"

        local _projectDir=$(ad_getDirFromWC "$_project")

        if $_runConfigure; then
            ad_configure "$_project" $_runACLocal "$_aclocalFlags" $_runAutoconf "$_configureFlags"
        fi

        local _jamCheck=`grep -i BJAM "$_projectDir/bootstrap.sh"`

        if [ -e "$_projectDir/bootstrap.sh" ] && [ ! -z "$_jamCheck" ]; then
            ad_boost_jam "$_project"
        elif [ -e "$_projectDir/build.sh" ]; then
            ad_build "$_project"
        else
            ad_make "$_project" "$_makeParameters"
        fi
        
        local _result=`echo "$_configureFlags"|grep "\-\-enable\-shared"`
        
        if [ ! -z "$_result" ]; then
            echo "Shared Library Enabled."
            
            local _shortProjectName=$(ad_getShortLibName $_project)
            
            echo "Short Name: $_shortProjectName"
            
            ad_fix_shared_lib "$_shortProjectName"
        fi
        
        ad_exec_script "$_project" "$_postBuildCommand"

        cd $MINGLE_BUILD_DIR
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
MINGLE_SUITE_PERL=false
MINGLE_SUITE_SWIG=false
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
MINGLE_EXCLUDE_DEP=false

suiteBase() {
    if [ $SUITE_BASE ]; then
        return;
    else
        SUITE_BASE=true
    fi

    updateFindCommand

    mingleDownloadPackages

    updateGCC

    buildInstallPExports
    buildInstallGenDef
    
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
    buildInstallJSONC

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

    if ! $MINGLE_EXCLUDE_DEP; then
      suiteBase
    fi

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

    if ! $MINGLE_EXCLUDE_DEP; then
      suiteXML
    fi

    buildInstallFreeType
    buildInstallFontConfig
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
    buildInstallAPR
    buildInstallAPRUtil
    suitePerl
    suiteSwig
    suiteSCMTools
    suiteImageTools
    suiteMathLibraries
    suiteGrpahicLibraries
    suiteGeoSpatialLibraries
}

suiteAll() {
    suiteAllExceptMapnik
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
    echo "`date +%m-%d-%y\ %T`, \"$_errorNum\" \"$_errorMsg\"">$MINGLE_BUILD_DIR/mingle_error.log
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

        MINGLE_CACHE=`echo "$MINGLE_CACHE" | sed -e 's/\([a-xA-X]\):\\\/\/\1\//' -e 's/\\\/\//g'`

        if [ -n "$altPath" ]; then
            export "MINGLE_BUILD_DIR=$altPath"
        fi

        echo MINGLE_BASE=$MINGLE_BASE
        echo MINGLE_BUILD_DIR=$MINGLE_BUILD_DIR
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

    if [ -e "mingle_error.log" ]; then
        rm mingle_error.log
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

        if [ ! -e "$_decompFile" ]; then
            mingleError $? "Failed to find archive for: $_project, aborting!"
        fi

        cd $MINGLE_BUILD_DIR
            
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
            unzip -q -n "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
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
    cd "$STOREPATH"

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
    OPTIONS=("Base" "XML Libraries" "Font Libraries" "Encryption Libraries" "Networking Libraries" "Database Tools" "Python Tools" "Debugging and Testing" "Boost Libraries" "SCM Tools" "Image Libraries" "Math Libraries" "Graphics Libraries" "Geospatial Libraries" "Manpik 2.1.0" "Mapnik Developer Release" "Mapnik Tools" "All" "Quit")
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
    "Debugging and Testing")
        suiteDebugTest
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
        suiteAll
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
    echo "  -h, --help      Show this menu."
    echo "  -s, --suite=NUM Deploy the suite specified by the selected suite below:"
    echo "  -l, --list      List suites of software to choose from."
    echo "  -d, --download  Download software only."
    echo "  -k, --lookup    Lookup suite name from numerical value."
    echo "  -e, --exclude   Exclude dependency checks during build."
    echo "  -p, --path=PATH Use alternate path for build."
    echo "  -m              Get max suite count."

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
altPath=""

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
    -e | --exclude)
        MINGLE_EXCLUDE_DEP=true
        shift 1
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
    -p | --path=*)
        altPath=${1#*=}
        shift 1
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