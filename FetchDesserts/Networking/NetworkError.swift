/// Enum of available network errors to be handled
///
enum NetworkError: Error {
    case invalidResponse
    case badUrl
    case decodingError
}
