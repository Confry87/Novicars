import React, { useState, useEffect } from 'react';
import {
    Box,
    TextField,
    Button,
    Typography,
    Paper,
    Table,
    TableBody,
    TableCell,
    TableContainer,
    TableHead,
    TableRow,
    CircularProgress,
    Alert,
} from '@mui/material';
import { apiService } from '../services/api';
import { Auto } from '../types';

export const AutoSearch: React.FC = () => {
    const [filters, setFilters] = useState({
        fornitore: '',
        modello: '',
        annoMin: '',
        annoMax: '',
        prezzoMin: '',
        prezzoMax: '',
        colore: '',
        targa: '',
        chilometraggioMin: '',
        chilometraggioMax: '',
    });
    const [autos, setAutos] = useState<Auto[]>([]);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);

    const handleSearch = async () => {
        setLoading(true);
        setError(null);
        try {
            const data = await apiService.searchAutos(filters);
            setAutos(data);
        } catch (err) {
            setError('Errore durante la ricerca delle auto');
            console.error('Errore:', err);
        } finally {
            setLoading(false);
        }
    };

    const handleReset = () => {
        setFilters({
            fornitore: '',
            modello: '',
            annoMin: '',
            annoMax: '',
            prezzoMin: '',
            prezzoMax: '',
            colore: '',
            targa: '',
            chilometraggioMin: '',
            chilometraggioMax: '',
        });
        setAutos([]);
    };

    return (
        <Box>
            <Paper elevation={3} sx={{ p: 3, mb: 3 }}>
                <Typography variant="h5" gutterBottom>
                    Ricerca Auto
                </Typography>

                <Box sx={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: 2 }}>
                    <TextField
                        label="Fornitore"
                        value={filters.fornitore}
                        onChange={(e) => setFilters({ ...filters, fornitore: e.target.value })}
                        fullWidth
                    />
                    <TextField
                        label="Modello"
                        value={filters.modello}
                        onChange={(e) => setFilters({ ...filters, modello: e.target.value })}
                        fullWidth
                    />
                    <TextField
                        label="Anno Min"
                        type="number"
                        value={filters.annoMin}
                        onChange={(e) => setFilters({ ...filters, annoMin: e.target.value })}
                        fullWidth
                    />
                    <TextField
                        label="Anno Max"
                        type="number"
                        value={filters.annoMax}
                        onChange={(e) => setFilters({ ...filters, annoMax: e.target.value })}
                        fullWidth
                    />
                    <TextField
                        label="Prezzo Min"
                        type="number"
                        value={filters.prezzoMin}
                        onChange={(e) => setFilters({ ...filters, prezzoMin: e.target.value })}
                        fullWidth
                    />
                    <TextField
                        label="Prezzo Max"
                        type="number"
                        value={filters.prezzoMax}
                        onChange={(e) => setFilters({ ...filters, prezzoMax: e.target.value })}
                        fullWidth
                    />
                    <TextField
                        label="Colore"
                        value={filters.colore}
                        onChange={(e) => setFilters({ ...filters, colore: e.target.value })}
                        fullWidth
                    />
                    <TextField
                        label="Targa"
                        value={filters.targa}
                        onChange={(e) => setFilters({ ...filters, targa: e.target.value })}
                        fullWidth
                    />
                    <TextField
                        label="Chilometraggio Min"
                        type="number"
                        value={filters.chilometraggioMin}
                        onChange={(e) => setFilters({ ...filters, chilometraggioMin: e.target.value })}
                        fullWidth
                    />
                    <TextField
                        label="Chilometraggio Max"
                        type="number"
                        value={filters.chilometraggioMax}
                        onChange={(e) => setFilters({ ...filters, chilometraggioMax: e.target.value })}
                        fullWidth
                    />
                </Box>

                <Box sx={{ mt: 2, display: 'flex', gap: 2 }}>
                    <Button
                        variant="contained"
                        onClick={handleSearch}
                        disabled={loading}
                        startIcon={loading ? <CircularProgress size={20} /> : null}
                    >
                        {loading ? 'Ricerca in corso...' : 'Cerca'}
                    </Button>
                    <Button variant="outlined" onClick={handleReset}>
                        Reset
                    </Button>
                </Box>
            </Paper>

            {error && (
                <Alert severity="error" sx={{ mb: 2 }}>
                    {error}
                </Alert>
            )}

            {autos.length > 0 && (
                <TableContainer component={Paper}>
                    <Table>
                        <TableHead>
                            <TableRow>
                                <TableCell>ID</TableCell>
                                <TableCell>Fornitore</TableCell>
                                <TableCell>Modello</TableCell>
                                <TableCell>Anno</TableCell>
                                <TableCell>Prezzo</TableCell>
                                <TableCell>Colore</TableCell>
                                <TableCell>Targa</TableCell>
                                <TableCell>Chilometraggio</TableCell>
                                <TableCell>Data Importazione</TableCell>
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {autos.map((auto) => (
                                <TableRow key={auto.id}>
                                    <TableCell>{auto.id}</TableCell>
                                    <TableCell>{auto.fornitore}</TableCell>
                                    <TableCell>{auto.modello}</TableCell>
                                    <TableCell>{auto.anno}</TableCell>
                                    <TableCell>€{auto.prezzo.toLocaleString()}</TableCell>
                                    <TableCell>{auto.colore}</TableCell>
                                    <TableCell>{auto.targa}</TableCell>
                                    <TableCell>{auto.chilometraggio?.toLocaleString()}</TableCell>
                                    <TableCell>
                                        {new Date(auto.data_importazione).toLocaleString()}
                                    </TableCell>
                                </TableRow>
                            ))}
                        </TableBody>
                    </Table>
                </TableContainer>
            )}
        </Box>
    );
}; 