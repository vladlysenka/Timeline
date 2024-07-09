// Created by Vlad Lysenka 25.06.2024

import SwiftUI

struct Timelines: View {
    @State private var network: Bool = false
    @State private var miniapp: Bool = false
    var body: some View {
        NavigationStack {
            ScrollCard(symbol: .timeline) {
                HStack {
                    TimeImage(.network) { network.toggle() }
                    
                    TimeImage(.miniapp) { miniapp.toggle() }
                }
                .padding(.vertical, 10)
                
                LazyVStack(spacing: 35) {
                    ForEach(Timeline.data) { timeline in
                        TimeCard(timeline)
                    }
                }
                .padding()
            }
            .navigationDestination(isPresented: $network) { Networks() }
            .navigationDestination(isPresented: $miniapp) { Miniapps() }
        }
    }
    
    
    @ViewBuilder func TimeCard(_ timeline: Timeline) -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "circle.fill")
                        .foregroundStyle(.circle)
                        .background {
                            Circle()
                                .stroke(lineWidth: 3)
                                .foregroundStyle(timeline.finish != nil ? .clear : .orange)
                        }
                    
                    Text(timeline.company)
                        .font(.system(size: 15, weight: .heavy, design: .rounded))
                        .foregroundStyle(.company)
                    
                    Spacer()
                    
                    HStack(spacing: 5) {
                        Text("\(timeline.start)")
                            .frame(width: 35)
                        
                        Image(systemName: "arrow.right")
                        
                        Text(timeline.finish ?? "......")
                            .frame(width: 35)
                    }
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(.position)
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(timeline.position)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(.position)
                    
                    Text(timeline.summary)
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .lineSpacing(3)
                        .foregroundStyle(.summary)
                }
                .padding(.leading, 28)
            }
        }
        .background(alignment: .leading) {
            if Timeline.data.last?.id != timeline.id {
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: 3)
                    .offset(x: 8)
                    .padding(.bottom, -35)
                    .padding(.top, 5)
                    .foregroundStyle(.line)
            }
        }
    }
    
    @ViewBuilder func TimeImage(_ symbol: Symbol, _ perform: @escaping () -> ()) -> some View {
        Image(systemName: symbol.rawValue)
            .font(.system(size: 20, weight: .semibold))
            .foregroundStyle(.blue.gradient)
            .frame(maxWidth: .infinity)
            .onTapGesture(perform: perform)
    }
}


#Preview {
    Timelines()
        .environment(\.colorScheme, .dark)
        .environment(Store())
}
