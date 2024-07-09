// Created by Vlad Lysenka 21.06.2024

import SwiftUI

struct Parallax: View {
    let symbol: Symbol
    @State private var profile: Bool = false
    var body: some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .global).minY
            let size = geometry.size
            let parallax = minY > 0 ? minY : 0
            
            Image(symbol.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height + (parallax))
                .clipped()
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .center, endPoint: .bottom))
                .overlay(alignment: .bottomLeading) {
                    HStack(spacing: 15) {
                        Text(symbol.title)
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                        
                        Spacer()
                        
                        Image(.myfoto)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(.circle)
                            .padding(5)
                            .shadow(color: .blue, radius: 4)
                            .onTapGesture { profile.toggle() }
                    }
                    .padding()
                }
                .offset(y: minY > 0 ? -minY : 0)
        }
        .frame(height: 250)
        .sheet(isPresented: $profile) {
            VStack(alignment: .center, spacing: 25) {
                Text("Владислав Лысенко")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.company)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack(spacing: 30) {
                    LinkRow(link: "mailto:vlad.lysenka@icloud.com", symbol: "envelope.fill")
                    
                    Image(.myfoto)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(.circle)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    LinkRow(link: "https://t.me/vladlysenka", symbol: "paperplane")
                }
                .padding(.horizontal)
                
                HStack {
                    Image(.iconlune)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipShape(.rect(cornerRadius: 12))
                }
                .padding(.top)
            }
            .padding(15)
            .presentationDetents([.height(250)])
            .presentationCornerRadius(50)
        }
    }
    
    @ViewBuilder func LinkRow(link: String, symbol: String) -> some View {
        Link(destination: URL(string: link)!) {
            Image(systemName: symbol)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.blue.gradient)
                .frame(width: 45, height: 45)
                .background(.ultraThinMaterial, in: .circle)
        }
    }
    
    
}

#Preview {
    ScrollView {
        Parallax(symbol: .network)
    }
}
