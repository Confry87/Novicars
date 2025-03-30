import os
from dotenv import load_dotenv

load_dotenv()

# Configurazione del database
DATABASE_URL = f"postgresql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"

# Configurazione JWT
JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY', 'chiave-segreta-di-sviluppo')
JWT_ACCESS_TOKEN_EXPIRES = 3600  # 1 ora

# Lista degli utenti autorizzati
AUTHORIZED_USERS = {
    'admin': 'admin123',
    'user1': 'password1',
    'user2': 'password2',
    'user3': 'password3'
}

class Config:
    # Configurazione del database
    SQLALCHEMY_DATABASE_URI = DATABASE_URL
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    
    # Configurazione CORS
    CORS_ORIGINS = ["http://localhost:3000", "https://novicars.netlify.app", "https://*.netlify.app"]
    
    # Configurazione upload file
    UPLOAD_FOLDER = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'uploads')
    MAX_CONTENT_LENGTH = 16 * 1024 * 1024  # 16MB max file size 