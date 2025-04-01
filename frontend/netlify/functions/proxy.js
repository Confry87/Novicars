const axios = require('axios');

const BACKEND_URL = 'https://novicars-backend.railway.app';

exports.handler = async function(event, context) {
  // Log della richiesta
  console.log('Request:', {
    path: event.path,
    method: event.httpMethod,
    headers: event.headers,
    body: event.body
  });

  // Gestione delle richieste OPTIONS
  if (event.httpMethod === 'OPTIONS') {
    return {
      statusCode: 200,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Max-Age': '86400'
      }
    };
  }

  try {
    // Costruisci l'URL del backend
    const path = event.path.replace('/.netlify/functions/proxy', '');
    const url = `${BACKEND_URL}${path}`;

    // Configura la richiesta
    const config = {
      method: event.httpMethod,
      url: url,
      headers: {
        ...event.headers,
        host: new URL(BACKEND_URL).host
      },
      data: event.body ? JSON.parse(event.body) : undefined,
      validateStatus: function (status) {
        return status >= 200 && status < 500; // Accetta tutti gli status code tranne 500
      }
    };

    // Invia la richiesta al backend
    const response = await axios(config);

    // Log della risposta
    console.log('Response:', {
      status: response.status,
      headers: response.headers,
      data: response.data
    });

    // Restituisci la risposta
    return {
      statusCode: response.status,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(response.data)
    };

  } catch (error) {
    console.error('Error:', error);

    // Gestione degli errori
    return {
      statusCode: error.response?.status || 500,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        error: error.message || 'Internal Server Error'
      })
    };
  }
}; 