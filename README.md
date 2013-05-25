Mingle64
===========

This scripts delpoys a 64bit build environment required by most open source geographic projects, osm2psql, mapnik. libgeos, etc... 

Requirements
============

* Currently Windows 64bit Professional
* Powershell
* Microsoft Visual Studio Express 12 - really only needs macro assembler

The following projects are fully building in the environment setup:

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
* TCL
* ICU
* SQLite
* freetype
* polarssl
* openssl
* libxml2
* fontconfig
* curl
* postgres
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
* waf
* pycairo
* mapnik

This build includes python27 with the sqlite3 extention:

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
