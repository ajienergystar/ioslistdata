//  Created By Aji Prakosa 2025

import Foundation
import SwiftUI

protocol ClaimDetailViewProtocol: AnyObject {
    func showClaimDetails(_ claim: Claim)
}

protocol ClaimDetailPresenterProtocol {
    var claim: Claim { get }
}

protocol ClaimDetailInteractorInputProtocol {
    var claim: Claim { get }
}

protocol ClaimDetailRouterProtocol {
    static func createModule(with claim: Claim) -> AnyView
}
