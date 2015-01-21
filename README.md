Mingle64
===========

This scripts delpoys a 64bit build environment required by most open source geographic projects, osm2psql, mapnik. libgeos, etc... 

Requirements
============

* Windows 7 64bit Professional, Windows Server 2008 64bit
* Powershell
* Microsoft Visual Studio Express 12 - really only needs macro assembler

Features
============

* Full 64 bit environment
* Automatically sets up  build environment for Windows 7+ and Server 2008+
* Integrates with Eclipse
* Log details how to build open source projects using a MinGW 64bit environment

The following projects are fully building in the environment setup:

* gmp
* mpfr
* mpc
* pthreads
* autoconf
* automake
* argTable
* libtool
* pkgconfig
* zlib
* bzip2
* gperf
* libiconv
* yasm
* libjpeg-turbo
* libpng
* libtiff
* expat
* Tcl/Tk
* ICU
* freetype
* polarssl
* openssl
* libxml2
* fontconfig
* textinfo
* libmicrohttpd
* curl
* curl - ca-bundle.crt
* Google Protobuf
* Google Protobuf-c
* SQLite
* Postgres
* Berkeley DB
* Perl
* Perl - SVN
* Perl - CPANMinus, Encode, LWP, DBPerl, DBFile
* PCRE
* SVN
* Git
* Git - ca-bundle.crt
* Git-SVN
* textinfo
* gettext
* cpio
* libproj
* projdatumgrid
* libgeotiff
* sigc
* pixman
* cairo
* cairomm
* libgeos
* libgdal
* boostjam
* boost
* python2.7.3
* python3.3 (Very Experimental)
* Scons
* Serf
* GDB w/python debugger
* CUnit
* waf
* apr
* apr-util
* swig
* pycairo
* mapnik
* postgis
* osm2pgsql
* Automation tasks for setting up PostgresDB and importing OSM Data
* OpenFTA
* FFmpeg
* PJSIP
* SDL
* QT
* qrencode
* Miniupnp
* Bitcoin-qt
* Pooler's cpuminer
* Ethereum

This build includes python27 with the sqlite3 extension:

```
$ python
Python 2.7.0 (default, Dec 28 2012, 15:10:41) [gcc] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import sqlite3
>>> sqlite3.version
'2.6.0'
>>> sqlite3.sqlite_version
'3.7.15'
>>>
>>> con=sqlite3.connect(':memory:')
>>> with con:
...     cur = con.cursor()
...     cur.execute("CREATE TABLE Friends(Id INTEGER PRIMARY KEY, Name TEXT);")
...
<sqlite3.Cursor object at 0x0000000002A35EA0>
```

Download
============

Download is available directly from GitHub:

https://github.com/onepremise/Mingle/archive/master.zip

You can also download mingle from our build machine:

https://vanguard.houghtonassociates.com/browse/MINGLE-MINGLE64/latest

Click the "64 bit Mingle SDK" link under "Artifacts". You should see two packages:

mingle-light.zip: Without binaries.
mingle.zip: With binaries.

Setup
============

Extract the contents to disk. Run the setup.bat script in a command prompt with administrative privileges. Click on the msys shortcut to open a terminal.

Installing Packages
============


You can install more packages at anytime by running mingle in the msys terminal:

```
$ mingle --help
Usage mingle [OPTION]
Deployment script for setting up the development environment in 64 bit MinGW.

Arguments:
  -h, --help      Show this menu.
  -s, --suite=key Deploy the suite specified by the selected suite below:
  -l, --list      List suites of software to choose from.
  -k, --lookup    Lookup suite name from key value.
  -e, --exclude   Exclude dependency checks during build.
  -p, --path=PATH Use alternate path for build.
  -m              Get max suite count.

Welcome to Mingle!

We are going to setup your build environment. Let's get started!

Please Choose from the following:
---------------------------------------------------------------------

base)      Base
xml)       XML Libraries
font)      Font Libraries
enc)       Encryption Libraries
net)       Networking Libraries
cert)      CA Certs
db)        Database Tools
py)        Python Toolkit
perl)      Perl Toolkit
java)      Java JDK
text)      Text Editors and Converters
util)      Shell Utilities
debug)     Debugging and Testing
boost)     Boost Libraries
scm)       SCM Tools
img)       Image Libraries
math)      Math Libraries
grafx)     Graphics Libraries
ui)        UI Libraries
mm)        Multimedia - codecs, encoders, converters, etc...
geo)       Geospatial Libraries
map)       Manpik 2.1.0
mapdev)    Mapnik Developer Release
maptools)  Mapnik Tools
osm2pgsql) osm2pgsql
all)       All
pgisDB)    Create PostGIS DB
usosm)     Import US OSM Data
fullpgis)  Full PostGIS Setup and US Data
unpgis)    Uninstall PostGIS DB
sim)       Simulation
cc)        Cryptocurrency
q)         Quit
```

Consulting
============

* https://www.houghtonassociates.com
* (email) opensource@houghtonassociates.com