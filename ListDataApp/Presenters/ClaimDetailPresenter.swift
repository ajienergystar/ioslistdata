//  Created By Aji Prakosa 2025

import Foundation

class ClaimDetailPresenter: ObservableObject {
    @Published var claim: Claim
    
    init(interactor: ClaimDetailInteractorInputProtocol) {
        self.claim = interactor.claim
    }
}
