import { createClient } from '@vercel/postgres';
import type { VercelRequest, VercelResponse } from '@vercel/node';
import { jwtVerify } from 'jose';
import * as XLSX from 'xlsx';

const client = createClient();

// Configurazione JWT
const JWT_SECRET = new TextEncoder().encode(process.env.JWT_SECRET_KEY || 'your-secret-key');

// Middleware di autenticazione
async function authenticate(req: VercelRequest, res: VercelResponse, next: () => Promise<void>) {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json({ error: 'Token non fornito' });
    }

    const token = authHeader.split(' ')[1];
    const { payload } = await jwtVerify(token, JWT_SECRET);
    req.user = payload;
    await next();
  } catch (error) {
    return res.status(401).json({ error: 'Token non valido' });
  }
}

// Mapping delle colonne per l'importazione
const columnMapping = {
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
  'kilometers': 'chilometraggio'
};

export default async function handler(req: VercelRequest, res: VercelResponse) {
  try {
    // Gestione CORS
    res.setHeader('Access-Control-Allow-Credentials', 'true');
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT');
    res.setHeader(
      'Access-Control-Allow-Headers',
      'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version, Authorization'
    );

    if (req.method === 'OPTIONS') {
      res.status(200).end();
      return;
    }

    // Gestione delle route
    const path = req.url?.split('/api/')[1];

    // Proteggi tutte le route tranne login
    if (path !== 'login' && path !== 'health') {
      await authenticate(req, res, async () => {
        await handleRoute(path, req, res);
      });
    } else {
      await handleRoute(path, req, res);
    }
  } catch (error) {
    console.error('Errore:', error);
    res.status(500).json({ error: 'Errore interno del server' });
  }
}

async function handleRoute(path: string | undefined, req: VercelRequest, res: VercelResponse) {
  switch (path) {
    case 'auto':
      if (req.method === 'GET') {
        const filters = req.query;
        let query = 'SELECT * FROM auto WHERE 1=1';
        const params: any[] = [];

        if (filters.fornitore) {
          query += ' AND fornitore ILIKE $' + (params.length + 1);
          params.push(`%${filters.fornitore}%`);
        }
        if (filters.modello) {
          query += ' AND modello ILIKE $' + (params.length + 1);
          params.push(`%${filters.modello}%`);
        }
        if (filters.annoMin) {
          query += ' AND anno >= $' + (params.length + 1);
          params.push(parseInt(filters.annoMin as string));
        }
        if (filters.annoMax) {
          query += ' AND anno <= $' + (params.length + 1);
          params.push(parseInt(filters.annoMax as string));
        }
        if (filters.prezzoMin) {
          query += ' AND prezzo >= $' + (params.length + 1);
          params.push(parseFloat(filters.prezzoMin as string));
        }
        if (filters.prezzoMax) {
          query += ' AND prezzo <= $' + (params.length + 1);
          params.push(parseFloat(filters.prezzoMax as string));
        }
        if (filters.colore) {
          query += ' AND colore ILIKE $' + (params.length + 1);
          params.push(`%${filters.colore}%`);
        }
        if (filters.targa) {
          query += ' AND targa ILIKE $' + (params.length + 1);
          params.push(`%${filters.targa}%`);
        }
        if (filters.chilometraggioMin) {
          query += ' AND chilometraggio >= $' + (params.length + 1);
          params.push(parseInt(filters.chilometraggioMin as string));
        }
        if (filters.chilometraggioMax) {
          query += ' AND chilometraggio <= $' + (params.length + 1);
          params.push(parseInt(filters.chilometraggioMax as string));
        }

        const { rows } = await client.query(query, params);
        res.status(200).json(rows);
      }
      break;

    case 'import':
      if (req.method === 'POST') {
        if (!req.files || !req.files.file) {
          return res.status(400).json({ error: 'Nessun file caricato' });
        }

        const file = req.files.file as any;
        if (!file.name.endsWith('.xlsx') && !file.name.endsWith('.xls')) {
          return res.status(400).json({ error: 'Formato file non supportato' });
        }

        const fornitoreForzato = req.body.fornitore_forzato?.trim() || '';
        const workbook = XLSX.read(file.data, { type: 'buffer' });
        const worksheet = workbook.Sheets[workbook.SheetNames[0]];
        const data = XLSX.utils.sheet_to_json(worksheet);

        let recordsImported = 0;
        let recordsUpdated = 0;

        for (const row of data) {
          const mappedRow: any = {};
          for (const [key, value] of Object.entries(row)) {
            const mappedKey = columnMapping[key as keyof typeof columnMapping] || key;
            mappedRow[mappedKey] = value;
          }

          const targa = mappedRow.targa?.toString().trim();
          if (!targa) continue;

          const existingAuto = await client.query(
            'SELECT * FROM auto WHERE targa = $1',
            [targa]
          );

          if (existingAuto.rows.length > 0) {
            await client.query(
              `UPDATE auto 
               SET fornitore = $1, modello = $2, anno = $3, prezzo = $4, 
                   colore = $5, chilometraggio = $6, data_importazione = NOW()
               WHERE targa = $7`,
              [
                fornitoreForzato || mappedRow.fornitore,
                mappedRow.modello,
                mappedRow.anno,
                mappedRow.prezzo,
                mappedRow.colore,
                mappedRow.chilometraggio,
                targa
              ]
            );
            recordsUpdated++;
          } else {
            await client.query(
              `INSERT INTO auto (fornitore, modello, anno, prezzo, colore, targa, chilometraggio, data_importazione)
               VALUES ($1, $2, $3, $4, $5, $6, $7, NOW())`,
              [
                fornitoreForzato || mappedRow.fornitore,
                mappedRow.modello,
                mappedRow.anno,
                mappedRow.prezzo,
                mappedRow.colore,
                targa,
                mappedRow.chilometraggio
              ]
            );
            recordsImported++;
          }
        }

        // Crea il log dell'importazione
        await client.query(
          `INSERT INTO import_logs (file_name, records_imported, success)
           VALUES ($1, $2, true)`,
          [file.name, recordsImported + recordsUpdated]
        );

        res.status(200).json({
          message: `Importati con successo ${recordsImported} nuovi record e aggiornati ${recordsUpdated} record esistenti`
        });
      }
      break;

    case 'import/logs':
      if (req.method === 'GET') {
        const { rows } = await client.query(
          'SELECT * FROM import_logs ORDER BY timestamp DESC'
        );
        res.status(200).json(rows);
      }
      break;

    case 'clear-database':
      if (req.method === 'POST') {
        await client.query('TRUNCATE TABLE auto CASCADE');
        res.status(200).json({ message: 'Database pulito con successo' });
      }
      break;

    case 'health':
      if (req.method === 'GET') {
        res.status(200).json({ status: 'ok', message: 'Backend is running' });
      }
      break;

    default:
      res.status(404).json({ error: 'Route non trovata' });
  }
} 