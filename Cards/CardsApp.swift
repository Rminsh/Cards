//
//  CardsApp.swift
//  Cards
//
//  Created by Armin on 9/24/22.
//

import SwiftUI

@main
struct CardsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if DEBUG
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified)
        #endif
    }
}
