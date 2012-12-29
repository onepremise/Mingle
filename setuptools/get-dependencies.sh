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
export AD_GLIBC=2.16.0
export AD_ZLIB=1.2.7
export AD_BZIP=1.0.6
export AD_SEVENZIPPATH=9.20
export AD_SEVENZIP=920
export AD_PTHREADS=2-9-1
export AD_PKGCONFIG=0.27.1
export AD_ICU_VERSION=50_1
export AD_ZLIB_VERSION=1.2.7
export AD_EXPAT_VERSION=2.1.0
export AD_LIBICONV=1.14
export AD_POLAR_VERSION=1.2.3
export AD_OPENSSL_VERSION=1.0.1c
export AD_LIBXML2_VERSION=2.9.0
export AD_LIBCURL_VERSION=7.28.1

export AD_APR_VERSION=1.4.6
export AD_SVN_VERSION=1.7.7
export AD_GIT_VERSION=

export AD_LIBSIGC_PATH_VERSION=2.3
export AD_LIBSIGC_VERSION=2.3.1

export AD_BOOST_JAM_VERSION=3.1.18
export AD_BOOST_PATH_VERSION=1.52.0
export AD_BOOST_VERSION=1_52_0

export AD_FONT_CONFIG=2.10.0
export AD_FREETYPE_VERSION=2.4.10

export AD_SQLITE_VERSION=3071500

export AD_LIBPNG_VERSION=1.5.13
export AD_LIBJPEG_VERSION=1.2.1
export AD_TIFF_VERSION=4.0.3

export AD_PROJ_VERSION=4.8.0
export AD_PROJ_GRIDS_VERSION=1.6RC1
export AD_GEOTIFF_VERSION=1.4.0
export AD_GDAL_VERSION=1.9.2
export AD_GEOS_VERSION=3.3.6

export AD_PIXMAN_VERSION=0.28.2
export AD_CAIRO_VERSION=1.12.8
export AD_CAIROMM_VERSION=1.10.0
export AD_PYCAIRO_VERSION=1.10.0

export AD_PYTHON_VERSION=3.3.0
export AD_POSTGRES_VERSION=9.2.2

export AD_MAPNIK_VERSION=2.1.0

