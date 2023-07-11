import Foundation

let mealDBLookupPath = "/api/json/v1/1/lookup.php"

extension URL {
    
    /// Returns the URL used to the Lookup API
    static func forLookup() -> URL? {
        var components = URLComponents()
        components.scheme = mealDBScheme
        components.host = mealDBHost
        components.path = mealDBLookupPath
        
        return components.url
    }
}
