//
//  ProfileComponents.swift
//  CineHive
//
//  Created by 이종민 on 4/3/25.
//

import SwiftUI

// MARK: - 재사용 가능한 컴포넌트

struct ActivityStatCard: View {
    let count: Int
    let title: String
    let icon: String
    let color: Color
    
    init(count: Int, title: String, icon: String, color: Color = CHColors.primaryColor) {
        self.count = count
        self.title = title
        self.icon = icon
        self.color = color
    }
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
            }
            
            Text("\(count)")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(CHColors.textColor)
            
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(CHColors.secondaryColor)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
    }
}

struct ProfileBoardItemView: View {
    let board: Board
    var onTap: ((Board) -> Void)? = nil
    
    var body: some View {
        Button(action: { onTap?(board) }) {
            VStack(alignment: .leading, spacing: 8) {
                // 카테고리 및 날짜
                HStack {
                    Text(board.localCategory)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(CHColors.primaryColor.opacity(0.2))
                        .foregroundColor(CHColors.primaryColor)
                        .cornerRadius(4)
                    
                    Spacer()
                    
                    Text(formatDate(board.createdAt))
                        .font(.caption)
                        .foregroundColor(CHColors.secondaryColor)
                }
                
                // 제목
                Text(board.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(CHColors.textColor)
                    .lineLimit(1)
                
                // 내용 미리보기
                Text(board.content)
                    .font(.system(size: 14))
                    .foregroundColor(CHColors.secondaryColor)
                    .lineLimit(1)
                
                // 통계
                HStack(spacing: 12) {
                    Label("\(board.viewCount)", systemImage: "eye")
                    Label("\(board.likeCount)", systemImage: "heart")
                    Label("\(board.commentCount)", systemImage: "bubble.left")
                    Spacer()
                }
                .font(.caption)
                .foregroundColor(CHColors.secondaryColor)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(CHColors.backgroundColor)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // 날짜 포맷팅 메서드
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "ko_KR")
        
        if let date = formatter.date(from: dateString) {
            let now = Date()
            let components = Calendar.current.dateComponents([.day, .hour, .minute], from: date, to: now)
            
            if let day = components.day, day > 0 {
                return "\(day)일 전"
            } else if let hour = components.hour, hour > 0 {
                return "\(hour)시간 전"
            } else if let minute = components.minute, minute > 0 {
                return "\(minute)분 전"
            } else {
                return "방금 전"
            }
        }
        return dateString
    }
}

struct ProfileCommentItemView: View {
    let comment: Comment
    var onTap: ((Comment) -> Void)? = nil
    
    var body: some View {
        Button(action: { onTap?(comment) }) {
            VStack(alignment: .leading, spacing: 8) {
                // 원본 게시글 정보
                HStack {
                    Text("원글: \(comment.author)님의 게시글")
                        .font(.caption)
                        .foregroundColor(CHColors.primaryColor)
                    
                    Spacer()
                    
                    Text(formatDate(comment.createdAt))
                        .font(.caption)
                        .foregroundColor(CHColors.secondaryColor)
                }
                
                // 댓글 내용
                Text(comment.content)
                    .font(.system(size: 15))
                    .foregroundColor(CHColors.textColor)
                    .lineLimit(2)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(CHColors.backgroundColor)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // 날짜 포맷팅 메서드
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "ko_KR")
        
        if let date = formatter.date(from: dateString) {
            let now = Date()
            let components = Calendar.current.dateComponents([.day, .hour, .minute], from: date, to: now)
            
            if let day = components.day, day > 0 {
                return "\(day)일 전"
            } else if let hour = components.hour, hour > 0 {
                return "\(hour)시간 전"
            } else if let minute = components.minute, minute > 0 {
                return "\(minute)분 전"
            } else {
                return "방금 전"
            }
        }
        return dateString
    }
}

struct MovieItemView: View {
    let movie: Movie
    var onTap: ((Movie) -> Void)? = nil
    var isFavorite: Bool = false // 외부에서 favorite 상태를 전달받도록 변경
    
    var body: some View {
        Button(action: { onTap?(movie) }) {
            VStack(alignment: .leading, spacing: 8) {
                // 포스터 이미지
                ZStack {
                    Rectangle()
                        .fill(CHColors.cardBackground)
                        .aspectRatio(2/3, contentMode: .fit)
                        .cornerRadius(8)
                        .shadow(radius: 3)
                    
                    AsyncImage(url: movie.posterURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            Image(systemName: "film")
                                .font(.largeTitle)
                                .foregroundColor(CHColors.secondaryColor)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .aspectRatio(2/3, contentMode: .fit)
                    .cornerRadius(8)
                    
                    // 즐겨찾기 아이콘
                    if isFavorite { // movie.isFavorite 대신 isFavorite 사용
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                    .padding(8)
                                    .background(
                                        Circle()
                                            .fill(Color.black.opacity(0.6))
                                    )
                                    .padding(8)
                            }
                            Spacer()
                        }
                    }
                }
                
                // 제목 및 연도
                HStack {
                    Text("영화제목")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(CHColors.textColor)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text("영화 출시일")
                        .font(.caption)
                        .foregroundColor(CHColors.secondaryColor)
                }
                
                // 평점
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(CHColors.starColor)
                        .font(.caption)
                    
                    Text(String(format: "%.1f", 4.4))
                        .font(.caption)
                        .foregroundColor(CHColors.secondaryColor)
                }
            }
            .padding(8)
            .background(CHColors.backgroundColor)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - 스켈레톤 로딩 뷰
struct SkeletonView: View {
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    @State private var isAnimating = false
    
    init(width: CGFloat, height: CGFloat, cornerRadius: CGFloat = 8) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color.gray.opacity(0.2),
                            Color.gray.opacity(0.15),
                            Color.gray.opacity(0.2)
                        ]
                    ),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(width: width, height: height)
            .mask(
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    .clear,
                                    .white,
                                    .clear
                                ]
                            ),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .offset(x: isAnimating ? width : -width)
            )
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1.5)
                        .repeatForever(autoreverses: false)
                ) {
                    isAnimating = true
                }
            }
    }
}

