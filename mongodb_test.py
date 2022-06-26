#Larissa Passamani Lima
#Module5.2
import pymongo
url = "mongodb+srv://admin:admin@cluster0.lp411.mongodb.net/?retryWrites=true&w=majority"
myclient = pymongo.MongoClient("mongodb+srv://admin:admin@cluster0.lp411.mongodb.net/?retryWrites=true&w=majority")
db = myclient.pytech
print(db.list_collection_names())

