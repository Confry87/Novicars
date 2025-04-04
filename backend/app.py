from flask import Flask, request, jsonify, send_from_directory
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from werkzeug.utils import secure_filename
import os
from datetime import datetime
import pandas as pd
from backend.config import Config, UPLOAD_FOLDER, MAX_CONTENT_LENGTH, CORS_ORIGINS
import logging

# Configurazione logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)
app.config.from_object(Config)
db = SQLAlchemy(app)

# Definizione del modello Auto
class Auto(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    fornitore = db.Column(db.String(100))
    modello = db.Column(db.String(100))
    anno = db.Column(db.Integer)
    prezzo = db.Column(db.Float)
    colore = db.Column(db.String(200))
    targa = db.Column(db.String(20), unique=True)
    chilometraggio = db.Column(db.Integer)
    data_importazione = db.Column(db.DateTime, default=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id,
            'fornitore': self.fornitore,
            'modello': self.modello,
            'anno': self.anno,
            'prezzo': self.prezzo,
            'colore': self.colore,
            'targa': self.targa,
            'chilometraggio': self.chilometraggio,
            'data_importazione': self.data_importazione.isoformat() if self.data_importazione else None
        }

# Definizione del modello ImportLog
class ImportLog(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    file_name = db.Column(db.String(255), nullable=False)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)
    records_imported = db.Column(db.Integer, default=0)
    success = db.Column(db.Boolean, default=True)
    error_message = db.Column(db.Text)

    def to_dict(self):
        return {
            'id': self.id,
            'file_name': self.file_name,
            'timestamp': self.timestamp.isoformat(),
            'records_imported': self.records_imported,
            'success': self.success,
            'error_message': self.error_message
        }

# Crea la cartella uploads se non esiste
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
logger.info(f"Upload folder created at: {UPLOAD_FOLDER}")

# Configurazione CORS
CORS(app, resources={
    r"/*": {
        "origins": CORS_ORIGINS,
        "methods": ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
        "allow_headers": ["Content-Type", "Authorization"]
    }
})

# Middleware per gestire le richieste OPTIONS e CORS
@app.after_request
def after_request(response):
    origin = request.headers.get('Origin')
    logger.info(f"Request origin: {origin}")
    
    if origin in CORS_ORIGINS:
        response.headers.add('Access-Control-Allow-Origin', origin)
        response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
        response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
        logger.info(f"Added CORS headers for origin: {origin}")
    else:
        logger.warning(f"Origin not allowed: {origin}")
    
    return response

# Crea le tabelle del database all'avvio dell'applicazione
with app.app_context():
    try:
        db.create_all()
        logger.info("Database tables created successfully")
    except Exception as e:
        logger.error(f"Error creating database tables: {e}")
        raise

# Mapping delle colonne per gestire i diversi nomi possibili
column_mapping = {
    'Marca': 'fornitore',
    'marca': 'fornitore',
    'MARCA': 'fornitore',
    'Modello': 'modello',
    'modello': 'modello',
    'MODELLO': 'modello',
    'Anno': 'anno',
    'anno': 'anno',
    'Model Year': 'anno',
    'Prezzo': 'prezzo',
     'prezzo Veicolo': 'prezzo',
    'PREZZO': 'prezzo',
    'Colore': 'colore',
    'colore': 'colore',
    'COLORE': 'colore',
    'Targa': 'targa',
    'targa': 'targa',
    'TARGA': 'targa',
    'Chilometraggio': 'chilometraggio',
    'chilometraggio': 'chilometraggio',
    'KM': 'chilometraggio',
    'km': 'chilometraggio',
    'Km': 'chilometraggio'
}

# Route per le auto
@app.route('/api/auto', methods=['GET'])
def get_autos():
    try:
        filters = request.args.to_dict()
        query = Auto.query

        if filters.get('fornitore'):
            query = query.filter(Auto.fornitore.ilike(f"%{filters['fornitore']}%"))
        if filters.get('modello'):
            query = query.filter(Auto.modello.ilike(f"%{filters['modello']}%"))
        if filters.get('annoMin'):
            query = query.filter(Auto.anno >= int(filters['annoMin']))
        if filters.get('annoMax'):
            query = query.filter(Auto.anno <= int(filters['annoMax']))
        if filters.get('prezzoMin'):
            query = query.filter(Auto.prezzo >= float(filters['prezzoMin']))
        if filters.get('prezzoMax'):
            query = query.filter(Auto.prezzo <= float(filters['prezzoMax']))
        if filters.get('colore'):
            query = query.filter(Auto.colore.ilike(f"%{filters['colore']}%"))
        if filters.get('targa'):
            query = query.filter(Auto.targa.ilike(f"%{filters['targa']}%"))
        if filters.get('chilometraggioMin'):
            query = query.filter(Auto.chilometraggio >= int(filters['chilometraggioMin']))
        if filters.get('chilometraggioMax'):
            query = query.filter(Auto.chilometraggio <= int(filters['chilometraggioMax']))

        autos = query.all()
        return jsonify([auto.to_dict() for auto in autos])
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/auto/<int:id>', methods=['GET'])
def get_auto(id):
    try:
        auto = Auto.query.get_or_404(id)
        return jsonify(auto.to_dict())
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Route per l'importazione
@app.route('/api/import', methods=['POST'])
def import_excel():
    if 'file' not in request.files:
        return jsonify({'error': 'Nessun file caricato'}), 400
    
    file = request.files['file']
    fornitore_forzato = request.form.get('fornitore')
    
    if file.filename == '':
        return jsonify({'error': 'Nessun file selezionato'}), 400
    
    if not file.filename.endswith(('.xlsx', '.xls')):
        return jsonify({'error': 'Formato file non supportato. Usa .xlsx o .xls'}), 400
    
    filepath = None
    try:
        # Salva il file temporaneamente
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(file.filename))
        file.save(filepath)
        app.logger.info(f"File salvato temporaneamente: {filepath}")
        
        # Leggi il file Excel
        df = pd.read_excel(filepath)
        app.logger.info(f"File Excel letto con successo. Colonne trovate: {df.columns.tolist()}")
        
        # Rinomina le colonne secondo il mapping
        df.columns = [column_mapping.get(col, col) for col in df.columns]
        app.logger.info(f"Colonne dopo il mapping: {df.columns.tolist()}")
        
        # Mappa il prezzo dal campo corretto
        if 'Prezzo Veicolo' in df.columns:
            df['prezzo'] = df['Prezzo Veicolo']
        elif 'prezzo "Chiavi In Mano"' in df.columns:
            df['prezzo'] = df['prezzo "Chiavi In Mano"']
        
        # Mappa il chilometraggio
        if 'Km (vei. AZ.)' in df.columns:
            df['chilometraggio'] = df['Km (vei. AZ.)']
        
        # Valori predefiniti per le colonne mancanti
        default_values = {
            'targa': '0000',
            'fornitore': fornitore_forzato if fornitore_forzato else '',
            'modello': '',
            'anno': 0,
            'prezzo': 0.0,
            'chilometraggio': 0,
            'colore': '',
            'note': ''
        }
        
        # Aggiungi le colonne mancanti con valori predefiniti
        for col, default_value in default_values.items():
            if col not in df.columns:
                app.logger.info(f"Aggiunta colonna mancante: {col} con valore predefinito: {default_value}")
                df[col] = default_value
        
        # Converti i tipi di dati
        df['anno'] = pd.to_numeric(df['anno'], errors='coerce').fillna(0).astype(int)
        df['prezzo'] = pd.to_numeric(df['prezzo'], errors='coerce').fillna(0.0).astype(float)
        df['chilometraggio'] = pd.to_numeric(df['chilometraggio'], errors='coerce').fillna(0).astype(int)
        
        # Converti NaN in valori predefiniti
        df = df.fillna(default_values)
        
        # Converti il DataFrame in una lista di dizionari
        records = df.to_dict('records')
        app.logger.info(f"Elaborazione di {len(records)} righe")
        
        # Inserisci i dati nel database
        for i, record in enumerate(records, 1):
            try:
                app.logger.info(f"Elaborazione riga {i}, targa: {record.get('targa')}")
                
                # Crea l'oggetto Auto con i dati validati
                auto = Auto(
                    targa=str(record['targa']).strip() or '0000',
                    fornitore=str(record['fornitore']).strip(),
                    modello=str(record['modello']).strip(),
                    anno=int(record['anno']),
                    prezzo=float(record['prezzo']),
                    chilometraggio=int(record['chilometraggio']),
                    colore=str(record['colore']).strip() if 'colore' in record else '',
                    data_importazione=datetime.utcnow()
                )
                
                db.session.add(auto)
                db.session.commit()
                app.logger.info(f"Riga {i} elaborata con successo")
                
            except Exception as e:
                app.logger.error(f"Errore nella riga {i}: {str(e)}")
                db.session.rollback()
                return jsonify({
                    'error': f'Errore nella riga {i}: {str(e)}',
                    'row_data': record
                }), 400
        
        return jsonify({'message': f'Importati con successo {len(records)} record'}), 200
        
    except Exception as e:
        app.logger.error(f"Errore durante l'importazione: {str(e)}")
        return jsonify({'error': str(e)}), 500
        
    finally:
        # Rimuovi il file temporaneo
        if filepath and os.path.exists(filepath):
            try:
                os.remove(filepath)
                app.logger.info(f"File temporaneo rimosso: {filepath}")
            except Exception as e:
                app.logger.error(f"Errore durante la rimozione del file temporaneo: {str(e)}")

