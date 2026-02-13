//
//  VDLocalizationManager.swift
//
//  Created by segmenthub on 13.02.2026.
//

import Foundation

enum AppTextKey {
    case match
    case camera
    case uploadPhoto
    case headline
    case detectedObjects
    case analyzingImage
    case subline
    case searching
    case placeholder
    case noMatchingFound
    case reset
    case items
    case showSimilar
    case detectingItems
    case noItemsFound
    case showProducts
}

class VDLocalizationManager {
    
    private static let translations: [String: [AppTextKey: String]] = [
        "de": [
            .match: "Übereinstimmung",
            .camera: "Kamera",
            .uploadPhoto: "Foto hochladen",
            .headline: "Erkennen & Einkaufen",
            .detectedObjects: "Erkannte Objekte",
            .analyzingImage: "Bild wird analysiert...",
            .subline: "Lade ein Foto hoch oder mache ein Bild",
            .searching: "Ähnliche Produkte werden gesucht...",
            .placeholder: "Suche verfeinern (z. B. 'rot', 'baumwolle', 'damen')",
            .noMatchingFound: "Keine passenden Produkte gefunden.",
            .reset: "Zurücksetzen",
            .items: "artikel",
            .showSimilar: "Ähnliche anzeigen",
            .detectingItems: "Erkenne Objekte...",
            .noItemsFound: "Es wurden keine Elemente erkannt. Bitte versuchen Sie es mit einem anderen Bild.",
            .showProducts: "Produkte anzeigen"
        ],
        "en": [
            .match: "Match",
            .camera: "Camera",
            .uploadPhoto: "Upload Photo",
            .headline: "Identify & Shop",
            .detectedObjects: "Detected Objects",
            .analyzingImage: "Analyzing image...",
            .subline: "Upload a photo or take a picture",
            .searching: "Searching for similar products...",
            .placeholder: "Refine search (e.g. 'red', 'cotton', 'female')",
            .noMatchingFound: "No matching products found.",
            .reset: "Reset",
            .items: "items",
            .showSimilar: "Show Similar",
            .detectingItems: "Detecting items...",
            .noItemsFound: "No items detected. Please try another image.",
            .showProducts: "Show Products"
        ],
        "es": [
            .match: "Coincidencia",
            .camera: "Cámara",
            .uploadPhoto: "Subir foto",
            .headline: "Identificar y comprar",
            .detectedObjects: "Objetos detectados",
            .analyzingImage: "Analizando imagen...",
            .subline: "Sube una foto o toma una fotografía",
            .searching: "Buscando productos similares...",
            .placeholder: "Refinar búsqueda (ej. 'rojo', 'algodón', 'mujer')",
            .noMatchingFound: "No se encontraron productos coincidentes.",
            .reset: "Reiniciar",
            .items: "artículos",
            .showSimilar: "Mostrar similares",
            .detectingItems: "Detectando elementos...",
            .noItemsFound: "No se detectaron elementos. Prueba con otra imagen.",
            .showProducts: "Mostrar productos"
        ],
        "fr": [
            .match: "Correspondance",
            .camera: "Appareil photo",
            .uploadPhoto: "Importer une photo",
            .headline: "Identifier & Acheter",
            .detectedObjects: "Objets détectés",
            .analyzingImage: "Analyse de l’image...",
            .subline: "Importez une photo ou prenez-en une",
            .searching: "Recherche de produits similaires...",
            .placeholder: "Affiner la recherche (ex. 'rouge', 'coton', 'femme')",
            .noMatchingFound: "Aucun produit correspondant trouvé.",
            .reset: "Réinitialiser",
            .items: "articles",
            .showSimilar: "Afficher similaires",
            .detectingItems: "Détection des objets...",
            .noItemsFound: "Aucun élément détecté. Veuillez essayer une autre image.",
            .showProducts: "Afficher les produits"
        ],
        "tr": [
            .match: "Benzer",
            .camera: "Kamera",
            .uploadPhoto: "Fotoğraf Yükle",
            .headline: "Keşfet & Satın Al",
            .detectedObjects: "Bulunan Nesneler",
            .analyzingImage: "Fotoğraf analiz ediliyor...",
            .subline: "Bir fotoğraf yükleyin veya fotoğraf çekin",
            .searching: "Benzer ürünler araştırılıyor...",
            .placeholder: "Aramayı daralt (örn. 'kırmızı', 'pamuklu', 'kadın')",
            .noMatchingFound: "Eşleşen ürün bulunamadı.",
            .reset: "Sıfırla",
            .items: "ürün",
            .showSimilar: "Benzerleri Göster",
            .detectingItems: "Nesneler algılanıyor...",
            .noItemsFound: "Hiçbir öğe algılanmadı. Lütfen başka bir görsel deneyin.",
            .showProducts: "Ürünleri Göster"
        ]
    ]
    
    private static var currentLanguageCode: String {
        if let selectedLanguage = VisualDiscoverySDK.shared.selectedLanguage?.rawValue {
            return selectedLanguage
        } else {
            let language = Locale.current.identifier
            let code = String(language.prefix(2))
            return translations.keys.contains(code) ? code : "en"
        }
    }
    
    static func getText(for key: AppTextKey) -> String {
        let languageCode = currentLanguageCode
        
        if let dict = translations[languageCode], let text = dict[key] {
            return text
        }

        return translations["en"]?[key] ?? ""
    }
}
