import React, { useState } from 'react';
import {
    Box,
    TextField,
    Button,
    Grid,
    Paper,
    Table,
    TableBody,
    TableCell,
    TableContainer,
    TableHead,
    TableRow,
    Typography,
    CircularProgress,
} from '@mui/material';
import { Auto, SearchFilters } from '../types';
import { autoService } from '../services/api';

export const AutoSearch: React.FC = () => {
    const [autos, setAutos] = useState<Auto[]>([]);
    const [loading, setLoading] = useState(false);
    const [filters, setFilters] = useState<SearchFilters>({});

    const handleSearch = async () => {
        setLoading(true);
        try {
            const data = await autoService.getAutos(filters);
            setAutos(data);
        } catch (error) {
            console.error('Errore durante la ricerca:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleFilterChange = (field: keyof SearchFilters, value: string | number) => {
        setFilters(prev => ({
            ...prev,
            [field]: value,
        }));
    };

    return (
        <Box sx={{ p: 3 }}>
            <Typography variant="h4" gutterBottom>
                Ricerca Auto
            </Typography>

            <Paper sx={{ p: 2, mb: 3 }}>
                <Grid container spacing={2}>
                    <Grid item xs={12} sm={6} md={3}>
                        <TextField
                            fullWidth
                            label="Fornitore"
                            value={filters.fornitore || ''}
                            onChange={(e: React.ChangeEvent<HTMLInputElement>) => handleFilterChange('fornitore', e.target.value)}
                        />
                    </Grid>
                    <Grid item xs={12} sm={6} md={3}>
                        <TextField
                            fullWidth
                            label="Modello"
                            value={filters.modello || ''}
                            onChange={(e: React.ChangeEvent<HTMLInputElement>) => handleFilterChange('modello', e.target.value)}
                        />
                    </Grid>
                    <Grid item xs={12} sm={6} md={3}>
                        <TextField
                            fullWidth
                            label="Colore"
                            value={filters.colore || ''}
                            onChange={(e: React.ChangeEvent<HTMLInputElement>) => handleFilterChange('colore', e.target.value)}
                        />
                    </Grid>
                    <Grid item xs={12} sm={6} md={3}>
                        <TextField
                            fullWidth
                            type="number"
                            label="Anno"
                            value={filters.anno || ''}
                            onChange={(e: React.ChangeEvent<HTMLInputElement>) => handleFilterChange('anno', parseInt(e.target.value))}
                        />
                    </Grid>
                    <Grid item xs={12} sm={6} md={3}>
                        <TextField
                            fullWidth
                            type="number"
                            label="Prezzo Min"
                            value={filters.prezzoMin || ''}
                            onChange={(e: React.ChangeEvent<HTMLInputElement>) => handleFilterChange('prezzoMin', parseFloat(e.target.value))}
                        />
                    </Grid>
                    <Grid item xs={12} sm={6} md={3}>
                        <TextField
                            fullWidth
                            type="number"
                            label="Prezzo Max"
                            value={filters.prezzoMax || ''}
                            onChange={(e: React.ChangeEvent<HTMLInputElement>) => handleFilterChange('prezzoMax', parseFloat(e.target.value))}
                        />
                    </Grid>
                    <Grid item xs={12} sm={6} md={3}>
                        <TextField
                            fullWidth
                            type="number"
                            label="Chilometraggio Min"
                            value={filters.chilometraggioMin || ''}
                            onChange={(e: React.ChangeEvent<HTMLInputElement>) => handleFilterChange('chilometraggioMin', parseInt(e.target.value))}
                        />
                    </Grid>
                    <Grid item xs={12} sm={6} md={3}>
                        <TextField
                            fullWidth
                            type="number"
                            label="Chilometraggio Max"
                            value={filters.chilometraggioMax || ''}
                            onChange={(e: React.ChangeEvent<HTMLInputElement>) => handleFilterChange('chilometraggioMax', parseInt(e.target.value))}
                        />
                    </Grid>
                    <Grid item xs={12}>
                        <Button
                            variant="contained"
                            onClick={handleSearch}
                            disabled={loading}
                            startIcon={loading ? <CircularProgress size={20} /> : null}
                        >
                            Cerca
                        </Button>
                    </Grid>
                </Grid>
            </Paper>

            <TableContainer component={Paper}>
                <Table>
                    <TableHead>
                        <TableRow>
                            <TableCell>Fornitore</TableCell>
                            <TableCell>Modello</TableCell>
                            <TableCell>Anno</TableCell>
                            <TableCell>Prezzo</TableCell>
                            <TableCell>Colore</TableCell>
                            <TableCell>Chilometraggio</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {autos.map((auto) => (
                            <TableRow key={auto.id}>
                                <TableCell>{auto.fornitore || '-'}</TableCell>
                                <TableCell>{auto.modello || '-'}</TableCell>
                                <TableCell>{auto.anno || '-'}</TableCell>
                                <TableCell>€{auto.prezzo ? auto.prezzo.toLocaleString() : '-'}</TableCell>
                                <TableCell>{auto.colore || '-'}</TableCell>
                                <TableCell>{auto.chilometraggio ? `${auto.chilometraggio.toLocaleString()} km` : '-'}</TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </TableContainer>
        </Box>
    );
}; 