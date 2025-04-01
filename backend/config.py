import os
from dotenv import load_dotenv

load_dotenv()

# JWT configuration
JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY', 'your-secret-key')
JWT_ACCESS_TOKEN_EXPIRES = 3600  # 1 hour

class Config:
    # Database configuration
    DB_HOST = os.getenv('DB_HOST', 'localhost')
    DB_PORT = os.getenv('DB_PORT', '5432')
    DB_NAME = os.getenv('DB_NAME', 'novicars')
    DB_USER = os.getenv('DB_USER', 'novicars')
    DB_PASSWORD = os.getenv('DB_PASSWORD', '')
    
    # Construct database URL
    SQLALCHEMY_DATABASE_URI = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    SQLALCHEMY_TRACK_MODIFICATIONS = False

# Lista degli utenti autorizzati
AUTHORIZED_USERS = {
    'admin': 'admin123',
    'user1': 'password1',
    'user2': 'password2',
    'user3': 'password3'
}

# Configurazione CORS
CORS_ORIGINS = ["http://localhost:3000", "https://novicars.netlify.app", "https://*.netlify.app"]

# Configurazione upload file
UPLOAD_FOLDER = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'uploads')
MAX_CONTENT_LENGTH = 16 * 1024 * 1024  # 16MB max file size 