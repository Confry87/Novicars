import os
from datetime import timedelta

class Config:
    # Configurazione del database
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'postgresql://postgres:postgres@localhost:5432/novicars')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    
    # Configurazione CORS
    CORS_ORIGINS = [
        'http://localhost:5173',  # Frontend locale
        'http://localhost:3000',  # Frontend locale alternativo
        'https://novicars-frontend.onrender.com',  # Frontend su Render
        'http://127.0.0.1:5173',  # Frontend locale (alternativo)
        'http://127.0.0.1:3000',  # Frontend locale (alternativo)
    ]
    
    # Configurazione upload
    UPLOAD_FOLDER = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'uploads')
    MAX_CONTENT_LENGTH = 16 * 1024 * 1024  # 16MB max-limit 