//  Created By Aji Prakosa 2025

import Foundation

class ClaimDetailPresenter: ClaimDetailPresenterProtocol {
    let interactor: ClaimDetailInteractorInputProtocol
    
    var claim: Claim {
        interactor.claim
    }
    
    init(interactor: ClaimDetailInteractorInputProtocol) {
        self.interactor = interactor
    }
}
