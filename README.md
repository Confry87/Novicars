# NoviCars - Gestione Auto

Applicazione web per la gestione del parco auto, con funzionalità di ricerca e importazione dati da file Excel.

## Requisiti

- Python 3.8+
- Node.js 14+
- PostgreSQL
- npm o yarn

## Configurazione

### Backend

1. Creare un database PostgreSQL:
```sql
CREATE DATABASE novicars;
```

2. Installare le dipendenze Python:
```bash
cd backend
pip install -r requirements.txt
```

3. Configurare le variabili d'ambiente nel file `backend/config.py`

4. Avviare il server backend:
```bash
cd backend
python app.py
```

### Frontend

1. Installare le dipendenze Node.js:
```bash
cd frontend
npm install
```

2. Avviare il server di sviluppo:
```bash
cd frontend
npm start
```

## Funzionalità

- Ricerca auto con filtri multipli
- Importazione dati da file Excel (.xls, .xlsx)
- Visualizzazione log di importazione
- Interfaccia utente moderna e reattiva

## Tecnologie Utilizzate

### Backend
- Flask
- SQLAlchemy
- PostgreSQL
- xlrd/openpyxl

### Frontend
- React
- TypeScript
- Material-UI
- Axios 