from app import db, Auto, ImportLog

def check_data():
    try:
        # Conta il numero totale di auto
        total_autos = Auto.query.count()
        print(f"\nNumero totale di auto nel database: {total_autos}")
        
        # Mostra le statistiche per fornitore
        print("\nStatistiche per fornitore:")
        fornitore_stats = db.session.query(Auto.fornitore, db.func.count(Auto.id)).group_by(Auto.fornitore).all()
        for fornitore, count in fornitore_stats:
            print(f"- {fornitore}: {count} auto")
        
        # Mostra le statistiche per anno
        print("\nStatistiche per anno:")
        anno_stats = db.session.query(Auto.anno, db.func.count(Auto.id)).group_by(Auto.anno).all()
        for anno, count in anno_stats:
            print(f"- {anno}: {count} auto")
        
        # Mostra le statistiche per colore
        print("\nStatistiche per colore:")
        colore_stats = db.session.query(Auto.colore, db.func.count(Auto.id)).group_by(Auto.colore).all()
        for colore, count in colore_stats:
            print(f"- {colore}: {count} auto")
        
        # Mostra le statistiche sui prezzi
        print("\nStatistiche sui prezzi:")
        prezzo_stats = db.session.query(
            db.func.min(Auto.prezzo).label('min_prezzo'),
            db.func.max(Auto.prezzo).label('max_prezzo'),
            db.func.avg(Auto.prezzo).label('avg_prezzo')
        ).first()
        print(f"- Prezzo minimo: €{prezzo_stats.min_prezzo:,.2f}")
        print(f"- Prezzo massimo: €{prezzo_stats.max_prezzo:,.2f}")
        print(f"- Prezzo medio: €{prezzo_stats.avg_prezzo:,.2f}")
        
        # Mostra gli ultimi 5 record importati
        print("\nUltimi 5 record importati:")
        ultimi_record = Auto.query.order_by(Auto.data_importazione.desc()).limit(5).all()
        for auto in ultimi_record:
            print(f"- {auto.fornitore} {auto.modello} ({auto.anno}) - €{auto.prezzo:,.2f}")
        
        # Mostra gli ultimi log di importazione
        print("\nUltimi 5 log di importazione:")
        ultimi_log = ImportLog.query.order_by(ImportLog.data_importazione.desc()).limit(5).all()
        for log in ultimi_log:
            print(f"- {log.nome_file} - {log.data_importazione.strftime('%Y-%m-%d %H:%M:%S')}")
            print(f"  Record importati: {log.record_importati}, Record aggiornati: {log.record_aggiornati}")
            
    except Exception as e:
        print(f"Errore durante la verifica dei dati: {str(e)}")

if __name__ == '__main__':
    check_data() 