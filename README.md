# NoviCars

Applicazione web per la gestione del parco auto.

## Tecnologie Utilizzate

- Frontend: React + Vite
- Backend: Vercel Serverless Functions
- Database: PostgreSQL (Vercel Postgres)
- Autenticazione: JWT

## Requisiti

- Node.js >= 18
- npm >= 9
- PostgreSQL >= 14

## Configurazione Locale

1. Clona il repository:
```bash
git clone https://github.com/yourusername/novicars.git
cd novicars
```

2. Installa le dipendenze:
```bash
npm install
```

3. Crea il file `.env` con le seguenti variabili:
```env
JWT_SECRET_KEY=your-secret-key-here
POSTGRES_URL=postgresql://user:password@localhost:5432/novicars
```

4. Inizializza il database:
```bash
psql -U your_user -d novicars -f schema.sql
```

5. Avvia l'applicazione in modalità sviluppo:
```bash
npm run dev
```

## Deployment

L'applicazione è configurata per essere deployata su Vercel. Per deployare:

1. Crea un account su Vercel
2. Connetti il repository GitHub
3. Configura le variabili d'ambiente su Vercel:
   - `JWT_SECRET_KEY`
   - `POSTGRES_URL`
4. Deploya l'applicazione

## API Endpoints

### Autenticazione
- `POST /api/login` - Login utente

### Auto
- `GET /api/auto` - Lista auto con filtri
- `GET /api/auto/:id` - Dettaglio auto
- `POST /api/import` - Importa auto da file Excel
- `GET /api/import/logs` - Log importazioni
- `POST /api/clear-database` - Pulisci database

## Filtri Disponibili

- `fornitore`: Filtra per fornitore
- `modello`: Filtra per modello
- `annoMin`: Anno minimo
- `annoMax`: Anno massimo
- `prezzoMin`: Prezzo minimo
- `prezzoMax`: Prezzo massimo
- `colore`: Filtra per colore
- `targa`: Filtra per targa
- `chilometraggioMin`: Chilometraggio minimo
- `chilometraggioMax`: Chilometraggio massimo

## Licenza

MIT 