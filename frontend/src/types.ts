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
    annoMin?: string;
    annoMax?: string;
    prezzoMin?: string;
    prezzoMax?: string;
    colore?: string;
    targa?: string;
    chilometraggioMin?: string;
    chilometraggioMax?: string;
}

export interface ImportLog {
    id: number;
    file_name: string;
    timestamp: string;
    records_imported: number;
    success: boolean;
    error_message: string | null;
    message?: string;
} 