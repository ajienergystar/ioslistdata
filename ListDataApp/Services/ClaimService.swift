import Alamofire

protocol ClaimServiceProtocol {
    func fetchClaims() async throws -> [Claim]
}

protocol RequestPerformer {
    func performRequest(_ url: String) async throws -> [Claim]
}

class AlamofireRequestPerformer: RequestPerformer {
    func performRequest(_ url: String) async throws -> [Claim] {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url)
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

class ClaimService: ClaimServiceProtocol {
    private let baseURL: String
    private let requestPerformer: RequestPerformer
    
    init(baseURL: String = "https://jsonplaceholder.typicode.com/posts",
         requestPerformer: RequestPerformer = AlamofireRequestPerformer()) {
        self.baseURL = baseURL
        self.requestPerformer = requestPerformer
    }
    
    func fetchClaims() async throws -> [Claim] {
        return try await requestPerformer.performRequest(baseURL)
    }
}
