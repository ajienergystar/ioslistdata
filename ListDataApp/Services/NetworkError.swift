//  Created By Aji Prakosa 2025

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .noData: return "No data received"
        case .decodingError: return "Failed to decode data"
        case .serverError(let error): return "Server error: \(error.localizedDescription)"
        }
    }
}
