import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link, Navigate } from 'react-router-dom';
import {
    AppBar,
    Toolbar,
    Typography,
    Container,
    Button,
    Box,
    CssBaseline,
    ThemeProvider,
} from '@mui/material';
import { AutoSearch } from './components/AutoSearch';
import { ExcelImport } from './components/ExcelImport';
import Login from './components/Login';
import theme from './theme';
import Layout from './components/Layout';
import Dashboard from './components/Dashboard';
import { useAuth } from './hooks/useAuth';

// Componente per proteggere le route
const ProtectedRoute: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const token = localStorage.getItem('token');
    if (!token) {
        return <Navigate to="/login" />;
    }
    return <>{children}</>;
};

function App() {
    const token = localStorage.getItem('token');
    const username = localStorage.getItem('username');

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('username');
        window.location.href = '/login';
    };

    return (
        <ThemeProvider theme={theme}>
            <CssBaseline />
            <Box sx={{ flexGrow: 1 }}>
                {token && (
                    <AppBar position="static">
                        <Toolbar>
                            <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
                                Gestione Auto
                            </Typography>
                            <Typography variant="body1" sx={{ mr: 2 }}>
                                {username}
                            </Typography>
                            <Button color="inherit" component={Link} to="/">
                                Ricerca
                            </Button>
                            <Button color="inherit" component={Link} to="/import">
                                Importa
                            </Button>
                            <Button color="inherit" onClick={handleLogout}>
                                Logout
                            </Button>
                        </Toolbar>
                    </AppBar>
                )}

                <Container maxWidth="lg" sx={{ mt: 4 }}>
                    <Routes>
                        <Route path="/login" element={<Login />} />
                        <Route
                            path="/"
                            element={
                                <ProtectedRoute>
                                    <AutoSearch />
                                </ProtectedRoute>
                            }
                        />
                        <Route
                            path="/import"
                            element={
                                <ProtectedRoute>
                                    <ExcelImport />
                                </ProtectedRoute>
                            }
                        />
                    </Routes>
                </Container>
            </Box>
        </ThemeProvider>
    );
}

export default App;
