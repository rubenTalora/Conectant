export const riberaTowns = [
    // Ribera Alta (35 municipios)
    'Alberic',
    'Alcàntera de Xúquer',
    "l'Alcúdia",
    'Alfarb',
    'Algemesí',
    'Alginet',
    'Alzira',
    'Antella',
    'Beneixida',
    'Benifaió',
    'Benimodo',
    'Benimuslem',
    'Carcaixent',
    'Càrcer',
    'Carlet',
    'Castelló',
    'Catadau',
    'Cotes',
    "l'Énova",
    'Gavarda',
    'Guadassuar',
    'Llombai',
    'Manuel',
    'Massalavés',
    'Montserrat',
    'Montroy',
    'la Pobla Llarga',
    'Rafelguaraf',
    'Real',
    'Sant Joanet',
    'Sellent',
    'Senyera',
    'Sumacàrcer',
    'Tous',
    'Turís',
    // Ribera Baixa (12 municipios)
    'Albalat de la Ribera',
    'Almussafes',
    'Benicull de Xúquer',
    'Corbera',
    'Cullera',
    'Favara',
    'Fortaleny',
    'Llaurí',
    'Polinyà de Xúquer',
    'Riola',
    'Sollana',
    'Sueca',
];
/**
 * Normaliza un string quitando acentos y pasándolo a minúsculas para búsqueda.
 */
export function normalize(str) {
    return str
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '') // quita acentos
        .toLowerCase();
}
/**
 * Filtra los pueblos según un texto de búsqueda.
 */
export function filterTowns(query) {
    if (!query.trim())
        return riberaTowns;
    const normalizedQuery = normalize(query);
    return riberaTowns.filter((town) => normalize(town).includes(normalizedQuery));
}
//# sourceMappingURL=riberaTowns.js.map