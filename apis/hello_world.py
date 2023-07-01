import os
from flask_restful import Resource

SECRET = os.environ.get("SECRET", "#SECRET")

class HelloWorld(Resource):
    def get(self):
        return {"hello": "world", "secret": SECRET}
