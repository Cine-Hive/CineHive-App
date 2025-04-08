//
//  CommunityHighlightsView.swift
//  CineHive
//
//  Created by 이종민 on 3/20/25.
//

import SwiftUI

struct CommunityHighlightsView: View {
    @State private var showPreparingView = false
    @State private var selectedPostIndex = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "커뮤니티 화제", actionTitle: "더보기")
            
            VStack(spacing: 12) {
                ForEach(0..<3, id: \.self) { index in
                    Button {
                        selectedPostIndex = index
                        showPreparingView = true
                    } label: {
                        communityPostCard(
                            title: ["넷플릭스 3월 신작 총정리", "디즈니+ 꿀팁 공유합니다", "최근 본 영화 TOP 5"][index],
                            author: "유저\(index+1)",
                            category: ["정보", "꿀팁", "리뷰"][index],
                            commentCount: [24, 18, 32][index],
                            likeCount: [86, 45, 120][index],
                            time: "\(index+1)시간 전"
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 15)
        .navigationDestination(isPresented: $showPreparingView) {
            PreparingView(
                type: "커뮤니티",
                actionTitle: "확인"
            ) {
                showPreparingView = false
            }
            .navigationBarBackButtonHidden(true)
        }
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
