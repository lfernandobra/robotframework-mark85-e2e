from robot.api.deco import keyword
from pymongo import MongoClient
import bcrypt

client = MongoClient('mongodb+srv://lfernandobra_db_user:3LbMgA6lTew3RV7O@cluster0.byu9afx.mongodb.net/?appName=Cluster0')

db = client['markdb']

@keyword('Clean User From Database')
def clean_user(user_email):
    users = db['users']
    tasks = db['tasks']

    u = users.find_one({'email': user_email})

    if(u):
        tasks.delete_many({'user': u['_id']})
        users.delete_many({'email': user_email})

@keyword('Remove User From Database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)

@keyword('Insert User From Database')
def insert_user(user):
    hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))
    doc = {
        'name': user['name'],
        'email': user['email'],
        'password': hash_pass
    }

    users = db['users']
    users.insert_one(doc)
    print('insert user', user)