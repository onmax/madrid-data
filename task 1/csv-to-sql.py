#!/usr/bin/env python3

import sys, os
import sqlite3

db_name = "stops.db"

'''
if os.path.exists(db_name):
  os.remove(db_name)
'''

con = sqlite3.connect(db_name)
cur = con.cursor()
cur.execute("CREATE TABLE {0} (id, lat, lon, name);".format(sys.argv[1]))

to_db = []
for line in sys.stdin:
    if(line[0] != "@"):
        to_db.append(line.split(",", 3))
    
cur.executemany("INSERT INTO {0} (id, lat, lon, name) VALUES (?, ?, ?, ?);".format(sys.argv[1]), to_db)
con.commit()
con.close()
