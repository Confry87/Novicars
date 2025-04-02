import axios from 'axios';
import { Auto, SearchFilters, ImportLog } from '../types';

const API_URL = 'https://novicars-backend.onrender.com';

const api = axios.create({
    baseURL: API_URL,
    headers: {
        'Content-Type': 'application/json',
    }
});

// Funzione per ottenere l'URL completo dell'endpoint
const getEndpointUrl = (endpoint: string) => {
    return `/api${endpoint.startsWith('/') ? endpoint : `/${endpoint}`}`;
};

export const apiService = {
    // Ricerca auto
    searchAutos: async (filters: SearchFilters): Promise<Auto[]> => {
        try {
            const response = await api.get('/api/auto', { params: filters });
            return response.data;
        } catch (error) {
            console.error('Errore nel recupero delle auto:', error);
            throw error;
        }
    },

    // Ottieni una singola auto per ID
    getAutoById: async (id: number): Promise<Auto> => {
        try {
            const response = await api.get(`/api/auto/${id}`);
            return response.data;
        } catch (error) {
            console.error(`Errore nel recupero dell'auto con ID ${id}:`, error);
            throw error;
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
            });
            return response.data;
        } catch (error) {
            console.error('Errore durante l\'importazione del file Excel:', error);
            throw error;
        }
    },

    // Ottieni log importazioni
    getImportLogs: async (): Promise<ImportLog[]> => {
        try {
            const response = await api.get('/api/import/logs');
            return response.data;
        } catch (error) {
            console.error('Errore nel recupero dei log di importazione:', error);
            throw error;
        }
    },

    // Pulisci database
    clearDatabase: async () => {
        try {
            const response = await api.post('/api/clear-database');
            return response.data;
        } catch (error) {
            console.error('Errore durante la pulizia del database:', error);
            throw error;
        }
    }
}; 