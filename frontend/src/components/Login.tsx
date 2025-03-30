import React, { useState } from 'react';
import {
    Box,
    Button,
    TextField,
    Typography,
    Paper,
    Alert,
} from '@mui/material';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import { getApiUrl } from '../config';

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
            console.log(`Connecting to: ${getApiUrl('login')}`);
            const response = await axios.post<LoginResponse>(getApiUrl('login'), {
                username,
                password,
            });

            // Salva il token nel localStorage
            localStorage.setItem('token', response.data.access_token);
            localStorage.setItem('username', response.data.username);

            // Reindirizza alla home
            navigate('/');
        } catch (err: any) {
            console.error('Login error:', err);
            if (err.response) {
                setError(err.response.data?.error || 'Errore durante il login');
            } else if (err.request) {
                setError('Impossibile connettersi al server. Verifica la tua connessione.');
            } else {
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