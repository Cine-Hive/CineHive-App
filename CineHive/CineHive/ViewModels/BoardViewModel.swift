//
//  BoardViewModel.swift
//  CineHive
//
//  Created by 이종민 on 3/26/25.
//

import Foundation
import Observation

@Observable
class BoardViewModel {
    // MARK: - 상태 변수
    var boards: [Board] = []
    var selectedBoard: Board? = nil
    var isLoading: Bool = false
    var error: String? = nil
    
    private let boardService: BoardService
    
    init(boardService: BoardService = .shared) {
        self.boardService = boardService
    }
    
    // MARK: - 게시글 조회 메소드
    @MainActor
    func fetchBoards() {
        performNetworkRequest {
            self.boards = try await self.boardService.fetchBoards()
        }
    }
    
    // MARK: - 네트워크 요청 공통 처리 메소드
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
                self.error = "알 수 없는 오류가 발생했습니다."
            }
            isLoading = false
        }
    }
}
