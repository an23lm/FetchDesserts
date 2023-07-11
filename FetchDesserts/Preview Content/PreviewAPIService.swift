import Foundation
import os

/// Service to provide data for Previews as a replacement for API Service
///

class PreviewAPIService: APIService {
    private let logger = Logger(subsystem: "com.an23lm.FetchDesserts", category: "PreviewAPIService")
    
    override func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        switch T.self {
        case is FilterResponse.Type: return try await loadPreviewData(forResource: "filter_response")
        case is LookupResponse.Type: return try await loadPreviewData(forResource: "lookup_response")
        default: throw NetworkError.badUrl
        }
    }
    
    private func loadPreviewData<T: Codable>(forResource resource: String) async throws -> T {
        if let path = Bundle.main.url(forResource: resource, withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                let jsonData = try JSONDecoder().decode(T.self, from: data)
                
                return jsonData
            } catch {
                logger.error("Lookup Response Error: \(error.localizedDescription)")
                throw NetworkError.decodingError
            }
        }
        throw NetworkError.invalidResponse
    }
}
