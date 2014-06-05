OPTIONS=

mingleGetSelections() {
    OPTIONS=("Base" "XML Libraries" "Font Libraries" "Encryption Libraries" "Networking Libraries" "CA Certs" "Database Tools" "Python Toolkit" "Perl Toolkit" "Text Editors and Converters" "Debugging and Testing" "Boost Libraries" "SCM Tools" "Image Libraries" "Math Libraries" "Graphics Libraries" "Geospatial Libraries" "Manpik 2.1.0" "Mapnik Developer Release" "Mapnik Tools" "osm2pgsql" "All" "Create PostGIS DB" "Import US OSM Data" "Full PostGIS Setup and US Data" "Uninstall PostGIS DB" "Simulation" "Quit")
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
    "CA Certs")
        suiteCABundle
        ;;
    "Database Tools")
        suiteDatabase
        ;;
    "Python Toolkit")
        suitePython
        ;;
    "Perl Toolkit")
        suitePerl
        ;;
    "Debugging and Testing")
        suiteDebugTest
        ;;
    "Boost Libraries")
        suiteBoost
        ;;
    "Text Editors and Converters")
        suiteTextEditorsConvertors
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
    "osm2pgsql")
        suiteOSM2PTSQL
        ;;
    "All")
        suiteAll
        break
        ;;
    "Create PostGIS DB")
        initializePostGISDB
        #installPostgresqlService
        break
        ;;
    "Import US OSM Data")
        importOSMUSData
        break
        ;;
    "Full PostGIS Setup and US Data")
        fullPostGISSetupWithImport
        break
        ;;
    "Uninstall PostGIS DB")
        uninstallPostgresql
        break
        ;;
    "Simulation")
        suiteSimulation
        ;;
    "Quit")
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