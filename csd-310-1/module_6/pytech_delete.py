import pymongo

myclient = pymongo.MongoClient("mongodb+srv://admin:admin@cluster0.lp411.mongodb.net/pytech")
mydb = myclient["pytech"]
students = mydb["students"]

docs = students.find({})
print("-- DISPLAYING STUDENTS DOCUMENTS FROM find() QUERY --")
for doc in docs:
    id = doc["id"]
    first_name = doc["first_name"]
    last_name = doc["last_name"]
    print(f"Student ID: {id}")
    print(f"First Name: {first_name}")
    print(f"Last Name: {last_name}")
    print("")

# insert data
table_data = []
print("-- INSERT STATEMENTS --")
table_data.append({ "id": 1010, "first_name": "Torin", "last_name": "Oakenshield"})

for new_student_object in table_data:
    new_student_Id = students.insert_one(new_student_object).inserted_id
    id = new_student_object["id"]
    first_name = new_student_object["first_name"]
    last_name = new_student_object["last_name"]
    print(f"Inserted student record {id} into the students collection with document_id {new_student_Id}")

print("")
docs = students.find({})
print("-- DISPLAYING NEW STUDENT LIST DOC --")
for doc in docs:
    id = doc["id"]
    first_name = doc["first_name"]
    last_name = doc["last_name"]
    print(f"Student ID: {id}")
    print(f"First Name: {first_name}")
    print(f"Last Name: {last_name}")
    print("")

# delete
students.delete_one({"id": 1010})

docs = students.find({})
print("-- DELETED STUDENT ID: 1010 --")
for doc in docs:
    id = doc["id"]
    first_name = doc["first_name"]
    last_name = doc["last_name"]
    print(f"Student ID: {id}")
    print(f"First Name: {first_name}")
    print(f"Last Name: {last_name}")
    print("")

print("\n\n")

x = input("End of Program, press any key to continue...")