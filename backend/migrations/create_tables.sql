CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS auto (
    id SERIAL PRIMARY KEY,
    marca VARCHAR(50),
    modello VARCHAR(50),
    versione VARCHAR(100),
    anno INTEGER,
    km INTEGER,
    prezzo DECIMAL(10,2),
    note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
); 