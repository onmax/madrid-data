#!/usr/bin/env python3

import sys
import os
import sqlite3
import random

db_name = "madrid-data.db"

if os.path.exists(db_name):
    os.remove(db_name)

con = sqlite3.connect(db_name)
cur = con.cursor()

to_db = {"subway": [], "bus": [], "train": []}
[cur.execute("CREATE TABLE IF NOT EXISTS {0} (id, lat, lon, name, nvotes, valoration);"
             .format(i)) for i in to_db]

for line in sys.stdin:
    row = line[:-1].split(",", 6)
    if(row[3][0] == "@"):
        continue
    row.append(random.randrange(1,10000))
    row.append(round(random.random() * 10, 2))
    to_db[list(to_db)[[i for i, e in enumerate(row[0:3]) if e != ''][0]]].append(
        row[3:])

for transport in to_db:
    cur.executemany("INSERT INTO {0}(id, lat, lon, name, nvotes, valoration) VALUES(?, ?, ?, ?, ?, ?)".format(
        transport), to_db[transport])

con.commit()
con.close()
