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
        Form {
            TextField("Front", text: $frontText)
            TextField("Back", text: $backText)
        }
        #if os(macOS)
        .padding()
        .frame(minWidth: 250, minHeight: 100)
        #endif
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    dismiss()
                    saveAction()
                }
            }
        }
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
