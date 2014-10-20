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

testPrefixReplace() {
    local _options="--prefix=/mingw --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32"
    local _additionalFlags="--prefix=/test"

    ad_remove_old_prefix_if_new "$_options" "$_additionalFlags"

    _options=$(ad_remove_old_prefix_if_new "$_options" "$_additionalFlags")

    mingleLog "ad_remove_old_prefix_if_new = $_options" true

    if [ "--host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32" == "$_options" ]; then
        mingleLog "Test pass." true
    else
        mingleError $? "ERROR: option wasn't removed properly!"
    fi
}

testPrefixReplace