download () {
    echo "Checking Downloads..."
    
    if ! ( [ -e "findutils-4.4.2-2-msys-1.0.13-bin.tar" ] || [ -e "findutils-4.4.2-2-msys-1.0.13-bin.tar.lzma" ] );then
        wget http://sourceforge.net/projects/mingw/files/MSYS/Base/findutils/findutils-4.4.2-2/findutils-4.4.2-2-msys-1.0.13-bin.tar.lzma/download
    fi
    
    if [ ! -e "7za$AD_SEVENZIP.zip" ];then
        wget http://sourceforge.net/projects/sevenzip/files/7-Zip/$AD_SEVENZIPPATH/7za$AD_SEVENZIP.zip/download
    fi
    
    #if [ ! -e "make-$MAKE.zip" ];then
    #  wget http://sourceforge.net/projects/mingw-w64/files/External%20binary%20packages%20%28Win64%20hosted%29/make/make-$MAKE.zip/download
    #fi
    
    if ! ( [ -e "m4-$AD_MFOUR.tar" ] || [ -e "m4-$AD_MFOUR.tar.xz" ] );then
        wget http://ftp.gnu.org/gnu/m4/m4-$AD_MFOUR.tar.xz
    fi
    
    if ! ( [ -e "autoconf-$AD_AUTOCONF.tar" ] || [ -e "autoconf-$AD_AUTOCONF.tar.gz" ] );then
        wget http://ftp.gnu.org/gnu/autoconf/autoconf-$AD_AUTOCONF.tar.gz
    fi
    
    if ! ( [ -e "automake-$AD_AUTOMAKE.tar" ] || [ -e "automake-$AD_AUTOMAKE.tar.gz" ] );then
        wget http://ftp.gnu.org/gnu/automake/automake-$AD_AUTOMAKE.tar.gz
    fi
    
    #if ! ( [ -e "glibc-$AD_GLIBC.tar" ] || [ -e "glibc-$AD_GLIBC.tar.xz" ] );then
    #    wget http://ftp.gnu.org/gnu/libc/glibc-$AD_GLIBC.tar.xz
    #fi
    
    if ! ( [ -e "libtool-2.4.2.tar" ] || [ -e "libtool-2.4.2.tar.gz" ] );then
        wget http://ftpmirror.gnu.org/libtool/libtool-2.4.2.tar.gz
    fi
    
    if ! ( [ -e "zlib-$AD_ZLIB.tar" ] || [ -e "zlib-$AD_ZLIB.tar.gz" ] );then
        wget http://zlib.net/zlib-$AD_ZLIB.tar.gz
    fi
    
    if ! ( [ -e "bzip2-$AD_BZIP.tar" ] || [ -e "bzip2-$AD_BZIP.tar.gz" ] );then
        wget http://www.bzip.org/$AD_BZIP/bzip2-$AD_BZIP.tar.gz
    fi
    
    if ! ( [ -e "libiconv-$AD_LIBICONV.tar" ] || [ -e "libiconv-$AD_LIBICONV.tar.gz" ] );then
        wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-$AD_LIBICONV.tar.gz
    fi
    
    if [ ! -e "pthreads-w32-$AD_PTHREADS-release.zip" ];then
        wget ftp://sourceware.org/pub/pthreads-win32/pthreads-w32-$AD_PTHREADS-release.zip
    fi    

    if ! ( [ -e "pkg-config-$AD_PKGCONFIG.tar" ] || [ -e "pkg-config-$AD_PKGCONFIG.tar.gz" ] );then
        wget http://pkgconfig.freedesktop.org/releases/pkg-config-$AD_PKGCONFIG.tar.gz
    fi
    
    if [ ! -e "boost-jam-"$AD_BOOST_JAM_VERSION".tgz" ]; then
        wget http://sourceforge.net/projects/boost/files/boost-jam/3.1.18/boost-jam-$AD_BOOST_JAM_VERSION.tgz/download
    fi

    if [ ! -e "boost_"$AD_BOOST_VERSION".7z" ]; then
        wget http://sourceforge.net/projects/boost/files/boost/"$AD_BOOST_PATH_VERSION"/boost_"$AD_BOOST_VERSION".7z/download
    fi

    if [ ! -e "libjpeg-turbo-$AD_LIBJPEG_VERSION-gcc64.exe" ];then
        wget http://sourceforge.net/projects/libjpeg-turbo/files/$AD_LIBJPEG_VERSION/libjpeg-turbo-$AD_LIBJPEG_VERSION-gcc64.exe/download
    fi
    
    if ! ( [ -e "fontconfig-$AD_FONT_CONFIG.tar" ] || [ -e "fontconfig-$AD_FONT_CONFIG.tar.gz" ] );then
        wget http://www.freedesktop.org/software/fontconfig/release/fontconfig-$AD_FONT_CONFIG.tar.gz
    fi

    if ! ( [ -e "freetype-$AD_FREETYPE_VERSION.tar" ] || [ -e "freetype-$AD_FREETYPE_VERSION.tar.gz" ] );then
        wget http://ftp.igh.cnrs.fr/pub/nongnu/freetype/freetype-$AD_FREETYPE_VERSION.tar.gz
    fi

    if ! ( [ -e "libpng-$AD_LIBPNG_VERSION.tar" ] || [ -e "libpng-$AD_LIBPNG_VERSION.tar.gz" ] );then
        wget ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng-$AD_LIBPNG_VERSION.tar.gz
    fi

    if ! ( [ -e "zlib-$AD_ZLIB_VERSION.tar" ] || [ -e "zlib-$AD_ZLIB_VERSION.tar.gz" ] );then
        wget http://www.zlib.net/zlib-$AD_ZLIB_VERSION.tar.gz
    fi

    if ! ( [ -e "tiff-$AD_TIFF_VERSION.tar" ] || [ -e "tiff-$AD_TIFF_VERSION.tar.gz" ] );then
        wget ftp://ftp.remotesensing.org/pub/libtiff/tiff-$AD_TIFF_VERSION.tar.gz
    fi
    
    if ! ( [ -e "curl-$AD_LIBCURL_VERSION.tar" ] || [ -e "curl-$AD_LIBCURL_VERSION.tar.bz2" ] );then
        wget http://curl.haxx.se/download/curl-$AD_LIBCURL_VERSION.tar.bz2
    fi
    
    if ! ( [ -e "apr-$AD_APR_VERSION.tar" ] || [ -e "apr-$AD_APR_VERSION.tar.bz2" ] );then
        wget http://mirror.cc.columbia.edu/pub/software/apache/apr/apr-$AD_APR_VERSION.tar.bz2
    fi
    
    if ! ( [ -e "subversion-$AD_SVN_VERSION.tar" ] || [ -e "subversion-$AD_SVN_VERSION.tar.bz2" ] );then
        wget http://mirror.cogentco.com/pub/apache/subversion/subversion-$AD_SVN_VERSION.tar.bz2
    fi
    
    if [ ! -e "git-master.zip" ];then
        wget --no-check-certificate https://github.com/git/git/archive/master.zip -O git-master.zip
    fi
    
    if ! ( [ -e "libsigc++-$AD_LIBSIGC_VERSION.tar" ] || [ -e "libsigc++-$AD_LIBSIGC_VERSION.tar.xz" ] );then
        wget http://ftp.gnome.org/pub/GNOME/sources/libsigc++/$AD_LIBSIGC_PATH_VERSION/libsigc++-$AD_LIBSIGC_VERSION.tar.xz
    fi

    if ! ( [ -e "pixman-$AD_PIXMAN_VERSION.tar" ] || [ -e "pixman-$AD_PIXMAN_VERSION.tar.gz" ] );then
        wget http://www.cairographics.org/releases/pixman-$AD_PIXMAN_VERSION.tar.gz
    fi

    if ! ( [ -e "cairo-$AD_CAIRO_VERSION.tar" ] || [ -e "cairo-$AD_CAIRO_VERSION.tar.xz" ] );then
        wget http://www.cairographics.org/releases/cairo-$AD_CAIRO_VERSION.tar.xz
    fi

    if ! ( [ -e "cairomm-$AD_CAIROMM_VERSION.tar" ] || [ -e "cairomm-$AD_CAIROMM_VERSION.tar.gz" ] );then
        wget http://www.cairographics.org/releases/cairomm-$AD_CAIROMM_VERSION.tar.gz
    fi

    if ! ( [ -e "icu4c-$AD_ICU_VERSION-src.tar" ] || [ -e "icu4c-$AD_ICU_VERSION-src.tgz" ] );then
        wget http://download.icu-project.org/files/icu4c/50.1/icu4c-$AD_ICU_VERSION-src.tgz 
    fi
    
    if [ ! -e "polarssl-$AD_POLAR_VERSION-gpl.tgz" ];then
        wget --no-check-certificate https://polarssl.org/download/polarssl-$AD_POLAR_VERSION-gpl.tgz
    fi
    
    if ! ( [ -e "openssl-$AD_OPENSSL_VERSION.tar" ] || [ -e "openssl-$AD_OPENSSL_VERSION.tar.gz" ] );then
        wget http://www.openssl.org/source/openssl-$AD_OPENSSL_VERSION.tar.gz
    fi

    if ! ( [ -e "libxml2-$AD_LIBXML2_VERSION.tar" ] || [ -e "libxml2-$AD_LIBXML2_VERSION.tar.gz" ] );then
        wget ftp://xmlsoft.org/libxml2/libxml2-$AD_LIBXML2_VERSION.tar.gz 
    fi

    if [ ! -e "expat-$AD_EXPAT_VERSION.tar.gz" ];then
        wget http://sourceforge.net/projects/expat/files/expat/$AD_EXPAT_VERSION/expat-$AD_EXPAT_VERSION.tar.gz/download
    fi
    
    if ! ( [ -e "geos-$AD_GEOS_VERSION.tar" ] || [ -e "geos-$AD_GEOS_VERSION.tar.bz2" ] );then
        wget http://download.osgeo.org/geos/geos-$AD_GEOS_VERSION.tar.bz2
    fi    

    if ! ( [ -e "gdal-$AD_GDAL_VERSION.tar" ] || [ -e "gdal-$AD_GDAL_VERSION.tar.gz" ] );then
        wget http://download.osgeo.org/gdal/gdal-$AD_GDAL_VERSION.tar.gz 
    fi

    if ! ( [ -e "sqlite-autoconf-$AD_SQLITE_VERSION.tar" ] || [ -e "sqlite-autoconf-$AD_SQLITE_VERSION.tar.gz" ] );then
        wget http://www.sqlite.org/sqlite-autoconf-$AD_SQLITE_VERSION.tar.gz
    fi

    if ! ( [ -e "proj-$AD_PROJ_VERSION.tar" ] || [ -e "proj-$AD_PROJ_VERSION.tar.gz" ] );then
        wget http://download.osgeo.org/proj/proj-$AD_PROJ_VERSION.tar.gz
    fi
    
    if ! ( [ -e "libgeotiff-$AD_GEOTIFF_VERSION.tar" ] || [ -e "libgeotiff-$AD_GEOTIFF_VERSION.tar.gz" ] );then
        wget ftp://ftp.remotesensing.org/pub/geotiff/libgeotiff/libgeotiff-$AD_GEOTIFF_VERSION.tar.gz
    fi

    if [ ! -e "proj-datumgrid-$AD_PROJ_GRIDS_VERSION.zip" ];then
        wget http://download.osgeo.org/proj/proj-datumgrid-$AD_PROJ_GRIDS_VERSION.zip
    fi
    
    if [ ! -e "Python-$AD_PYTHON_VERSION.tgz" ];then
    #if ! ( [ -e "python-latest.tar" ] || [ -e "python-latest.tar.bz2" ] );then
        wget http://www.python.org/ftp/python/$AD_PYTHON_VERSION/Python-$AD_PYTHON_VERSION.tgz
        #wget http://hg.python.org/cpython/archive/tip.tar.bz2 -O python-latest.tar.bz2
    fi
    
    if ! ( [ -e "py2cairo-$AD_PYCAIRO_VERSION.tar" ] || [ -e "py2cairo-$AD_PYCAIRO_VERSION.tar.bz2" ] );then
        wget http://www.cairographics.org/releases/py2cairo-$AD_PYCAIRO_VERSION.tar.bz2
    fi
    
    if ! ( [ -e "postgresql-$AD_POSTGRES_VERSION.tar" ] || [ -e "postgresql-$AD_POSTGRES_VERSION.tar.gz" ] );then
        wget http://ftp.postgresql.org/pub/source/v$AD_POSTGRES_VERSION/postgresql-$AD_POSTGRES_VERSION.tar.gz
    fi
    
    #if [ ! -e "occivc9-winx64-111070-133869.zip" ];then
        #wget --no-check-certificate http://download.oracle.com/otn/other/occi/occivc9-winx64-111070-133869.zip
    #fi
    
    if ! ( [ -e "mapnik-v$AD_MAPNIK_VERSION.tar" ] || [ -e "mapnik-v$AD_MAPNIK_VERSION.tar.bz2" ] );then
        wget --no-check-certificate https://github.com/downloads/mapnik/mapnik/mapnik-v$AD_MAPNIK_VERSION.tar.bz2
    fi
}

