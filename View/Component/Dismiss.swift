// Created by Vlad Lysenka 09.07.2024 

import SwiftUI

struct Dismiss: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Button { dismiss() } label: {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 15, weight: .bold))
                
                Text("Назад")
                    .font(.system(size: 18, weight: .semibold ,design: .rounded))
            }
            .frame(height: 40)
            .padding(.horizontal, 8)
            .background(.regularMaterial, in: .capsule)
            .foregroundStyle(.blue)
        }
        .padding(.leading, 7)
    }
}

#Preview {
    Dismiss()
}
