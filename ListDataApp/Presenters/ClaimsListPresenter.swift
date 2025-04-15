//  Created By Aji Prakosa 2025

import Foundation

class ClaimsListPresenter: ClaimsListPresenterProtocol {
    private let interactor: ClaimsListInteractorInputProtocol
    let router: ClaimsListRouterProtocol
    
    @Published var isLoading: Bool = false
    @Published var claims: [Claim] = []
    @Published var errorMessage: String?
    
    init(interactor: ClaimsListInteractorInputProtocol,
         router: ClaimsListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func onAppear() {
        Task { @MainActor in
            isLoading = true
            do {
                claims = try await interactor.fetchClaims()
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    func searchClaims(with query: String) {
        // Search logic now handled in the view
    }
    
    func didSelectClaim(_ claim: Claim) {
        // Navigation handled by router
    }
}
