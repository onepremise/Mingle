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
* curl
* SQLite
* Postgres
* Berkeley DB
* Perl
* PCRE
* SVN
* Git
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
* GDB w/python debugger
* CUnit
* waf
* apr
* apr-util
* swig
* pycairo
* mapnik

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
1) Base                       10) Image Libraries
2) XML Libraries              11) Math Libraries
3) Font Libraries             12) Graphics Libraries
4) Encryption Libraries       13) Geospatial Libraries
5) Networking Libraries       14) Manpik 2.1.0
6) Database Tools             15) Mapnik Developer Release
7) Python Tools               16) Manpik Tools
8) Debugger                   17) All
9) Boost Libraries            18) Quit
#?
```

Consulting
============

* https://www.houghtonassociates.com
* (email) opensource@houghtonassociates.com