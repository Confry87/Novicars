from flask import Flask, request, jsonify, send_from_directory
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from werkzeug.utils import secure_filename
import os
from datetime import datetime
import pandas as pd
from config import Config
from auth import init_auth, jwt_required

app = Flask(__name__)
app.config.from_object(Config)
db = SQLAlchemy(app)
CORS(app, resources={r"/api/*": {"origins": "*"}})

# Inizializza l'autenticazione
init_auth(app)

# Mapping delle colonne per gestire i diversi nomi possibili
column_mapping = {
    'Marca': 'fornitore',
    'marca': 'fornitore',
    'brand': 'fornitore',
    'Descrizione Marca': 'fornitore',
    
    'Modello': 'modello',
    'modello': 'modello',
    'model': 'modello',
    'Descrizione Versione': 'modello',
    'Descrizione Modello': 'modello',
    'Descrizione veicolo': 'modello',
    
    'Model Year': 'anno',
    'Anno': 'anno',
    'anno': 'anno',
    'year': 'anno',
    
    'Prezzo Veicolo': 'prezzo',
    'Prezzo': 'prezzo',
    'prezzo': 'prezzo',
    'price': 'prezzo',
    'Prezzo Listino Privil.': 'prezzo',
    'Prezzo Veicolo': 'prezzo',
    
    'Colore': 'colore',
    'colore': 'colore',
    'color': 'colore',
    
    'Targa': 'targa',
    'targa': 'targa',
    'plate': 'targa',
    
    'Km (vei. AZ.)': 'chilometraggio',
    'Km': 'chilometraggio',
    'Chilometraggio': 'chilometraggio',
    'chilometraggio': 'chilometraggio',
    'km': 'chilometraggio',
    'kilometers': 'chilometraggio',
    'Km (vei. AZ.)': 'chilometraggio'
}

# Modelli
class Auto(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    fornitore = db.Column(db.String(200), nullable=False)
    modello = db.Column(db.String(500), nullable=False)
    anno = db.Column(db.Integer)
    prezzo = db.Column(db.Float)
    colore = db.Column(db.String(200))
    targa = db.Column(db.String(20))
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
            'data_importazione': self.data_importazione.isoformat()
        }

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

# Proteggi tutte le route con autenticazione
@app.before_request
def before_request():
    if request.endpoint and 'login' not in request.endpoint and request.path.startswith('/api/'):
        jwt_required()

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
    try:
        if 'file' not in request.files:
            return jsonify({'error': 'Nessun file caricato'}), 400

        file = request.files['file']
        if file.filename == '':
            return jsonify({'error': 'Nessun file selezionato'}), 400

        if not file.filename.endswith(('.xls', '.xlsx')):
            return jsonify({'error': 'Formato file non supportato'}), 400

        # Ottieni il fornitore forzato dalla richiesta
        fornitore_forzato = request.form.get('fornitore_forzato', '').strip()

        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)

        # Leggi il file Excel
        df = pd.read_excel(filepath)
        
        # Rinomina le colonne secondo il mapping
        df.columns = [column_mapping.get(col, col) for col in df.columns]
        
        # Mappa le colonne del file Excel ai campi del modello
        records_imported = 0
        records_updated = 0
        
        for _, row in df.iterrows():
            try:
                targa = str(row.get('targa', '')).strip()
                
                # Cerca se esiste già un record con la stessa targa
                existing_auto = Auto.query.filter_by(targa=targa).first() if targa else None
                
                if existing_auto:
                    # Aggiorna il record esistente
                    existing_auto.fornitore = fornitore_forzato if fornitore_forzato else str(row.get('fornitore', ''))
                    existing_auto.modello = str(row.get('modello', ''))
                    existing_auto.anno = int(row.get('anno')) if pd.notna(row.get('anno')) else None
                    existing_auto.prezzo = float(row.get('prezzo')) if pd.notna(row.get('prezzo')) else None
                    existing_auto.colore = str(row.get('colore', ''))
                    existing_auto.chilometraggio = int(row.get('chilometraggio')) if pd.notna(row.get('chilometraggio')) else None
                    existing_auto.data_importazione = datetime.utcnow()
                    records_updated += 1
                else:
                    # Crea un nuovo record
                    auto = Auto(
                        fornitore=fornitore_forzato if fornitore_forzato else str(row.get('fornitore', '')),
                        modello=str(row.get('modello', '')),
                        anno=int(row.get('anno')) if pd.notna(row.get('anno')) else None,
                        prezzo=float(row.get('prezzo')) if pd.notna(row.get('prezzo')) else None,
                        colore=str(row.get('colore', '')),
                        targa=targa,
                        chilometraggio=int(row.get('chilometraggio')) if pd.notna(row.get('chilometraggio')) else None,
                        data_importazione=datetime.utcnow()
                    )
                    db.session.add(auto)
                    records_imported += 1
            except Exception as e:
                print(f"Errore nell'importazione della riga: {e}")
                continue

        db.session.commit()

        # Crea il log dell'importazione
        log = ImportLog(
            file_name=filename,
            records_imported=records_imported + records_updated,
            success=True
        )
        db.session.add(log)
        db.session.commit()

        # Rimuovi il file temporaneo
        os.remove(filepath)

        return jsonify({
            'message': f'Importati con successo {records_imported} nuovi record e aggiornati {records_updated} record esistenti',
            'log': log.to_dict()
        })

    except Exception as e:
        if 'filepath' in locals():
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

if __name__ == '__main__':
    os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)
    with app.app_context():
        db.create_all()
    app.run(debug=True, host='0.0.0.0', port=5000) 