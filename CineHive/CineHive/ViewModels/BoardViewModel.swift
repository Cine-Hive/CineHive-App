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
    
    // 검색 관련 상태
    var searchText: String = ""
    var searchResults: [Board] = []
    var isSearching: Bool = false
    
    // 카테고리 관련 상태
    var selectedCategory: BoardCategory = .all
    
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
    
    // MARK: - 게시글 검색 메소드
    @MainActor
    func searchBoards(keyword: String) {
        guard !keyword.isEmpty else {
            self.searchResults = []
            return
        }
        
        performNetworkRequest {
            self.searchResults = try await self.boardService.searchBoards(keyword: keyword)
            self.isSearching = true
        }
    }
    
    // MARK: - 게시글 상세 조회 메소드
    @MainActor
    func fetchBoardDetail(id: Int) {
        performNetworkRequest {
            self.selectedBoard = try await self.boardService.fetchBoardDetail(id: id)
        }
    }
    
    // MARK: - 게시글 생성 메소드
    @MainActor
    func createBoard(title: String, content: String, email: String) async -> Bool {
        do {
            isLoading = true
            error = nil
            
            let request = BoardForRequest(
                email: email,
                title: title,
                content: content
            )
            
            let newBoard = try await boardService.createBoard(request: request)
            // 새 게시글을 목록에 추가
            boards.insert(newBoard, at: 0)
            
            isLoading = false
            return true
        } catch let networkError as NetworkError {
            error = networkError.errorDescription
            isLoading = false
            return false
        } catch {
            self.error = "게시글 작성 중 오류가 발생했습니다."
            isLoading = false
            return false
        }
    }
    
    // MARK: - 게시글 수정 메소드
    @MainActor
    func updateBoard(id: Int, title: String, content: String, email: String) async -> Bool {
        do {
            isLoading = true
            error = nil
            
            let request = BoardForRequest(
                email: email,
                title: title,
                content: content
            )
            
            let updatedBoard = try await boardService.updateBoard(id: id, request: request)
            
            // 목록에서 해당 게시글 업데이트
            if let index = boards.firstIndex(where: { $0.id == id }) {
                boards[index] = updatedBoard
            }
            
            // 현재 선택된 게시글이 수정한 게시글이면 업데이트
            if selectedBoard?.id == id {
                selectedBoard = updatedBoard
            }
            
            isLoading = false
            return true
        } catch let networkError as NetworkError {
            error = networkError.errorDescription
            isLoading = false
            return false
        } catch {
            self.error = "게시글 수정 중 오류가 발생했습니다."
            isLoading = false
            return false
        }
    }
    
    // MARK: - 게시글 삭제 메소드
    @MainActor
    func deleteBoard(id: Int) async -> Bool {
        do {
            isLoading = true
            error = nil
            
            try await boardService.deleteBoard(id: id)
            
            // 목록에서 해당 게시글 삭제
            boards.removeAll { $0.id == id }
            
            // 현재 선택된 게시글이 삭제한 게시글이면 초기화
            if selectedBoard?.id == id {
                selectedBoard = nil
            }
            
            isLoading = false
            return true
        } catch let networkError as NetworkError {
            error = networkError.errorDescription
            isLoading = false
            return false
        } catch {
            self.error = "게시글 삭제 중 오류가 발생했습니다."
            isLoading = false
            return false
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
    
    // MARK: - 검색 관련 메소드
    func clearSearch() {
        searchText = ""
        searchResults = []
        isSearching = false
    }
    
    // MARK: - 카테고리 변경 메소드
    @MainActor
    func changeCategory(to category: BoardCategory) {
        selectedCategory = category
        // 카테고리에 맞는 게시글을 가져오는 로직은 추후 API 구현 시 업데이트 필요
        fetchBoards()
    }
}
