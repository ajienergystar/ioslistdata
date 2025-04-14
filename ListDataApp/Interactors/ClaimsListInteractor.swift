//  Created By Aji Prakosa 2025

import Foundation

class ClaimsListInteractor: ClaimsListInteractorInputProtocol {
    private let service: ClaimServiceProtocol
    
    init(service: ClaimServiceProtocol = ClaimService()) {
        self.service = service
    }
    
    func fetchClaims() async throws -> [Claim] {
        return try await service.fetchClaims()
    }
}
