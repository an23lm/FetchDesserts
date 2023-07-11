import Foundation

extension Meal {
    
    /// Returns a Resouce to perform a GET request to the Filter API
    ///
    /// - Parmeters:
    ///   - category: category to be filtered by
    static func forCategory(_ category: String) -> Resource<FilterResponse> {
        guard let url = URL.forFilter() else {
            fatalError("Invalid URL")
        }
        
        return Resource(url: url, method: .get([URLQueryItem(name: "c", value: category)]))
    }
    
    /// Returns a Resouce to perform a GET request to the Lookup API
    ///
    /// - Parmeters:
    ///   - id: id to be fetched
    static func forMealID(_ id: String) -> Resource<LookupResponse> {
        guard let url = URL.forLookup() else {
            fatalError("Invalid URL")
        }
    
        return Resource(url: url, method: .get([URLQueryItem(name: "i", value: id)]))
    }
}
