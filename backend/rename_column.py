from app import db
from sqlalchemy import text

def rename_column():
    try:
        # Esegui il comando SQL per rinominare la colonna
        db.session.execute(text('ALTER TABLE auto RENAME COLUMN marca TO fornitore'))
        db.session.commit()
        print("Colonna rinominata con successo!")
    except Exception as e:
        print(f"Errore durante la rinomina della colonna: {str(e)}")
        db.session.rollback()

if __name__ == '__main__':
    rename_column() 