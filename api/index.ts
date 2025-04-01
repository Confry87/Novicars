import { createClient } from '@vercel/postgres';
import type { VercelRequest, VercelResponse } from '@vercel/node';

const client = createClient();

export default async function handler(req: VercelRequest, res: VercelResponse) {
  try {
    // Gestione CORS
    res.setHeader('Access-Control-Allow-Credentials', 'true');
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT');
    res.setHeader(
      'Access-Control-Allow-Headers',
      'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
    );

    if (req.method === 'OPTIONS') {
      res.status(200).end();
      return;
    }

    // Gestione delle route
    const path = req.url?.split('/api/')[1];

    switch (path) {
      case 'auto':
        if (req.method === 'GET') {
          const { rows } = await client.query('SELECT * FROM auto');
          res.status(200).json(rows);
        }
        break;

      case 'import':
        if (req.method === 'POST') {
          // Implementare la logica di importazione
          res.status(200).json({ message: 'Importazione completata' });
        }
        break;

      case 'import/logs':
        if (req.method === 'GET') {
          const { rows } = await client.query('SELECT * FROM import_logs ORDER BY timestamp DESC');
          res.status(200).json(rows);
        }
        break;

      default:
        res.status(404).json({ error: 'Route non trovata' });
    }
  } catch (error) {
    console.error('Errore:', error);
    res.status(500).json({ error: 'Errore interno del server' });
  }
} 