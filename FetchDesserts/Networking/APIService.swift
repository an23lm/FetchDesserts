import Foundation

class APIService {
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
            case .post(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data
            case .get(let queryItems):
                var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
                components?.queryItems = queryItems
                guard let url = components?.url else {
                    throw NetworkError.badUrl
                }
                request = URLRequest(url: url)
        }
        
        // create the URLSession configuration
        let configuration = URLSessionConfiguration.default
        // add default headers
        configuration.httpAdditionalHeaders = ["Accept": "*/*"]
        configuration.httpAdditionalHeaders = ["Accept-Encoding": "gzip, deflate, br"]
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidResponse
        }
        
        guard let result = try? JSONDecoder().decode(T.self, from: data)
        else {
            throw NetworkError.decodingError
        }
        
        return result
    }
}
