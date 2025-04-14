//  Created By Aji Prakosa 2025

import Foundation
import SwiftUI

class ClaimDetailRouter: ClaimDetailRouterProtocol {
    static func createModule(with claim: Claim) -> AnyView {
        let interactor = ClaimDetailInteractor(claim: claim)
        let presenter = ClaimDetailPresenter(interactor: interactor)
        return AnyView(ClaimDetailView(presenter: presenter))
    }
}
