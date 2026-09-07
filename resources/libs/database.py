from robot.api.deco import keyword
from pymongo import MongoClient

client = MongoClient('mongodb://127.0.0.1:27017/')

db = client['markdb']

@keyword('Remove User From Database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)

@keyword('Insert User From Database')
def insert_user(user):
    # doc = {
    #     'name': name,
    #     'email': email,
    #     'password': password
    # }

    users = db['users']
    users.insert_one(user)
    print('insert user', user)