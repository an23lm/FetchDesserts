import Foundation

let mealDBLookupPath = "/api/json/v1/1/lookup.php"

extension URL {
    
    static func forLookup() -> URL? {
        var components = URLComponents()
        components.scheme = mealDBScheme
        components.host = mealDBHost
        components.path = mealDBLookupPath
        
        return components.url
    }
}
