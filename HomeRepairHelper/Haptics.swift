//
//  Haptics.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/22/21.
//

import SwiftUI
import Foundation

func playHaptic(style: String) {
    switch style {
    case "heavy":
        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
        impactMed.impactOccurred()
    case "medium":
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
    default:
        let impactMed = UIImpactFeedbackGenerator(style: .light)
        impactMed.impactOccurred()
    }
}
