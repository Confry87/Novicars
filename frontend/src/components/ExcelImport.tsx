import React, { useState } from 'react';
import {
    Box,
    Button,
    TextField,
    Typography,
    Paper,
    Alert,
    CircularProgress,
} from '@mui/material';
import { apiService } from '../services/api';

interface ApiResponse {
    message: string;
    error?: string;
}

interface ApiError {
    response?: {
        data?: {
            error: string;
        };
    };
}

export const ExcelImport: React.FC = () => {
    const [file, setFile] = useState<File | null>(null);
    const [fornitoreForzato, setFornitoreForzato] = useState<string>('');
    const [message, setMessage] = useState<string>('');
    const [error, setError] = useState<string>('');
    const [loading, setLoading] = useState<boolean>(false);
    const [clearing, setClearing] = useState<boolean>(false);

    const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        if (e.target.files && e.target.files[0]) {
            setFile(e.target.files[0]);
            setError('');
        }
    };

    const handleFornitoreChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        setFornitoreForzato(e.target.value);
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!file) {
            setError('Seleziona un file da importare');
            return;
        }

        setLoading(true);
        setError('');
        setMessage('');

        try {
            const response = await apiService.importExcel(file, fornitoreForzato || undefined);
            setMessage(response.message || 'Importazione completata con successo');
            setFile(null);
            setFornitoreForzato('');
        } catch (err) {
            const error = err as ApiError;
            setError(error.response?.data?.error || 'Errore durante l\'importazione');
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
            const response = await apiService.clearDatabase();
            setMessage(response.message || 'Database pulito con successo');
        } catch (err) {
            const error = err as ApiError;
            setError(error.response?.data?.error || 'Errore durante la pulizia del database');
        } finally {
            setClearing(false);
        }
    };

    return (
        <Paper elevation={3} sx={{ p: 3 }}>
            <Typography variant="h5" gutterBottom>
                Importa File Excel
            </Typography>

            <Box component="form" onSubmit={handleSubmit} sx={{ mt: 2 }}>
                <TextField
                    fullWidth
                    type="file"
                    onChange={handleFileChange}
                    disabled={loading}
                    sx={{ mb: 2 }}
                    inputProps={{
                        accept: '.xls,.xlsx'
                    }}
                />

                <TextField
                    fullWidth
                    label="Fornitore Forzato (opzionale)"
                    value={fornitoreForzato}
                    onChange={handleFornitoreChange}
                    disabled={loading}
                    sx={{ mb: 2 }}
                />

                <Box sx={{ display: 'flex', gap: 2 }}>
                    <Button
                        type="submit"
                        variant="contained"
                        disabled={loading || !file}
                        startIcon={loading ? <CircularProgress size={20} /> : null}
                    >
                        {loading ? 'Importazione in corso...' : 'Importa'}
                    </Button>

                    <Button
                        type="button"
                        variant="contained"
                        color="error"
                        onClick={handleClearDatabase}
                        disabled={clearing}
                        startIcon={clearing ? <CircularProgress size={20} /> : null}
                    >
                        {clearing ? 'Pulizia in corso...' : 'Pulisci Database'}
                    </Button>
                </Box>
            </Box>

            {message && (
                <Alert severity="success" sx={{ mt: 2 }}>
                    {message}
                </Alert>
            )}

            {error && (
                <Alert severity="error" sx={{ mt: 2 }}>
                    {error}
                </Alert>
            )}
        </Paper>
    );
}; 