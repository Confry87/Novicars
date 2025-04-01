-- Tabella Auto
CREATE TABLE IF NOT EXISTS auto (
    id SERIAL PRIMARY KEY,
    fornitore VARCHAR(200) NOT NULL,
    modello VARCHAR(500) NOT NULL,
    anno INTEGER,
    prezzo DECIMAL(10,2),
    colore VARCHAR(200),
    targa VARCHAR(20),
    chilometraggio INTEGER,
    data_importazione TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabella ImportLogs
CREATE TABLE IF NOT EXISTS import_logs (
    id SERIAL PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    records_imported INTEGER DEFAULT 0,
    success BOOLEAN DEFAULT true,
    error_message TEXT
);

-- Indici per migliorare le performance
CREATE INDEX IF NOT EXISTS idx_auto_targa ON auto(targa);
CREATE INDEX IF NOT EXISTS idx_auto_fornitore ON auto(fornitore);
CREATE INDEX IF NOT EXISTS idx_auto_modello ON auto(modello);
CREATE INDEX IF NOT EXISTS idx_import_logs_timestamp ON import_logs(timestamp); 