//  Created By Aji Prakosa 2025

import XCTest
import SwiftUI
@testable import ListDataApp

class ClaimsListPresenterTests: XCTestCase {
    var presenter: ClaimsListPresenter!
    var mockInteractor: MockClaimsListInteractor!
    var mockRouter: MockClaimsListRouter!
    
    override func setUp() {
        super.setUp()
        mockInteractor = MockClaimsListInteractor()
        mockRouter = MockClaimsListRouter()
        
        presenter = ClaimsListPresenter(
            interactor: mockInteractor,
            router: mockRouter
        )
    }
    
    override func tearDown() {
        presenter = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }
    
    func testOnAppearSuccess() async throws {
        // Given
        let testClaims = [Claim(claimantId: 1, claimId: 1, title: "Test", description: "Test")]
        mockInteractor.stubbedClaims = testClaims
        
        // When
        await presenter.onAppear()
        
        // Then
        XCTAssertFalse(presenter.isLoading)
        XCTAssertEqual(presenter.claims, testClaims)
        XCTAssertNil(presenter.errorMessage)
    }

    func testOnAppearFailure() async throws {
        // Given
        mockInteractor.stubbedError = NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test Error"])
        
        // When
        await presenter.onAppear()
        
        // Then
        XCTAssertFalse(presenter.isLoading)
        XCTAssertTrue(presenter.claims.isEmpty)
        XCTAssertEqual(presenter.errorMessage, "Test Error")
    }
    
    func testSearchClaims() {
        // Given
        let testClaims = [
            Claim(claimantId: 1, claimId: 1, title: "Car Accident", description: "Front collision"),
            Claim(claimantId: 2, claimId: 2, title: "Theft", description: "Stolen items")
        ]
        presenter.claims = testClaims
        
        // When empty search
        presenter.searchClaims(with: "")
        // Then
        XCTAssertEqual(presenter.claims, testClaims)
        
        // When matching search
        presenter.searchClaims(with: "Car")
        // Then
        XCTAssertEqual(presenter.claims.count, 1)
        XCTAssertEqual(presenter.claims.first?.title, "Car Accident")
    }
}

// MARK: - Mock Implementations

class MockClaimsListInteractor: ClaimsListInteractorInputProtocol {
    var stubbedClaims: [Claim] = []
    var stubbedError: Error?
    
    func fetchClaims() async throws -> [Claim] {
        if let error = stubbedError {
            throw error
        }
        return stubbedClaims
    }
}

class MockClaimsListRouter: ClaimsListRouterProtocol {
    var navigatedToClaim: Claim?
    
    func navigateToClaimDetail(with claim: Claim) -> AnyView {
        navigatedToClaim = claim
        return AnyView(EmptyView())
    }
}
