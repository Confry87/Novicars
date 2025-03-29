import React, { useState } from 'react';
import axios from 'axios';

const ImportForm = () => {
  const [file, setFile] = useState(null);
  const [fornitoreForzato, setFornitoreForzato] = useState('');
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [clearing, setClearing] = useState(false);

  const handleFileChange = (e) => {
    setFile(e.target.files[0]);
    setError('');
  };

  const handleFornitoreChange = (e) => {
    setFornitoreForzato(e.target.value);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!file) {
      setError('Seleziona un file da importare');
      return;
    }

    setLoading(true);
    setError('');
    setMessage('');

    const formData = new FormData();
    formData.append('file', file);
    if (fornitoreForzato) {
      formData.append('fornitore_forzato', fornitoreForzato);
    }

    try {
      const response = await axios.post('http://localhost:5000/api/import', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });

      setMessage(response.data.message);
      setFile(null);
      setFornitoreForzato('');
    } catch (err) {
      setError(err.response?.data?.error || 'Errore durante l\'importazione');
    } finally {
      setLoading(false);
    }
  };

  const handleClearDatabase = async () => {
    if (!window.confirm('Sei sicuro di voler eliminare tutti i record dal database? Questa operazione non può essere annullata.')) {
      return;
    }

    setClearing(true);
    setError('');
    setMessage('');

    try {
      const response = await axios.post('http://localhost:5000/api/clear-database');
      setMessage(response.data.message);
    } catch (err) {
      setError(err.response?.data?.error || 'Errore durante la pulizia del database');
    } finally {
      setClearing(false);
    }
  };

  return (
    <div className="import-form">
      <h2>Importa File Excel</h2>
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label htmlFor="file">File Excel:</label>
          <input
            type="file"
            id="file"
            accept=".xls,.xlsx"
            onChange={handleFileChange}
            disabled={loading}
          />
        </div>

        <div className="form-group">
          <label htmlFor="fornitore">Fornitore Forzato (opzionale):</label>
          <input
            type="text"
            id="fornitore"
            value={fornitoreForzato}
            onChange={handleFornitoreChange}
            placeholder="Inserisci il nome del fornitore"
            disabled={loading}
          />
        </div>

        <div className="button-group">
          <button type="submit" disabled={loading}>
            {loading ? 'Importazione in corso...' : 'Importa'}
          </button>
          
          <button 
            type="button" 
            onClick={handleClearDatabase} 
            disabled={clearing}
            className="danger-button"
          >
            {clearing ? 'Pulizia in corso...' : 'Pulisci Database'}
          </button>
        </div>
      </form>

      {message && <div className="success-message">{message}</div>}
      {error && <div className="error-message">{error}</div>}

      <style jsx>{`
        .button-group {
          display: flex;
          gap: 10px;
          margin-top: 20px;
        }
        
        .danger-button {
          background-color: #dc3545;
          color: white;
          border: none;
          padding: 8px 16px;
          border-radius: 4px;
          cursor: pointer;
        }
        
        .danger-button:hover {
          background-color: #c82333;
        }
        
        .danger-button:disabled {
          background-color: #6c757d;
          cursor: not-allowed;
        }
      `}</style>
    </div>
  );
};

export default ImportForm; 