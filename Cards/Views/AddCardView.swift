//
//  AddView.swift
//  Cards
//
//  Created by Armin on 9/27/22.
//

import SwiftUI

struct AddCardView: View {
    
    @Binding var frontText: String
    @Binding var backText: String
    @State var saveAction: () -> Void
    
    @Environment(\.dismiss) var dismiss
    
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
        .background(.thinMaterial)
        .frame(maxWidth: 300, maxHeight: 400)
        #endif
        .cornerRadius(12)
        .shadow(radius: 2)
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
