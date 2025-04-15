import XCTest
@testable import ListDataApp

class ClaimServiceTests: XCTestCase {
    var claimService: ClaimService!
    var mockRequestPerformer: MockRequestPerformer!
    
    override func setUp() {
        super.setUp()
        mockRequestPerformer = MockRequestPerformer()
        claimService = ClaimService(requestPerformer: mockRequestPerformer)
    }
    
    func testFetchClaimsSuccess() async throws {
        let mockClaim = Claim(claimantId: 1, claimId: 1, title: "Test Claim", description: "Test Description")
        mockRequestPerformer.mockResult = .success([mockClaim])
        
        let claims = try await claimService.fetchClaims()
        XCTAssertEqual(claims.count, 1)
        XCTAssertEqual(claims.first?.title, "Test Claim")
    }
    
    func testFetchClaimsFailure() async {
        mockRequestPerformer.mockResult = .failure(NSError(domain: "test", code: 500, userInfo: nil))
        
        do {
            _ = try await claimService.fetchClaims()
            XCTFail("Should not succeed")
        } catch {
            if case NetworkError.serverError = error {
                // Expected error
            } else {
                XCTFail("Unexpected error type: \(error)")
            }
        }
    }
}

class MockRequestPerformer: RequestPerformer {
    var mockResult: Result<[Claim], Error> = .failure(NetworkError.noData)
    
    func performRequest(_ url: String) async throws -> [Claim] {
        switch mockResult {
        case .success(let claims):
            return claims
        case .failure(let error):
            throw error
        }
    }
}
