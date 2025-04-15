//  Created By Aji Prakosa 2025

import Foundation
import SwiftUI

public extension View {
    func background(
        color: Color,
        borderColor: Color = .clear,
        cornerRadius: CGFloat = 0,
        lineWidth: CGFloat = 1
    ) -> some View {
        background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(borderColor, lineWidth: lineWidth)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(color)
                )
        )
    }
}
