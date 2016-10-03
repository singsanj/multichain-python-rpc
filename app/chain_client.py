from app import app
from flask import Flask, jsonify
from bitcoinrpc.authproxy import AuthServiceProxy, JSONRPCException

@app.route('/')
@app.route('/index')
def index():
    return "Hello, World!"

tasks = [
    {
        'id': 1,
        'title': u'Buy groceries',
        'description': u'Milk, Cheese, Pizza, Fruit, Tylenol', 
        'done': False
    },
    {
        'id': 2,
        'title': u'Learn Python',
        'description': u'Need to find a good Python tutorial on the web', 
        'done': False
    }
]

@app.route('/todo/api/v1.0/tasks', methods=['GET'])
def get_tasks():
    return jsonify({'tasks': tasks})

@app.route('/chain/api/v1.0/info', methods=['GET'])
def get_info():
    rpc_user = 'multichainrpc'
    rpc_password = 'GryGTrNiMpcGU6HdXXk8egsHB1PXnckaU37XZmjL7qcq'
    rpc_connection = AuthServiceProxy("http://%s:%s@localhost:2684"%(rpc_user, rpc_password))
    return jsonify({'chain-info':rpc_connection.getinfo() })
