from flask import jsonify, request
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from config import JWT_SECRET_KEY, AUTHORIZED_USERS

jwt = JWTManager()

def init_auth(app):
    app.config['JWT_SECRET_KEY'] = JWT_SECRET_KEY
    jwt.init_app(app)

    @app.route('/api/login', methods=['POST'])
    def login():
        data = request.get_json()
        username = data.get('username')
        password = data.get('password')

        if username in AUTHORIZED_USERS and AUTHORIZED_USERS[username] == password:
            access_token = create_access_token(identity=username)
            return jsonify({
                'access_token': access_token,
                'username': username
            }), 200
        else:
            return jsonify({'error': 'Credenziali non valide'}), 401

    @app.route('/api/check-auth', methods=['GET'])
    @jwt_required()
    def check_auth():
        current_user = get_jwt_identity()
        return jsonify({
            'username': current_user,
            'authenticated': True
        }), 200

    @jwt.expired_token_loader
    def expired_token_callback(jwt_header, jwt_payload):
        return jsonify({
            'error': 'Token scaduto',
            'message': 'Il token è scaduto. Effettua nuovamente il login.'
        }), 401

    @jwt.invalid_token_loader
    def invalid_token_callback(error):
        return jsonify({
            'error': 'Token non valido',
            'message': 'Token non valido. Effettua nuovamente il login.'
        }), 401 