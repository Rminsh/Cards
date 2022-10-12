//
//  CardsApp.swift
//  Cards
//
//  Created by Armin on 9/24/22.
//

import SwiftUI

@main
struct CardsApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified)
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.newItem) {
                Button("New Card") {
                    NotificationCenter.default.post(name: Notification.Name("NewCard"), object: nil)
                }
                .keyboardShortcut("n")
            }
        }
        #endif
    }
}
