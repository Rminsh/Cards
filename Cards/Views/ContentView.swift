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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.creationDate)]) var cards: FetchedResults<Card>
    
    @State private var showAdd: Bool = false
    @State private var showStats: Bool = false
    @State private var showHint: Bool = true
    @State private var showSettings: Bool = false
    
    @State private var frontText: String = ""
    @State private var backText : String = ""
    
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
        ZStack {
            /// Background
            #if os(macOS)
            VisualEffectBlur(
                material: .popover,
                blendingMode: .behindWindow
            )
            .edgesIgnoringSafeArea(.all)
            #elseif os(iOS)
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            #endif
            
            /// Base content
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
                        frontText: card.front ?? "",
                        backText: card.back ?? "",
                        direction: direction,
                        deleteAction: { removeCard(card) }
                    )
                }
                .id(model.reloadToken)
            }
            .frame(maxWidth: 300, maxHeight:  400)
            .padding()
            
            /// Hints
            HStack {
                if showHint {
                    Spacer()
                    VStack(spacing: 15) {
                        Image(systemName: leftOptionIcon)
                            .font(.title2)
                        Text("Swipe left for \(leftOptionTitle)")
                            .font(.callout)
                    }
                    Spacer()
                    VStack(spacing: 15) {
                        Image(systemName: rightOptionIcon)
                            .font(.title2)
                        Text("Swipe right for \(rightOptionTitle)")
                            .font(.callout)
                    }
                    Spacer()
                }
            }
            .foregroundStyle(.secondary)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding()
            .animation(.easeIn, value: showHint)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.showHint.toggle()
                    }
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
                /// Add Card
                Button(action: { showAdd.toggle() }) {
                    Label("Add", systemImage: "plus")
                }
            }
            
            ToolbarItemGroup {
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
                
                Button {
                    showSettings.toggle()
                } label: {
                    Label("Settings", systemImage: "gear")
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
        .sheet(isPresented: $showSettings) {
            SettingsView()
                #if os(macOS)
                .frame(minWidth: 350, minHeight: 450)
                #endif
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("NewCard"))) {_ in
            showAdd.toggle()
        }
    }
    
    func reload() {
        withAnimation {
            model.reloadToken = UUID()
            model.resetStats()
        }
        #if os(iOS)
        HapticGenerator.shared.impact(style: .heavy)
        #endif
    }
    
    func addCard() {
        let card = Card(context: moc)
        card.id = UUID()
        card.front = frontText
        card.back = backText
        card.creationDate = Date()
        
        try? moc.save()
        moc.refresh(card, mergeChanges: true)
        reload()
    }
    
    func removeCard(_ card: Card) {
        moc.delete(card)
        reload()
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
