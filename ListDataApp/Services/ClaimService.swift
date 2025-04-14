//  Created By Aji Prakosa 2025

import Alamofire

protocol ClaimServiceProtocol {
    func fetchClaims(completion: @escaping (Result<[Claim], NetworkError>) -> Void)
}

class ClaimService: ClaimServiceProtocol {
    private let baseURL = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchClaims(completion: @escaping (Result<[Claim], NetworkError>) -> Void) {
        AF.request(baseURL).validate().responseDecodable(of: [Claim].self) { response in
            switch response.result {
            case .success(let claims):
                completion(.success(claims))
            case .failure(let error):
                completion(.failure(.serverError(error)))
            }
        }
    }
}
