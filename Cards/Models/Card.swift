//
//  Card.swift
//  Cards
//
//  Created by Armin on 9/25/22.
//

import Foundation

struct Card: Identifiable {
    var id = UUID().uuidString
    var front: String
    var back: String
    var status: CardStatus = .blank
}

enum CardStatus {
    case blank
    case knew
    case forgot
}
