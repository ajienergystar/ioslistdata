//  Created By Aji Prakosa 2025

import Foundation
import SwiftUI

struct ClaimDetailView: View, ClaimDetailViewProtocol {
    @ObservedObject var presenter: ClaimDetailPresenter
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(presenter.claim.title)
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Claim ID: \(presenter.claim.id)")
                    Text("Claimant ID: \(presenter.claim.claimantId)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text(presenter.claim.description)
                    .font(.body)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Claim Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - ClaimDetailViewProtocol
    
    func showClaimDetails(_ claim: Claim) {
        // Handled by presenter in this case
    }
}
