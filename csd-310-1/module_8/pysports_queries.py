#Larissa Passamani Lima Module 8.2
import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "pysports_user",
    "password": "Lari2325!",
    "host": "127.0.0.1",
    "database": "pysports",
    "raise_on_warnings": True
}

try:
    db = mysql.connector.connect(**config)
    
    print("-- DISPLAYING TEAM RECORDS --")
    cursor = db.cursor()
    cursor.execute("SELECT * FROM team")
    teams = cursor.fetchall()
    for row in teams:
        print(f"Team ID: {row[0]}")
        print(f"Team Name: {row[1]}")
        print(f"Mascot: {row[2]}")
        print("")

    print("-- DISPLAYING PLAYER RECORDS --")
    cursor = db.cursor()
    cursor.execute("SELECT * FROM player")
    players = cursor.fetchall()
    for row in players:
        print(f"Player ID: {row[0]}")
        print(f"First Name: {row[1]}")
        print(f"Last Name: {row[2]}")
        print(f"Team ID: {row[3]}")
        print("")

    db.close()

except mysql.connector.Error as err:
    if err .errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The specified database does  exist")
    else:
        print(err)
finally:
    pass
    

input("Press any key to continue...")
