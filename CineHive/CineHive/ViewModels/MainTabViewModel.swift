//
//  MainTabViewModel.swift
//  CineHive
//
//  Created by 이종민 on 3/30/25.
//

import Foundation
import Observation

@Observable
final class MainTabViewModel {
    var isNetworkConnected: Bool = true
    var showNetworkToast: Bool = false

    private let monitor = NetworkMonitor.shared

    init() {
        observeNetwork()
    }

    private func observeNetwork() {
        Task {
            for await connection in monitor.connectionStream() {
                self.isNetworkConnected = connection
                if connection == false {
                    self.showNetworkToast = true
                }
            }
        }
    }
    
    func retryNetworkCheck() {
            Task { @MainActor in
                self.isNetworkConnected = monitor.isConnected
                if monitor.isConnected {
                    self.showNetworkToast = false
                }
            }
        }
}
