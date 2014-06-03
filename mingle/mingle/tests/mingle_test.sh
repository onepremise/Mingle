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
export MINGLE_BUILD_DIR=/home/dev/build/test
export MINGLE_CACHE=$MINGLE_BUILD_DIR/packages

if [ -e $MINGLE_BASE/mingle/mingle/api/mingle-api.sh ]; then
    source $MINGLE_BASE/mingle/mingle/api/mingle-api.sh
    if [ $? -ne 0 ]; then
        mingleError $? "mingle-api.sh failed to load without errors!"
    fi
else
    echo
    echo "ERROR: Unable to find mingle-api, required to build and install packages!"
    echo
    exit 9999
fi

testMingleSyntax() {
    mingleLog "Checking script syntax." true
    
    export MINGLE_SYNTAX_CHECK=1

    if [ -e $MINGLE_BASE/mingle/mingle/api/mingle-api.sh ]; then
        source $MINGLE_BASE/mingle/mingle.sh
        
        mingleThrowIfError $? "mingle.sh failed to load without errors!"
    else
        mingleError $? "ERROR: Unable to find mingle.sh!"
    fi
    
    unset MINGLE_SYNTAX_CHECK
    
    mingleLog "Test pass." true
}

testDownloadDecompress() {
    mingleLog "Testing downloading and decompression." true
    
    #cd
    #rm -rf $MINGLE_BUILD_DIR
    #ad_mkdir $MINGLE_BUILD_DIR
    
    cd $MINGLE_BUILD_DIR
    
    echo test>test.txt
    zip mingletest-1.0.zip test.txt
    rm test.txt
    
    ad_mkdir "$MINGLE_CACHE/mingletest/1.0"
    mv -f mingletest-1.0.zip "$MINGLE_CACHE/mingletest/1.0"
    
    mingleCategoryDecompress "mingletest" "1.0" "mingletest-*"
    
    if [ ! -e "$MINGLE_BUILD_DIR/test.txt" ]; then
        mingleError $? "Failed to extract correctly!"
    fi
    
    mingleDownload "https://vanguard.houghtonassociates.com/artifact/MINGLE-MINGLE64/shared/build-165/64-bit-Mingle-SDK/mingle-light.zip"
    mingleDecompress "mingle-light.*"
    
    mingleCategoryDownload "mingle" "1.0" "https://vanguard.houghtonassociates.com/artifact/MINGLE-MINGLE64/shared/build-165/64-bit-Mingle-SDK/mingle-light.zip"
    mingleCategoryDecompress "mingle" "1.0" "mingle-light.*"
    mingleCategoryDecompress "mingle" "1.0" "mingle-light.*" "test2"
    
    if [ -e "$MINGLE_BUILD_DIR/test2/setup.bat" ]; then
        mingleLog "Test pass."
    else
        mingleError $? "Failed to extract correctly!"
    fi
}

testExampleBuild() {
    mingleLog "Testing example build." true
    
    cd $MINGLE_BUILD_DIR
    
    if [ -e /bin/7za.exe ]; then 
        rm /bin/7za.exe
    fi
        
    install7Zip
    
    if [ ! -e "/bin/7za.exe" ]; then
        mingleError $? "Failed to build example correctly!"
    fi 
    
    if [ ! -e libmingle ]; then
        cp -rf $MINGLE_BASE/mingle/libmingle .
    fi
    buildInstallGeneric "libmingle" false false "" false false "" "" "ignorexxxx" "" ""
    
    if [ -e "/mingw/lib/libmingle.a" ]; then
        mingleLog "Test pass."
    else
        mingleError $? "Failed to build example correctly!"
    fi
}

testMingleSyntax
testDownloadDecompress
testExampleBuild