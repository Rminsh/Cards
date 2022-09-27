//
//  CardsStats.swift
//  Cards
//
//  Created by Armin on 9/27/22.
//

import SwiftUI

struct Stats: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: CardsListViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(model.forgotCards) { card in
                        Text("\(card.front ?? ""): \(card.back ?? "")")
                    }
                } header: {
                    Label("Forgot", systemImage: "xmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.red)
                }
                
                Section {
                    ForEach(model.knewCards) { card in
                        Text("\(card.front ?? ""): \(card.back ?? "")")
                    }
                } header: {
                    Label("Knew", systemImage: "checkmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.green)
                }
            }
            #if os(macOS)
            .listStyle(.inset(alternatesRowBackgrounds: true))
            .frame(minWidth: 350, minHeight: 500)
            #endif
            .navigationTitle("Stats")
            .toolbar {
                ToolbarItem {
                    Button {
                        dismiss()
                    } label: {
                        Label("Close", systemImage: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                    }
                }
            }
        }
    }
}

struct CardsStats_Previews: PreviewProvider {
    static var previews: some View {
        Stats()
    }
}
