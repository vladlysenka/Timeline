// Created by Vlad Lysenka 25.06.2024

import SwiftUI

enum Symbol: String {
    // MARK: Timeline
    case timeline   = "list.bullet.clipboard"
    case email      = "envelope.fill"
    case telegram   = "paperplane"
    // MARK: Network
    case network    = "globe.europe.africa"
    case joke       = "message.and.waveform"
    // MARK: Miniapp
    case miniapp    = "applelogo"
    case calculator = "plus.forwardslash.minus"
    
    
    var title: String {
        switch self {
        // MARK: Network
        case .network    : "Network"
        case .joke       : "Joke"
        // MARK: Miniapp
        case .miniapp    : "Miniapp"
        case .calculator : "Calculator"
        default          : "Timeline"
        }
    }
    
    var summary: String {
        switch self {
        // MARK: Network
        case .joke       : "Случайные шутки от Чака Норриса - это генератор случайных шуток, который работает с сетью для получения данных."
        // MARK: Miniapp
        case .calculator : "Summary"
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
        case .timeline : .orange
        default        : .blue
        }
    }
    
    var back: Bool {
        switch self {
        case .timeline : false
        default        : true
        }
    }
    
    var link: URL {
        switch self {
        case .email    : URL(string: "mailto:vlad.lysenka@icloud.com")!
        case .telegram : URL(string: "https://t.me/vladlysenka")!
        default        : URL(string: "https://t.me/vladlysenka")!
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
}
