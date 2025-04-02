// Configurazione dell'API
export const getApiUrl = () => {
  // In sviluppo, usa l'URL locale
  if (import.meta.env.DEV) {
    return 'http://localhost:5000';
  }
  
  // In produzione, usa l'URL di Render
  return 'https://novicars-backend.onrender.com';
};

// Configurazione di Axios
export const axiosConfig = {
  baseURL: getApiUrl(),
  withCredentials: true,
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json'
  }
};

// Log dell'URL del backend per debug
console.log('Backend URL:', getApiUrl()); 