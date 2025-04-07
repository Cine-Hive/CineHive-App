//
//  HomeHeaderView.swift
//  CineHive
//
//  Created by 이종민 on 4/7/25.
//

import SwiftUI

struct HomeHeaderView: View {
    @Environment(UserState.self) private var userState
    @Binding var isSearchActive: Bool
    @Binding var showProfileOptions: Bool
    var onProfileTap: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 15) {
            // 로고
            Text("CineHive")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(CHColors.primaryColor)
                .accessibilityAddTraits(.isHeader)
            
            Spacer()
            
            // 검색 버튼
            Button {
                withAnimation(.spring(duration: 0.3)) {
                    isSearchActive = true
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(CHColors.textColor)
                    .font(.system(size: 18))
            }
            .buttonStyle(ScaleButtonStyle())
            .accessibilityLabel("검색")
            
            ProfileButtonView {
                withAnimation(.spring(duration: 0.3)) {
                    if let customAction = onProfileTap {
                        customAction()
                    } else {
                        handleProfileTap()
                    }
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
    
    // 프로필 버튼 탭 처리
    private func handleProfileTap() {
        if userState.isLoggedIn || userState.isGuestMode {
            // 이미 로그인한 상태 - 프로필 옵션 표시
            showProfileOptions.toggle()
        } else {
            // 로그인 필요 상태 - 로그인 화면 또는 프로필 탭으로 이동
            showProfileOptions.toggle() // 임시로 동일한 동작 수행
            
            // 로그인이 필요함을 알리는 방법은 앱 구조에 따라 달라질 수 있음
            // 예: 탭 바 컨트롤러의 프로필 탭으로 이동
            // 또는 로그인 모달 표시 등
        }
    }
}

// 미리보기
#Preview {
    VStack {
        HomeHeaderView(
            isSearchActive: .constant(false),
            showProfileOptions: .constant(false)
        )
        
        Spacer()
    }
    .background(CHColors.backgroundColor)
    .environment(UserState.shared)
}
