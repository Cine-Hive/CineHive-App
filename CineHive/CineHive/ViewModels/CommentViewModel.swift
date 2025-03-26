//
//  CommentViewModel.swift
//  CineHive
//
//  Created by 이종민 on 3/27/25.
//

import Foundation
import Observation

@Observable
final class CommentViewModel {
    // MARK: - 상태 변수
    var comments: [Comment] = []
    var isLoading: Bool = false
    var error: String? = nil
    
    // 댓글 입력 관련 상태
    var commentText: String = ""
    var isSubmitting: Bool = false
    
    private let commentService: CommentService
    private let boardId: Int
    
    init(boardId: Int, commentService: CommentService = .shared) {
        self.boardId = boardId
        self.commentService = commentService
    }
    
    // MARK: - 댓글 조회 메소드
    @MainActor
    func fetchComments() {
        performNetworkRequest {
            self.comments = try await self.commentService.fetchComments(boardId: self.boardId)
        }
    }
    
    // MARK: - 댓글 작성 메소드
    @MainActor
    func addComment(email: String, nickname: String) async -> Bool {
        guard !commentText.isEmpty else { return false }
        
        do {
            isSubmitting = true
            error = nil
            
            let request = CommentForRequest(
                content: commentText,
                nickname: nickname,
                email: email
            )
            
            let newComment = try await commentService.addComment(boardId: boardId, email: email, request: request)
            
            // 댓글 목록에 추가
            comments.append(newComment)
            
            // 텍스트 필드 초기화
            commentText = ""
            
            isSubmitting = false
            return true
        } catch let networkError as NetworkError {
            error = networkError.errorDescription
            isSubmitting = false
            return false
        } catch {
            self.error = "댓글 작성 중 오류가 발생했습니다."
            isSubmitting = false
            return false
        }
    }
    
    // MARK: - 댓글 수정 메소드
    @MainActor
    func updateComment(commentId: Int, content: String, nickname: String, email: String) async -> Bool {
        do {
            isLoading = true
            error = nil
            
            let request = CommentForRequest(
                id: commentId,
                content: content,
                nickname: nickname,
                email: email
            )
            
            let updatedComment = try await commentService.updateComment(boardId: boardId, commentId: commentId, request: request)
            
            // 댓글 목록 업데이트
            if let index = comments.firstIndex(where: { $0.id == commentId }) {
                comments[index] = updatedComment
            }
            
            isLoading = false
            return true
        } catch let networkError as NetworkError {
            error = networkError.errorDescription
            isLoading = false
            return false
        } catch {
            self.error = "댓글 수정 중 오류가 발생했습니다."
            isLoading = false
            return false
        }
    }
    
    // MARK: - 댓글 삭제 메소드
    @MainActor
    func deleteComment(commentId: Int) async -> Bool {
        do {
            isLoading = true
            error = nil
            
            try await commentService.deleteComment(boardId: boardId, commentId: commentId)
            
            // 댓글 목록에서 제거
            comments.removeAll { $0.id == commentId }
            
            isLoading = false
            return true
        } catch let networkError as NetworkError {
            error = networkError.errorDescription
            isLoading = false
            return false
        } catch {
            self.error = "댓글 삭제 중 오류가 발생했습니다."
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
}
