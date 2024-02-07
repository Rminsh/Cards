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
    
    @AppStorage("leftOptionIcon") var leftOptionIcon: String = "hand.thumbsdown.circle"
    @AppStorage("rightOptionIcon") var rightOptionIcon: String = "hand.thumbsup.circle"
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                /// Delete card
                Button(action: { showDeleteDialog.toggle() }) {
                    Image(systemName: "trash.fill")
                }
                #if !os(macOS)
                .hoverEffect(.lift)
                #endif
                
                Spacer()
                
                /// Show Answer
                Button(action: {
                    withAnimation {
                        showAnswer.toggle()
                    }
                }) {
                    Image(systemName: "questionmark.circle.fill")
                }
                #if !os(macOS)
                .hoverEffect(.lift)
                #elseif !os(visionOS)
                .sensoryFeedback(.warning, trigger: showAnswer)
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
            
            /// Right swipe
            Image(systemName: rightOptionIcon)
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.green)
                .symbolRenderingMode(.hierarchical)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .leading
                )
                .padding()
                .opacity(direction == .right ? 1 : 0)
                .animation(.spring(), value: direction)
                #if !os(visionOS)
                .sensoryFeedback(.impact(weight: .heavy), trigger: direction == .right)
                #endif
                
            /// Left swipe
            Image(systemName: leftOptionIcon)
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.red)
                .symbolRenderingMode(.hierarchical)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .trailing
                )
                .padding()
                .opacity(direction == .left ? 1 : 0)
                .animation(.spring(), value: direction)
                #if !os(visionOS)
                .sensoryFeedback(.impact(weight: .heavy), trigger: direction == .left)
                #endif
        }
        #if os(macOS)
        .background(
            VisualEffectBlur(
                material: .menu,
                blendingMode: .withinWindow
            )
        )
        #else
        .background(.ultraThinMaterial)
        #endif
        .clipShape(.rect(cornerRadius: 25, style: .continuous))
        .background {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .stroke(.white.opacity(0.3), lineWidth: 1.5)
        }
        .shadow(color: .black.opacity(0.2), radius: 25)
        .alert("Delete this card?", isPresented: $showDeleteDialog) {
            Button("Delete", role: .destructive, action: deleteAction)
            Button("Cancel", role: .cancel, action: {})
        }
    }
}

#Preview {
    CardContentView(
        frontText: "Front text with some long text for testing",
        backText: "Back text with some long text for testing",
        direction: nil,
        deleteAction: {}
    )
    .frame(maxWidth: 350, maxHeight: 400)
    .padding(.all, 50)
}
