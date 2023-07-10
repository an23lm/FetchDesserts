import Foundation

struct Resource<T: Codable> {
    
    let url: URL
    var method: HttpMethod = .get([])
}
