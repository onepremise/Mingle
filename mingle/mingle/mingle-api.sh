MINGLE_INITIALIZE=false

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

ad_getLocalDirFromWC() {
    local _project="$1"
    local _result=`find . -maxdepth 1 -name "$_project" -prune -type d -print | head -1`

    echo "$_result"
}

ad_getDirFromWC() {
    local _project="$1"
    local _result=`find $MINGLE_BUILD_DIR -maxdepth 1 -name "$_project" -prune -type d -print | head -1`

    echo "$_result"
}

ad_getLocalArchiveFromWC() {
    local _project="$1"
    local _result=`find . -maxdepth 1 -name "$_project" -prune -type f -print | head -1`

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

ad_generateImportLibraryForDLL() {
    local _dll=$1
    local _importName=`echo $_dll|sed 's/\.dll//'`
    local _searchPath=''
    
    echo
    echo "Generate Import Library..."
    echo    
    
    if ! echo $_dll|grep '^lib' ; then
        _importName="lib$_importName"
    fi
    
    if [ -e /mingw/lib/$_dll ]; then
        _searchPath=/mingw/lib
    else
        _searchPath=/mingw/bin
    fi
    
    echo
    echo "Generating import library for dll: $_dll, import library: $_importName.a..."
    
    pexports $_searchPath/$_dll |sed "s/^_//">$_importName.def || mingleError $? "ad_generateImportLibraryForDLL failed to pexport $_importName.a, aborting"
    dlltool -U -d $_importName.def -l $_importName.a || mingleError $? "ad_generateImportLibraryForDLL failed to generate def file for $_importName.a, aborting"
    mv $_importName.a /mingw/lib || mingleError $? "ad_generateImportLibraryForDLL failed to generate $_importName.a, aborting"
}

ad_clearEnv() {
    echo
    echo "Resetting environment flags..."
    echo

    unset PKG_CONFIG_PATH; unset CFLAGS; unset LDFLAGS; unset CPPFLAGS; unset CRYPTO; unset CC; unset LIBS

    cd $MINGLE_BUILD_DIR
}

ad_setDefaultEnv() {
    echo
    echo "Resetting environment flags to default..."
    echo

    export "PKG_CONFIG_PATH=/mingw/lib/pkgconfig"
    #for debugging: CFLAGS=-g -fno-inline -fno-strict-aliasing
    export "CFLAGS=-I/mingw/include -D_WIN64 -D__WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO"
    export "LDFLAGS=-L/mingw/lib"
    export "CPPFLAGS=-I/mingw/include  -D_WIN64 -D__WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO"
    export "CRYPTO=POLARSSL"
    export "CC=x86_64-w64-mingw32-gcc"
    unset LIBS

    cd $MINGLE_BUILD_DIR
}

ad_patch() {
    local _patchFile=$1
    local _workingDir=`pwd`
    
    echo
    echo "Patching..."
    echo

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
    
    echo
    echo "Configuring..."
    echo
    
    local _projectDir=$(ad_getDirFromWC "$_project")

    cd $_projectDir || mingleError $? "ad_configure cd failed, aborting!"
    
    if [ -e "./libtool" ]; then
        echo "Adjusting libtool LTCC setting"
        sed 's/\(LTC[CFLAGS]*=.*\)\s\-I.mingw.include.mingle/\1/g' ./libtool>libtool2
        mv -f libtool2 libtool
    fi
    
    if [ -e "autogen.sh" ]; then
        echo "Autgen.sh script found, executing script..."
        ./autogen.sh
    elif [ -e "configure.ac" ] || [ -e "configure.in" ]; then
        if [ -e "/mingw/bin/autoconf" ];then
            echo

            if $_runACLocal; then
                echo "Executing aclocal $_aclocalFlags..."
                
                if [ -n "$_aclocalFlags" ]; then
                    aclocal $_aclocalFlags || mingleError $? "ad_configure aclocal failed, aborting!"
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
        
        if [ ! -e "/tmp" ]; then
            mkdir /tmp || mingleError $? "failed to create tmp, aborting!"
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
    local _localDir="$2"
    local _projectDir=""
    local _decompFile=""
    local _tarcheck=false
    
    if [ -n "$_localDir" ]; then
        _projectDir=$(ad_getLocalDirFromWC "$_project")
    else
        _projectDir=$(ad_getDirFromWC "$_project")
    fi
    
    if [ -z "$_projectDir" ]; then
        _decompFile=$(ad_getArchiveFromWC "$_project")

        if [ ! -e "$_decompFile" ]; then
            mingleError $? "Failed to find archive for: $_project, aborting!"
        fi

        if [ -z "$_localDir" ]; then
            cd $MINGLE_BUILD_DIR
        fi
            
        echo "Decompressing $_decompFile"...
            
        if [ ${_decompFile: -4} == ".tgz" ]; then
            tar xzvf "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
        elif [ ${_decompFile: -3} == ".gz" ]; then
            gzip -d "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
            _tarcheck=true
        elif [ ${_decompFile: -3} == ".xz" ]; then
            xz -d "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
            _tarcheck=true
        elif [ ${_decompFile: -4} == ".bz2" ]; then
            bzip2 -d "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
            _tarcheck=true
        elif [ ${_decompFile: -3} == ".7z" ]; then
            7za x "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
        elif [ ${_decompFile: -4} == ".zip" ]; then
            unzip -q -n "$_decompFile"
            local _result=$?
	    if ! ( [ "$_result" == 0 ] || [ "$_result" == 3 ] );then
                echo _result=$_result
                mingleError $? "Decompression failed for $_decompFile, aborting!"
            fi
        elif [ ${_decompFile: -5} == ".lzma" ]; then
            lzma -d "$_decompFile" || mingleError $? "Decompression failed for $_decompFile, aborting!"
            _tarcheck=true
        elif [ "${_decompFile: -4}" == ".tar" ]; then
            tar xvf "$_decompFile" || mingleError $? "Failed to unarchive $_decompFile, aborting!"
        fi
        
        if $_tarcheck; then
            _decompFile=$(ad_getLocalArchiveFromWC "$_project")
        
            if [ "${_decompFile: -4}" == ".tar" ]; then
                tar xvf "$_decompFile" || mingleError $? "Failed to unarchive extracted $_decompFile, aborting!"
            fi
        fi
    fi
}

mingleCleanup() {
    cd "$STOREPATH"

    echo
    echo "Finished Building Modules."
    echo
}