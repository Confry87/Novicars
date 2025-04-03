import axios from 'axios';
import { Auto, SearchFilters, ImportLog } from '../types';

const API_URL = 'https://novicars-backend.onrender.com';

const api = axios.create({
    baseURL: API_URL,
    timeout: 30000, // Timeout di 30 secondi per le richieste normali
});

// Funzione per ottenere l'URL completo dell'endpoint
const getEndpointUrl = (endpoint: string) => {
    return `/api${endpoint.startsWith('/') ? endpoint : `/${endpoint}`}`;
};

// Funzione helper per gestire gli errori
const handleApiError = (error: any, operation: string): never => {
    console.error(`Errore durante ${operation}:`, error);
    
    if (error.response?.data?.error) {
        throw new Error(error.response.data.error);
    }
    
    if (error.code === 'ECONNABORTED') {
        throw new Error(`La richiesta di ${operation} ha impiegato troppo tempo. Riprova più tardi.`);
    }
    
    if (!error.response) {
        throw new Error(`Impossibile connettersi al server durante ${operation}. Verifica la tua connessione internet.`);
    }
    
    throw new Error(`Errore durante ${operation}. Riprova più tardi.`);
};

export const apiService = {
    // Ricerca auto
    searchAutos: async (filters: SearchFilters): Promise<Auto[]> => {
        try {
            const response = await api.get('/api/auto', { 
                params: filters,
                headers: {
                    'Content-Type': 'application/json'
                }
            });
            return response.data;
        } catch (error: any) {
            handleApiError(error, 'ricerca delle auto');
        }
    },

    // Ottieni una singola auto per ID
    getAutoById: async (id: number): Promise<Auto> => {
        try {
            const response = await api.get(`/api/auto/${id}`, {
                headers: {
                    'Content-Type': 'application/json'
                }
            });
            return response.data;
        } catch (error: any) {
            handleApiError(error, `recupero dell'auto con ID ${id}`);
        }
    },

    // Importa file Excel
    importExcel: async (file: File, fornitoreForzato?: string): Promise<ImportLog> => {
        try {
            const formData = new FormData();
            formData.append('file', file);
            if (fornitoreForzato) {
                formData.append('fornitore_forzato', fornitoreForzato);
            }

            const response = await api.post('/api/import', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
                timeout: 60000, // Timeout più lungo per l'importazione
            });

            if (!response.data || !response.data.log) {
                throw new Error('Risposta non valida dal server durante l\'importazione');
            }

            return response.data.log;
        } catch (error: any) {
            handleApiError(error, 'importazione del file Excel');
        }
    },

    // Ottieni log importazioni
    getImportLogs: async (): Promise<ImportLog[]> => {
        try {
            const response = await api.get('/api/import/logs', {
                headers: {
                    'Content-Type': 'application/json'
                }
            });
            return response.data;
        } catch (error: any) {
            handleApiError(error, 'recupero dei log di importazione');
        }
    },

    // Pulisci database
    clearDatabase: async (): Promise<any> => {
        try {
            const response = await api.post('/api/clear-database', null, {
                headers: {
                    'Content-Type': 'application/json'
                }
            });
            return response.data;
        } catch (error: any) {
            handleApiError(error, 'pulizia del database');
        }
    }
}; 