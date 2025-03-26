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
    
    private let commentEndpoint = "/comment/all/board"
    private let boardsEndpoint = "/boards"
    
    /// 전체 게시글 목록을 조회합니다.
    func fetchBoards() async throws -> [Board] {
        return try await NetworkManager.shared.fetch(endpoint: boardsEndpoint)
    }
}
