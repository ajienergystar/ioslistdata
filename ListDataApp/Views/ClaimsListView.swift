import SwiftUI

struct ClaimsListView: View, ClaimsListViewProtocol {
    @ObservedObject var presenter: ClaimsListPresenter
    @State private var searchText = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    @State private var selectedClaim: Claim?
    @State private var showDetail = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Custom header
                headerView
                
                // Search bar
                searchView
                
                Spacer()
                
                // Main content
                contentView
            }
            .navigationDestination(for: Claim.self) { claim in
                ClaimDetailConfigurator.configure(with: claim)
            }
        }
        .onAppear {
            presenter.onAppear()
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Insurance Claims")
                .font(.title.bold())
                .padding(.leading, 16)
            Spacer()
        }
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
    
    private var searchView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search claims", text: $searchText)
                .textFieldStyle(.plain)
                .autocorrectionDisabled()
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
    
    @ViewBuilder
    private var contentView: some View {
        if presenter.isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
        } else if let errorMessage = presenter.errorMessage {
            ErrorView(message: errorMessage)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(filteredClaims, id: \.claimId) { claim in
                        claimRow(for: claim)
                        Divider()
                    }
                }
            }
        }
    }
    
    private func claimRow(for claim: Claim) -> some View {
        NavigationLink(value: claim) {
            VStack(alignment: .leading, spacing: 4) {
                Text(claim.title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(claim.description)
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundColor(.secondary)
                
                HStack {
                    Text("Claim ID: \(claim.claimId)")
                    Text("•")
                    Text("Claimant ID: \(claim.claimantId)")
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var filteredClaims: [Claim] {
        guard !searchText.isEmpty else { return presenter.claims }
        let lowercasedSearch = searchText.lowercased()
        return presenter.claims.filter {
            $0.title.lowercased().contains(lowercasedSearch) ||
            $0.description.lowercased().contains(lowercasedSearch)
        }
    }
    
    // MARK: - ClaimsListViewProtocol
    func showLoading() { isLoading = true }
    func hideLoading() { isLoading = false }
    func showClaims(_ claims: [Claim]) { presenter.claims = claims }
    func showError(_ message: String) { errorMessage = message }
}

// MARK: - Configurator for ClaimDetailView
struct ClaimDetailConfigurator {
    static func configure(with claim: Claim) -> some View {
        let interactor = ClaimDetailInteractor(claim: claim)
        let presenter = ClaimDetailPresenter(interactor: interactor)
        return ClaimDetailView(presenter: presenter)
    }
}

struct ErrorView: View {
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
                .foregroundColor(.red)
            Text(message)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
        }
    }
}


extension Claim: Identifiable {
    // Assuming Claim has a unique identifier property like 'id' or 'claimId'
    public var id: Int { claimId }
}

extension Claim: Hashable {
    static func == (lhs: Claim, rhs: Claim) -> Bool {
        lhs.claimId == rhs.claimId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(claimId)
    }
}
