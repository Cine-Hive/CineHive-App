//
//  DramaViewModel.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import Foundation
import Observation

@Observable
final class DramaViewModel {
    
    private(set) var dramas: [Drama] = []
    private(set) var dramaDetail: Drama?
    private(set) var isLoading = false
    private(set) var error: String?
    private let dramaService: DramaService
    
    init(dramaService: DramaService = .shared) {
        self.dramaService = dramaService
    }
    
    @MainActor
    func fetchDramas() async {
        performNetworkRequest {
            self.dramas = try await self.dramaService.fetchDramas()
        }
    }
    
    @MainActor
    func fetchDramaDetail(id: Int) async {
        performNetworkRequest {
            self.dramaDetail = try await self.dramaService.fetchDramaDetail(id: id)
        }
    }
    
    @MainActor
    private func performNetworkRequest(_ task: @escaping @Sendable () async throws -> Void) {
        Task {
            do {
                isLoading = true
                error = nil
                try await task()
            } catch let error as NetworkError {
                self.error = error.errorDescription
            } catch {
                self.error = "알 수 없는 오류가 발생했습니다: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
}
