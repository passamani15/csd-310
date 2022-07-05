#Larissa Passamani Lima / Assignment 9.3
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

    # insert a new record into the player table for Team Gandalf. 
    cursor = db.cursor()
    cursor.execute("""
        INSERT INTO player (first_name, last_name, team_id) 
        VALUES ('Smeagol', 'Shire Folk', 1)
    """)
    db.commit()

    print("-- DISPLAYING PLAYER AFTER INSERT --")

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

    # update player
    cursor = db.cursor()
    cursor.execute("""
        UPDATE player
        SET team_id = 2,
            first_name = 'Gollum',
            last_name = 'Ring Stealer'
        WHERE first_name = 'Smeagol'
    """)
    db.commit()


    print("-- DISPLAYING PLAYER AFTER UPDATE --")

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

    # delete records
    cursor = db.cursor()
    cursor.execute("""
        DELETE FROM player      
        WHERE first_name = 'Gollum'
    """)
    db.commit()

    print("-- DISPLAYING PLAYER AFTER DELETE --")

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