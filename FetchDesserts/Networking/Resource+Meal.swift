import Foundation

extension Meal {
    static func forCategory(_ category: String) -> Resource<FilterResponse> {
        guard let url = URL.forFilter() else {
            fatalError("Invalid URL")
        }
        
        return Resource(url: url, method: .get([URLQueryItem(name: "c", value: category)]))
    }
    
    static func forMealID(_ id: Int) -> Resource<LookupResponse> {
        guard let url = URL.forLookup() else {
            fatalError("Invalid URL")
        }
    
        return Resource(url: url, method: .get([URLQueryItem(name: "i", value: String(id))]))
    }
}
