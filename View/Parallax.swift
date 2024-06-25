// Created by Vlad Lysenka 21.06.2024

import SwiftUI

struct Parallax: View {
    @Environment(\.dismiss) private var dismiss
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
                        Image(systemName: symbol.rawValue)
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundStyle(symbol.color.gradient)
                        
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
        .overlay(alignment: .topLeading) {
            if symbol.back {
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
        .sheet(isPresented: $profile) {
            VStack(alignment: .center, spacing: 15) {
                Text("Владислав Лысенко")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.company)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 30)
                HStack(spacing: 30) {
                    LinkRow(symbol: .email)
                    
                    Image(.myfoto)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(.circle)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    LinkRow(symbol: .telegram)
                }
                .padding(.horizontal)
            }
            .padding(15)
            .presentationDetents([.height(250)])
            .presentationCornerRadius(50)
        }
    }
    
    @ViewBuilder func LinkRow(symbol: Symbol) -> some View {
        Link(destination: symbol.link) {
            Image(systemName: symbol.rawValue)
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