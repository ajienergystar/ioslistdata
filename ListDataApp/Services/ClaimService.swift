import Alamofire

protocol ClaimServiceProtocol {
    func fetchClaims() async throws -> [Claim]
}

class ClaimService: ClaimServiceProtocol {
    private let baseURL = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchClaims() async throws -> [Claim] {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(baseURL)
                .validate()
                .responseDecodable(of: [Claim].self) { response in
                    switch response.result {
                    case .success(let claims):
                        continuation.resume(returning: claims)
                    case .failure(let error):
                        continuation.resume(throwing: NetworkError.serverError(error))
                    }
                }
        }
    }
}