setupPaths() {
    echo
    echo "Setting up paths..."
    
    if [ ! -e "/home/developer/dependencies" ]; then
        mkdir /home/developer/dependencies
    fi
    
    if [ ! -e "/usr/local" ]; then
        mkdir /usr/local
    fi
    
    if [ ! -e "/usr/local/bin" ]; then
        mkdir /usr/local/bin
    fi
    
    if [ ! -e "/usr/local/include" ]; then
        mkdir /usr/local/include
    fi
    
    if [ ! -e "/usr/local/lib" ]; then
        mkdir /usr/local/lib
    fi  
    
    echo
}

updateFindCommand() {
    echo
    echo "Update Find Command..."

    if ! ls -d findutils-*/ &> /dev/null; then
        if ls findutils-*-bin.tar.lzma &> /dev/null; then
            lzma -d findutils-*-bin.tar.lzma
        fi
        
        tar xvf findutils-*-bin.tar
    fi
    
    cp bin/find.exe /bin
    cp bin/xargs.exe /bin

    echo
}

install7Zip() {
    echo
    echo "Installing 7zip..."
    echo
    
    if ! 7za &> /dev/null; then
        unzip -uo 7za$AD_SEVENZIP.zip
    
        cp 7z* /bin
    else
        echo "Already Installed."        
    fi
    
    echo
}

