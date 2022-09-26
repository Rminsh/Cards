//
//  CardContentView.swift
//  Cards
//
//  Created by Armin on 9/26/22.
//

import SwiftUI

struct CardContentView: View {
    
    @State var card: Card
    @State private var showAnswer: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            Button(action: {
                withAnimation {
                    showAnswer.toggle()
                }
            }) {
                Image(systemName: "questionmark.circle.fill")
            }
            .foregroundStyle(.secondary)
            .buttonStyle(.plain)
            .padding()
            
            Text(card.front)
                .font(.largeTitle)
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if showAnswer {
                Text(card.back)
                    .font(.title3)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .bottom
                    )
                    .padding()
                    .animation(.interactiveSpring(), value: showAnswer)
                    .transition(.move(edge: .bottom))
            }
        }
        #if os(macOS)
        .background(
            VisualEffectBlur(
                material: .menu,
                blendingMode: .withinWindow
            )
        )
        #elseif os(iOS)
        .background(.thinMaterial)
        #endif
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct CardContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardContentView(card: Card(front: "Front", back: "Back"))
            .frame(maxWidth: 200, maxHeight: 350)
            .padding(.all, 50)
    }
}
