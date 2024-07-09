// Created by Vlad Lysenka 25.06.2024 

import SwiftUI

struct Miniapps: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 1)
    var body: some View {
        ScrollCard(symbol: .miniapp) {
            VStackNetwork
        }
    }
    
    var VStackNetwork: some View {
        LazyVStack(spacing: 10) {
            LazyVGrid(columns: columns) {
                ForEach(Miniapp.data) { miniapp in
                    MiniappRow(miniapp)
                }
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder func MiniappRow(_ miniapp: Miniapp) -> some View {
        NavigationLink {
            miniapp.symbol.destination
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: miniapp.symbol.rawValue)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.gray)
                    Text(miniapp.symbol.title)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(.company)
                }
                
                Text(miniapp.symbol.summary)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(.position)
                    .multilineTextAlignment(.leading)
            }
            .padding(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(miniapp.symbol.color.opacity(0.2), in: .rect(cornerRadius: 16))
        }
    }
}

#Preview {
    Miniapps()
}
