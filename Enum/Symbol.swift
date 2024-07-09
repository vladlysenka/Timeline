// Created by Vlad Lysenka 25.06.2024

import SwiftUI

enum Symbol: String {
    // MARK: Timeline
    case timeline   = "list.bullet.clipboard"
    // MARK: Network
    case network    = "globe.europe.africa"
    case joke       = "message.and.waveform"
    // MARK: Miniapp
    case miniapp    = "applelogo"
    case calculator = "plus.forwardslash.minus"
    case tictactoe  = "xmark.circle"
    
    
    var title: String {
        switch self {
        // MARK: Network
        case .network    : "Network"
        case .joke       : "Joke"
        // MARK: Miniapp
        case .miniapp    : "Miniapp"
        case .calculator : "Calculator"
        case .tictactoe  : "Крестики нолики"
        default          : "Timeline"
        }
    }
    
    var summary: String {
        switch self {
        // MARK: Network
        case .joke       : "Генератор случайных шуток от Чака Норриса, который работает с сетью для получения данных."
        // MARK: Miniapp
        case .calculator : "Классический калькулятор apple"
        case .tictactoe  : "Игра в крестики нолики"
        default          : ""
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        // MARK: Network
        case .joke       : Jokes()
        // MARK: Miniapp
        case .calculator : Calculator()
        default          : Text("text")
        }
    }
    
    var color: Color {
        switch self {
        case .timeline   : .orange
        // MARK: Network
        case .joke       : .green
        // MARK: Miniapp
        case .calculator : .orange
        default          : .blue
        }
    }
    
    var image: ImageResource {
        switch self {
        // MARK: Network
        case .network : .network
        case .joke    : .chuck
        // MARK: Miniapp
        case .miniapp : .miniapp
        default       : .parallax
        }
    }
    
    var back: Bool {
        switch self {
        case .timeline : false
        default        : true
        }
    }
}
