//
//  CommunityTabView.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import SwiftUI

struct CommunityTabView: View {
    @State private var selectedCategory: BoardCategory = .all
    @State private var searchText = ""
    @State private var isSearchActive = false
    @State private var isRefreshing = false
    @State private var showWritePostSheet = false
    @State private var boards: [Board] = []
    @State private var isLoading = false
    @State private var errorMessage: String? = nil
    
    private let primaryColor = Color.red
    private let textColor = Color.white
    private let secondaryColor = Color.gray
    
    // 게시판 카테고리
    enum BoardCategory: String, CaseIterable {
        case all = "전체"
        case free = "자유"
        case review = "리뷰"
        case question = "질문"
        case info = "정보"
    }
    
    var body: some View {
        ZStack {
            CHColors.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 헤더
                communityHeader()
                
                // 카테고리 선택기
                categorySelector()
                
                // 게시글 목록
                ScrollView {
                    VStack(spacing: 0) {
                        // 새로고침 인디케이터
                        CustomRefreshView(isRefreshing: isRefreshing)
                        
                        if isLoading {
                            loadingView()
                        } else if let error = errorMessage {
                            errorView(message: error)
                        } else if boards.isEmpty {
                            emptyBoardsView()
                        } else {
                            boardListView()
                        }
                        
                        Spacer(minLength: 80)
                    }
                }
                .refreshable {
                    await refreshBoards()
                }
            }
            
            // 글쓰기 버튼
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        showWritePostSheet = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(primaryColor)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        .foregroundColor(textColor)
        .navigationBarHidden(true)
        .overlay(
            isSearchActive ? searchOverlay() : nil
        )
        .sheet(isPresented: $showWritePostSheet) {
            WritePostView()
        }
        .onAppear {
            if boards.isEmpty {
                Task {
                    await loadBoards()
                }
            }
        }
    }
    
    // MARK: - UI Components
    
