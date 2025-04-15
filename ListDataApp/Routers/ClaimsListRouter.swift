//  Created By Aji Prakosa 2025

import Foundation
import SwiftUI

class ClaimsListRouter: ClaimsListRouterProtocol {
    func navigateToClaimDetail(with claim: Claim) -> AnyView {
        let interactor = ClaimDetailInteractor(claim: claim)
        let presenter = ClaimDetailPresenter(interactor: interactor)
        return AnyView(ClaimDetailView(presenter: presenter))
    }
    
    static func createModule() -> some View {
        let interactor = ClaimsListInteractor()
        let router = ClaimsListRouter()
        let presenter = ClaimsListPresenter(interactor: interactor, router: router)
        let view = ClaimsListView(presenter: presenter)
        return view
    }
}
