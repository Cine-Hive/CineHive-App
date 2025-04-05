//
//  DetailActionsButtonViewModel.swift
//  CineHive
//
//  Created by 이종민 on 3/7/25.
//

import SwiftUI

@Observable
class DetailActionButtonsViewModel {
    var isAddedToList = false
    var showAvailabilitySheet = false
    var showShareSheet = false

    func toggleWatchlist() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            isAddedToList.toggle()
        }
        provideHapticFeedback()
    }

    func openAvailabilitySheet() {
        showAvailabilitySheet = true
    }

    func openShareSheet() {
        showShareSheet = true
    }

    func closeAvailabilitySheet() {
        showAvailabilitySheet = false
    }

    func closeShareSheet() {
        showShareSheet = false
    }

    private func provideHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}
