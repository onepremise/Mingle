if [ -e $MINGLE_BASE/mingle/mingle/api/mingle-api.sh ]; then
    source $MINGLE_BASE/mingle/mingle/api/mingle-util.sh
elif [ -e /mingw/lib/mingle/api/mingle-util.sh ]; then
    source /mingw/lib/mingle/api/mingle-util.sh
else
    echo
    echo ERROR: Unable to find mingle-util, required to build and install packages!
    echo
    exit 9999
fi

OPTIONS=

mingleInitSelections() {
    OPTIONS=(\
    "base|Base|suiteBase" \
    "xml|XML Libraries|suiteXML" \
    "json|JSON Libraries|suiteJSON" \
    "font|Font Libraries|suiteFonts" \
    "enc|Encryption Libraries|suiteEncryption" \
    "net|Networking Libraries|suiteNetworking" \
    "cert|CA Certs|suiteCABundle" \
    "db|Database Tools|suiteDatabase" \
    "py|Python Toolkit|suitePython" \
    "perl|Perl Toolkit|suitePerl" \
    "java|Java JDK|suiteJava" \
    "text|Text Editors and Converters|suiteTextEditorsConvertors" \
    "util|Shell Utilities|suiteUtilities" \
    "debug|Debugging and Testing|suiteDebugTest" \
    "boost|Boost Libraries|suiteBoost" \
    "scm|SCM Tools|suiteSCMTools" \
    "img|Image Libraries|suiteImageTools" \
    "math|Math Libraries|suiteMathLibraries" \
    "grafx|Graphics Libraries|suiteGrpahicLibraries" \
    "ui|UI Libraries|suiteUILibraries" \
    "mm|Multimedia - codecs, encoders, converters, etc...|suiteMultimedia" \
    "geo|Geospatial Libraries|suiteGeoSpatialLibraries" \
    "map|Manpik 2.1.0|suiteMapnik" \
    "mapdev|Mapnik Developer Release|suiteMapnik true" \
    "maptools|Mapnik Tools|suiteMapnikTools" \
    "osm2pgsql|osm2pgsql|suiteOSM2PTSQL" \
    "all|All|suiteAll" \
    "pgisDB|Create PostGIS DB|initializePostGISDB" \
    "usosm|Import US OSM Data|importOSMUSData" \
    "fullpgis|Full PostGIS Setup and US Data|fullPostGISSetupWithImport" \
    "unpgis|Uninstall PostGIS DB|uninstallPostgresql" \
    "sim|Simulation|suiteSimulation" \
    "cc|Cryptocurrency|suiteCryptoCurrency" \
    "q|Quit")
}

