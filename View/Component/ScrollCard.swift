// Created by Vlad Lysenka 09.07.2024 

import SwiftUI

struct ScrollCard<Content: View>: View {
    let symbol: Symbol
    @ViewBuilder var content: () -> Content
    var body: some View {
        ScrollView {
            Parallax(symbol: symbol)
            
            content()
        }
        .scrollIndicators(.hidden)
        .overlay(alignment: .topLeading) {
            if symbol.back {
                Dismiss()
            }
        }
    }
}

#Preview {
    ScrollCard(symbol: .joke) {
        
    }
}
