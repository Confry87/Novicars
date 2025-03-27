from app import db, Auto, ImportLog
from sqlalchemy import text

def recreate_table():
    try:
        # Elimina le tabelle esistenti
        db.session.execute(text('DROP TABLE IF EXISTS auto'))
        db.session.execute(text('DROP TABLE IF EXISTS import_log'))
        db.session.commit()
        
        # Ricrea le tabelle con la nuova struttura
        db.create_all()
        
        print("Tabelle ricreate con successo!")
    except Exception as e:
        print(f"Errore durante la ricreazione delle tabelle: {str(e)}")
        db.session.rollback()

if __name__ == '__main__':
    recreate_table() 