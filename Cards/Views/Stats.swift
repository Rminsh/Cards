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
    
    @AppStorage("leftOptionIcon") var leftOptionIcon: String = "hand.thumbsdown.circle"
    @AppStorage("leftOptionTitle") var leftOptionTitle: String = "Forgot"
    
    @AppStorage("rightOptionIcon") var rightOptionIcon: String = "hand.thumbsup.circle"
    @AppStorage("rightOptionTitle") var rightOptionTitle: String = "Knew"
    
    var body: some View {
        NavigationStack {
            content
        }
    }
    
    var content: some View {
        List {
            Section {
                ForEach(model.forgotCards) { card in
                    Text("\(card.front ?? ""): \(card.back ?? "")")
                }
                
                if model.forgotCards.isEmpty {
                    Text("The \(leftOptionTitle) list is empty")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondary)
                }
            } header: {
                Label(leftOptionTitle, systemImage: leftOptionIcon)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.red.gradient)
            }
            
            Section {
                ForEach(model.knewCards) { card in
                    Text("\(card.front ?? ""): \(card.back ?? "")")
                }
                
                if model.knewCards.isEmpty {
                    Text("The \(rightOptionTitle) list is empty")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondary)
                }
            } header: {
                Label(rightOptionTitle, systemImage: rightOptionIcon)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.green.gradient)
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
