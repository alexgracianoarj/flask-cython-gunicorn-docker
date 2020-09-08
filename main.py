from flask import Flask
from flask_restful import Api
from apis.hello_world import HelloWorld

app = Flask(__name__)
api = Api(app)

api.add_resource(HelloWorld, "/")

if __name__ == "__main__":
    app.run(debug=True, port=3000)