@app.route('/api/import/logs', methods=['GET'])
def get_import_logs():
    try:
        logs = ImportLog.query.order_by(ImportLog.timestamp.desc()).all()
        return jsonify([log.to_dict() for log in logs])
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/')
def index():
    # Ottieni i parametri di ricerca
    fornitore = request.args.get('fornitore', '')
    modello = request.args.get('modello', '')
    colore = request.args.get('colore', '')
    
    # Costruisci la query
    query = Auto.query
    if fornitore:
        query = query.filter(Auto.fornitore.ilike(f"%{fornitore}%"))
    if modello:
        query = query.filter(Auto.modello.ilike(f"%{modello}%"))
    if colore:
        query = query.filter(Auto.colore.ilike(f"%{colore}%"))
    
    autos = query.all()
    
    # Genera le righe della tabella
    rows = ''
    for auto in autos:
        prezzo_formattato = f"€{auto.prezzo:,.2f}" if auto.prezzo is not None else '-'
        rows += f'''
        <tr>
            <td>{auto.id}</td>
            <td>{auto.fornitore or '-'}</td>
            <td>{auto.modello or '-'}</td>
            <td>{auto.anno or '-'}</td>
            <td>{auto.chilometraggio or '-'}</td>
            <td>{auto.colore or '-'}</td>
            <td>{prezzo_formattato}</td>
            <td>{auto.data_importazione.strftime('%Y-%m-%d %H:%M:%S') if auto.data_importazione else '-'}</td>
        </tr>
        '''
    
    # Template HTML
    html = f'''
    <html>
        <head>
            <title>Database Auto</title>
            <style>
                body {{ font-family: Arial, sans-serif; margin: 20px; }}
                .search-form {{ margin-bottom: 20px; padding: 20px; background: #f5f5f5; border-radius: 5px; }}
                .search-form input {{ margin-right: 10px; padding: 5px; }}
                .search-form button {{ padding: 5px 10px; }}
                table {{ border-collapse: collapse; width: 100%; margin-top: 20px; }}
                th, td {{ border: 1px solid #ddd; padding: 8px; text-align: left; }}
                th {{ background-color: #f2f2f2; }}
                tr:nth-child(even) {{ background-color: #f9f9f9; }}
                .header {{ margin-bottom: 20px; }}
                .stats {{ margin: 20px 0; }}
            </style>
        </head>
        <body>
            <div class="header">
                <h1>Database Auto</h1>
                <div class="stats">
                    <p>Numero totale di auto: {Auto.query.count()}</p>
                    <p>Numero di auto filtrate: {len(autos)}</p>
                </div>
            </div>
            
            <div class="search-form">
                <form method="GET">
                    <input type="text" name="fornitore" placeholder="Fornitore" value="{fornitore}">
                    <input type="text" name="modello" placeholder="Modello" value="{modello}">
                    <input type="text" name="colore" placeholder="Colore" value="{colore}">
                    <button type="submit">Cerca</button>
                </form>
            </div>
            
            <table>
                <tr>
                    <th>ID</th>
                    <th>Fornitore</th>
                    <th>Modello</th>
                    <th>Anno</th>
                    <th>Chilometraggio</th>
                    <th>Colore</th>
                    <th>Prezzo</th>
                    <th>Data Importazione</th>
                </tr>
                {rows}
            </table>
        </body>
    </html>
    '''
    
    return html

@app.route('/api/clear-database', methods=['POST'])
def clear_database():
    try:
        num_records = Auto.query.count()
        # Elimina tutti i record dalla tabella Auto
        Auto.query.delete()
        db.session.commit()
        
        return jsonify({
            'message': 'Database pulito con successo',
            'records_deleted': num_records
        })
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@app.route('/health')
def health_check():
    return jsonify({"status": "ok", "message": "Backend is running"})

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    logger.info(f"Starting application on port {port}")
    logger.info(f"Database URL: {app.config['SQLALCHEMY_DATABASE_URI']}")
    with app.app_context():
        db.create_all()
        logger.info("Database tables created")
    app.run(host='0.0.0.0', port=port) 