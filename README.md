MinGW-AD64S
===========

This scripts delpoys a 64bit build environment required by most open source geographic projects, osm2psql, mapnik. libgeos, etc...

This build includes python33 with the sqlite3 extention:

$ python33
Python 3.3.0 (default, Dec 28 2012, 15:10:41) [gcc] on win32
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