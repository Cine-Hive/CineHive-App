//
//  CommunityTabView.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import SwiftUI

struct CommunityTabView: View {
    @State private var viewModel = BoardViewModel()
    @State private var isRefreshing = false
    @State private var isSearchActive = false
    @State private var showWritePostSheet = false
    @State private var userEmail = "user@example.com" // 실제 앱에서는 UserDefaults나 AuthManager에서 가져옴
    
    private let primaryColor = CHColors.primaryColor
    private let textColor = CHColors.textColor
    private let secondaryColor = CHColors.secondaryColor
    
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
                        
                        if viewModel.isLoading {
                            loadingView()
                        } else if let error = viewModel.error {
                            errorView(message: error)
                        } else if viewModel.boards.isEmpty {
                            emptyBoardsView()
                        } else {
                            boardListView()
                        }
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
        .foregroundColor(textColor)
        .navigationBarHidden(true)
        .overlay(
            isSearchActive ? searchOverlay() : nil
        )
        .sheet(isPresented: $showWritePostSheet) {
            WritePostView(
                onSubmit: { title, content in
                    Task {
                        let success = await viewModel.createBoard(
                            title: title,
                            content: content,
                            email: userEmail
                        )
                        
                        if success {
                            showWritePostSheet = false
                        }
                    }
                }
            )
        }
        .onAppear {
            if viewModel.boards.isEmpty {
                Task {
                    await viewModel.fetchBoards()
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
                            viewModel.selectedCategory = category
                        }
                        
                        Task {
                            await viewModel.changeCategory(to: category)
                        }
                    } label: {
                        Text(category.rawValue)
                            .font(.system(size: 14))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(viewModel.selectedCategory == category ? primaryColor : Color.gray.opacity(0.2))
                            .foregroundColor(viewModel.selectedCategory == category ? .white : .gray)
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
            ForEach(viewModel.boards) { board in
                NavigationLink(destination: BoardDetailView(boardId: board.id, viewModel: viewModel)) {
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
                    await viewModel.fetchBoards()
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
                
                TextField("게시글 검색", text: $viewModel.searchText)
                    .foregroundColor(textColor)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onSubmit {
                        Task {
                            await viewModel.searchBoards(keyword: viewModel.searchText)
                        }
                    }
                
                if !viewModel.searchText.isEmpty {
                    Button {
                        viewModel.searchText = ""
                        viewModel.searchResults = []
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(secondaryColor)
                    }
                }
                
                Button {
                    withAnimation(.spring(response: 0.3)) {
                        isSearchActive = false
                        viewModel.clearSearch()
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
                if viewModel.searchText.isEmpty {
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
                } else if viewModel.isLoading {
                    ProgressView()
                        .tint(primaryColor)
                        .scaleEffect(1.5)
                        .padding()
                } else if !viewModel.searchResults.isEmpty {
                    // 검색 결과
                    VStack(spacing: 0) {
                        Text("'\(viewModel.searchText)'에 대한 검색 결과")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        ForEach(viewModel.searchResults) { board in
                            NavigationLink(destination: BoardDetailView(boardId: board.id, viewModel: viewModel)) {
                                BoardRow(board: board)
                            }
                            
                            Divider()
                                .background(Color.gray.opacity(0.3))
                        }
                    }
                } else if viewModel.isSearching {
                    VStack(spacing: 15) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 40))
                            .foregroundColor(secondaryColor)
                            .padding()
                        
                        Text("검색 결과가 없습니다")
                            .font(.headline)
                            .foregroundColor(textColor)
                        
                        Text("다른 검색어로 시도해보세요")
                            .font(.subheadline)
                            .foregroundColor(secondaryColor)
                    }
                    .padding()
                } else if viewModel.searchText.count > 1 {
                    Text("검색 중...")
                        .foregroundColor(secondaryColor)
                        .padding()
                        .onAppear {
                            Task {
                                await viewModel.searchBoards(keyword: viewModel.searchText)
                            }
                        }
                } else {
                    Text("검색어를 더 입력해주세요")
                        .foregroundColor(secondaryColor)
                        .padding()
                }
            }
            .background(CHColors.backgroundColor)
        }
        .background(CHColors.backgroundColor.edgesIgnoringSafeArea(.all))
    }
    
    private func refreshBoards() async {
        isRefreshing = true
        await viewModel.fetchBoards()
        isRefreshing = false
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
