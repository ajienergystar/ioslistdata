//  Created By Aji Prakosa 2025

import Foundation

class ClaimsListPresenter: ClaimsListPresenterProtocol {
    weak var view: ClaimsListViewProtocol?
    let interactor: ClaimsListInteractorInputProtocol
    let router: ClaimsListRouterProtocol
    
    private var allClaims: [Claim] = []
    
    init(interactor: ClaimsListInteractorInputProtocol,
         router: ClaimsListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func onAppear() {
        Task { @MainActor in
            view?.showLoading()
            do {
                let claims = try await interactor.fetchClaims()
                allClaims = claims
                view?.showClaims(claims)
            } catch {
                view?.showError(error.localizedDescription)
            }
            view?.hideLoading()
        }
    }
    
    func didSelectClaim(_ claim: Claim) {
        // Navigation handled by SwiftUI in this case
    }
    
    func searchClaims(with query: String) {
        if query.isEmpty {
            view?.showClaims(allClaims)
        } else {
            let filtered = allClaims.filter {
                $0.title.localizedCaseInsensitiveContains(query) ||
                $0.description.localizedCaseInsensitiveContains(query)
            }
            view?.showClaims(filtered)
        }
    }
}