updateMake() {
    echo "Updating Make..."
    
    unzip -uo make-$MAKE.zip

    echo "Updating make..."

    #cp -rf make-$MAKE/bin_amd64/m* /bin
    cp -rf make-$MAKE/bin_ix86 /bin
}

buildInstallM4() {
    buildInstallGeneric "m4-*" "" "m4" "" "m4 --version"
}

buildInstallAutoconf() {
    export "M4=/bin/m4"
    buildInstallGeneric "autoconf-*" "" "autoconf" "" "autoconf --version"
}

buildInstallAutoMake() {
    buildInstallGeneric "automake-*" "" "automake" "" "automake --version"
}

buildInstallLibtool() {
    buildInstallGeneric "libtool-*" "" "libtool" "" "libtool --version"
}

buildInstallGLibC() {
    buildInstallGeneric "glibc-*" "" "xxx" "" ""
}

buildInstallZlib() {
    echo
    echo "Building zlib..."
    echo
    
    if [ ! -e /mingw/bin/zlib1.dll ]; then
        if ! ls -d zlib-*/ &> /dev/null; then
            tar zxvf zlib-*.tar.gz
        fi

        cd zlib-*

        make -f win32/Makefile.gcc || { stat=$?; echo "make failed, aborting" >&2; exit $stat; }

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
    echo
    echo "Building bzip2..."
    echo
    
    if [ ! -e /mingw/bin/bzip2 ]; then
        if ! ls -d bzip2-*/ &> /dev/null; then
            tar zxvf bzip2-*.tar.gz
        fi

        cd bzip2*

        make || { stat=$?; echo "make failed, aborting" >&2; exit $stat; }

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
    echo
    echo "Building libiconv..."
    echo
    
    if ! ls -d libiconv-*/ &> /dev/null; then
        tar zxvf libiconv-*.tar.gz
    fi
    
    cd libiconv-*
    
    if [ ! -e /mingw/lib/libiconv.dll.a ]; then
        echo "Building Dynamic lib..."
        ./configure --host=x86_64-w64-mingw32 --prefix=/mingw
        make || { stat=$?; echo "make failed, aborting" >&2; exit $stat; } 
        make install-strip || { stat=$?; echo "make failed, aborting" >&2; exit $stat; } 

        if ! iconv --version; then
             echo "Build Failed!"
            exit 0;
        fi
    else
        echo "Dynamic Library Already Installed."        
    fi
    
    if [ ! -e /mingw/lib/libiconv.a ]; then
        echo "Building Static lib..."
        make distclean
        ./configure --host=x86_64-w64-mingw32 --disable-shared --prefix=/mingw
        make || { stat=$?; echo "make failed, aborting" >&2; exit $stat; } 
        make install-strip || { stat=$?; echo "make failed, aborting" >&2; exit $stat; } 
        
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
        if ! ls -d pthreads*/ &> /dev/null; then
            unzip -uo pthreads-w32-2-9-1-release.zip
        fi

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

buildInstallPkgconfig() {
    buildInstallGeneric "pkg-config-*" "--with-internal-glib" "pkg-config" "" "pkg-config --version"
}

installLibJPEG () {
    echo
    echo "Installing libjpeg-turbo..."
    echo

    STOREPATH=`pwd`

    cd /mingw

    DOSPATH=`cmd /c 'echo %CD%'`

    cd $STOREPATH

    if [ ! -e "$DOSPATH/uninstall_1.2.1.exe" ]; then
        cmd /c "libjpeg-turbo-1.2.1-gcc64.exe /S /D=$DOSPATH"
        
        if [ ! -e "$DOSPATH/uninstall_1.2.1.exe" ]; then
            echo "Install failed, aborting"
            exit
        fi
    else
        echo "libjpeg-turbo already installed."
    fi
    
    echo
}

installLibPNG() {
    echo
    echo "Installing libPNG..."
    echo
    
    if [ ! -e /mingw/bin/libpng15-15.dll ]; then
        if ! ls -d libpng-*/ &> /dev/null; then
            tar xzvf libpng-*.tar.gz
        fi

        cd libpng-*

        export "CFLAGS=-I/mingw/include"
        export "LDFLAGS=-L/mingw/lib"

        if [ ! -e Makefile ]; then
            ./configure --host=x86_64-w64-mingw32 --prefix=/mingw
        fi

        make || { stat=$?; echo "make failed, aborting" >&2; exit $stat; }
        make install || { stat=$?; echo "make failed, aborting" >&2; exit $stat; }

        cd ..
    else
        echo "Already Installed."
    fi
    
    echo
}

installLibTiff() {
    buildInstallGeneric "tiff-*" "" "tiffinfo" "" "tiffinfo"
}

buildInstallSigc() {
    buildInstallGeneric "libsigc++-*" "" "libsigc-2.0-0.dll"
}

buildInstallPixman() {
    buildInstallGeneric "pixman-$AD_PIXMAN_VERSION*" "" "libpixman-1.a"
}

buildInstallCairo() {
    buildInstallGeneric "cairo-$AD_CAIRO_VERSION*" "" "libcairo.a"
}

buildInstallCairomm() {
    buildInstallGeneric "cairomm-*" "" "libcairomm-1.0.a"
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
    
    ad_preCleanEnv
    
    export "CC=gcc"
    export "LDFLAGS=$LDFLAGS -lws2_32 -L/mingw/win64bitlibs"
    export "CFLAGS=$CFLAGS -I/mingw/include -DZLIB"
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        ad_decompress "$_project"
        
        cd $_project
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
    
    ad_preCleanEnv
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        ad_decompress "$_project"
        
        local _dir=$(ad_getDirFromWC $_project)
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
    buildInstallGeneric "libxml2-*" "--enable-shared --enable-static --with-icu" "xmllint" "" "xmllint --version"
}

buildInstallCurl() {
    #buildInstallGeneric "curl-*" "--with-polarssl" "libcurl.a" "" "curl --version"
    buildInstallGeneric "curl-*" "" "libcurl.a" "" "curl --version"
}

buildInstallAPR() {
    buildInstallGeneric "apr-*" "" "xxxx" ""
}

buildInstallSVN() {
    buildInstallGeneric "subversion-*" "" "xxxx" ""
}

buildInstallGit() {
    buildInstallGeneric "git-master*" "" "xxxx" ""
}

buildInstallFontConfig() {
    local _project="fontconfig-*"
    local _additionFlags="--enable-libxml2 --disable-docs"
    local _binCheck="fc-list"
    local _exeToTest="fc-list"
    
    echo
    echo "Building $_project..."
    echo
    
    ad_preCleanEnv
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        ad_decompress "$_project"
        
        cd $_project
        
        mkdir -p /mingw/share/fontconfig/conf.avail        
        cp -rf conf.d/*.conf /mingw/share/fontconfig/conf.avail
        
        cd ..
        
        ad_configure "$_project" "$_additionFlags"
        ad_make "$_project"
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
        if ! ls -d freetype-*/ &> /dev/null; then
            tar xzvf freetype-*.tar.gz
        fi

        cd freetype-*

        make setup unix
        ./configure --host=x86_64-w64-mingw32 --prefix=/mingw
        mkdir objs/.libs

        make || { stat=$?; echo "make failed, aborting" >&2; exit $stat; }
        make install -i || { stat=$?; echo "make failed, aborting" >&2; exit $stat; }

        cd ..
    else
        echo "Already Installed."          
    fi
    
    echo
}

buildInstallSQLite() {
    buildInstallGeneric "sqlite-*" "" "libsqlite3.a"
}

buildInstallICU() {
    echo
    echo "Installing ICU..."
    echo
    
    if [ ! -e /mingw/lib/libicui18n.dll ]; then
        if ! ls -d icu*/ &> /dev/null; then
            tar xzvf icu4c-*-src.tgz
        fi

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

        make || { stat=$?; echo "make failed, aborting" >&2; exit $stat; }
        make install || { stat=$?; echo "make failed, aborting" >&2; exit $stat; }
        
        cp -f /mingw/lib/icu*.dll /mingw/bin
        
        local _origPath=`pwd`
        cd /mingw/lib
        ad_rename "./icu.*.dll" "s/^icu/libicu/g"
        cd "$_origPath"
        
        cp /mingw/lib/libicuuc50.dll /mingw/bin/icuuc50.dll || { stat=$?; echo "copy failed, aborting" >&2; exit $stat; }
        cp /mingw/lib/libicudt50.dll /mingw/bin/icudt50.dll || { stat=$?; echo "copy failed, aborting" >&2; exit $stat; }
        cp /mingw/lib/libicuin.dll /mingw/lib/libicui18n.dll || { stat=$?; echo "copy failed, aborting" >&2; exit $stat; }
        cp /mingw/lib/libicudt.dll /mingw/lib/libicudata.dll || { stat=$?; echo "copy failed, aborting" >&2; exit $stat; }
        
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
    buildInstallGeneric "postgresql-*" "" "postgres" "" "postgres --version"
    
    if [ -e /mingw/lib/libpq.dll ]; then
        cp -rf /mingw/lib/libpq.dll /mingw/bin
    fi
}

buildInstallExpat() {
    buildInstallGeneric "expat-*" "" "libexpat.a"
}

buildInstallLibproj() {
    buildInstallGeneric "proj-*" "" "libproj.a"
}

buildInstallProjDatumgrid() {
    echo
    echo "Installing proj-datumgrid..."
    echo
    
    if [ ! -e /mingw/share/proj/ntv1_can.dat ]; then
        if ! ls -d proj-datumgrid*/ &> /dev/null; then
            unzip -uo proj-datumgrid*.zip -d proj-datumgrid
        fi

        cd proj-datumgrid*

        cp -f * /mingw/share/proj

        cd ..
    else
        echo "Already Installed."        
    fi
    
    echo    
}

buildInstallLibGeotiff() {
    buildInstallGeneric "libgeotiff-*" "--enable-shared --enable-incode-epsg" "libgeotiff.dll.a" "" "geotifcp"
    
    buildInstallGeneric "libgeotiff-*" "--enable-static --enable-incode-epsg" "libgeotiff.a" "" "geotifcp"
}

buildInstallLibgeos() {
    buildInstallGeneric "geos-*" "" "libgeos.a" "" ""
}

buildInstallGDAL() {
    buildInstallGeneric "gdal-*" "" "libgdal-1.dll" "" "gdal_grid --version"
}

buildInstallPython() {
    local _project="Python-*"
    local _binCheck="python33"
    local _exeToTest="python33 --version"

    echo
echo "Building $_project..."
    echo
    
    $ad_preCleanEnv
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$ _binCheck" ] );then
        ad_decompress $_project
        
        if ls -d cpython*/ &> /dev/null; then
            mv cpython* python-latest
        fi
        
        cd $_project
        
        if [ ! -e py3k-20121004-MINGW.patch ]; then
            #http://bugs.python.org/issue3754
            #http://bugs.python.org/issue4709
            
            #http://bugs.python.org/issue3871
            #wget http://bugs.python.org/file27474/py3k-20121004-MINGW.patch
            
            #my update
            cp /home/developer/patches/python/3.0.0/py3k-20121227-MINGW.patch .
        fi
        
        ad_patch "py3k-20121227-MINGW.patch"
        
        echo "Executing autoconf..."
        
        autoconf || { stat=$?; echo "autoconf failed, aborting" >&2; exit $stat; }
        
        echo "Executing autoheader..."
        
        autoheader || { stat=$?; echo "autoheader failed, aborting" >&2; exit $stat; }

		echo "Isolating dependencies..."

        if [ ! -e dependencies ]; then
		    mkdir dependencies
            mkdir dependencies/include
            mkdir dependencies/lib
        fi

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
        
        export "CFLAGS=$CFLAGS -IPC -DMS_WIN64 -D__MINGW32__ -Idependencies/include -I/mingw/ssl"
		export "LDFLAGS=$LDFLAGS -Ldependencies/lib"
        
        echo "Using flags: $CFLAGS"
               
        ad_configure "$_project" "--with-universal-archs=64-bit --with-system-expat --enable-loadable-sqlite-extensions build_alias=x86_64-w64-mingw32 host_alias=x86_64-w64-mingw32 target_alias=x86_64-w64-mingw32"      

        ad_make $_project
    else
        echo "Already Installed."
    fi
    
	ad_run_test "$_exeToTest"
}

buildInstallBoostJam() {
    buildInstallGeneric "boost-jam*" "" "bjam" "cp bin.ntx86_64/*.exe /mingw/bin" ""
}

buildInstallBoost() {
    buildInstallGeneric "boost_*" "" "libboost_wave-47-mt-d-1_52.lib" "" ""
}

buildInstallPyCairo() {
    buildInstallGeneric "py2cairo-*" "" "xxx" "" ""
}

buildInstallMapnik() {
    buildInstallGeneric "mapnik-*" "" "xxx" "" ""
}

ad_getDirFromWC() {
    local _project=$1
    echo `find . -maxdepth 1 -name "$_project" -prune -type d`
}

ad_getArchiveFromWC() {
    local _project="$1"
    echo `find . -maxdepth 1 -name "$_project" -prune -type f`
}

ad_rename() {
    local _wildcard="$1"
    local _regex="$2"
    
    echo "Renaming _wildcard=$1, _regex=$2 "
    
    find . -regex "$_wildcard" | while read line; do
        A=`basename ${line} | sed $_regex`
        B=`dirname ${line}`
        
        echo mv ${line} "${B}/${A}"
        mv ${line} "${B}/${A}"
    done
}

ad_fix_shared_lib() {  
    local _origPath=`pwd`
    cd /mingw/lib
    
    local _libraryName=`ls $1*.a|head -1|sed -e 's/dll\.a//' -e 's/\.a//'`
    
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
    
    cd "$_origPath"
}

ad_preCleanEnv() {
    export "CFLAGS=-I/mingw/include"
    export "LDFLAGS=-L/mingw/lib"
    export "CPPFLAGS=-I/mingw/include" 
    export "CRYPTO=POLARSSL"
}

ad_decompress() {
    local _project="$1"
    local _projectDir=$(ad_getDirFromWC "$_project")

    if [ -z $_projectDir ]; then
        local _decompFile=$(ad_getArchiveFromWC $_project)
            
        echo "Decompressing $_decompFile"...
            
        if [ ${_decompFile: -4} == ".tgz" ]; then
            tar xzvf $_decompFile
        elif [ ${_decompFile: -3} == ".gz" ]; then
            gzip -d $_decompFile
        elif [ ${_decompFile: -3} == ".xz" ]; then
            xz -d $_decompFile     
        elif [ ${_decompFile: -4} == ".bz2" ]; then
            bzip2 -d $_decompFile
        elif [ ${_decompFile: -3} == ".7z" ]; then
            7za x $_decompFile 
        elif [ ${_decompFile: -4} == ".zip" ]; then
            unzip $_decompFile 
        fi
        
        _decompFile=$(ad_getArchiveFromWC $_project)
        
        if [ -e "$_decompFile" ]; then
            tar xvf $_decompFile
        fi
    fi
}

ad_patch() {
    local _patchFile=$1
    patch --ignore-whitespace -f -p1 < $_patchFile
}

ad_configure() {
    local _project=$1
    local _additionFlags=$2
    
    local _projectDir=$(ad_getDirFromWC $_project)
    cd $_projectDir
        
    if [ -e "configure" ]; then
        echo
        echo "executing: ./configure --target=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --prefix=/mingw $_additionFlags"
        echo
        ./configure --target=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --prefix=/mingw $_additionFlags
    fi
        
    cd ..
}

ad_make() {
    local _project=$1
    
    local _projectDir=$(ad_getDirFromWC $_project)
    cd $_projectDir
    
    make || { stat=$?; echo "make failed, aborting" >&2; exit $stat; }
    make install || { stat=$?; echo "make failed, aborting" >&2; exit $stat; }
    
    cd ..
}

ad_boost_jam() {
    local _project=$1
    
    local _projectDir=$(ad_getDirFromWC $_project)
    cd $_projectDir
    
    #this is needed for boost https://svn.boost.org/trac/boost/ticket/6350
    cp /home/developer/mingw.jam tools/build/v2/tools
    
   ./bootstrap.sh --with-icu --prefix=/mingw --with-toolset=mingw|| { stat=$?; echo "build failed, aborting" >&2; exit $stat; }
   
    bjam --prefix=/mingw -sICU_PATH=/mingw -sICONV_PATH=/mingw toolset=mingw address-model=64 variant=debug,release link=static,shared threading=multi install
    
    cd ..
}

ad_build() {
    local _project=$1
    
    local _projectDir=$(ad_getDirFromWC $_project)
    cd $_projectDir
    
    ./build.sh  || { stat=$?; echo "build failed, aborting" >&2; exit $stat; }
    
    cd ..
}

ad_exec_script() {
    local _project="$1"
    local _postBuildCommand="$2"
    
    local _projectDir=$(ad_getDirFromWC $_project)
    cd $_projectDir
        
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
            echo "Build Failed!"
            exit 0;
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
    local _additionFlags="$2"
    local _binCheck="$3"
    local _postBuildCommand="$4"
    local _exeToTest="$5"
    
    echo
    echo "Building $_project..."
    echo
    
    ad_preCleanEnv
    
    echo "Checking for binary $_binCheck..."
    if ! ( [ -e "/mingw/lib/$_binCheck" ] || [ -e "/mingw/bin/$_binCheck" ] );then
        local _projectDir=$(ad_getDirFromWC $_project)
        
        ad_decompress "$_project"
        ad_configure "$_project" "$_additionFlags"

        if [ -e "$_projectDir/bootstrap.sh" ]; then
            ad_boost_jam "$_project"
        elif [ -e "$_projectDir/build.sh" ]; then
            ad_build "$_project"
        else
            ad_make "$_project"
        fi
        
        local _result=`echo "$_additionFlags"|grep "\-\-enable\-shared"`
        
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

setupPaths

cd dependencies

download
updateFindCommand
install7Zip
buildInstallPThreads
#Keep the msys M4 for now due to build issues it causes with autoconf
#buildInstallM4
buildInstallAutoconf
buildInstallAutoMake
buildInstallLibtool
buildInstallPkgconfig
#Not ready for mingw64
#buildInstallGLibC
buildInstallZlib
buildInstallBzip2
buildInstallLibiconv
installLibJPEG
installLibPNG
installLibTiff
buildInstallExpat
buildInstallICU
buildInstallSQLite
buildInstallFreeType
buildInstallPolarSSL
buildInstallLOpenSSL
buildInstallLibXML2
buildInstallFontConfig
buildInstallCurl
buildInstallPostgres
buildInstallLibproj
buildInstallProjDatumgrid
buildInstallLibGeotiff
buildInstallSigc
buildInstallPixman
buildInstallCairo
buildInstallCairomm
buildInstallLibgeos
buildInstallGDAL
buildInstallBoostJam
buildInstallBoost
buildInstallPython
#buildInstallPyCairo
#buildInstallMapnik
#buildInstallAPR
#buildInstallSVN
#buildInstallGit

echo
echo "Finished Building Modules."
echo

cd ..