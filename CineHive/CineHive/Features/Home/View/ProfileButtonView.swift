//
//  ProfileButtonView.swift
//  CineHive
//
//  Created by 이종민 on 4/7/25.
//

import SwiftUI
import Observation

struct ProfileButtonView: View {
    @Environment(UserState.self) private var userState
    @Environment(\.colorScheme) private var colorScheme
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            profileContent
        }
        .buttonStyle(ScaleButtonStyle())
        .hapticFeedback(.light)
        .contentShape(Rectangle())
        .accessibilityLabel(accessibilityLabel)
    }
    
    // MARK: - 프로필 상태에 따른 콘텐츠
    @ViewBuilder
    private var profileContent: some View {
        if userState.isLoggedIn, let user = userState.currentUser {
            LoggedInProfileView(nickname: user.nickname)
        } else if userState.isGuestMode {
            GuestProfileView()
        } else {
            LoginButtonView()
        }
    }
    
    // MARK: - 접근성
    private var accessibilityLabel: String {
        if userState.isLoggedIn, let user = userState.currentUser {
            return "\(user.nickname)의 프로필"
        } else if userState.isGuestMode {
            return "게스트 모드"
        } else {
            return "로그인 필요"
        }
    }
}

// MARK: - 로그인 상태 프로필 뷰
struct LoggedInProfileView: View {
    let nickname: String
    
    var body: some View {
        Text(String(nickname.prefix(1)))
            .font(.system(size: 12, weight: .bold))
            .foregroundColor(.white)
            .frame(width: 26, height: 26)
            .background(CHColors.primaryColor)
            .clipShape(Circle())
    }
}

// MARK: - 게스트 모드 프로필 뷰
struct GuestProfileView: View {
    var body: some View {
        Text("게스트")
            .font(.caption2)
            .fontWeight(.medium)
            .foregroundStyle(CHColors.gray)
    }
}

// MARK: - 로그인 버튼 뷰
struct LoginButtonView: View {
    var body: some View {
        Text("로그인")
            .font(.caption)
            .fontWeight(.medium)
            .foregroundStyle(CHColors.primaryColor)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                Capsule()
                    .fill(CHColors.primaryColor.opacity(0.15))
            )
    }
}
