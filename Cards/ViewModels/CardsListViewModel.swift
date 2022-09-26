//
//  CardsListViewModel.swift
//  Cards
//
//  Created by Armin on 9/25/22.
//

import Foundation

class CardsListViewModel: ObservableObject {
    
    @Published var cards: [Card] = []
    @Published var reloadToken = UUID()
    
    init() {
        rearrangeCards()
    }
    
    func rearrangeCards() {
        self.reloadToken = UUID()
        cards = [
            Card(front: "Pester", back: "اذیت کردن / چشیدن"),
            Card(front: "Vice versa", back: "برعکس / در جهت مخالف"),
            Card(front: "Illusion", back: "وهم / خیال"),
            Card(front: "Bargain", back: "معامله / داد و ستد / چانه زنی"),
            Card(front: "Leisure", back: "اوقات فراغت / فرصت / وقت کافی"),
            Card(front: "Glamour", back: "فریبندگی / زرق و برق / جادو / افسون"),
        ]
    }
    
    func updateCardStatus(card: Card, status: CardStatus) {
        let index = self.cards.firstIndex(where: { $0.id == card.id })
        if let index {
            self.cards[index].status = status
        }
    }
}
