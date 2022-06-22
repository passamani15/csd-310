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

# update student data for 1007
result = students.update_one({"id": 1007}, {"$set": {"last_name": "Passsamani"}})

doc = students.find_one({"id": 1007})

print("-- DISPLAING STUDENT DOCUMENT FROM find_one() QUERY --")
id = doc["id"]
first_name = doc["first_name"]
last_name = doc["last_name"]
print(f"Student ID: {id}")
print(f"First Name: {first_name}")
print(f"Last Name: {last_name}")

print("\n\n")

x = input("End of Program, press any key to continue...")