import pymongo

myclient = pymongo.MongoClient("mongodb+srv://admin:admin@cluster0.lp411.mongodb.net/pytech")
mydb = myclient["pytech"]
students = mydb["students"]

table_data = []

table_data.append({ "id": 1007, "first_name": "Torin", "last_name": "Oakenshield"})
table_data.append({ "id": 1008, "first_name": "Bilbo", "last_name": "Baggins"})
table_data.append({ "id": 1009, "first_name": "Frodo", "last_name": "Baggins"})

for new_student_object in table_data:
    new_student_Id = students.insert_one(new_student_object).inserted_id
    first_name = new_student_object["first_name"]
    last_name = new_student_object["last_name"]
    print(f"Inserted student record {first_name} {last_name} into the students collection with document_id {new_student_Id}")


