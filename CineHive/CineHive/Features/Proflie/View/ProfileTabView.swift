//
//  ProfileTabView.swift
//  CineHive
//
//  Created by 이종민 on 3/18/25.
//

import SwiftUI

struct ProfileTabView: View {
    @State private var viewModel = ProfileViewModel()
    @State private var showLoginView = false
    @State private var selectedSection: ProfileSection = .activities
    @State private var selectedActivityTab: ActivityTab = .boards
    @State private var selectedSettingCategory: SettingCategory = .account
    
    // 모달 상태
    @State private var showProfileEditView = false
    @State private var showPasswordChangeView = false
    @State private var showTermsView = false
    @State private var showPrivacyView = false
    @State private var showAboutView = false
    @State private var showDeleteAccountConfirm = false
    @State private var showLanguageSelection = false
    
    // 색상 테마
    private let backgroundColor = CHColors.backgroundColor
    private let primaryColor = CHColors.primaryColor
    private let textColor = CHColors.textColor
    private let secondaryColor = CHColors.secondaryColor
    
    // 섹션 정의
    enum ProfileSection: String, CaseIterable, Identifiable {
        case activities = "내 활동"
        case favorites = "찜 목록"
        case settings = "설정"
        
        var id: String { self.rawValue }
        
        var icon: String {
            switch self {
            case .activities: return "person.text.rectangle.fill"
            case .favorites: return "heart.fill"
            case .settings: return "gearshape.fill"
            }
        }
    }
    
    // 활동 탭 정의
    enum ActivityTab: String, CaseIterable, Identifiable {
        case boards = "게시글"
        case comments = "댓글"
        case likes = "좋아요"
        case bookmarks = "북마크"
        
        var id: String { self.rawValue }
        
        var icon: String {
            switch self {
            case .boards: return "doc.text.fill"
            case .comments: return "bubble.left.fill"
            case .likes: return "heart.fill"
            case .bookmarks: return "bookmark.fill"
            }
        }
    }
    
    // 설정 카테고리 정의
    enum SettingCategory: String, CaseIterable, Identifiable {
        case account = "계정 설정"
        case app = "앱 설정"
        case info = "정보"
        
