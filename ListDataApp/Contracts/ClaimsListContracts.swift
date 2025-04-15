//  Created By Aji Prakosa 2025

import Foundation
import SwiftUI

protocol ClaimsListViewProtocol {
    func showLoading()
    func hideLoading()
    func showClaims(_ claims: [Claim])
    func showError(_ message: String)
}

protocol ClaimsListPresenterProtocol: ObservableObject {
    func onAppear()
    func didSelectClaim(_ claim: Claim)
    func searchClaims(with query: String)
}

protocol ClaimsListInteractorInputProtocol {
    func fetchClaims() async throws -> [Claim]
}

protocol ClaimsListRouterProtocol {
    func navigateToClaimDetail(with claim: Claim) -> AnyView
}
