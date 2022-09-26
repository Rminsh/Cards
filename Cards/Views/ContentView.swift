//
//  ContentView.swift
//  Cards
//
//  Created by Armin on 9/24/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var model = CardsListViewModel()
    
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
                    CardStack(
                        direction: LeftRight.direction,
                        data: model.cards
                    ) { card, direction in
                        print("Swiped \(card) to \(direction)")
                    } content: { card, direction, isOnTop in
                        CardContentView(card: card)
                    }
                }
                .frame(maxWidth: 300, maxHeight:  400)
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
