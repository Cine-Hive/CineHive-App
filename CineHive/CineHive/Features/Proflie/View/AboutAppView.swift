//
//  AboutAppView.swift
//  CineHive
//
//  Created by 이종민 on 4/16/25.
//

import SwiftUI

struct AboutAppView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    // GitHubProfile 모달 상태
    @State private var selectedGitHubUsername: String? = nil
    @State private var showGitHubProfile = false
    
    // 앱 정보
    private let appName = "CineHive"
    private let appVersion = "1.0.0"
    private let buildNumber = "25"
    private let appDescriptionText = "영화 팬들을 위한 커뮤니티 플랫폼"
    private let copyrightText = "© 2025 CineHive. All rights reserved."
    
    // 개발자 정보 구조체
    struct Developer: Identifiable {
        let id = UUID()
        let name: String
        let role: String
        let github: String
        let githubUsername: String
        let profileImage: String? // Optional: 이미지 URL 또는 로컬 이미지명
    }
    
    // 개발자 목록 데이터
    private let developers = [
        Developer(
            name: "이종민",
            role: "iOS 개발자",
            github: "https://github.com/unib35",
            githubUsername: "unib35",
            profileImage: nil
        ),
        Developer(
            name: "조은진",
            role: "iOS 개발자",
            github: "https://github.com/whswls",
            githubUsername: "whswls",
            profileImage: nil
        )
    ]
    private let developerEmail = "contact@cinehive.com"
    private let developerWebsite = "https://cinehive.com"
    
    // 소셜 미디어 링크 - 아이콘 수정
    private let socialLinks: [(name: String, icon: String, url: String)] = [
        ("인스타그램", "camera.fill", "https://instagram.com/cinehive"),
        ("트위터", "message.fill", "https://twitter.com/cinehive"),
        ("유튜브", "play.rectangle.fill", "https://youtube.com/c/cinehive")
    ]
    
    // 색상 테마
    @Environment(\.colorScheme) private var colorScheme
    private let backgroundColor = CHColors.backgroundColor
    private let primaryColor = CHColors.primaryColor
    private let textColor = CHColors.textColor
    private let secondaryColor = CHColors.secondaryColor
    
    var body: some View {
        ZStack {
            // 메인 콘텐츠
            ScrollView {
                VStack(spacing: 30) {
                    // 앱 아이콘 및 메인 정보
                    appHeader
                    
                    // 앱 소개 텍스트
                    appDescriptionSection
                    
                    // 주요 기능
                    featuresSection
                    
                    // 개발자 정보
                    developerSection
                    
                    // 소셜 미디어 링크
                    socialSection
                    
                    // 저작권 표시
                    Text(copyrightText)
                        .font(.caption2)
                        .foregroundStyle(secondaryColor)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                }
                .padding()
            }
            .background(backgroundColor.ignoresSafeArea())
            
            // GitHub 프로필 모달 오버레이
            if showGitHubProfile {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        closeGitHubProfile()
                    }

                if let username = selectedGitHubUsername {
                    GitHubProfileCardView(
                        username: username,
                        onClose: closeGitHubProfile
                    )
                    .background(
                        colorScheme == .dark ?
                            Color.black.opacity(0.9) :
                            Color.white.opacity(0.9)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 20)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: 600)
                    .transition(.scale(scale: 0.8).combined(with: .opacity))
                }
            }
        }
        .navigationTitle("앱 정보")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                CloseButton(action: {
                    dismiss()
                })
            }
        }
    }
    
    private func closeGitHubProfile() {
        withAnimation(.easeOut(duration: 0.3)) {
            showGitHubProfile = false
            selectedGitHubUsername = nil
        }
    }
    
    // MARK: - UI Components
    
    // 앱 헤더 섹션
    private var appHeader: some View {
        VStack(spacing: 12) {
            // 앱 아이콘
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(primaryColor.gradient)
                    .frame(width: 100, height: 100)
                    .shadow(radius: 5)
                
                Image(systemName: "film")
                    .font(.system(size: 50))
                    .fontWeight(.light)
                    .foregroundStyle(.white)
            }
            
            // 앱 이름
            Text(appName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(textColor)
            
            // 앱 버전
            Text("버전 \(appVersion) (\(buildNumber))")
                .font(.subheadline)
                .foregroundStyle(secondaryColor)
            
            // 앱 설명
            Text(appDescriptionText)
                .font(.headline)
                .foregroundStyle(secondaryColor)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
    }
    
    // 앱 소개 텍스트
    private var appDescriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("앱 소개")
                .font(.headline)
                .foregroundStyle(textColor)
            
            Text("CineHive는 영화를 사랑하는 사람들이 모여 영화에 대한 이야기를 나누고 정보를 공유하는 커뮤니티 플랫폼입니다. 다양한 장르의 영화에 대한 리뷰, 평가, 추천을 통해 더 풍부한 영화 감상 경험을 제공합니다.")
                .font(.body)
                .foregroundStyle(textColor.opacity(0.9))
                .multilineTextAlignment(.leading)
            
            Text("영화 팬들을 위한 모든 것이 여기에 있습니다. 최신 영화 정보부터 클래식 명작까지, CineHive와 함께 영화의 세계를 탐험해보세요.")
                .font(.body)
                .foregroundStyle(textColor.opacity(0.9))
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(colorScheme == .dark ? Color.gray.opacity(0.15) : Color.gray.opacity(0.05))
        )
    }
    
    // 주요 기능 섹션
    private var featuresSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("주요 기능")
                .font(.headline)
                .foregroundStyle(textColor)
            
            ForEach(features.indices, id: \.self) { index in
                featureRow(icon: features[index].icon, title: features[index].title, description: features[index].description)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // 개발자 정보 섹션
    private var developerSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("개발자 정보")
                .font(.headline)
                .foregroundStyle(textColor)
            
            VStack(alignment: .leading, spacing: 16) {
                // 개발자 목록
                ForEach(developers) { developer in
                    VStack(alignment: .leading, spacing: 8) {
                        // 개발자 이름과 역할
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(developer.name)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(textColor)
                                
                                Text(developer.role)
                                    .font(.caption)
                                    .foregroundStyle(secondaryColor)
                            }
                            
                            Spacer()
                            
                            // GitHub 프로필 버튼
                            Button {
                                selectedGitHubUsername = developer.githubUsername
                                withAnimation(.spring(duration: 0.4)) {
                                    showGitHubProfile = true
                                }
                            } label: {
                                HStack(spacing: 6) {
                                    Image(systemName: "person.circle.fill")
                                        .font(.system(size: 16))
                                        .foregroundStyle(primaryColor)
                                    
                                    Text("GitHub 프로필")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(
                                    Capsule()
                                        .fill(primaryColor.opacity(0.1))
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    if developer.id != developers.last?.id {
                        Divider()
                            .padding(.vertical, 4)
                    }
                }
                
                // 연락처 정보
                Divider()
                    .padding(.vertical, 8)
                
                HStack {
                    Text("이메일")
                        .font(.subheadline)
                        .foregroundStyle(secondaryColor)
                        .frame(width: 70, alignment: .leading)
                    
                    Button {
                        if let url = URL(string: "mailto:\(developerEmail)") {
                            openURL(url)
                        }
                    } label: {
                        Text(developerEmail)
                            .font(.body)
                            .foregroundStyle(primaryColor)
                            .underline()
                    }
                    .buttonStyle(.plain)
                }
                
                HStack {
                    Text("웹사이트")
                        .font(.subheadline)
                        .foregroundStyle(secondaryColor)
                        .frame(width: 70, alignment: .leading)
                    
                    Button {
                        if let url = URL(string: developerWebsite) {
                            openURL(url)
                        }
                    } label: {
                        Text(developerWebsite)
                            .font(.body)
                            .foregroundStyle(primaryColor)
                            .underline()
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(colorScheme == .dark ? Color.gray.opacity(0.15) : Color.gray.opacity(0.05))
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // 소셜 미디어 섹션
    private var socialSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("소셜 미디어")
                .font(.headline)
                .foregroundStyle(textColor)
            
            HStack(spacing: 20) {
                ForEach(socialLinks, id: \.name) { link in
                    Button {
                        if let url = URL(string: link.url) {
                            openURL(url)
                        }
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: link.icon)
                                .font(.system(size: 24))
                                .foregroundStyle(primaryColor)
                            
                            Text(link.name)
                                .font(.caption)
                                .foregroundStyle(secondaryColor)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(colorScheme == .dark ? Color.gray.opacity(0.15) : Color.gray.opacity(0.05))
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // 기능 행
    private func featureRow(icon: String, title: String, description: String) -> some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(primaryColor)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(textColor)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(secondaryColor)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 6)
    }
    
    // 앱 주요 기능 데이터
    private var features: [(icon: String, title: String, description: String)] {
        [
            ("film.fill", "영화 정보", "최신 영화부터 클래식 명작까지 다양한 영화 정보를 제공합니다."),
            ("star.fill", "리뷰 및 평점", "영화에 대한 리뷰를 작성하고 평점을 남길 수 있습니다."),
            ("bubble.left.and.bubble.right.fill", "커뮤니티", "다른 영화 팬들과 의견을 나누고 토론할 수 있습니다."),
            ("bell.fill", "영화 알림", "기대하는 영화의 개봉일, 티저 등 최신 소식을 받아볼 수 있습니다."),
            ("heart.fill", "찜 목록", "보고 싶은 영화를 찜 목록에 저장하고 관리할 수 있습니다.")
        ]
    }
}

// MARK: - 미리보기

#Preview("앱 정보") {
    NavigationStack {
        AboutAppView()
    }
    .preferredColorScheme(.dark)
}
