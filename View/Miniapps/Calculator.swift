// Created by Vlad Lysenka 25.06.2024 

import SwiftUI

struct Calculator: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(Store.self) private var store
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            // MARK: Display
            Text(store.value)
                .font(.system(size: 90, weight: .regular, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .padding(.horizontal, 28)
            
            // MARK: Buttons
            ForEach(store.buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { item in
                        Button {
                            store.didTap(button: item)
                        } label: {
                            Text(item.rawValue)
                                .frame(width: store.buttonWidth(item: item), height: store.buttonHeight())
                                .foregroundColor(item.color)
                                .background(item.background)
                                .cornerRadius(store.buttonHeight() / 2)
                                .font(.system(size: 35, weight: .semibold, design: .rounded))
                        }
                    }
                }
            }
        }
        .padding(.bottom)
        .overlay(alignment: .topLeading) {
            Button { dismiss() } label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15, weight: .heavy))
                    
                    Text("back")
                        .font(.system(size: 18, weight: .bold ,design: .rounded))
                }
                .padding(8)
                .background(.regularMaterial, in: .capsule)
                .foregroundStyle(.blue)
            }
            .padding(.leading, 7)
        }
    }
}

#Preview {
    Calculator()
        .environment(Store())
}
