// Created by Vlad Lysenka 25.06.2024 

import SwiftUI

struct Miniapp: Identifiable {
    var id: Int
    var symbol: Symbol
    
    static var data: [Miniapp] = [
        Miniapp(id: 1, symbol: .tictactoe),
        Miniapp(id: 0, symbol: .calculator)
    ]
}

