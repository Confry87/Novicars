import React, { useState } from 'react';
import {
    Box,
    Button,
    TextField,
    Typography,
    Paper,
    Alert,
} from '@mui/material';
import { useNavigate } from 'react-router-dom';
import { getApiUrl } from '../config';
import axios from 'axios';

interface LoginResponse {
    access_token: string;
    username: string;
}

export const Login: React.FC = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError('');
        setLoading(true);

        try {
            const url = getApiUrl('login');
            console.log(`Connecting to: ${url}`);
            
            const response = await axios.post<LoginResponse>(url, {
                username,
                password,
            }, {
                withCredentials: true,
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            });

            console.log('Login response:', response.data);

            // Salva il token nel localStorage
            localStorage.setItem('token', response.data.access_token);
            localStorage.setItem('username', response.data.username);

            // Reindirizza alla home
            navigate('/');
        } catch (err: any) {
            console.error('Login error:', err);
            if (err.response) {
                // Il server ha risposto con un errore
                console.error('Server response:', err.response.data);
                setError(err.response.data?.error || 'Errore durante il login');
            } else if (err.request) {
                // La richiesta è stata fatta ma non è stata ricevuta risposta
                console.error('No response received:', err.request);
                setError('Impossibile connettersi al server. Verifica la tua connessione.');
            } else {
                // Errore nella configurazione della richiesta
                console.error('Request error:', err.message);
                setError('Errore durante la richiesta di login');
            }
        } finally {
            setLoading(false);
        }
    };

    return (
        <Box
            sx={{
                display: 'flex',
                justifyContent: 'center',
                alignItems: 'center',
                minHeight: '100vh',
                bgcolor: 'background.default',
            }}
        >
            <Paper elevation={3} sx={{ p: 4, maxWidth: 400, width: '100%' }}>
                <Typography variant="h5" component="h1" gutterBottom>
                    Login
                </Typography>

                {error && (
                    <Alert severity="error" sx={{ mb: 2 }}>
                        {error}
                    </Alert>
                )}

                <Box component="form" onSubmit={handleSubmit}>
                    <TextField
                        fullWidth
                        label="Username"
                        value={username}
                        onChange={(e) => setUsername(e.target.value)}
                        margin="normal"
                        required
                        disabled={loading}
                    />
                    <TextField
                        fullWidth
                        label="Password"
                        type="password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        margin="normal"
                        required
                        disabled={loading}
                    />
                    <Button
                        type="submit"
                        fullWidth
                        variant="contained"
                        sx={{ mt: 3 }}
                        disabled={loading}
                    >
                        {loading ? 'Login in corso...' : 'Accedi'}
                    </Button>
                </Box>
            </Paper>
        </Box>
    );
}; 