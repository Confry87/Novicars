export interface Auto {
    id: number;
    marca: string;
    modello: string;
    anno: number;
    prezzo: number;
    colore: string;
    targa: string;
    chilometraggio: number;
    data_importazione: string;
}

export interface ImportLog {
    id: number;
    file_name: string;
    timestamp: string;
    records_imported: number;
    success: boolean;
    error_message: string | null;
}

export interface SearchFilters {
    marca?: string;
    modello?: string;
    annoMin?: number;
    annoMax?: number;
    prezzoMin?: number;
    prezzoMax?: number;
    colore?: string;
    targa?: string;
    chilometraggioMin?: number;
    chilometraggioMax?: number;
} 