// Configurazione dell'API
export const API_URL = 'https://novicars-backend.onrender.com/api';

// Configurazione di Axios
export const axiosConfig = {
  baseURL: API_URL,
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json'
  }
};

// Log dell'URL del backend per debug
console.log('Backend URL:', API_URL); 