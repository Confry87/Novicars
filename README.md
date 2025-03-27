# Novicars - Gestione Auto

Un'applicazione web per la gestione del parco auto, con funzionalità di importazione da Excel e ricerca avanzata.

## 🚀 Tecnologie Utilizzate

### Frontend
- React
- TypeScript
- Material-UI
- Axios

### Backend
- Python
- Flask
- SQLAlchemy
- PostgreSQL

## 📋 Prerequisiti

- Node.js (versione 16 o superiore)
- Python (versione 3.8 o superiore)
- PostgreSQL

## 🛠️ Installazione

### Backend

1. Navigare nella directory backend:
```bash
cd backend
```

2. Creare un ambiente virtuale Python:
```bash
python -m venv venv
```

3. Attivare l'ambiente virtuale:
- Windows:
```bash
.\venv\Scripts\activate
```
- Linux/Mac:
```bash
source venv/bin/activate
```

4. Installare le dipendenze:
```bash
pip install -r requirements.txt
```

5. Configurare le variabili d'ambiente:
Creare un file `.env` nella root del progetto con le seguenti variabili:
```env
DATABASE_URL=postgresql://username:password@localhost:5432/novicars
```

### Frontend

1. Navigare nella directory frontend:
```bash
cd frontend
```

2. Installare le dipendenze:
```bash
npm install
```

## 🚀 Avvio dell'applicazione

### Backend

1. Dalla directory backend:
```bash
python app.py
```
Il server sarà disponibile su http://localhost:5000

### Frontend

1. Dalla directory frontend:
```bash
npm start
```
L'applicazione sarà disponibile su http://localhost:3000

## 📊 Funzionalità

- **Importazione dati**: Supporto per l'importazione di file Excel con dati auto
- **Ricerca avanzata**: Ricerca auto per fornitore e altri parametri
- **Interfaccia moderna**: UI intuitiva realizzata con Material-UI
- **API RESTful**: Backend con endpoints ben definiti per la gestione dei dati

## 📁 Struttura del Progetto

```
novicars/
├── backend/
│   ├── app.py
│   ├── config.py
│   ├── import_data.py
│   └── requirements.txt
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   └── App.tsx
│   └── package.json
├── uploads/
└── README.md
```

## 🔒 Sicurezza

- I file sensibili (`.env`, file Excel, ecc.) sono esclusi dal repository
- La directory `uploads` è utilizzata temporaneamente per i file importati

## 🤝 Contribuire

1. Fai il fork del repository
2. Crea un branch per la tua feature (`git checkout -b feature/AmazingFeature`)
3. Committa i tuoi cambiamenti (`git commit -m 'Aggiunta una feature incredibile'`)
4. Pusha sul branch (`git push origin feature/AmazingFeature`)
5. Apri una Pull Request

## 📝 Note

- L'applicazione utilizza un server di sviluppo Flask. Per la produzione, si consiglia l'uso di un server WSGI come Gunicorn
- Il frontend è configurato per lo sviluppo. Per la produzione, utilizzare `npm run build` 