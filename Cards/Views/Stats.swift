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
        #if os(iOS)
        NavigationView {
            content
        }
        #else
        content
        #endif
    }
    
    var content: some View {
        List {
            Section {
                ForEach(model.forgotCards) { card in
                    Text("\(card.front ?? ""): \(card.back ?? "")")
                }
                
                if model.forgotCards.isEmpty {
                    Text("🎉 Yay! The forgot list is empty")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondary)
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
                
                if model.knewCards.isEmpty {
                    Text("🤔 Huh, The knew list is empty")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondary)
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

struct CardsStats_Previews: PreviewProvider {
    struct Preview: View {
        
        @StateObject var model = CardsListViewModel()
        
        var body: some View {
            Stats()
                .environmentObject(model)
        }
    }
    static var previews: some View {
        Preview()
    }
}
