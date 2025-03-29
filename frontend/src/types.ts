export interface Auto {
    id: number;
    fornitore: string;
    modello: string;
    anno: number;
    chilometraggio: number;
    colore: string;
    prezzo: number;
    data_importazione: string;
}

export interface SearchFilters {
    fornitore?: string;
    modello?: string;
    anno?: number;
    prezzoMin?: number;
    prezzoMax?: number;
    colore?: string;
    chilometraggioMin?: number;
    chilometraggioMax?: number;
}

export interface ImportLog {
    id: number;
    nome_file: string;
    data_importazione: string;
    numero_record: number;
    record_aggiornati: number;
    record_inseriti: number;
    errori?: string;
} 