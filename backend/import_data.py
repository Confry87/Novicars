from app import db, Auto
import pandas as pd
import os
import numpy as np

def import_excel():
    try:
        # Leggi il file Excel
        excel_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'Stock Audi Magnifica al 17.03.xls')
        df = pd.read_excel(excel_path)
        
        # Mappa le colonne
        column_mapping = {
            'Descrizione veicolo': 'modello',
            'Colore': 'colore',
            'Prezzo Veicolo': 'prezzo',
            'Model Year': 'anno',
            'Km (vei. AZ.)': 'chilometraggio',
            'Marca': 'fornitore'
        }
        
        # Rinomina le colonne
        df = df.rename(columns=column_mapping)
        
        # Converti i dati
        df['prezzo'] = pd.to_numeric(df['prezzo'], errors='coerce')
        df['anno'] = pd.to_numeric(df['anno'], errors='coerce').astype('Int64')
        df['chilometraggio'] = pd.to_numeric(df['chilometraggio'], errors='coerce').astype('Int64')
        
        # Rimuovi le righe con valori NaN
        df = df.dropna(subset=['fornitore', 'modello', 'colore'])
        
        # Inserisci i dati nel database
        for _, row in df.iterrows():
            auto = Auto(
                fornitore=str(row['fornitore']) if pd.notna(row['fornitore']) else None,
                modello=str(row['modello']) if pd.notna(row['modello']) else None,
                anno=int(row['anno']) if pd.notna(row['anno']) else None,
                chilometraggio=int(row['chilometraggio']) if pd.notna(row['chilometraggio']) else None,
                colore=str(row['colore']) if pd.notna(row['colore']) else None,
                prezzo=float(row['prezzo']) if pd.notna(row['prezzo']) else None
            )
            db.session.add(auto)
        
        db.session.commit()
        print(f"Importati {len(df)} record con successo!")
        
    except Exception as e:
        print(f"Errore durante l'importazione: {str(e)}")
        db.session.rollback()

if __name__ == '__main__':
    import_excel() 