    private func communityHeader() -> some View {
        HStack(spacing: 15) {
            // 제목
            Text("커뮤니티")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(textColor)
            
            Spacer()
            
            // 검색 버튼
            Button {
                withAnimation(.spring(response: 0.3)) {
                    isSearchActive = true
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(textColor)
                    .font(.system(size: 18))
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
    
    private func categorySelector() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(BoardCategory.allCases, id: \.self) { category in
                    Button {
                        withAnimation {
                            selectedCategory = category
                        }
                        
                        Task {
                            await loadBoards(category: category)
                        }
                    } label: {
                        Text(category.rawValue)
                            .font(.system(size: 14))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selectedCategory == category ? primaryColor : Color.gray.opacity(0.2))
                            .foregroundColor(selectedCategory == category ? .white : .gray)
                            .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
    }
    
    private func boardListView() -> some View {
        VStack(spacing: 0) {
            ForEach(boards) { board in
                NavigationLink(destination: BoardDetailView(boardId: board.id)) {
                    BoardRow(board: board)
                }
                
                Divider()
                    .background(Color.gray.opacity(0.3))
            }
        }
    }
    
    private func loadingView() -> some View {
        VStack(spacing: 20) {
            ProgressView()
                .tint(primaryColor)
                .scaleEffect(1.5)
            
            Text("게시판을 불러오는 중...")
                .font(.caption)
                .foregroundColor(secondaryColor)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding()
    }
    
    private func errorView(message: String) -> some View {
        VStack(spacing: 15) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
                .foregroundColor(primaryColor)
                .padding()
            
            Text("오류가 발생했습니다")
                .font(.headline)
                .foregroundColor(textColor)
            
            Text(message)
                .font(.caption)
                .foregroundColor(secondaryColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button {
                Task {
                    await loadBoards()
                }
            } label: {
                Text("다시 시도")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(primaryColor)
                    .cornerRadius(8)
                    .padding(.top, 10)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding()
    }
    
    private func emptyBoardsView() -> some View {
        VStack(spacing: 15) {
            Image(systemName: "bubble.left.and.bubble.right")
                .font(.system(size: 40))
                .foregroundColor(primaryColor)
                .padding()
            
            Text("아직 게시글이 없습니다")
                .font(.headline)
                .foregroundColor(textColor)
            
            Text("첫 게시글을 작성해보세요!")
                .font(.subheadline)
                .foregroundColor(secondaryColor)
                .padding(.bottom, 10)
            
            Button {
                showWritePostSheet = true
            } label: {
                Text("글쓰기")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(primaryColor)
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 300)
        .padding()
    }
    
    private func searchOverlay() -> some View {
        VStack(spacing: 0) {
            // 검색 헤더
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(secondaryColor)
                
                TextField("게시글 검색", text: $searchText)
                    .foregroundColor(textColor)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(secondaryColor)
                    }
                }
                
                Button {
                    withAnimation(.spring(response: 0.3)) {
                        isSearchActive = false
                        searchText = ""
                    }
                } label: {
                    Text("취소")
                        .foregroundColor(primaryColor)
                }
            }
            .padding()
            .background(Color(hex: "#1A1A1A"))
            
            // 검색 결과
            ScrollView {
                if searchText.isEmpty {
                    // 인기 검색어 또는 팁
                    VStack(alignment: .leading, spacing: 15) {
                        Text("이렇게 검색해보세요!")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        ForEach(["인기 영화 후기", "저렴한 영화관 추천", "OTT 구독 꿀팁", "신작 평가"], id: \.self) { tip in
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 14))
                                    .foregroundColor(secondaryColor)
                                
                                Text(tip)
                                    .font(.system(size: 16))
                                    .foregroundColor(textColor)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        }
                    }
                } else {
                    // 검색 결과
                    if searchText.count > 1 {
                        VStack(spacing: 0) {
                            Text("'\(searchText)'에 대한 검색 결과")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                            
                            // 여기서 실제 검색 결과 표시
                            Text("검색 중...")
                                .foregroundColor(secondaryColor)
                                .padding()
                                .onAppear {
                                    // 실제 게시판 검색 API 호출 구현
                                    Task {
                                        await searchBoards(query: searchText)
                                    }
                                }
                        }
                    } else {
                        Text("검색어를 더 입력해주세요")
                            .foregroundColor(secondaryColor)
                            .padding()
                    }
                }
            }
            .background(CHColors.backgroundColor)
        }
        .background(CHColors.backgroundColor.edgesIgnoringSafeArea(.all))
    }
    
    private func loadBoards(category: BoardCategory = .all) async {
        isLoading = true
        errorMessage = nil
        
        do {
            // 서버 API 호출
            // 실제 구현 시 BoardService 등을 통해 호출
            // 현재는 임시 데이터 사용
            try await Task.sleep(nanoseconds: 500_000_000) // 1초 대기
            
            // 임시 데이터
            boards = createDummyBoards(category: category)
            
            isLoading = false
        } catch {
            errorMessage = "게시판을 불러오는 데 실패했습니다: \(error.localizedDescription)"
            isLoading = false
        }
    }
    
    private func refreshBoards() async {
        isRefreshing = true
        await loadBoards(category: selectedCategory)
        isRefreshing = false
    }
    
    private func searchBoards(query: String) async {
        // 실제 게시판 검색 API 구현
        // 현재는 비어있음
    }
    
    // 임시 데이터 생성 함수
    private func createDummyBoards(category: BoardCategory) -> [Board] {
        let categories = ["자유", "리뷰", "질문", "정보"]
        let titles = [
            "오늘 본 영화 후기입니다",
            "넷플릭스 신작 어떤가요?",
            "이번 주말 영화 추천 부탁드려요",
            "OTT 비교 후기",
            "영화관 할인 정보 공유",
            "이 영화 봤는데 결말이 이해가 안돼요",
            "올해 최고의 영화는?",
            "디즈니플러스 구독 꿀팁",
            "독립영화 추천 부탁드립니다",
            "왓챠 vs 넷플릭스"
        ]
        
        let result = (1...20).map { i -> Board in
            let categoryStr = categories[i % categories.count]
            
            // 카테고리 필터링
            if category != .all && categoryStr != category.rawValue {
                return Board(id: i, empty: true)
            }
            
            return Board(
                id: i,
                title: titles[i % titles.count],
                content: "게시글 내용입니다. 여기에는 본문 내용이 들어갑니다.",
                author: "사용자\(i)",
                category: categoryStr,
                createdAt: "\(Int.random(in: 1...24))시간 전",
                viewCount: Int.random(in: 10...200),
                likeCount: Int.random(in: 0...50),
                commentCount: Int.random(in: 0...20)
            )
        }.filter { !$0.empty }
        
        return result
    }
}

// 게시글 행 컴포넌트
struct BoardRow: View {
    let board: Board
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 카테고리 및 작성자 정보
            HStack {
                Text(board.category)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(hex: "#FF2F6E").opacity(0.2))
                    .foregroundColor(Color(hex: "#FF2F6E"))
                    .cornerRadius(4)
                
                Spacer()
                
                Text(board.author)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("•")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(board.createdAt)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            // 제목
            Text(board.title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .lineLimit(1)
            
            // 조회수, 좋아요, 댓글수
            HStack(spacing: 12) {
                HStack(spacing: 4) {
                    Image(systemName: "eye")
                        .font(.system(size: 12))
                    Text("\(board.viewCount)")
                        .font(.caption)
                }
                .foregroundColor(.gray)
                
                HStack(spacing: 4) {
                    Image(systemName: "heart")
                        .font(.system(size: 12))
                    Text("\(board.likeCount)")
                        .font(.caption)
                }
                .foregroundColor(.gray)
                
                HStack(spacing: 4) {
                    Image(systemName: "bubble.left")
                        .font(.system(size: 12))
                    Text("\(board.commentCount)")
                        .font(.caption)
                }
                .foregroundColor(.gray)
                
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.black)
        .contentShape(Rectangle()) // 전체 영역 탭 가능하도록
    }
}

// 게시글 상세 페이지
struct BoardDetailView: View {
    let boardId: Int
    @State private var board: Board?
    @State private var isLoading = true
    @State private var comments: [Comment] = []
    @State private var commentText = ""
    
    // 테마 색상
    private let backgroundColor = Color.black
    private let primaryColor = Color.red
    private let textColor = Color.white
    private let secondaryColor = Color.gray
    
    @Environment(\.dismiss) private var dismiss
    
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
                    
                    Button {
                        // 공유 기능
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 18))
                            .foregroundColor(textColor)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                if isLoading {
                    loadingView()
                } else if let board = board {
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
            Text("이것은 게시글의 상세 내용입니다. 사용자가 작성한 글의 전체 내용이 이곳에 표시됩니다. 다양한 영화와 OTT 서비스에 대한 이야기, 추천, 리뷰 등이 담겨있을 수 있습니다.\n\n특히 영화 관련 커뮤니티로서 사용자들의 다양한 의견을 볼 수 있습니다. CineHive 앱을 통해 다양한 영화 정보를 공유하고 소통해보세요!")
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
                    // 좋아요 기능
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
                    Text("\(board.commentCount)")
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
            Text("댓글 \(comments.count)")
                .font(.headline)
                .foregroundColor(textColor)
                .padding(.horizontal, 16)
            
            if comments.isEmpty {
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
                ForEach(comments) { comment in
                    CommentRow(comment: comment)
                    
                    Divider()
                        .background(Color.gray.opacity(0.2))
                }
            }
        }
    }
    
    private func commentInputBar() -> some View {
        HStack(spacing: 10) {
            TextField("댓글을 입력하세요", text: $commentText)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .foregroundColor(textColor)
            
            Button {
                // 댓글 추가
                addComment()
            } label: {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 18))
                    .foregroundColor(commentText.isEmpty ? secondaryColor : primaryColor)
            }
            .disabled(commentText.isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(backgroundColor)
        .animation(.default, value: commentText)
    }
    
    private func loadBoardDetail() async {
        isLoading = true
        
        // 임시 데이터 - 서버 API 연동 시 실제 호출로 변경
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        board = Board(
            id: boardId,
            title: "게시글 제목 #\(boardId)",
            content: "게시글 내용입니다. 여기에는 본문 내용이 들어갑니다.",
            author: "사용자\(boardId)",
            category: ["자유", "리뷰", "질문", "정보"][boardId % 4],
            createdAt: "\(Int.random(in: 1...24))시간 전",
            viewCount: Int.random(in: 10...200),
            likeCount: Int.random(in: 0...50),
            commentCount: Int.random(in: 0...20)
        )
        
        // 댓글 임시 데이터
        let randomCommentCount = Int.random(in: 0...10)
        comments = (1...randomCommentCount).map { i in
            Comment(
                id: i,
                author: "댓글작성자\(i)",
                content: "이 글에 대한 댓글입니다. 댓글 내용은 여기에 표시됩니다.",
                createdAt: "\(Int.random(in: 1...60))분 전",
                likeCount: Int.random(in: 0...15)
            )
        }
        
        isLoading = false
    }
    
    private func addComment() {
        guard !commentText.isEmpty else { return }
        
        // 새 댓글 추가 (실제로는 API 호출)
        let newComment = Comment(
            id: comments.count + 1,
            author: "현재사용자",
            content: commentText,
            createdAt: "방금 전",
            likeCount: 0
        )
        
        comments.append(newComment)
        commentText = ""
    }
}

// 댓글 행 컴포넌트
struct CommentRow: View {
    let comment: Comment
    @State private var isLiked = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 작성자 정보
            HStack {
                Text(comment.author)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(comment.createdAt)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            // 내용
            Text(comment.content)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .padding(.vertical, 4)
            
            // 좋아요 버튼
            Button {
                isLiked.toggle()
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 12))
                        .foregroundColor(isLiked ? Color(hex: "#FF2F6E") : .gray)
                    
                    Text("\(comment.likeCount + (isLiked ? 1 : 0))")
                        .font(.caption)
                        .foregroundColor(isLiked ? Color(hex: "#FF2F6E") : .gray)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}
