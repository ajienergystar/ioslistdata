//  Created By Aji Prakosa 2025

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Error)
}
