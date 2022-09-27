//
//  CardsListViewModel.swift
//  Cards
//
//  Created by Armin on 9/25/22.
//

import Foundation

class CardsListViewModel: ObservableObject {
    
    @Published var knewCards: [Card] = []
    @Published var forgotCards: [Card] = []
    @Published var reloadToken = UUID()
    
    func addKnewCard(_ card: Card) {
        self.knewCards.append(card)
    }
    
    func addForgotCard(_ card: Card) {
        self.forgotCards.append(card)
    }
    
    func resetStats() {
        self.knewCards.removeAll()
        self.forgotCards.removeAll()
    }
}
