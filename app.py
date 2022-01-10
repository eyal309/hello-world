from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello():
    return '<h1>Hello World!</h1><p>this is a test app</p>'


if __name__ == '__main__':
    app.run()

