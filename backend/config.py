import os
from datetime import timedelta
import tempfile

# Configurazione CORS
CORS_ORIGINS = [
    'http://localhost:5173',  # Frontend locale
    'http://localhost:3000',  # Frontend locale alternativo
    'https://novicars-frontend.onrender.com',  # Frontend su Render
    'http://127.0.0.1:5173',  # Frontend locale (alternativo)
    'http://127.0.0.1:3000',  # Frontend locale (alternativo)
]

# Configurazione upload
UPLOAD_FOLDER = tempfile.gettempdir()  # Usa la directory temporanea del sistema
MAX_CONTENT_LENGTH = 16 * 1024 * 1024  # 16MB max-limit

class Config:
    # Configurazione del database
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'postgresql://postgres:postgres@localhost:5432/novicars')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    
    # Configurazione CORS
    CORS_ORIGINS = CORS_ORIGINS
    
    # Configurazione upload
    UPLOAD_FOLDER = UPLOAD_FOLDER
    MAX_CONTENT_LENGTH = MAX_CONTENT_LENGTH 