//  Created By Aji Prakosa 2025

import Foundation

class ClaimDetailInteractor: ClaimDetailInteractorInputProtocol {
    let claim: Claim
    
    init(claim: Claim) {
        self.claim = claim
    }
}
