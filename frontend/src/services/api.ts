import axios from 'axios';
import { Auto, SearchFilters, ImportLog } from '../types';
import { getApiUrl } from '../config';

const api = axios.create({
    baseURL: getApiUrl(''),
    timeout: 10000,
    withCredentials: true,
    headers: {
        'Content-Type': 'application/json'
    }
});

// Configura l'interceptor per il token
api.interceptors.request.use(
    (config) => {
        const token = localStorage.getItem('token');
        if (token) {
            config.headers.Authorization = `Bearer ${token}`;
        }
        return config;
    },
    (error) => {
        return Promise.reject(error);
    }
);

// Configura l'interceptor per gestire gli errori
api.interceptors.response.use(
    (response) => {
        return response;
    },
    (error) => {
        if (error.response) {
            // La richiesta è stata effettuata e il server ha risposto con un codice di stato
            // che non rientra nell'intervallo 2xx
            console.error('Errore dal server:', error.response.data);
        } else if (error.request) {
            // La richiesta è stata effettuata ma non è stata ricevuta alcuna risposta
            console.error('Nessuna risposta dal server:', error.request);
        } else {
            // Si è verificato un errore durante la configurazione della richiesta
            console.error('Errore configurazione richiesta:', error.message);
        }
        return Promise.reject(error);
    }
);

export const autoService = {
    // Ottieni tutte le auto con filtri opzionali
    getAutos: async (filters?: SearchFilters): Promise<Auto[]> => {
        try {
            const response = await api.get('auto', { params: filters });
            return response.data;
        } catch (error) {
            console.error('Errore nel recupero delle auto:', error);
            throw error;
        }
    },

    // Ottieni una singola auto per ID
    getAutoById: async (id: number): Promise<Auto> => {
        try {
            const response = await api.get(`auto/${id}`);
            return response.data;
        } catch (error) {
            console.error(`Errore nel recupero dell'auto con ID ${id}:`, error);
            throw error;
        }
    },

    // Importa un file Excel
    importExcel: async (file: File): Promise<ImportLog> => {
        try {
            const formData = new FormData();
            formData.append('file', file);
            const response = await api.post('import', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });
            return response.data;
        } catch (error) {
            console.error('Errore durante l\'importazione del file Excel:', error);
            throw error;
        }
    },

    // Ottieni i log di importazione
    getImportLogs: async (): Promise<ImportLog[]> => {
        try {
            const response = await api.get('import/logs');
            return response.data;
        } catch (error) {
            console.error('Errore nel recupero dei log di importazione:', error);
            throw error;
        }
    },
}; 