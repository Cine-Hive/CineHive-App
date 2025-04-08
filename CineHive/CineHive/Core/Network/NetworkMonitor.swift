//
//  NetworkMonitor.swift
//  CineHive
//
//  Created by 이종민 on 3/30/25.
//

import Foundation
import Network
import Observation
import OSLog

// 연결 타입 열거형
enum ConnectionType: String {
    case wifi = "Wi-Fi"
    case cellular = "셀룰러"
    case ethernet = "유선"
    case unknown = "알 수 없음"
}

@Observable
final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    var isConnected: Bool = true
    private var streamContinuation: AsyncStream<Bool>.Continuation?
    var connectionType: ConnectionType = .unknown
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            Task { @MainActor in
                self.isConnected = (path.status == .satisfied)
                self.updateConnectionType(path)
                self.streamContinuation?.yield(self.isConnected)
                Logger.log(.info, category: Logger.networking, message: "네트워크 상태: \(self.isConnected ? "연결됨 (\(self.connectionType.rawValue))" : "끊김")")
            }
        }
        monitor.start(queue: queue)
    }
    
    private func updateConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
    
    func connectionStream() -> AsyncStream<Bool> {
        AsyncStream { continuation in
            self.streamContinuation = continuation
            continuation.yield(self.isConnected) // 초기값 전송
        }
    }
    
    func testConnection() async -> Bool {
        guard let url = URL(string: "https://www.apple.com") else {
            return false
        }
        
        do {
            let (_, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                return false
            }
            
            let isSuccess = (200...299).contains(httpResponse.statusCode)
            
            await MainActor.run {
                self.isConnected = isSuccess
            }
            
            return isSuccess
        } catch {
            Logger.log(.error, category: Logger.networking, message: "네트워크 연결 테스트 실패: \(error.localizedDescription)")
            
            // 실패 시 isConnected를 false로 설정
            await MainActor.run {
                self.isConnected = false
            }
            
            return false
        }
    }
    
    func retryNetworkCheck() {
        Task {
            _ = await testConnection()
        }
    }
}
