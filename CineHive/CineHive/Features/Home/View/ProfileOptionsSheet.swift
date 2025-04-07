//
//  ProfileOptionsSheet.swift
//  CineHive
//
//  Created by 이종민 on 4/8/25.
//

import SwiftUI

/// 프로필 옵션 시트 - 사용자 계정 관련 옵션을 표시하는 시트 뷰
struct ProfileOptionsSheet: View {
    @Environment(UserState.self) private var userState
    @Binding var isPresented: Bool
    
    // 콜백 핸들러
    var onLogout: () -> Void
    var onSettingsTap: (() -> Void)?
    var onActivityTap: (() -> Void)?
    var onFavoritesTap: (() -> Void)?
    
    var body: some View {
        NavigationStack {
            List {
                // 프로필 정보 섹션
                if userState.isLoggedIn, let user = userState.currentUser {
                    userProfileSection(user: user)
                } else if userState.isGuestMode {
                    guestProfileSection()
                }
                
                // 계정 메뉴 섹션
                accountMenuSection()
                
                // 로그아웃 섹션
                logoutSection()
            }
            .navigationTitle("프로필")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    closeButton
                }
            }
        }
        .presentationDragIndicator(.visible)
        .presentationDetents([.medium, .large])
        .background(CHColors.backgroundColor)
    }
    
    // MARK: - 섹션 컴포넌트
    
    /// 사용자 프로필 정보 섹션
    private func userProfileSection(user: UserData) -> some View {
        Section {
            HStack {
                // 프로필 이미지나 이니셜
                Text(String(user.nickname.prefix(1)))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(CHColors.primaryColor)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                
                // 사용자 정보
                VStack(alignment: .leading, spacing: 2) {
                    Text(user.nickname)
                        .font(.headline)
                    
                    Text(user.email)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 4)
        } header: {
            Text("내 정보")
        }
    }
    
    /// 게스트 프로필 섹션
    private func guestProfileSection() -> some View {
        Section {
            HStack {
                // 게스트 아이콘
                Image(systemName: "person.fill.questionmark")
                    .font(.system(size: 16))
                    .foregroundColor(CHColors.gray)
                    .frame(width: 36, height: 36)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                
                // 게스트 정보
                VStack(alignment: .leading, spacing: 2) {
                    Text("게스트 모드")
                        .font(.headline)
                    
                    Text("제한된 기능 이용 가능")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 4)
        } header: {
            Text("게스트 정보")
        }
    }
    
    /// 계정 메뉴 섹션
    private func accountMenuSection() -> some View {
        Section {
            // 설정 버튼
            Button {
                if let action = onSettingsTap {
                    isPresented = false
                    action()
                }
            } label: {
                accountMenuItem(icon: "gear", title: "설정")
            }
            .hapticFeedback(.light)
            
            // 내 활동 버튼
            Button {
                if let action = onActivityTap {
                    isPresented = false
                    action()
                }
            } label: {
                accountMenuItem(icon: "clock.arrow.circlepath", title: "내 활동")
            }
            .hapticFeedback(.light)
            
            // 찜한 영화 버튼
            Button {
                if let action = onFavoritesTap {
                    isPresented = false
                    action()
                }
            } label: {
                accountMenuItem(icon: "heart.fill", title: "찜한 영화")
            }
            .hapticFeedback(.light)
        } header: {
            Text("계정")
        }
    }
    
    /// 로그아웃 섹션
    private func logoutSection() -> some View {
        Section {
            Button {
                isPresented = false
                onLogout()
            } label: {
                HStack {
                    Text(userState.isGuestMode ? "게스트 모드 종료" : "로그아웃")
                    Spacer()
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
                .foregroundColor(.red)
            }
            .hapticFeedback(.medium)
        }
    }
    
    // MARK: - 유틸리티 컴포넌트
    
    /// 계정 메뉴 아이템 레이아웃
    private func accountMenuItem(icon: String, title: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .frame(width: 24, height: 24)
                .foregroundColor(CHColors.primaryColor.opacity(0.8))
            
            Text(title)
                .foregroundColor(CHColors.backgroundColor)
        }
    }
    
    /// 닫기 버튼
    private var closeButton: some View {
        Button("닫기") {
            isPresented = false
        }
        .hapticFeedback(.light)
    }
}

// MARK: - 미리보기
#Preview("로그인 상태") {
    ProfileOptionsSheet(
        isPresented: .constant(true),
        onLogout: {}
    )
    .environment(UserState.shared)
}

#Preview("게스트 모드") {
    ProfileOptionsSheet(
        isPresented: .constant(true),
        onLogout: {}
    )
    .environment(UserState.shared)
}
