//
//  ContentView.swift
//  Cards
//
//  Created by Armin on 9/24/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var model = CardsListViewModel()
    @State private var showStats: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                #if os(macOS)
                VisualEffectBlur(
                    material: .popover,
                    blendingMode: .behindWindow
                )
                .edgesIgnoringSafeArea(.all)
                #endif
                
                ZStack {
                    /// EmptyState
                    Text("Finally, the list is empty. You can reset now.")
                        .font(.title3)
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    /// Cards
                    CardStack(
                        direction: LeftRight.direction,
                        data: model.cards
                    ) { card, direction in
                        switch direction {
                        case .left:
                            model.updateCardStatus(card: card, status: .forgot)
                        case .right:
                            model.updateCardStatus(card: card, status: .knew)
                        }
                    } content: { card, direction, isOnTop in
                        CardContentView(card: card, direction: direction)
                    }
                    .id(model.reloadToken)
                }
                .frame(maxWidth: 300, maxHeight:  400)
                .padding()
            }
            .toolbar {
                ToolbarItemGroup {
                    Button(action: {
                        withAnimation {
                            model.rearrangeCards()
                        }
                    }) {
                        Label("Reload", systemImage: "arrow.counterclockwise")
                    }
                    Button(action: {
                        showStats.toggle()
                    }) {
                        Label("Stats", systemImage: "chart.bar.xaxis")
                    }
                }
            }
            .sheet(isPresented: $showStats) {
                CardsStats()
                    .environmentObject(model)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
