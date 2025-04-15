//  Created By Aji Prakosa 2025

import Foundation
import SwiftUI

struct ClaimDetailView: View {
    @ObservedObject var presenter: ClaimDetailPresenter
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Title: \(presenter.claim.title)")
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Claim ID: \(presenter.claim.claimId)")
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
}
