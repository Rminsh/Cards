//
//  AddView.swift
//  Cards
//
//  Created by Armin on 9/27/22.
//

import SwiftUI

struct AddView: View {
    
    @Binding var frontText: String
    @Binding var backText: String
    @State var saveAction: () -> Void
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        #if os(iOS)
        NavigationView {
            content
        }
        #else
        content
        #endif
    }
    
    var content: some View {
        ZStack {
            TextField("Front text", text: $frontText)
                .font(.system(.largeTitle, design: .rounded))
                .multilineTextAlignment(.center)
                .textFieldStyle(.plain)
                .padding(.vertical)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.primary.opacity(0.05))
                )
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .padding(.horizontal)
            
            TextField("Back text", text: $backText)
                .font(.system(.title3, design: .rounded))
                .multilineTextAlignment(.center)
                .textFieldStyle(.plain)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.primary.opacity(0.05))
                )
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottom
                )
                .padding()
        }
        #if os(macOS)
        .frame(width: 300, height: 400)
        #elseif os(iOS)
        .background(.thinMaterial)
        .frame(maxWidth: 300, maxHeight: 400)
        #endif
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding()
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
    
    func clearFields() {
        frontText = ""
        backText = ""
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(
            frontText: .constant(""),
            backText: .constant(""),
            saveAction: {}
        )
    }
}
