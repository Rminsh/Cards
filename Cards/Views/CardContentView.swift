//
//  CardContentView.swift
//  Cards
//
//  Created by Armin on 9/26/22.
//

import SwiftUI

struct CardContentView: View {
    
    @State var frontText: String
    @State var backText : String
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
                #if os(iOS)
                .hoverEffect(.lift)
                #endif
                
                Spacer()
                
                /// Show Answer
                Button(action: {
                    withAnimation {
                        showAnswer.toggle()
                        #if os(iOS)
                        HapticGenerator.shared.impact()
                        #endif
                    }
                }) {
                    Image(systemName: "questionmark.circle.fill")
                }
                #if os(iOS)
                .hoverEffect(.lift)
                #endif
            }
            .opacity(0.65)
            .buttonStyle(.plain)
            .padding()
            
            /// Front Text
            Text(frontText)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(.horizontal)
            
            /// Back Text
            if showAnswer {
                Text(backText)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
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
            
            /// Thumbs up
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
                
            /// Thumbs down
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
        .background(.ultraThinMaterial)
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
            frontText: "Front text with some long text for testing",
            backText: "Back text with some long text for testing",
            direction: nil,
            deleteAction: {}
        )
        .frame(maxWidth: 350, maxHeight: 400)
        .padding(.all, 50)
    }
}
