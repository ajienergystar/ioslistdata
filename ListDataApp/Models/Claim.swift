//  Created By Aji Prakosa 2025

struct Claim: Codable {
    let claimantId: Int
    let claimId: Int
    let title: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case claimantId = "userId"
        case claimId = "id"
        case title
        case description = "body"
    }
}