        var id: String { self.rawValue }
    }
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                if viewModel.isLoggedIn {
                    userProfileContent()
                } else {
                    loginPrompt()
                }
            }
            
            // 에러 토스트
            VStack {
                if let error = viewModel.error, viewModel.showErrorToast {
                    Spacer()
                    ErrorToastView(message: error) {
                        viewModel.clearError()
                    }
                    .transition(.move(edge: .bottom))
                    .zIndex(100)
                }
            }
            .animation(.easeInOut, value: viewModel.showErrorToast)
        }
        .sheet(isPresented: $showLoginView, onDismiss: {
            // 로그인 화면이 닫힐 때 로그인 상태 확인
            viewModel.checkLoginStatus()
            
            // 로그인 상태라면 데이터 로드
            if viewModel.isLoggedIn {
                Task {
                    await loadActivityData()
                }
            }
        }) {
            LoginView()
        }
        .sheet(isPresented: $showProfileEditView) {
            ProfileEditView(viewModel: viewModel)
        }
        .sheet(isPresented: $showPasswordChangeView) {
            PasswordChangeView()
        }
        .sheet(isPresented: $showTermsView) {
            TermsView()
        }
        .sheet(isPresented: $showPrivacyView) {
            PrivacyPolicyView()
        }
        .sheet(isPresented: $showAboutView) {
            AboutAppView()
        }
        .alert("회원 탈퇴", isPresented: $showDeleteAccountConfirm) {
            Button("취소", role: .cancel) { }
            Button("탈퇴하기", role: .destructive) {
                Task {
                    _ = await viewModel.deleteAccount()
                }
            }
        } message: {
            Text("모든 데이터가 삭제되며 복구할 수 없습니다. 정말 탈퇴하시겠습니까?")
        }
        .alert("언어 설정", isPresented: $showLanguageSelection) {
            ForEach(Language.allCases) { language in
                Button(language.displayName) {
                    viewModel.setLanguage(language)
                }
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("선호하는 언어를 선택하세요")
        }
        .onAppear {
            viewModel.checkLoginStatus()
            if viewModel.isLoggedIn {
                Task {
                    await loadInitialData()
                }
            }
        }
    }
    
    // MARK: - 데이터 로드
    
    private func loadInitialData() async {
        switch selectedSection {
        case .activities:
            await loadActivityData()
        case .favorites:
            await loadFavoritesData()
        case .settings:
            break // 설정은 데이터 로드가 필요 없음
        }
    }
    
    private func loadActivityData() async {
        switch selectedActivityTab {
        case .boards:
            await viewModel.loadUserBoards()
        case .comments:
            await viewModel.loadUserComments()
        case .likes:
            await viewModel.loadUserLikedPosts()
        case .bookmarks:
            //await viewModel.loadUserBookmarks()
            print("bookmark")
        }
    }
    
    private func loadFavoritesData() async {
        //await viewModel.loadUserFavoriteMovies()
    }
    
    // MARK: - UI Components
    
    private func loginPrompt() -> some View {
        VStack(spacing: 25) {
            Spacer()
            
            Image(systemName: "person.crop.circle.badge.exclamationmark")
                .font(.system(size: 70))
                .foregroundColor(primaryColor)
                .padding()
            
            Text("로그인이 필요합니다")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(textColor)
            
            Text("게시글 작성, 댓글, 좋아요 등의\n기능을 이용하려면 로그인이 필요합니다.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(secondaryColor)
            
            Button {
                showLoginView = true
            } label: {
                Text("로그인하기")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(primaryColor)
                    .cornerRadius(10)
                    .padding(.top, 20)
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func userProfileContent() -> some View {
        VStack(spacing: 0) {
            // 프로필 헤더
            profileHeader()
            
            // 상단 탭 (섹션 선택)
            sectionTabSelector()
            
            // 선택된 섹션 콘텐츠
            ScrollView {
                switch selectedSection {
                case .activities:
                    activitiesSection()
                case .favorites:
                    favoritesSection()
                case .settings:
                    settingsSection()
                }
                
                Spacer(minLength: 50)
            }
            .refreshable {
                await loadInitialData()
            }
        }
        .navigationBarHidden(true)
        .animation(.easeInOut(duration: 0.2), value: selectedSection)
    }
    
    private func profileHeader() -> some View {
        VStack(spacing: 15) {
            // 프로필 정보
            HStack(spacing: 15) {
                // 프로필 이미지
                Circle()
                    .fill(primaryColor.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Text(String(viewModel.userInfo.nickname.prefix(1)))
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(primaryColor)
                    )
                
                // 사용자 정보
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.userInfo.nickname)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(textColor)
                    
                    Text(viewModel.userInfo.email)
                        .font(.subheadline)
                        .foregroundColor(secondaryColor)
                }
                
                Spacer()
                
                // 로그아웃 버튼
                Button {
                    // 로그아웃 기능
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.system(size: 14))
                        Text("로그아웃")
                            .font(.caption)
                    }
                    .foregroundColor(secondaryColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            // 활동 통계
            HStack(spacing: 0) {
                ActivityStatCard(
                    count: viewModel.userBoardsCount,
                    title: "게시글",
                    icon: "doc.text.fill"
                )
                .onTapGesture {
                    selectedSection = .activities
                    selectedActivityTab = .boards
                    Task {
                        await viewModel.loadUserBoards()
                    }
                }
                
                ActivityStatCard(
                    count: viewModel.userCommentsCount,
                    title: "댓글",
                    icon: "bubble.left.fill",
                    color: .blue
                )
                .onTapGesture {
                    selectedSection = .activities
                    selectedActivityTab = .comments
                    Task {
                        await viewModel.loadUserComments()
                    }
                }
                
                ActivityStatCard(
                    count: viewModel.userLikesCount,
                    title: "좋아요",
                    icon: "heart.fill",
                    color: .red
                )
                .onTapGesture {
                    selectedSection = .activities
                    selectedActivityTab = .likes
                    Task {
                        await viewModel.loadUserLikedPosts()
                    }
                }
                
                ActivityStatCard(
                    count: viewModel.userBookmarksCount,
                    title: "북마크",
                    icon: "bookmark.fill",
                    color: .orange
                )
                .onTapGesture {
                    selectedSection = .activities
                    selectedActivityTab = .bookmarks
                    Task {
                        await viewModel.loadUserBookmarks()
                    }
                }
            }
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(8)
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
    }
    
    private func sectionTabSelector() -> some View {
        HStack(spacing: 0) {
            ForEach(ProfileSection.allCases) { section in
                Button {
                    withAnimation {
                        selectedSection = section
                        Task {
                            await loadInitialData()
                        }
                    }
                } label: {
                    VStack(spacing: 6) {
                        Image(systemName: section.icon)
                            .font(.system(size: 16))
                        
                        Text(section.rawValue)
                            .font(.system(size: 12))
                    }
                    .foregroundColor(selectedSection == section ? primaryColor : secondaryColor)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        selectedSection == section ?
                        RoundedRectangle(cornerRadius: 4)
                            .fill(primaryColor.opacity(0.1))
                            .padding(.horizontal, 10) :
                            nil
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.vertical, 6)
        .background(Color.gray.opacity(0.05))
    }
    
    // MARK: - 내 활동 섹션
    
    private func activitiesSection() -> some View {
        VStack(spacing: 0) {
            // 활동 탭 선택
            activityTabSelector()
            
            // 선택된 활동 탭 콘텐츠
            switch selectedActivityTab {
            case .boards:
                boardsContent()
            case .comments:
                commentsContent()
            case .likes:
                likedPostsContent()
            case .bookmarks:
                bookmarksContent()
            }
        }
        .animation(.easeInOut(duration: 0.2), value: selectedActivityTab)
    }
    
    private func activityTabSelector() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(ActivityTab.allCases) { tab in
                    Button {
                        withAnimation {
                            selectedActivityTab = tab
                            Task {
                                await loadActivityData()
                            }
                        }
                    } label: {
                        VStack(spacing: 8) {
                            HStack(spacing: 4) {
                                Image(systemName: tab.icon)
                                    .font(.system(size: 12))
                                
                                Text(tab.rawValue)
                                    .font(.system(size: 14, weight: selectedActivityTab == tab ? .bold : .regular))
                            }
                            .foregroundColor(selectedActivityTab == tab ? primaryColor : secondaryColor)
                            
                            Rectangle()
                                .fill(selectedActivityTab == tab ? primaryColor : Color.clear)
                                .frame(height: 2)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .padding(.bottom, 5)
        }
    }
    
    private func boardsContent() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            if viewModel.isLoadingBoards {
                loadingBoardsView()
            } else if viewModel.userBoards.isEmpty {
                EmptyStateView(
                    icon: "doc.text",
                    title: "아직 작성한 게시글이 없어요",
                    message: "커뮤니티에서 다양한 주제로 게시글을 작성해보세요.",
                    buttonTitle: "게시글 작성하기",
                    action: {
                        // 게시글 작성 화면으로 이동
                    }
                )
            } else {
                ForEach(viewModel.userBoards) { board in
                    ProfileBoardItemView(board: board) { selectedBoard in
                        // 선택한 게시글로 이동
                    }
                    
                    Divider()
                        .background(CHColors.divider)
                        .padding(.horizontal, 20)
                }
            }
        }
    }
    
    private func commentsContent() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            if viewModel.isLoadingComments {
                loadingCommentsView()
            } else if viewModel.userComments.isEmpty {
                EmptyStateView(
                    icon: "bubble.left",
                    title: "아직 작성한 댓글이 없어요",
                    message: "다른 사용자의 게시글에 의견을 남겨보세요.",
                    buttonTitle: "커뮤니티 둘러보기",
                    action: {
                        // 커뮤니티 화면으로 이동
                    }
                )
            } else {
                ForEach(viewModel.userComments) { comment in
                    ProfileCommentItemView(comment: comment) { selectedComment in
                        // 선택한 댓글이 있는 게시글로 이동
                    }
                    
                    Divider()
                        .background(CHColors.divider)
                        .padding(.horizontal, 20)
                }
            }
        }
    }
    
    private func likedPostsContent() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            if viewModel.isLoadingLikedPosts {
                loadingBoardsView()
            } else if viewModel.userLikedPosts.isEmpty {
                EmptyStateView(
                    icon: "heart",
                    title: "아직 좋아요한 게시글이 없어요",
                    message: "마음에 드는 게시글에 좋아요를 눌러보세요.",
                    buttonTitle: "커뮤니티 둘러보기",
                    action: {
                        // 커뮤니티 화면으로 이동
                    }
                )
            } else {
                ForEach(viewModel.userLikedPosts) { board in
                    ProfileBoardItemView(board: board) { selectedBoard in
                        // 선택한 게시글로 이동
                    }
                    
                    Divider()
                        .background(CHColors.divider)
                        .padding(.horizontal, 20)
                }
            }
        }
    }
    
    private func bookmarksContent() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            if viewModel.isLoadingBookmarks {
                loadingBoardsView()
            } else if viewModel.userBookmarks.isEmpty {
                EmptyStateView(
                    icon: "bookmark",
                    title: "아직 북마크한 게시글이 없어요",
                    message: "나중에 다시 보고 싶은 게시글을 북마크해보세요.",
                    buttonTitle: "커뮤니티 둘러보기",
                    action: {
                        // 커뮤니티 화면으로 이동
                    }
                )
            } else {
                ForEach(viewModel.userBookmarks) { board in
                    ProfileBoardItemView(board: board) { selectedBoard in
                        // 선택한 게시글로 이동
                    }
                    
                    Divider()
                        .background(CHColors.divider)
                        .padding(.horizontal, 20)
                }
            }
        }
    }
    
    // MARK: - 찜 목록 섹션
    
    private func favoritesSection() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            if viewModel.isLoadingFavoriteMovies {
                loadingFavoritesView()
            } else if viewModel.userFavoriteMovies.isEmpty {
                EmptyStateView(
                    icon: "film",
                    title: "아직 찜한 영화가 없어요",
                    message: "관심있는 영화를 찜해보세요.\n나중에 쉽게 찾아볼 수 있어요.",
                    buttonTitle: "영화 둘러보기",
                    action: {
                        // 영화 목록 화면으로 이동
                    }
                )
            } else {
                // 영화 그리드 표시
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 16)], spacing: 20) {
                    ForEach(viewModel.userFavoriteMovies) { movie in
                        MovieItemView(movie: movie) { selectedMovie in
                            // 선택한 영화 상세 페이지로 이동
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
        }
    }
    
    // MARK: - 설정 섹션
    
    private func settingsSection() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            // 설정 카테고리 선택
            Picker("설정 카테고리", selection: $selectedSettingCategory) {
                ForEach(SettingCategory.allCases) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            
            // 선택된 카테고리에 따른 설정 항목
            switch selectedSettingCategory {
            case .account:
                accountSettingsView()
            case .app:
                appSettingsView()
            case .info:
                infoSettingsView()
            }
        }
        .animation(.easeInOut(duration: 0.2), value: selectedSettingCategory)
    }
    
    private func accountSettingsView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(selectedSettingCategory.rawValue)
                .font(.headline)
                .foregroundColor(textColor)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            
            // 프로필 편집
            SettingRowView(
                icon: "person.fill",
                title: "프로필 편집",
                subtitle: "닉네임 등 프로필 정보를 수정합니다",
                color: primaryColor
            ) {
                showProfileEditView = true
            }
            
            // 알림 설정
            SettingRowView(
                icon: "bell.fill",
                title: "알림 설정",
                subtitle: "푸시 알림 설정을 관리합니다",
                toggle: $viewModel.pushNotificationsEnabled
            )
            
            // 이메일 알림
            SettingRowView(
                icon: "envelope.fill",
                title: "이메일 알림",
                subtitle: "이메일 알림 설정을 관리합니다",
                toggle: $viewModel.emailNotificationsEnabled
            )
            
            // 비밀번호 변경
            SettingRowView(
                icon: "lock.fill",
                title: "비밀번호 변경",
                subtitle: "계정 비밀번호를 변경합니다"
            ) {
                showPasswordChangeView = true
            }
            
            // 회원 탈퇴
            SettingRowView(
                icon: "person.crop.circle.badge.xmark",
                title: "회원 탈퇴",
                subtitle: "계정과 모든 데이터를 영구 삭제합니다",
                color: .red,
                showDivider: false
            ) {
                showDeleteAccountConfirm = true
            }
        }
    }
    
    private func appSettingsView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(selectedSettingCategory.rawValue)
                .font(.headline)
                .foregroundColor(textColor)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            
            // 다크모드 설정
            SettingRowView(
                icon: "moon.fill",
                title: "다크 모드",
                subtitle: "어두운 테마로 앱을 사용합니다",
                toggle: $viewModel.isDarkMode
            ) {
                viewModel.toggleDarkMode()
            }
            
            // 언어 설정
            SettingRowView(
                icon: "globe",
                title: "언어 설정",
                subtitle: "현재 설정: \(viewModel.selectedLanguage.displayName)"
            ) {
                showLanguageSelection = true
            }
            
            // 캐시 삭제
            SettingRowView(
                icon: "trash.fill",
                title: "캐시 삭제",
                subtitle: "앱 캐시를 정리하여 저장공간을 확보합니다",
                showDivider: false
            ) {
                // 캐시 삭제 기능 구현
            }
        }
    }
    
    private func infoSettingsView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(selectedSettingCategory.rawValue)
                .font(.headline)
                .foregroundColor(textColor)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            
            // 개인정보 처리방침
            SettingRowView(
                icon: "doc.text.fill",
                title: "개인정보 처리방침",
                subtitle: "개인정보 수집 및 이용에 대한 안내"
            ) {
                showPrivacyView = true
            }
            
            // 이용약관
            SettingRowView(
                icon: "doc.text.fill",
                title: "이용약관",
                subtitle: "서비스 이용에 관한 약관"
            ) {
                showTermsView = true
            }
            
            // 앱 정보
            SettingRowView(
                icon: "info.circle.fill",
                title: "앱 정보",
                subtitle: "버전 1.0.0"
            ) {
                showAboutView = true
            }
            
            // 평가하기
            SettingRowView(
                icon: "star.fill",
                title: "앱 평가하기",
                subtitle: "앱스토어에서 CineHive를 평가해주세요",
                color: .yellow,
                showDivider: false
            ) {
                // 앱스토어 링크로 이동
                if let url = URL(string: "itms-apps://itunes.apple.com/app/idXXXXXXXXXX?action=write-review") {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    // MARK: - 스켈레톤 로딩 뷰
    
    private func loadingBoardsView() -> some View {
        VStack(spacing: 20) {
            ForEach(0..<3, id: \.self) { _ in
                VStack(alignment: .leading, spacing: 8) {
                    // 카테고리 및 날짜
                    HStack {
                        SkeletonView(width: 70, height: 20, cornerRadius: 4)
                        Spacer()
                        SkeletonView(width: 60, height: 16, cornerRadius: 4)
                    }
                    
                    // 제목
                    SkeletonView(width: .infinity, height: 20, cornerRadius: 4)
                    
                    // 내용 미리보기
                    SkeletonView(width: .infinity, height: 16, cornerRadius: 4)
                    
                    // 통계
                    HStack(spacing: 12) {
                        SkeletonView(width: 40, height: 16, cornerRadius: 4)
                        SkeletonView(width: 40, height: 16, cornerRadius: 4)
                        SkeletonView(width: 40, height: 16, cornerRadius: 4)
                        Spacer()
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                
                Divider()
                    .background(CHColors.divider)
                    .padding(.horizontal, 20)
            }
        }
    }
    
    private func loadingCommentsView() -> some View {
        VStack(spacing: 20) {
            ForEach(0..<3, id: \.self) { _ in
                VStack(alignment: .leading, spacing: 8) {
                    // 원본 게시글 정보
                    HStack {
                        SkeletonView(width: 120, height: 16, cornerRadius: 4)
                        Spacer()
                        SkeletonView(width: 60, height: 16, cornerRadius: 4)
                    }
                    
                    // 댓글 내용
                    SkeletonView(width: .infinity, height: 40, cornerRadius: 4)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                
                Divider()
                    .background(CHColors.divider)
                    .padding(.horizontal, 20)
            }
        }
    }
    
    private func loadingFavoritesView() -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 16)], spacing: 20) {
            ForEach(0..<6, id: \.self) { _ in
                VStack(alignment: .leading, spacing: 8) {
                    // 포스터 이미지
                    SkeletonView(width: 140, height: 210, cornerRadius: 8)
                    
                    // 제목
                    SkeletonView(width: 120, height:16, cornerRadius: 4)
                    Spacer()
                    SkeletonView(width: 60, height: 16, cornerRadius: 4)
                }
                
                // 댓글 내용
                SkeletonView(width: .infinity, height: 40, cornerRadius: 4)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            
            Divider()
                .background(CHColors.divider)
                .padding(.horizontal, 20)
        }
    }
}

// MARK: - 추가 화면들

// 프로필 편집 화면
struct ProfileEditView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var nickname: String = ""
    @State private var isUpdating = false
    @State private var showSuccessAlert = false
    
    let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        self._nickname = State(initialValue: viewModel.userInfo.nickname)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                CHColors.backgroundColor.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        // 프로필 이미지
                        Circle()
                            .fill(CHColors.primaryColor.opacity(0.2))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Text(String(nickname.prefix(1)))
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(CHColors.primaryColor)
                            )
                            .overlay(
                                Circle()
                                    .stroke(CHColors.backgroundColor, lineWidth: 4)
                            )
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("닉네임")
                                .font(.headline)
                                .foregroundColor(CHColors.textColor)
                            
                            TextField("닉네임을 입력하세요", text: $nickname)
                                .padding()
                                .background(CHColors.inputBackground)
                                .cornerRadius(8)
                                .foregroundColor(CHColors.textColor)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        Spacer()
                    }
                    .padding(.vertical, 20)
                }
                
                if isUpdating {
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle(tint: CHColors.primaryColor))
                }
            }
            .navigationTitle("프로필 편집")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("저장") {
                        saveProfile()
                    }
                    .disabled(nickname.isEmpty || isUpdating || nickname == viewModel.userInfo.nickname)
                }
            }
            .alert("프로필 업데이트 완료", isPresented: $showSuccessAlert) {
                Button("확인") {
                    dismiss()
                }
            } message: {
                Text("프로필 정보가 성공적으로 업데이트되었습니다.")
            }
        }
    }
    
    private func saveProfile() {
        isUpdating = true
        
        Task {
            let success = await viewModel.updateProfile(nickname: nickname)
            
            await MainActor.run {
                isUpdating = false
                if success {
                    showSuccessAlert = true
                }
            }
        }
    }
}

