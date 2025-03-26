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
    
}
