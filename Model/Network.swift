// Created by Vlad Lysenka 25.06.2024 

import SwiftUI

struct Network: Identifiable {
    var id: Int
    var symbol: Symbol
    
    static var data: [Network] = [
        Network(id: 0, symbol: .joke)
    ]
}
