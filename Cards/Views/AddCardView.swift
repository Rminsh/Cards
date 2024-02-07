//
//  AddView.swift
//  Cards
//
//  Created by Armin on 9/27/22.
//

import SwiftUI

struct AddCardView {
    @Binding var frontText: String
    @Binding var backText: String
    @State var saveAction: () -> Void
    
    @Environment(\.dismiss) var dismiss
}
    
extension AddCardView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                #if os(iOS)
                Color.background
                    .ignoresSafeArea(.all)
                #endif
                
                content
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                        clearFields()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        dismiss()
                        saveAction()
                        clearFields()
                    }
                }
            }
        }
    }
    
    var content: some View {
        ZStack {
            TextField("Front text", text: $frontText)
                .font(.system(.largeTitle, design: .rounded))
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .controlSize(.extraLarge)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .padding(.horizontal)
            
            TextField("Back text", text: $backText)
                .font(.system(.title3, design: .rounded))
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .controlSize(.large)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottom
                )
                .padding()
        }
        #if os(macOS)
        .frame(width: 300, height: 400)
        #else
        .frame(maxWidth: 300, maxHeight: 400)
        #endif
        #if !os(macOS)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 25, style: .continuous))
        .background {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .stroke(.white.opacity(0.3), lineWidth: 1.5)
        }
        .shadow(color: .black.opacity(0.2), radius: 25)
        #endif
        .padding()
    }
    
    func clearFields() {
        frontText = ""
        backText = ""
    }
}

#Preview {
    AddCardView(
        frontText: .constant(""),
        backText: .constant(""),
        saveAction: {}
    )
}
