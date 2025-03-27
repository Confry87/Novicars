from waitress import serve
from app import app

if __name__ == '__main__':
    print('Server di produzione in esecuzione su http://localhost:5000')
    serve(app, host='0.0.0.0', port=5000, threads=4) 