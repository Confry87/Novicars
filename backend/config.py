import os
from dotenv import load_dotenv

load_dotenv()

# JWT configuration
JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY', 'your-secret-key')
JWT_ACCESS_TOKEN_EXPIRES = 3600  # 1 hour

class Config:
    # Database configuration
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'postgresql://novicars:novicars@localhost:5432/novicars')
    # Fix per Render che usa postgres:// invece di postgresql://
    if SQLALCHEMY_DATABASE_URI.startswith("postgres://"):
        SQLALCHEMY_DATABASE_URI = SQLALCHEMY_DATABASE_URI.replace("postgres://", "postgresql://", 1)
    SQLALCHEMY_TRACK_MODIFICATIONS = False

# Lista degli utenti autorizzati
AUTHORIZED_USERS = {
    'admin': 'admin123',
    'user1': 'password1',
    'user2': 'password2',
    'user3': 'password3'
}

# Configurazione CORS
CORS_ORIGINS = [
    "http://localhost:3000",
    "http://localhost:5173",
    "https://novicars-frontend.onrender.com",
    "https://*.onrender.com"
]

# Configurazione upload file
UPLOAD_FOLDER = os.getenv('UPLOAD_FOLDER', os.path.join(os.path.dirname(os.path.abspath(__file__)), 'uploads'))
MAX_CONTENT_LENGTH = 16 * 1024 * 1024  # 16MB max file size

# Crea la cartella uploads se non esiste
os.makedirs(UPLOAD_FOLDER, exist_ok=True) 