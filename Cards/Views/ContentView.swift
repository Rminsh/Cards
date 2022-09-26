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
        ZStack {
            #if os(macOS)
            VisualEffectBlur(
                material: .popover,
                blendingMode: .behindWindow
            )
            .edgesIgnoringSafeArea(.all)
            #endif
            
            NavigationStack {
                ZStack {
                    if let cards = model.displayingCards {
                        if cards.isEmpty {
                            /// Empty list
                            Text("Finally, it is empty")
                                .font(.title)
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                                .foregroundStyle(.secondary)
                        } else {
                            /// Cards list
                            
                        }
                    } else {
                        /// Loading cards
                        ProgressView()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
