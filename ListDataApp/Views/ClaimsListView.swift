//  Created By Aji Prakosa 2025

import Foundation
import SwiftUI


struct ClaimsListView: View, ClaimsListViewProtocol {
    @ObservedObject var presenter: ClaimsListPresenter
    @State private var searchText = ""
    @State private var isLoading = false
    @State private var claims: [Claim] = []
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView()
                } else if let errorMessage = errorMessage {
                    ErrorView(message: errorMessage)
                } else {
                    List(filteredClaims) { claim in
                        NavigationLink {
                            presenter.router.navigateToClaimDetail(with: claim)
                        } label: {
                            ClaimRow(claim: claim)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Insurance Claims")
            .searchable(text: $searchText, prompt: "Search claims")
            .onChange(of: searchText) { newValue in
                presenter.searchClaims(with: newValue)
            }
        }
        .onAppear {
            presenter.onAppear()
        }
    }
    
    private var filteredClaims: [Claim] {
        if searchText.isEmpty {
            return claims
        } else {
            return claims.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    // MARK: - ClaimsListViewProtocol
    
    func showLoading() {
        isLoading = true
    }
    
    func hideLoading() {
        isLoading = false
    }
    
    func showClaims(_ claims: [Claim]) {
        self.claims = claims
    }
    
    func showError(_ message: String) {
        errorMessage = message
    }
}

struct ClaimRow: View {
    let claim: Claim
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(claim.title)
                .font(.headline)
            
            Text(claim.description)
                .font(.subheadline)
                .lineLimit(2)
                .foregroundColor(.secondary)
            
            HStack {
                Text("Claim ID: \(claim.id)")
                Text("•")
                Text("Claimant ID: \(claim.claimantId)")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct ErrorView: View {
    let message: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text(message)
                .padding()
        }
    }
}
