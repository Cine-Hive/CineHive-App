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
    var avatarURL: String? = nil
    
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
            
            Button {
                withAnimation(.spring(duration: 0.3)) {
                    if let customAction = onProfileTap {
                        customAction()
                    } else {
                        // 기본: 프로필 옵션 표시
                        showProfileOptions.toggle()
                    }
                }
            } label: {
                if let raw = avatarURL {
                    let cleaned = raw.trimmingCharacters(in: .whitespacesAndNewlines)
                    let https = cleaned.hasPrefix("http://") ? cleaned.replacingOccurrences(of: "http://", with: "https://") : cleaned
                    if let url = URL(string: https) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                Circle().fill(Color.gray.opacity(0.2))
                            case .success(let image):
                                image.resizable().scaledToFill()
                            case .failure:
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable().scaledToFill()
                            @unknown default:
                                Image(systemName: "person.crop.circle")
                                    .resizable().scaledToFill()
                            }
                        }
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                    } else {
                        // URL 변환 실패 시 기본 아이콘
                        Image(systemName: "person.crop.circle.fill")
                            .resizable().scaledToFill()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(CHColors.textColor)
                    }
                } else {
                    // 로그인 칩 (기존 스타일)
                    Text("로그인")
                        .font(.system(size: 12, weight: .semibold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color.black.opacity(0.25))
                        )
                        .overlay(
                            Capsule()
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 0.5)
                        )
                        .foregroundStyle(.white)
                }
            }
            .buttonStyle(ScaleButtonStyle())
            .accessibilityLabel("프로필")
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
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
