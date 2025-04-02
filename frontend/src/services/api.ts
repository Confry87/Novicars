import axios from 'axios';
import { Auto, SearchFilters, ImportLog } from '../types';
import { getApiUrl, axiosConfig } from '../config';

const API_URL = 'https://novicars-backend.onrender.com/api';

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

export const autoService = {
    // Ottieni tutte le auto con filtri opzionali
    getAutos: async (filters?: SearchFilters): Promise<Auto[]> => {
        try {
            const response = await api.get(getEndpointUrl('/auto'), { params: filters });
            return response.data;
        } catch (error) {
            console.error('Errore nel recupero delle auto:', error);
            throw error;
        }
    },

    // Ottieni una singola auto per ID
    getAutoById: async (id: number): Promise<Auto> => {
        try {
            const response = await api.get(getEndpointUrl(`/auto/${id}`));
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
            const response = await api.post(getEndpointUrl('/import'), formData, {
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
            const response = await api.get(getEndpointUrl('/import/logs'));
            return response.data;
        } catch (error) {
            console.error('Errore nel recupero dei log di importazione:', error);
            throw error;
        }
    },
};

export const apiService = {
    // Ricerca auto
    searchAutos: async (filters: any) => {
        const response = await api.get('/auto', { params: filters });
        return response.data;
    },

    // Importa file Excel
    importExcel: async (file: File, fornitoreForzato?: string) => {
        const formData = new FormData();
        formData.append('file', file);
        if (fornitoreForzato) {
            formData.append('fornitore_forzato', fornitoreForzato);
        }
        const response = await api.post('/import', formData);
        return response.data;
    },

    // Ottieni log importazioni
    getImportLogs: async () => {
        const response = await api.get('/import/logs');
        return response.data;
    },

    // Pulisci database
    clearDatabase: async () => {
        const response = await api.post('/clear-database');
        return response.data;
    }
}; 