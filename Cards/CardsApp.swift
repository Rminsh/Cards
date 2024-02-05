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
        .defaultSize(width: 500, height: 700)
        #elseif os(visionOS)
        .defaultSize(width: 600, height: 750)
        #endif
        #if os(visionOS) || os(macOS)
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
