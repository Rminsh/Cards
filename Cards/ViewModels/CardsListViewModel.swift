//
//  CardsListViewModel.swift
//  Cards
//
//  Created by Armin on 9/25/22.
//

import Foundation

class CardsListViewModel: ObservableObject {
    
    @Published var fetchedCards: [Card] = []
    
    @Published var displayingCards: [Card]?
    
    init() {
        fetchedCards = [
            Card(front: "Pester", back: "اذیت کردن / چشیدن"),
            Card(front: "Vice versa", back: "برعکس / در جهت مخالف"),
            Card(front: "Illusion", back: "وهم / خیال"),
            Card(front: "Bargain", back: "معامله / داد و ستد / چانه زنی"),
            Card(front: "Leisure", back: "اوقات فراغت / فرصت / وقت کافی"),
            Card(front: "Glamour", back: "فریبندگی / زرق و برق / جادو / افسون"),
        ]
        
        displayingCards = fetchedCards
    }
}
