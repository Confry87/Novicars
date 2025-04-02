import React from 'react';
import { Routes, Route, Link } from 'react-router-dom';
import {
    AppBar,
    Toolbar,
    Typography,
    Container,
    Button,
    Box,
    CssBaseline,
    ThemeProvider,
    createTheme,
} from '@mui/material';
import { AutoSearch } from './components/AutoSearch';
import { ExcelImport } from './components/ExcelImport';

const theme = createTheme({
    palette: {
        primary: {
            main: '#1976d2',
        },
        secondary: {
            main: '#dc004e',
        },
    },
});

function App() {
    return (
        <ThemeProvider theme={theme}>
            <CssBaseline />
            <Box sx={{ flexGrow: 1 }}>
                <AppBar position="static">
                    <Toolbar>
                        <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
                            Gestione Auto
                        </Typography>
                        <Button color="inherit" component={Link} to="/">
                            Ricerca
                        </Button>
                        <Button color="inherit" component={Link} to="/import">
                            Importa
                        </Button>
                    </Toolbar>
                </AppBar>

                <Container maxWidth="lg" sx={{ mt: 4 }}>
                    <Routes>
                        <Route path="/" element={<AutoSearch />} />
                        <Route path="/import" element={<ExcelImport />} />
                    </Routes>
                </Container>
            </Box>
        </ThemeProvider>
    );
}

export default App;
