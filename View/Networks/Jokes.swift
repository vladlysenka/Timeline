// Created by Vlad Lysenka 25.06.2024

import SwiftUI

struct Jokes: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(Store.self) private var store
    var body: some View {
        List {
            Parallax(symbol: .joke)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
                .buttonStyle(.plain)
            
            if !store.jokes.isEmpty {
                HStack {
                    Text("Сохраненных шуток")
                    
                    Spacer()
                    
                    Text("\(store.jokes.count)")
                        .listRowSeparator(.hidden)
                }
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(.summary)
                
                ForEach(store.jokes, id: \.self) { joke in
                    Text(joke)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(.company)
                        .padding(.vertical, 5)
                }
                .onDelete { indexSet in
                    store.deleteJoke(at: indexSet)
                }
                .listRowSeparator(.hidden)
            } else {
                ContentUnavailableView("Список пуст", systemImage: Symbol.joke.rawValue)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .overlay(alignment: .topLeading) {
            Dismiss()
        }
        .safeAreaInset(edge: .bottom) {
            VStack {
                Text(!store.text.isEmpty ? store.text : "Нажми на кнопку чтобы появилась шутка от Чака Норриса")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.company)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    if !store.text.isEmpty {
                        Button("", systemImage:  store.isJokeExists ? "star.fill" : "star", action: store.isJokeExists ? store.removeJoke : store.saveJoke)
                    }
                    
                    Spacer()
                    
                    Group {
                        if store.isDownloading {
                            ProgressView()
                        } else {
                            Button("", systemImage: "arrow.counterclockwise", action: store.downloadRandomJoke)
                        }
                    }
                    .frame(width: 30, height: 30)
                }
                .font(.system(size: 20, weight: .bold))
            }
            .padding()
            .background(.regularMaterial, in: .rect(cornerRadius: 25))
            .padding(5)
        }
    }
}

#Preview {
    Jokes()
        .environment(Store())
}
