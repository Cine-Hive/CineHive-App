//
//  NetworkMonitor.swift
//  CineHive
//
//  Created by 이종민 on 3/30/25.
//

import Foundation
import Network
import Observation

@Observable
final class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")

    var isConnected: Bool = true

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            Task { @MainActor in
                self.isConnected = (path.status == .satisfied)
                print("네트워크 상태: \(self.isConnected ? "연결됨" : "끊김")")
            }
        }
        monitor.start(queue: queue)
    }
}
