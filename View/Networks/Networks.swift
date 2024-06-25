// Created by Vlad Lysenka 25.06.2024

import SwiftUI

struct Networks: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    var body: some View {
        ScrollView {
            Parallax(symbol: .network)
            
            VStackNetwork
        }
    }
    
    var VStackNetwork: some View {
        LazyVStack(spacing: 10) {
            LazyVGrid(columns: columns) {
                ForEach(Network.data) { network in
                    NetworkRow(network)
                }
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder func NetworkRow(_ network: Network) -> some View {
        NavigationLink {
            network.symbol.destination
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: network.symbol.rawValue)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.gray)
                    Text(network.symbol.title)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(.company)
                }
                
                Text(network.symbol.summary)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(.position)
                    .multilineTextAlignment(.leading)
            }
            .padding(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(.orange.opacity(0.2), in: .rect(cornerRadius: 16))
        }
    }
    
}

#Preview {
    Networks()
        .environment(Store())
}


