//
//  CommentService.swift
//  CineHive
//
//  Created by 이종민 on 3/27/25.
//

import Foundation

final class CommentService {
    static let shared = CommentService()
    private init() { }
    
    // MARK: - 엔드포인트
    private let commentEndPoint = "/comment"
    
    // MARK: - 댓글 조회
    func fetchComments(boardId: Int) async throws -> [Comment] {
        let endpoint = "\(commentEndPoint)/all/board/\(boardId)"
        return try await NetworkManager.shared.fetch(endpoint: endpoint)
    }
    
    // MARK: - 댓글 등록
    func addComment(boardId: Int, email: String, request: CommentForRequest) async throws -> Comment {
        let endpoint = "\(commentEndPoint)/\(boardId)/\(email)"
        return try await NetworkManager.shared.post(endpoint: endpoint, body: request)
    }
    
    // MARK: - 댓글 수정
    func updateComment(boardId: Int, commentId: Int, request: CommentForRequest) async throws -> Comment {
        let endpoint = "\(commentEndPoint)/board/\(boardId)/update/\(commentId)"
        return try await NetworkManager.shared.put(endpoint: endpoint, body: request)
    }
    
    // MARK: - 댓글 삭제
    func deleteComment(boardId: Int, commentId: Int) async throws {
        let endpoint = "\(commentEndPoint)/board/\(boardId)/delete/\(commentId)"
        try await NetworkManager.shared.delete(endpoint: endpoint)
    }
    
}
