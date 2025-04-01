import axios, { AxiosError } from 'axios';
import { Auto, SearchFilters, ImportLog } from '../types';
import { getApiUrl, axiosConfig } from '../config';

// Crea un'istanza di axios con la configurazione
const api = axios.create(axiosConfig);

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

// Interceptor per gestire gli errori
api.interceptors.response.use(
    response => response,
    error => {
        if (error instanceof AxiosError) {
            console.error('API Error:', {
                status: error.response?.status,
                data: error.response?.data,
                headers: error.response?.headers
            });
        }
        return Promise.reject(error);
    }
);

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
    // Login
    login: async (username: string, password: string) => {
        try {
            const response = await api.post(getEndpointUrl('/login'), { username, password });
            return response.data;
        } catch (error) {
            console.error('Login error:', error);
            throw error;
        }
    },

    // Ottieni tutte le auto
    getAutos: async () => {
        try {
            const response = await api.get(getEndpointUrl('/auto'));
            return response.data;
        } catch (error) {
            console.error('Get autos error:', error);
            throw error;
        }
    },

    // Ottieni un'auto specifica
    getAutoById: async (id: number) => {
        try {
            const response = await api.get(getEndpointUrl(`/auto/${id}`));
            return response.data;
        } catch (error) {
            console.error('Get auto by id error:', error);
            throw error;
        }
    },

    // Importa file Excel
    importExcel: async (file: File) => {
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
            console.error('Import excel error:', error);
            throw error;
        }
    },

    // Ottieni i log di importazione
    getImportLogs: async () => {
        try {
            const response = await api.get(getEndpointUrl('/import/logs'));
            return response.data;
        } catch (error) {
            console.error('Get import logs error:', error);
            throw error;
        }
    }
}; 