// 비밀번호 변경 화면
struct PasswordChangeView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var isProcessing = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                CHColors.backgroundColor.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        passwordField(title: "현재 비밀번호", placeholder: "현재 비밀번호 입력", text: $currentPassword)
                        
                        passwordField(title: "새 비밀번호", placeholder: "새 비밀번호 입력", text: $newPassword)
                        
                        passwordField(title: "새 비밀번호 확인", placeholder: "새 비밀번호 다시 입력", text: $confirmPassword)
                        
                        Button(action: changePassword) {
                            Text("비밀번호 변경")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(isFormValid ? CHColors.primaryColor : CHColors.secondaryColor)
                                .cornerRadius(8)
                        }
                        .disabled(!isFormValid || isProcessing)
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
                
                if isProcessing {
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle(tint: CHColors.primaryColor))
                }
            }
            .navigationTitle("비밀번호 변경")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("알림"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("확인")) {
                        if alertMessage.contains("성공") {
                            dismiss()
                        }
                    }
                )
            }
        }
    }
    
    private var isFormValid: Bool {
        return !currentPassword.isEmpty &&
        !newPassword.isEmpty &&
        !confirmPassword.isEmpty &&
        newPassword == confirmPassword &&
        newPassword.count >= 8
    }
    
    private func passwordField(title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
                .foregroundColor(CHColors.textColor)
            
            SecureField(placeholder, text: text)
                .padding()
                .background(CHColors.inputBackground)
                .cornerRadius(8)
                .foregroundColor(CHColors.textColor)
        }
    }
    
    private func changePassword() {
        isProcessing = true
        
        // 실제로는 비밀번호 변경 API 호출
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isProcessing = false
            alertMessage = "비밀번호가 성공적으로 변경되었습니다."
            showAlert = true
        }
    }
}





// 앱 정보 화면
struct AboutAppView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                CHColors.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    // 앱 아이콘
                    Circle()
                        .fill(CHColors.primaryColor)
                        .frame(width: 100, height: 100)
                        .overlay(
                            Image(systemName: "play.tv.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        )
                        .padding(.top, 40)
                    
                    // 앱 이름 및 버전
                    VStack(spacing: 6) {
                        Text("CineHive")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(CHColors.textColor)
                        
                        Text("버전 1.0.0")
                            .font(.subheadline)
                            .foregroundColor(CHColors.secondaryColor)
                    }
                    
                    // 앱 설명
                    Text("CineHive는 영화와 드라마를 사랑하는 사람들을 위한 커뮤니티 앱입니다.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(CHColors.textColor)
                        .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    // 저작권 정보
                    Text("© 2025 CineHive. All rights reserved.")
                        .font(.caption)
                        .foregroundColor(CHColors.secondaryColor)
                        .padding(.bottom, 20)
                }
            }
            .navigationTitle("앱 정보")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("닫기") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - 미리보기

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabView()
            .preferredColorScheme(.dark)
    }
}
