import Foundation

/// Resouce used to represent a network request
///
struct Resource<T: Codable> {
    
    let url: URL
    var method: HttpMethod = .get([])
}
