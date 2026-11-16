import os
import bcrypt
from pymongo import MongoClient
from robot.api.deco import keyword

_client = None


def _get_db():
    global _client
    if _client is None:
        mongo_uri = os.getenv("MONGO_URI", "mongodb://127.0.0.1:27017/")
        _client = MongoClient(mongo_uri)
    db_name = os.getenv("MONGO_DB", "markdb")
    return _client[db_name]


@keyword("Clean User From Database")
def clean_user(user_email):
    db = _get_db()
    users = db["users"]
    tasks = db["tasks"]

    user = users.find_one({"email": user_email})
    if user:
        tasks.delete_many({"user": user["_id"]})
        users.delete_many({"email": user_email})


@keyword("Remove User From Database")
def remove_user(email):
    db = _get_db()
    users = db["users"]
    users.delete_many({"email": email})
    print("removing user by " + email)


@keyword("Insert User From Database")
def insert_user(user):
    db = _get_db()
    hash_pass = bcrypt.hashpw(user["password"].encode("utf-8"), bcrypt.gensalt(8))
    doc = {
        "name": user["name"],
        "email": user["email"],
        "password": hash_pass,
    }

    users = db["users"]
    users.insert_one(doc)
    print("insert user", user["email"])
