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
    colore = db.Column(db.String(50))
    targa = db.Column(db.String(20), unique=True)
    chilometraggio = db.Column(db.Integer)
    data_importazione = db.Column(db.DateTime, default=datetime.utcnow)

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
    'Modello': 'modello',
    'modello': 'modello',
    'Anno': 'anno',
    'anno': 'anno',
    'Prezzo': 'prezzo',
    'prezzo': 'prezzo',
    'Colore': 'colore',
    'colore': 'colore',
    'Targa': 'targa',
    'targa': 'targa',
    'Chilometraggio': 'chilometraggio',
    'chilometraggio': 'chilometraggio'
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
    filepath = None
    try:
        if 'file' not in request.files:
            logger.error("Nessun file caricato nella richiesta")
            return jsonify({'error': 'Nessun file caricato'}), 400

        file = request.files['file']
        if file.filename == '':
            logger.error("Nome file vuoto")
            return jsonify({'error': 'Nessun file selezionato'}), 400

        if not file.filename.endswith(('.xls', '.xlsx')):
            logger.error(f"Formato file non supportato: {file.filename}")
            return jsonify({'error': 'Formato file non supportato'}), 400

        # Ottieni il fornitore forzato dalla richiesta
        fornitore_forzato = request.form.get('fornitore_forzato', '').strip()
        logger.info(f"Fornitore forzato: {fornitore_forzato}")

        filename = secure_filename(file.filename)
        filepath = os.path.join(UPLOAD_FOLDER, filename)
        logger.info(f"Salvataggio file in: {filepath}")
        
        try:
            file.save(filepath)
            logger.info("File salvato con successo")
        except Exception as e:
            logger.error(f"Errore durante il salvataggio del file: {str(e)}")
            return jsonify({'error': f'Errore durante il salvataggio del file: {str(e)}'}), 500

        # Leggi il file Excel
        try:
            df = pd.read_excel(filepath)
            logger.info(f"File Excel letto con successo. Colonne trovate: {df.columns.tolist()}")
        except Exception as e:
            logger.error(f"Errore durante la lettura del file Excel: {str(e)}")
            return jsonify({'error': f'Errore durante la lettura del file Excel: {str(e)}'}), 500
        
        # Rinomina le colonne secondo il mapping
        df.columns = [column_mapping.get(col, col) for col in df.columns]
        logger.info(f"Colonne rinominate: {df.columns.tolist()}")
        
        # Mappa le colonne del file Excel ai campi del modello
        records_imported = 0
        records_updated = 0
        
        for index, row in df.iterrows():
            try:
                targa = str(row.get('targa', '')).strip()
                logger.info(f"Elaborazione riga {index + 1}, targa: {targa}")
                
                # Verifica solo la targa come campo obbligatorio
                if not targa:
                    raise ValueError("La targa è un campo obbligatorio")
                
                # Cerca se esiste già un record con la stessa targa
                existing_auto = Auto.query.filter_by(targa=targa).first()
                
                # Funzione helper per gestire i campi vuoti
                def get_field_value(value, field_type=str):
                    if pd.isna(value) or value == '' or value is None:
                        return None
                    try:
                        return field_type(value)
                    except (ValueError, TypeError):
                        return None

                if existing_auto:
                    # Aggiorna solo i campi non vuoti
                    if fornitore_forzato:
                        existing_auto.fornitore = fornitore_forzato
                    elif row.get('fornitore'):
                        existing_auto.fornitore = str(row.get('fornitore'))
                    
                    if row.get('modello'):
                        existing_auto.modello = str(row.get('modello'))
                    
                    if row.get('anno'):
                        existing_auto.anno = get_field_value(row.get('anno'), int)
                    
                    if row.get('prezzo'):
                        existing_auto.prezzo = get_field_value(row.get('prezzo'), float)
                    
                    if row.get('colore'):
                        existing_auto.colore = str(row.get('colore'))
                    
                    if row.get('chilometraggio'):
                        existing_auto.chilometraggio = get_field_value(row.get('chilometraggio'), int)
                    
                    existing_auto.data_importazione = datetime.utcnow()
                    records_updated += 1
                    logger.info(f"Record aggiornato: {targa}")
                else:
                    # Crea un nuovo record solo con i campi non vuoti
                    auto_data = {
                        'targa': targa,
                        'data_importazione': datetime.utcnow()
                    }
                    
                    if fornitore_forzato:
                        auto_data['fornitore'] = fornitore_forzato
                    elif row.get('fornitore'):
                        auto_data['fornitore'] = str(row.get('fornitore'))
                    
                    if row.get('modello'):
                        auto_data['modello'] = str(row.get('modello'))
                    
                    if row.get('anno'):
                        auto_data['anno'] = get_field_value(row.get('anno'), int)
                    
                    if row.get('prezzo'):
                        auto_data['prezzo'] = get_field_value(row.get('prezzo'), float)
                    
                    if row.get('colore'):
                        auto_data['colore'] = str(row.get('colore'))
                    
                    if row.get('chilometraggio'):
                        auto_data['chilometraggio'] = get_field_value(row.get('chilometraggio'), int)
                    
                    auto = Auto(**auto_data)
                    db.session.add(auto)
                    records_imported += 1
                    logger.info(f"Nuovo record creato: {targa}")
            except Exception as e:
                logger.error(f"Errore nell'importazione della riga {index + 1}: {str(e)}")
                error_message = f"Errore nella riga {index + 1}: {str(e)}"
                log = ImportLog(
                    file_name=filename,
                    records_imported=0,
                    success=False,
                    error_message=error_message
                )
                db.session.add(log)
                db.session.commit()
                return jsonify({'error': error_message}), 400

        try:
            db.session.commit()
            logger.info(f"Database aggiornato con successo. Importati: {records_imported}, Aggiornati: {records_updated}")
        except Exception as e:
            logger.error(f"Errore durante il commit del database: {str(e)}")
            db.session.rollback()
            return jsonify({'error': f'Errore durante il salvataggio nel database: {str(e)}'}), 500

        # Crea il log dell'importazione
        log = ImportLog(
            file_name=filename,
            records_imported=records_imported + records_updated,
            success=True
        )
        db.session.add(log)
        db.session.commit()

        # Rimuovi il file temporaneo
        try:
            if filepath and os.path.exists(filepath):
                os.remove(filepath)
                logger.info("File temporaneo rimosso con successo")
        except Exception as e:
            logger.error(f"Errore durante la rimozione del file temporaneo: {str(e)}")

        return jsonify({
            'message': f'Importati con successo {records_imported} nuovi record e aggiornati {records_updated} record esistenti',
            'log': log.to_dict()
        })

    except Exception as e:
        logger.error(f"Errore generale durante l'importazione: {str(e)}")
        if filepath and os.path.exists(filepath):
            try:
                os.remove(filepath)
            except:
                pass

        log = ImportLog(
            file_name=file.filename if 'file' in locals() else 'unknown',
            records_imported=0,
            success=False,
            error_message=str(e)
        )
        db.session.add(log)
        db.session.commit()
        return jsonify({'error': str(e)}), 500

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
        # Elimina tutti i record dalla tabella Auto
        Auto.query.delete()
        db.session.commit()
        
        return jsonify({
            'message': 'Database pulito con successo',
            'records_deleted': Auto.query.count()
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