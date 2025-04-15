//  Created By Aji Prakosa 2025

import SwiftUI

public struct CardView<Content: View>: View {
    @ViewBuilder
    private let content: Content
    private let cornerRadius: CGFloat
    private let shadowOpacity: Double
    private let color: Color
    private let borderColor: Color
    private let borderWidth: CGFloat

    public init(
        cornerRadius: CGFloat = 8,
        shadowOpacity: Double = 0.2,
        color: Color = Color(.white),
        borderColor: Color = Color(.white),
        borderWidth: CGFloat = 0,
        @ViewBuilder contentBuilder: @escaping () -> Content
    ) {
        content = contentBuilder()
        self.shadowOpacity = shadowOpacity
        self.cornerRadius = cornerRadius
        self.color = color
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }

    public var body: some View {
        VStack(alignment: .leading) {
            content
                .padding(0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color: color, borderColor: borderColor, cornerRadius: cornerRadius, lineWidth: borderWidth)
        .clipped()
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(color)
                .shadow(color: Color(.systemGray2).opacity(shadowOpacity), radius: 3, y: 3)
        )
    }
}
