//
//  BoardDetailView.swift
//  CineHive
//
//  Created by 이종민 on 3/27/25.
//

import SwiftUI

struct BoardDetailView: View {
    let boardId: Int
    @State var viewModel: BoardViewModel
    @State private var commentViewModel: CommentViewModel
    @State private var showActionSheet = false
    @State private var showCommentActionSheet = false
    @State private var selectedCommentId: Int? = nil
    @State private var editingCommentId: Int? = nil
    @State private var editingCommentText: String = ""
    @State private var userEmail = "user@example.com" // 추후에 UserDefaults나 AuthManager에서 가져옴
    
    // 테마 색상
    private let backgroundColor = CHColors.backgroundColor
    private let primaryColor = CHColors.primaryColor
    private let textColor = CHColors.textColor
    private let secondaryColor = CHColors.secondaryColor
    
    @Environment(\.dismiss) private var dismiss
    
    init(boardId: Int, viewModel: BoardViewModel) {
        self.boardId = boardId
        self.viewModel = viewModel
        self._commentViewModel = State(initialValue: CommentViewModel(boardId: boardId))
    }
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 헤더
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(textColor)
                    }
                    
                    Spacer()
                    
                    Text("게시글")
                        .font(.headline)
                        .foregroundColor(textColor)
                    
                    Spacer()
                    
                    Menu {
                        Button {
                            // 공유 기능
                        } label: {
                            Label("공유하기", systemImage: "square.and.arrow.up")
                        }
                        
                        if viewModel.selectedBoard?.author == "현재사용자" || viewModel.selectedBoard?.author == userEmail { // 사용자 정보 확인 로직 수정 필요
                            Button {
                                showActionSheet = true
                            } label: {
                                Label("더 보기", systemImage: "ellipsis")
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 18))
                            .foregroundColor(textColor)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                if viewModel.isLoading {
                    loadingView()
                } else if let board = viewModel.selectedBoard {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            boardDetailContent(board)
                            
                            Divider()
                                .background(Color.gray.opacity(0.3))
                                .padding(.vertical, 16)
                            
                            commentSection()
                            
                            Spacer(minLength: 60)
                        }
                    }
                    
                    commentInputBar()
                }
            }
        }
        .foregroundColor(textColor)
        .navigationBarHidden(true)
        .confirmationDialog("게시글 관리", isPresented: $showActionSheet, titleVisibility: .visible) {
            Button("수정하기") {
                // 수정 화면으로 이동하는 로직
            }
            
            Button("삭제하기", role: .destructive) {
                Task {
                    let success = await viewModel.deleteBoard(id: boardId)
                    if success {
                        dismiss()
                    }
                }
            }
            
            Button("취소", role: .cancel) {}
        }
        .confirmationDialog("댓글 관리", isPresented: $showCommentActionSheet, titleVisibility: .visible) {
            if let commentId = selectedCommentId {
                Button("수정하기") {
                    if let comment = commentViewModel.comments.first(where: { $0.id == commentId }) {
                        editingCommentId = commentId
                        editingCommentText = comment.content
                    }
                }
                
                Button("삭제하기", role: .destructive) {
                    Task {
                        let success = await commentViewModel.deleteComment(commentId: commentId)
                        if success {
                            selectedCommentId = nil
                        }
                    }
                }
            }
            
            Button("취소", role: .cancel) {
                selectedCommentId = nil
            }
        }
        .onAppear {
            Task {
                await loadBoardDetail()
            }
        }
    }
    
    private func loadingView() -> some View {
        VStack(spacing: 20) {
            ProgressView()
                .tint(primaryColor)
                .scaleEffect(1.5)
            
            Text("게시글을 불러오는 중...")
                .font(.caption)
                .foregroundColor(secondaryColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func boardDetailContent(_ board: Board) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            // 제목
            Text(board.title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(textColor)
            
            // 작성자 정보
            HStack {
                Text(board.category)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(primaryColor.opacity(0.2))
                    .foregroundColor(primaryColor)
                    .cornerRadius(4)
                
                Spacer()
                
                Text(board.author)
                    .font(.caption)
                    .foregroundColor(secondaryColor)
                
                Text("•")
                    .font(.caption)
                    .foregroundColor(secondaryColor)
                
                Text(board.createdAt)
                    .font(.caption)
                    .foregroundColor(secondaryColor)
            }
            
            // 내용
            Text(board.content)
                .font(.body)
                .foregroundColor(textColor)
                .lineSpacing(6)
                .padding(.vertical, 10)
            
            // 조회수, 좋아요, 댓글수
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "eye")
                        .font(.system(size: 14))
                    Text("\(board.viewCount)")
                        .font(.subheadline)
                }
                .foregroundColor(secondaryColor)
                
                Button {
                    Task {
                        await viewModel.toggleLike(boardId: board.id, userEmail: userEmail)
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "heart")
                            .font(.system(size: 14))
                        Text("\(board.likeCount)")
                            .font(.subheadline)
                    }
                    .foregroundColor(secondaryColor)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "bubble.left")
                        .font(.system(size: 14))
                    Text("\(commentViewModel.comments.count)")
                        .font(.subheadline)
                }
                .foregroundColor(secondaryColor)
                
                Spacer()
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func commentSection() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("댓글 \(commentViewModel.comments.count)")
                .font(.headline)
                .foregroundColor(textColor)
                .padding(.horizontal, 16)
            
            if commentViewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                        .tint(primaryColor)
                    Spacer()
                }
                .padding(.vertical, 20)
            } else if commentViewModel.comments.isEmpty {
                VStack(spacing: 10) {
                    Text("아직 댓글이 없습니다")
                        .font(.subheadline)
                        .foregroundColor(secondaryColor)
                        .padding(.top, 20)
                    
                    Text("첫 댓글을 남겨보세요")
                        .font(.caption)
                        .foregroundColor(secondaryColor)
                        .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity)
            } else {
                // 댓글 목록
                ForEach(commentViewModel.comments) { comment in
                    if editingCommentId == comment.id {
                        // 댓글 수정 UI
                        VStack(spacing: 8) {
                            TextField("댓글을 수정하세요", text: $editingCommentText)
                                .padding(10)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(textColor)
                            
                            HStack {
                                Spacer()
                                
                                Button {
                                    editingCommentId = nil
                                    editingCommentText = ""
                                } label: {
                                    Text("취소")
                                        .font(.subheadline)
                                        .foregroundColor(secondaryColor)
                                }
                                .padding(.horizontal, 8)
                                
                                Button {
                                    if !editingCommentText.isEmpty {
                                        Task {
                                            let success = await commentViewModel.updateComment(
                                                commentId: comment.id,
                                                content: editingCommentText,
                                                nickname: comment.author,
                                                email: comment.email
                                            )
                                            if success {
                                                editingCommentId = nil
                                                editingCommentText = ""
                                            }
                                        }
                                    }
                                } label: {
                                    Text("완료")
                                        .font(.subheadline)
                                        .foregroundColor(primaryColor)
                                        .fontWeight(.medium)
                                }
                                .disabled(editingCommentText.isEmpty)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    } else {
                        CommentRow(
                            comment: comment,
                            isCurrentUser: comment.email == userEmail,
                            onAction: {
                                selectedCommentId = comment.id
                                showCommentActionSheet = true
                            }
                        )
                    }
                    
                    Divider()
                        .background(Color.gray.opacity(0.2))
                }
            }
        }
    }
    
    private func commentInputBar() -> some View {
        HStack(spacing: 10) {
            TextField("댓글을 입력하세요", text: $commentViewModel.commentText)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .foregroundColor(textColor)
                .disabled(commentViewModel.isSubmitting)
            
            Button {
                // 댓글 추가
                Task {
                    await commentViewModel.addComment(
                        email: userEmail,
                        nickname: "현재사용자" // 실제로는 UserDefaults나 AuthManager에서 가져와야 함
                    )
                }
            } label: {
                if commentViewModel.isSubmitting {
                    ProgressView()
                        .tint(primaryColor)
                        .frame(width: 20, height: 20)
                } else {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 18))
                        .foregroundColor(commentViewModel.commentText.isEmpty ? secondaryColor : primaryColor)
                }
            }
            .disabled(commentViewModel.commentText.isEmpty || commentViewModel.isSubmitting)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(backgroundColor)
        .animation(.default, value: commentViewModel.commentText)
    }
    
    private func loadBoardDetail() async {
        // API를 통해 게시글 상세 정보 로드
        await viewModel.fetchBoardDetail(id: boardId)
        
        // 댓글 정보 로드
        await commentViewModel.fetchComments()
    }
}

struct CommentRow: View {
    let comment: Comment
    let isCurrentUser: Bool
    let onAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 작성자 정보
            HStack {
                Text(comment.author)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                if isCurrentUser {
                    Text("(내 댓글)")
                        .font(.caption)
                        .foregroundColor(CHColors.primaryColor)
                }
                
                Spacer()
                
                Text(comment.createdAt)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if isCurrentUser {
                    Button(action: onAction) {
                        Image(systemName: "ellipsis")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            // 내용
            Text(comment.content)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .padding(.vertical, 4)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}
