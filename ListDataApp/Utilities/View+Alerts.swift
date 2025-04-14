//  Created By Aji Prakosa 2025

import SwiftUI

extension View {
    func errorAlert(error: Binding<String?>) -> some View {
        alert("Error", isPresented: .constant(error.wrappedValue != nil)) {
            Button("OK") {
                error.wrappedValue = nil
            }
        } message: {
            Text(error.wrappedValue ?? "")
        }
    }
}
