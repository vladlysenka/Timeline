// Created by Vlad Lysenka 04.06.2024 

import SwiftUI

@main
struct TimelineApp: App {
    @State private var store: Store = Store()
    var body: some Scene {
        WindowGroup {
            Timelines()
                .environment(\.colorScheme, .dark)
                .environment(store)
        }
    }
}
