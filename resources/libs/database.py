from robot.api.deco import keyword
from pymongo import MongoClient

client = MongoClient('mongodb+srv://lfernandobra_db_user:3LbMgA6lTew3RV7O@cluster0.byu9afx.mongodb.net/?appName=Cluster0')

db = client['markdb']

@keyword('Remove user from database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)

@keyword('Insert user from database')
def insert_user(name, email, password):
    doc = {
        'name': name,
        'email': email,
        'password': password
    }

    users = db['users']
    users.insert_one(doc)
    print('insert user', doc)