mingleGetDescByKey() {
    local _keyToFind=$1
    local addr=''
    local _i=0
    local _j=0
    
    mingleInitSelections

    # get length of an array
    tLen=${#OPTIONS[@]}
     
    # use for loop read all options
    for (( _i=0; _i<${tLen}; _i++ ));
    do
      IFS='|'
      read -ra addr <<< "${OPTIONS[$_i]}"
      local _key="${addr[0]}"
      local _value="${addr[1]}"
      IFS=' '
      
      if [ "$_keyToFind" == "$_key" ]; then
          echo "$_value"
          break
      fi
    done
}

mingleGetFuncFromKey() {
    local _keyToFind=$1
    local addr=''
    local _i=0
    local _j=0
    
    mingleInitSelections

    # get length of an array
    tLen=${#OPTIONS[@]}
     
    # use for loop read all options
    for (( _i=0; _i<${tLen}; _i++ ));
    do
      IFS='|'
      read -ra addr <<< "${OPTIONS[$_i]}"
      local _key="${addr[0]}"
      local _value="${addr[2]}"
      IFS=' '
      
      if [ $_keyToFind == $_key ]; then
          echo "$_value"
          break
      fi
    done
}

mingleGetSelections() {
    local _keysonly=''
    local addr=''
    
    # get length of an array
    tLen=${#OPTIONS[@]}
     
    # use for loop read all options
    for (( _i=0; _i<${tLen}; _i++ ));
    do
      IFS='|'
      read -ra addr <<< "${OPTIONS[$_i]}"
      _keysonly="$_keysonly ${addr[0]}"
      IFS=' '
    done
    
    echo $_keysonly
}

mingleGetMaxSetting() {
    mingleInitSelections
    tLen=${#OPTIONS[@]}
    exit $tLen
}

minglePrintSelection() {
    local _selection=$1
    local _desc=''
    
    _desc=$(mingleGetDescByKey $_selection)
    
    if [ -z "$_desc" ]; then
       return 1
    fi
    
    echo $_desc
    
    return 0
}

minglePrintSelections() {
    local _i=0
    local _j=0
    local addr=''
    local key=''
    local value=''
    
    mingleInitSelections
    
    echo

    # get length of an array
    tLen=${#OPTIONS[@]}
     
    # use for loop read all options
    for (( _i=0; _i<${tLen}; _i++ ));
    do
      IFS='|'
      read -ra addr <<< "${OPTIONS[$_i]}"
      local _key="${addr[0]}"
      local _value="${addr[1]}"
      IFS=' '
      
      #echo "$((_i+1))) ${OPTIONS[$_i]}"
      printf "%-10s %s\n" "$_key)" "$_value"
    done

    echo
}

mingleProcessSelectionNum() {
    local _s=$1

    mingleInitSelections
    
    local _selections=$(mingleGetSelections)

    if array_contains _selections "$_s"; then
        mingleProcessSelection "$_s"
    elif [ -z "$_s" ]; then
        echo
        echo "Please Choose from the following:"
        echo "---------------------------------------------------------------------"
        minglePrintSelections
    else
        echo "Invalid selection, $_s. Please Choose from the following:"
        echo "---------------------------------------------------------------------"
        minglePrintSelections
        return 1
    fi

    return 0
}

mingle_print_welcome() {
    echo
    echo "Welcome to Mingle!"
    echo
    echo "We are going to setup your build environment. Let's get started!"
    echo
    echo "Please Choose from the following:"
    echo "---------------------------------------------------------------------"
}

mingle_show_help() {
    echo "Usage mingle [OPTION]"
    echo "Deployment script for setting up the development environment in 64 bit MinGW."
    echo
    echo "Arguments:"
    echo "  -h, --help      Show this menu."
    echo "  -s, --suite=key Deploy the suite specified by the selected suite below:"
    echo "  -l, --list      List suites of software to choose from."
    echo "  -k, --lookup    Lookup suite name from key value."
    echo "  -e, --exclude   Exclude dependency checks during build."
    echo "  -p, --path=PATH Use alternate path for build."
    echo "  -m              Get max suite count."

    mingle_print_welcome
    minglePrintSelections
}

mingleMenu() {
    local _s

    mingle_print_welcome
    mingleInitSelections
    minglePrintSelections
    
    while true; do
      read -p "#?" _s
      mingleProcessSelectionNum $_s
    done
}

mingleProcessSelection() {
    local _suite="$1"
    local _selections=$(mingleGetSelections)

    if [ "$_suite" != "q" ]; then
        if array_contains _selections "$_suite"; then
            mingleInitialize
            echo
            echo "Preparing suite $_suite..."
            echo
            local _function=$(mingleGetFuncFromKey $_suite)
            
            eval ${_function}
        else
            echo
	    echo "Invalid option. Try another one."
            minglePrintSelections
        fi
    else
        exit 0
    fi

    if [ ! -z "$_suite" ] && [ "$_suite" != "NONE" ] && [ "$_suite" != "q" ]; then
        mingleCleanup
    fi
}

if [ -n "$MINGLE_SYNTAX_CHECK" ]; then
    return;
fi

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
    -k | --lookup)
        minglePrintSelection $2
        exit $?
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