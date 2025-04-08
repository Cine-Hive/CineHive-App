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
    @State private var userEmail = "unib335@naver.com"
    
    private let primaryColor = CHColors.primaryColor
    private let textColor = CHColors.textColor
    private let secondaryColor = CHColors.secondaryColor
    
    var body: some View {
        ZStack {
            CHColors.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                communityHeader()
                categorySelector()
                boardScrollView()
            }
            .refreshable { await refreshBoards() }
            
            writePostButton()
                .padding(.bottom, 40)
        }
        .onAppear {
            if viewModel.boards.isEmpty {
                Task { await viewModel.fetchBoards() }
            }
        }
        .navigationBarHidden(true)
        .overlay(isSearchActive ? searchOverlay() : nil)
        .sheet(isPresented: $showWritePostSheet) {
            WritePostView { title, content in
                Task {
                    let success = await viewModel.createBoard(title: title, content: content, email: userEmail)
                    if success { showWritePostSheet = false }
                }
            }
        }
    }
    
    // MARK: - UI Components
    
    private func communityHeader() -> some View {
        HStack(spacing: 15) {
            Text("커뮤니티")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(textColor)
            
            Spacer()
            
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
                        withAnimation { viewModel.selectedCategory = category }
                        Task { await viewModel.changeCategory(to: category) }
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
    
    private func boardScrollView() -> some View {
        ScrollView {
            VStack(spacing: 0) {
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
    
    private func writePostButton() -> some View {
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
    }
    
    private func boardListView() -> some View {
        VStack(spacing: 0) {
            ForEach(viewModel.boards.filter {
                viewModel.selectedCategory == .all || $0.localCategory == viewModel.selectedCategory.rawValue
            }) { board in
                NavigationLink(destination: PreparingView(type: "게시글 상세",actionTitle: "게시글 목록", action: {})) {
                    BoardRow(board: board)
                }
                Divider().background(Color.gray.opacity(0.3))
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
                Task { await viewModel.fetchBoards() }
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
        CommunitySearchOverlay(
            viewModel: viewModel,
            isSearchActive: $isSearchActive,
            primaryColor: primaryColor,
            textColor: textColor,
            secondaryColor: secondaryColor
        )
    }
    
    private func refreshBoards() async {
        isRefreshing = true
        await viewModel.fetchBoards()
        isRefreshing = false
    }
}

struct BoardRow: View {
    let board: Board
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(board.localCategory)
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
            Text(board.title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .lineLimit(1)
            HStack(spacing: 12) {
                Label("\(board.viewCount)", systemImage: "eye")
                Label("\(board.likeCount)", systemImage: "heart")
                Label("\(board.commentCount)", systemImage: "bubble.left")
                Spacer()
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.black)
        .contentShape(Rectangle())
    }
}


struct CommunitySearchOverlay: View {
    @Bindable var viewModel: BoardViewModel
    @Binding var isSearchActive: Bool
    
    let primaryColor: Color
    let textColor: Color
    let secondaryColor: Color
    
    var body: some View {
        VStack(spacing: 0) {
            searchHeader
            searchResults
        }
        .background(CHColors.backgroundColor.ignoresSafeArea())
    }
    
    private var searchHeader: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(secondaryColor)
            
            TextField("게시글 검색", text: $viewModel.searchText)
                .foregroundColor(textColor)
                .submitLabel(.search)
                .onSubmit(of: .text) {
                    Task { await viewModel.searchBoards(keyword: viewModel.searchText) }
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
            
            Button("취소") {
                withAnimation(.spring(response: 0.3)) {
                    isSearchActive = false
                    viewModel.clearSearch()
                }
            }
            .foregroundStyle(primaryColor)
        }
        .padding()
        .background(Color(hex: "#1A1A1A"))
    }
    
    private var searchResults: some View {
        ScrollView {
            if viewModel.searchText.isEmpty {
                searchTips
            } else if viewModel.isLoading {
                ProgressView()
                    .tint(primaryColor)
                    .scaleEffect(1.5)
                    .padding()
            } else if !viewModel.searchResults.isEmpty {
                resultsList
            } else if viewModel.isSearching {
                noResultsView
            } else if viewModel.searchText.count > 1 {
                Text("검색 중...")
                    .foregroundStyle(secondaryColor)
                    .padding()
                    .task {
                        await viewModel.searchBoards(keyword: viewModel.searchText)
                    }
            } else {
                Text("검색어를 더 입력해주세요")
                    .foregroundStyle(secondaryColor)
                    .padding()
            }
        }
    }
    
    private var searchTips: some View {
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
                        .foregroundStyle(textColor)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
        }
    }
    
    private var resultsList: some View {
        VStack(spacing: 0) {
            Text("'\(viewModel.searchText)'에 대한 검색 결과")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ForEach(viewModel.searchResults) { board in
                NavigationLink(value: board.id) {
                    BoardRow(board: board)
                }
                Divider().background(Color.gray.opacity(0.3))
            }
        }
    }
    
    private var noResultsView: some View {
        VStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundColor(secondaryColor)
                .padding()
            
            Text("검색 결과가 없습니다")
                .font(.headline)
                .foregroundStyle(textColor)
            
            Text("다른 검색어로 시도해보세요")
                .font(.subheadline)
                .foregroundStyle(secondaryColor)
        }
        .padding()
    }
}
