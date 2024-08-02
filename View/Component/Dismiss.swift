// Created by Vlad Lysenka 09.07.2024

import SwiftUI

struct Dismiss: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 15, weight: .bold))
                .padding(12)
                .background(.regularMaterial, in: .circle)
                .foregroundStyle(.blue)
        }
        .padding(.leading)
    }
}

#Preview {
    Dismiss()
}
