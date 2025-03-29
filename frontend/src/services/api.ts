import axios from 'axios';
import { Auto, SearchFilters, ImportLog } from '../types';

const API_URL = 'http://localhost:5000/api';

const api = axios.create({
    baseURL: API_URL,
    headers: {
        'Content-Type': 'application/json',
    },
    timeout: 10000, // 10 secondi di timeout
});

// Interceptor per gestire gli errori
api.interceptors.response.use(
    response => response,
    (error) => {
        if (error.code === 'ERR_NETWORK') {
            console.error('Errore di rete: Impossibile connettersi al server. Assicurati che il backend sia in esecuzione.');
        }
        return Promise.reject(error);
    }
);

export const autoService = {
    // Ottieni tutte le auto con filtri opzionali
    getAutos: async (filters?: SearchFilters): Promise<Auto[]> => {
        try {
            const response = await api.get<Auto[]>('/auto', { params: filters });
            return response.data;
        } catch (error) {
            console.error('Errore nel recupero delle auto:', error);
            throw error;
        }
    },

    // Ottieni una singola auto per ID
    getAutoById: async (id: number): Promise<Auto> => {
        try {
            const response = await api.get<Auto>(`/auto/${id}`);
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
            const response = await api.post<ImportLog>('/import', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });
            return response.data;
        } catch (error) {
            console.error('Errore nell\'importazione del file:', error);
            throw error;
        }
    },

    // Ottieni i log di importazione
    getImportLogs: async (): Promise<ImportLog[]> => {
        try {
            const response = await api.get<ImportLog[]>('/import/logs');
            return response.data;
        } catch (error) {
            console.error('Errore nel recupero dei log di importazione:', error);
            throw error;
        }
    },
}; 