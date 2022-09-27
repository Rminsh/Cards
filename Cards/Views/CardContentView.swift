//
//  CardContentView.swift
//  Cards
//
//  Created by Armin on 9/26/22.
//

import SwiftUI

struct CardContentView: View {
    
    @State var card: Card
    let direction: LeftRight?
    @State var deleteAction: () -> Void
    
    @State private var showAnswer: Bool = false
    @State private var showDeleteDialog: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                /// Delete card
                Button(action: { showDeleteDialog.toggle() }) {
                    Image(systemName: "trash.fill")
                }
                
                Spacer()
                
                /// Show Answer
                Button(action: {
                    withAnimation {
                        showAnswer.toggle()
                    }
                }) {
                    Image(systemName: "questionmark.circle.fill")
                }
            }
            .foregroundStyle(.secondary)
            .buttonStyle(.plain)
            .padding()
            
            Text(card.front ?? "")
                .font(.largeTitle)
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if showAnswer {
                Text(card.back ?? "")
                    .font(.title3)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .bottom
                    )
                    .padding()
                    .animation(.interactiveSpring(), value: showAnswer)
                    .transition(.move(edge: .bottom))
            }
            
            Image(systemName: "hand.thumbsup.circle")
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundColor(.green)
                .symbolRenderingMode(.hierarchical)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .leading
                )
                .padding()
                .opacity(direction == .right ? 1 : 0)
                .animation(.spring(), value: direction)
                
            
            Image(systemName: "hand.thumbsdown.circle")
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundColor(.red)
                .symbolRenderingMode(.hierarchical)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .trailing
                )
                .padding()
                .opacity(direction == .left ? 1 : 0)
                .animation(.spring(), value: direction)
                
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
        .alert("Delete this card?", isPresented: $showDeleteDialog) {
            Button("Delete", role: .destructive, action: deleteAction)
            Button("Cancel", role: .cancel, action: {})
        }
    }
}

struct CardContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardContentView(
            card: Card(),
            direction: nil,
            deleteAction: {}
        )
        .frame(maxWidth: 200, maxHeight: 350)
        .padding(.all, 50)
    }
}