// MARK: - 에러 토스트 뷰
struct ErrorToastView: View {
    let message: String
    let onDismiss: () -> Void
    
    @State private var opacity: Double = 0
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.white)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.red.opacity(0.9))
            )
            .shadow(radius: 4)
        }
        .padding(.horizontal, 20)
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.3)) {
                opacity = 1.0
            }
            
            // 자동 제거
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    opacity = 0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    onDismiss()
                }
            }
        }
    }
}

// MARK: - 빈 상태 뷰
struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 20)
            
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundColor(CHColors.primaryColor)
            
            Text(title)
                .font(.headline)
                .foregroundColor(CHColors.textColor)
                .multilineTextAlignment(.center)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(CHColors.secondaryColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button(action: action) {
                Text(buttonTitle)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(CHColors.primaryColor)
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
    }
}

// MARK: - 수평 스크롤 섹션
struct HorizontalScrollSection<Content: View, T: Identifiable>: View {
    let title: String
    let items: [T]
    let emptyStateIcon: String
    let emptyStateTitle: String
    let emptyStateMessage: String
    let emptyStateButtonTitle: String
    let emptyStateAction: () -> Void
    let content: (T) -> Content
    var showSeeAll: Bool = false
    var seeAllAction: (() -> Void)? = nil
    var isLoading: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ProfileSectionHeader(
                title: title,
                showSeeAll: showSeeAll && !items.isEmpty,
                action: seeAllAction
            )
            
            if isLoading {
                VStack {
                    HStack(spacing: 12) {
                        ForEach(0..<3, id: \.self) { _ in
                            SkeletonView(width: 140, height: 210)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                }
            } else if items.isEmpty {
                EmptyStateView(
                    icon: emptyStateIcon,
                    title: emptyStateTitle,
                    message: emptyStateMessage,
                    buttonTitle: emptyStateButtonTitle,
                    action: emptyStateAction
                )
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(items) { item in
                            content(item)
                                .frame(width: 140)
                        }
                        Spacer().frame(width: 4)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                }
            }
        }
    }
}


struct SettingRowView: View {
    let icon: String
    let title: String
    var subtitle: String? = nil
    var toggle: Binding<Bool>? = nil
    var color: Color = CHColors.secondaryColor
    var showDivider: Bool = true
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            if toggle == nil {
                action?()
            }
        }) {
            VStack(spacing: 0) {
                HStack(spacing: 16) {
                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundColor(color)
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: subtitle != nil ? 4 : 0) {
                        Text(title)
                            .font(.system(size: 16))
                            .foregroundColor(CHColors.textColor)
                        
                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(.system(size: 12))
                                .foregroundColor(CHColors.secondaryColor)
                        }
                    }
                    
                    Spacer()
                    
                    if let toggle = toggle {
                        Toggle("", isOn: toggle)
                            .toggleStyle(SwitchToggleStyle(tint: CHColors.primaryColor))
                            .labelsHidden()
                    } else {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(CHColors.secondaryColor.opacity(0.6))
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 20)
                
                if showDivider {
                    Divider()
                        .padding(.leading, 60)
                        .background(CHColors.divider)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ProfileSectionHeader: View {
    let title: String
    var showSeeAll: Bool = false
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(CHColors.textColor)
            
            Spacer()
            
            if showSeeAll {
                Button(action: { action?() }) {
                    Text("더보기")
                        .font(.subheadline)
                        .foregroundColor(CHColors.primaryColor)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
}

