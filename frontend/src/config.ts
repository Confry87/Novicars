// Configurazione dell'API
export const getApiUrl = () => {
  // In sviluppo, usa l'URL locale
  if (import.meta.env.DEV) {
    return 'http://localhost:5000';
  }
  
  // In produzione, usa il proxy Netlify
  return '';
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