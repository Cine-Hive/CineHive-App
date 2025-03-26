//
//  BoardService.swift
//  CineHive
//
//  Created by 이종민 on 3/26/25.
//

import Foundation

final class BoardService {
    static let shared = BoardService()
    private init() { }
    
    // MARK: - 엔드포인트
    private let boardsEndpoint = "/boards"
    private let createBoardEndpoint = "/boards/create"
    private let deleteBoardEndpoint = "/boards/delete"
    private let detailBoardEndpoint = "/boards/detail"
    private let searchBoardEndpoint = "/boards/search"
    private let updateBoardEndpoint = "/boards"
    private let commentEndpoint = "/comment/all/board"
    
    private let dislikeBaseEndpoint = "/dislike"
    private let likeBaseEndpoint = "/like"
    
    // MARK: - 게시글 목록 조회
    func fetchBoards() async throws -> [Board] {
        return try await NetworkManager.shared.fetch(endpoint: boardsEndpoint)
    }
    
    // MARK: - 게시글 등록
    func createBoard(request: BoardForRequest) async throws -> Board {
        return try await NetworkManager.shared.post(endpoint: createBoardEndpoint, body: request)
    }
    
    // MARK: - 게시글 삭제
    func deleteBoard(id: Int) async throws {
        let endpoint = "\(deleteBoardEndpoint)/\(id)"
        try await NetworkManager.shared.delete(endpoint: endpoint)
    }
    
    // MARK: - 게시글 상세 조회
    func fetchBoardDetail(id: Int) async throws -> Board {
        let endpoint = "\(detailBoardEndpoint)/\(id)"
        return try await NetworkManager.shared.fetch(endpoint: endpoint)
    }
    
    // MARK: - 게시글 검색
    func searchBoards(keyword: String) async throws -> [Board] {
        let queryItems = [
            URLQueryItem(name: "keyword", value: keyword)
        ]
        return try await NetworkManager.shared.fetch(endpoint: searchBoardEndpoint, queryItems: queryItems)
    }
    
    // MARK: - 게시글 수정
    func updateBoard(id: Int, request: BoardForRequest) async throws -> Board {
        let endpoint = "\(updateBoardEndpoint)/\(id)"
        return try await NetworkManager.shared.put(endpoint: endpoint, body: request)
    }
    
    // MARK: - 좋아요 등록
    func addLike(boardId: Int, userEmail: String) async throws {
        let endpoint = "\(likeBaseEndpoint)/\(boardId)/users/\(userEmail)"
        try await NetworkManager.shared.post(endpoint: endpoint, body: EmptyRequest())
    }
}
