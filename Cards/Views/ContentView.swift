//
//  ContentView.swift
//  Cards
//
//  Created by Armin on 9/24/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @StateObject var model = CardsListViewModel()
    @FetchRequest(sortDescriptors: []) var cards: FetchedResults<Card>
    
    @State private var showAdd  : Bool = false
    @State private var showStats: Bool = false
    
    @State private var frontText: String = ""
    @State private var backText : String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                #if os(macOS)
                VisualEffectBlur(
                    material: .popover,
                    blendingMode: .behindWindow
                )
                .edgesIgnoringSafeArea(.all)
                #endif
                
                ZStack {
                    /// EmptyState
                    VStack(spacing: 10) {
                        Image(systemName: cards.isEmpty ? "rectangle.stack.fill.badge.plus" : "app.badge.checkmark.fill")
                            .font(.largeTitle)
                        
                        Text(cards.isEmpty ?
                             "Cards list is empty, add cards!" :
                             "Finally, the list is empty. You can check the stats or reload cards."
                        )
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                    }
                    .foregroundStyle(.secondary)
                    .padding()
                    
                    /// Cards
                    CardStack(
                        direction: LeftRight.direction,
                        data: cards.reversed(),
                        id: \.id
                    ) { card, direction in
                        switch direction {
                        case .left:
                            model.addForgotCard(card)
                        case .right:
                            model.addKnewCard(card)
                        }
                    } content: { card, direction, isOnTop in
                        CardContentView(
                            card: card,
                            direction: direction,
                            deleteAction: { removeCard(card) }
                        )
                    }
                    .id(model.reloadToken)
                }
                .frame(maxWidth: 300, maxHeight:  400)
                .padding()
            }
            .toolbar {
                ToolbarItemGroup {
                    /// Add Card
                    Button(action: { showAdd.toggle() }) {
                        Label("Add", systemImage: "plus")
                    }
                    /// Reloading Cards
                    Button(action: reload) {
                        Label("Reload", systemImage: "arrow.counterclockwise")
                    }
                    /// Show Stats of Cards
                    Button(action: {
                        showStats.toggle()
                    }) {
                        Label("Stats", systemImage: "chart.bar.xaxis")
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                AddView(
                    frontText: $frontText,
                    backText: $backText,
                    saveAction: addCard
                )
            }
            .sheet(isPresented: $showStats) {
                Stats()
                    .environmentObject(model)
            }
        }
    }
    func reload() {
        withAnimation {
            model.reloadToken = UUID()
            model.resetStats()
        }
    }
    
    func addCard() {
        let card = Card(context: moc)
        card.id = UUID()
        card.front = frontText
        card.back = backText
        
        try? moc.save()
        moc.refresh(card, mergeChanges: true)
        reload()
    }
    
    func removeCard(_ card: Card) {
        moc.delete(card)
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
