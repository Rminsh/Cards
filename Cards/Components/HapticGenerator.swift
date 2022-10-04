//
//  HapticGenerator.swift
//  Cards
//
//  Created by Armin on 10/4/22.
//
#if canImport(UIKit)
import UIKit

class HapticGenerator {
    
    static let shared = HapticGenerator()
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        let hapticGenerator = UIImpactFeedbackGenerator(style: style)
        hapticGenerator.impactOccurred()
    }
    
    func notif(style: UINotificationFeedbackGenerator.FeedbackType = .success) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
}
#endif
