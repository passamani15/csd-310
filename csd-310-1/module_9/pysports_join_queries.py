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

    print("-- DISPLAYING PLAYER RECORDS --")

    cursor = db.cursor()
    cursor.execute("""
        Select player_id, first_name, last_name, team_name
        FROM player
        INNER JOIN team ON player.team_id = team.team_id
        """)
    players = cursor.fetchall()
    for row in players:
        print(f"Player ID: {row[0]}")
        print(f"First Name: {row[1]}")
        print(f"Last Name: {row[2]}")
        print(f"Team Name: {row[3]}")
        print("")


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
