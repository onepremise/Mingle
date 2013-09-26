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
* libtool
* pkgconfig
* zlib
* bzip2
* libiconv
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
* osm2pgsql
* Automation tasks for setting up PostgresDB and importing OSM Data

This build includes python27 with the sqlite3 extention:

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

Extract the contents to disk. Run the setup.bat script in a command prompt with administrative priveleges. Click on the msys shortcut to open a terminal.

Installing Packages
============


You can install more packages at anytime by running mingle in the msys terminal:

```
$ mingle
Welcome to Mingle!

We are going to setup your build environment. Let's get started!

Please Choose from the following:
---------------------------------------------------------------------
 1) Base                            15) Math Libraries
 2) XML Libraries                   16) Graphics Libraries
 3) Font Libraries                  17) Geospatial Libraries
 4) Encryption Libraries            18) Manpik 2.1.0
 5) Networking Libraries            19) Mapnik Developer Release
 6) CA Certs                        20) Mapnik Tools
 7) Database Tools                  21) osm2pgsql
 8) Python Toolkit                  22) All
 9) Perl Toolkit                    23) Create PostGIS DB
10) Text Editors and Converters     24) Import US OSM Data
11) Debugging and Testing           25) Full PostGIS Setup and US Data
12) Boost Libraries                 26) Uninstall PostGIS DB
13) SCM Tools                       27) Quit
14) Image Libraries
#?
```

Consulting
============

* https://www.houghtonassociates.com
* (email) opensource@houghtonassociates.com