export const API_URL = import.meta.env.VITE_API_URL || 'https://novicars-backend.railway.app';

// Verifica se l'URL ha già il percorso /api
export const getApiUrl = (endpoint: string) => {
  const baseUrl = API_URL.endsWith('/api') 
    ? API_URL 
    : `${API_URL}/api`;
  
  return `${baseUrl}${endpoint.startsWith('/') ? endpoint : `/${endpoint}`}`;
}; 