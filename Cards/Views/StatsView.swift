//
//  StatsView.swift
//  Cards
//
//  Created by Armin on 9/27/22.
//

import SwiftUI

struct StatsView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: CardsListViewModel
    
    @AppStorage("leftOptionIcon") var leftOptionIcon: String = "hand.thumbsdown.circle"
    @AppStorage("leftOptionTitle") var leftOptionTitle: String = "Forgot"
    
    @AppStorage("rightOptionIcon") var rightOptionIcon: String = "hand.thumbsup.circle"
    @AppStorage("rightOptionTitle") var rightOptionTitle: String = "Knew"
    
    var body: some View {
        NavigationStack {
            ZStack {
                #if os(iOS)
                Color.background
                    .ignoresSafeArea(.all)
                #endif
                
                content
            }
            .navigationTitle("Stats")
            .toolbar {
                ToolbarItem {
                    Button {
                        dismiss()
                    } label: {
                        #if os(iOS)
                        Label("Close", systemImage: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                        #elseif os(macOS)
                        Text("Close")
                        #elseif os(visionOS)
                        Label("Close", systemImage: "xmark")
                        #endif
                    }
                }
            }
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
            #if os(iOS)
            .listRowBackground(Color.backgroundSecond)
            #endif
            
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
            #if os(iOS)
            .listRowBackground(Color.backgroundSecond)
            #endif
        }
        #if os(macOS)
        .listStyle(.inset(alternatesRowBackgrounds: true))
        .frame(minWidth: 350, minHeight: 500)
        #elseif os(iOS)
        .scrollContentBackground(.hidden)
        #endif
    }
}

#Preview {
    @StateObject var model = CardsListViewModel()
    
    return StatsView().environmentObject(model)
}
