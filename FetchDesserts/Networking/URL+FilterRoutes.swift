import Foundation

let mealDBScheme = "https"
let mealDBHost = "themealdb.com"
let mealDBFilterPath = "/api/json/v1/1/filter.php"

extension URL {
    
    static func forFilter() -> URL? {
        var components = URLComponents()
        components.scheme = mealDBScheme
        components.host = mealDBHost
        components.path = mealDBFilterPath
        
        return components.url
    }
}
