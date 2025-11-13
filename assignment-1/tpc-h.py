import duckdb

con = duckdb.connect("tpc-h.db")

con.execute("INSTALL tpch;")
con.execute("LOAD tpch;")

# Create schema + sample data
con.execute("CALL dbgen(sf=0.1);")

# Verify tables
print(con.execute("SHOW TABLES").fetchall())
