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

    /// boardId에 해당하는 게시글의 전체 댓글을 조회합니다.
    func fetchComments(for boardId: Int) async throws -> [Comment] {
        let endpoint = "\(commentEndpoint)/\(boardId)"
        return try await NetworkManager.shared.fetch(endpoint: endpoint)
    }
}
