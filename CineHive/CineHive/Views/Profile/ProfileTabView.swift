//
//  ProfileTabView.swift
//  CineHive
//
//  Created by 이종민 on 3/18/25.
//

import SwiftUI

struct ProfileTabView: View {
    @State private var viewModel = MovieViewModel()
    @State private var showLoginView = false
    @State private var selectedSection: ProfileSection = .ratings
    
    // 색상 테마
    private let backgroundColor = Color.black
    private let primaryColor = Color("PrimaryColor")
    private let textColor = Color.white
    private let secondaryColor = Color.gray
    
    enum ProfileSection: String, CaseIterable {
        case ratings = "평가"
        case watchlist = "볼 영화"
        case watched = "본 영화"
        case collections = "컬렉션"
    }
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            if viewModel.isLoggedIn {
                userProfileContent()
            } else {
                loginPrompt()
            }
        }
        .sheet(isPresented: $showLoginView) {
            LoginView()
        }
        .onAppear {
            // 테스트용 임시 데이터
            viewModel.isLoggedIn = true
        }
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
            
            Text("평가, 저장, 커뮤니티 기능을\n이용하려면 로그인이 필요합니다.")
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
            
            // 카테고리 선택 탭
            profileSectionSelector()
            
            // 선택된 섹션 콘텐츠
            ScrollView {
                VStack(spacing: 20) {
                    switch selectedSection {
                    case .ratings:
                        ratingsSection()
                    case .watchlist:
                        watchlistSection()
                    case .watched:
                        watchedSection()
                    case .collections:
                        collectionsSection()
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding(.top, 20)
            }
        }
        .navigationBarHidden(true)
    }
    
    private func profileHeader() -> some View {
        VStack(spacing: 15) {
            // 프로필 정보
            HStack(spacing: 15) {
                // 프로필 이미지
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(primaryColor)
                
                // 사용자 정보
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.currentUser?.nickname ?? "사용자")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(textColor)
                    
                    Text(viewModel.currentUser?.email ?? "user@example.com")
                        .font(.subheadline)
                        .foregroundColor(secondaryColor)
                    
                    // 선호 장르
                    if let genres = viewModel.currentUser?.genres, !genres.isEmpty {
                        HStack {
                            ForEach(genres.prefix(3), id: \.self) { genre in
                                Text(genre)
                                    .font(.caption2)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(Color.gray.opacity(0.2))
                                    .foregroundColor(secondaryColor)
                                    .cornerRadius(4)
                            }
                        }
                    }
                }
                
                Spacer()
                
                // 설정 버튼
                Button {
                    // 설정 화면 표시
                } label: {
                    Image(systemName: "gearshape")
                        .font(.title2)
                        .foregroundColor(secondaryColor)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            // 활동 통계
            HStack(spacing: 0) {
                statsCard(count: 0, title: "평가")
                
                Divider()
                    .frame(height: 40)
                    .background(Color.gray.opacity(0.3))
                
                statsCard(count: 0, title: "볼 영화")
                
                Divider()
                    .frame(height: 40)
                    .background(Color.gray.opacity(0.3))
                
                statsCard(count: 0, title: "본 영화")
            }
            .padding(.vertical, 15)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
    }
    
    private func statsCard(count: Int, title: String) -> some View {
        VStack(spacing: 5) {
            Text("\(count)")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(textColor)
            
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(secondaryColor)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func profileSectionSelector() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(ProfileSection.allCases, id: \.self) { section in
                    Button {
                        withAnimation {
                            selectedSection = section
                        }
                    } label: {
                        VStack(spacing: 8) {
                            Text(section.rawValue)
                                .font(.system(size: 16, weight: selectedSection == section ? .bold : .regular))
                                .foregroundColor(selectedSection == section ? textColor : secondaryColor)
                            
                            Rectangle()
                                .fill(selectedSection == section ? primaryColor : Color.clear)
                                .frame(height: 2)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
        }
    }
    
    // MARK: - Section Content
    
    private func ratingsSection() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            if true { // 평가가 없는 경우 (임시 조건)
                emptyStateView(
                    icon: "star.fill",
                    title: "아직 평가한 작품이 없어요",
                    message: "영화, TV 프로그램, 애니메이션을 평가해보세요.",
                    buttonTitle: "작품 둘러보기"
                )
            } else {
                // 평가 내역 표시 (미래 구현)
                Text("평가 내역")
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func watchlistSection() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            if true { // 저장한 영화가 없는 경우 (임시 조건)
                emptyStateView(
                    icon: "bookmark.fill",
                    title: "아직 저장한 작품이 없어요",
                    message: "나중에 보고 싶은 작품을 저장해보세요.",
                    buttonTitle: "작품 둘러보기"
                )
            } else {
                // 저장 내역 표시 (미래 구현)
                Text("저장 목록")
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func watchedSection() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            if true { // 본 영화가 없는 경우 (임시 조건)
                emptyStateView(
                    icon: "eye.fill",
                    title: "아직 본 작품이 없어요",
                    message: "시청 완료한 작품을 기록해보세요.",
                    buttonTitle: "작품 둘러보기"
                )
            } else {
                // 본 영화 내역 표시 (미래 구현)
                Text("시청 내역")
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func collectionsSection() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            if true { // 컬렉션이 없는 경우 (임시 조건)
                emptyStateView(
                    icon: "rectangle.stack.fill",
                    title: "아직 만든 컬렉션이 없어요",
                    message: "작품들을 테마별로 모아 컬렉션을 만들어보세요.",
                    buttonTitle: "컬렉션 만들기"
                )
            } else {
                // 컬렉션 표시 (미래 구현)
                Text("내 컬렉션")
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func emptyStateView(icon: String, title: String, message: String, buttonTitle: String) -> some View {
        VStack(spacing: 15) {
            Spacer().frame(height: 30)
            
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(primaryColor)
            
            Text(title)
                .font(.headline)
                .foregroundColor(textColor)
                .padding(.top, 10)
            
            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(secondaryColor)
                .padding(.horizontal, 40)
            
            Button {
                // 해당 작업 수행
            } label: {
                Text(buttonTitle)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(primaryColor)
                    .cornerRadius(8)
                    .padding(.top, 15)
            }
            
            Spacer()
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProfileTabView()
}
