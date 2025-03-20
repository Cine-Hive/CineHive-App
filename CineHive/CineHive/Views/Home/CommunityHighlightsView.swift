//
//  CommunityHighlightsView.swift
//  CineHive
//
//  Created by 이종민 on 3/20/25.
//

import SwiftUI

// 커뮤니티 하이라이트 섹션 컴포넌트
struct CommunityHighlightsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "커뮤니티 화제", actionTitle: "더보기")
            
            VStack(spacing: 12) {
                ForEach(1...3, id: \.self) { index in
                    NavigationLink(destination: EmptyView()) {
                        // 나중에 커뮤니티 상세 페이지로 연결
                        // 커뮤니티 인기글 3개나 상위 3개
                        communityPostCard(
                            title: ["넷플릭스 3월 신작 총정리", "디즈니+ 꿀팁 공유합니다", "최근 본 영화 TOP 5"][index-1],
                            author: "유저\(index)",
                            category: ["정보", "꿀팁", "리뷰"][index-1],
                            commentCount: [24, 18, 32][index-1],
                            likeCount: [86, 45, 120][index-1],
                            time: ["\(index)시간 전"][0]
                        )
                    }
                }
            }
            .padding(.horizontal, 15)
        }
        .padding(.vertical, 15)
        
    }
    
    // 커뮤니티 게시글 카드
    private func communityPostCard(title: String, author: String, category: String, commentCount: Int, likeCount: Int, time: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // 상단 정보
            HStack {
                Text(category)
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(CHColors.primaryColor.opacity(0.2))
                    .foregroundColor(CHColors.primaryColor)
                    .cornerRadius(4)
                
                Spacer()
                
                Text(author)
                    .font(.caption)
                    .foregroundColor(CHColors.gray)
                
                Text("•")
                    .font(.caption)
                    .foregroundColor(CHColors.gray)
                
                Text(time)
                    .font(.caption)
                    .foregroundColor(CHColors.gray)
            }
            
            // 제목
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(CHColors.textColor)
                .lineLimit(1)
            
            // 하단 정보
            HStack(spacing: 12) {
                HStack(spacing: 4) {
                    Image(systemName: "bubble.left")
                        .font(.system(size: 12))
                    Text("\(commentCount)")
                        .font(.caption)
                }
                .foregroundColor(CHColors.gray)
                
                HStack(spacing: 4) {
                    Image(systemName: "heart")
                        .font(.system(size: 12))
                    Text("\(likeCount)")
                        .font(.caption)
                }
                .foregroundColor(CHColors.gray)
                
                Spacer()
            }
        }
        .padding(12)
        .background(CHColors.cardBackground)
        .cornerRadius(10)
    }
}

#Preview {
    CommunityHighlightsView()
        .background(CHColors.backgroundColor)
}
